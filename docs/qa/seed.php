<?php
/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

/**
 * Bring a demo PrestaShop install up to the state docs/qa/testing-checklist.md
 * assumes, so a QA pass can answer the whole list instead of stopping at
 * "this shop has no data for that".
 *
 * It is not a fixture factory. It creates the narrowest thing each checklist
 * point needs, names everything QA so a human can tell it apart a month later,
 * and goes through PrestaShop's own model classes rather than raw INSERTs, so
 * search indexes, image types, friendly URLs and caches stay consistent. A
 * product written straight into the tables makes the theme look broken when it
 * is not, and a false red costs more than the point it was meant to answer.
 *
 * Every action is idempotent: run it twice and the second run reports
 * "already there" rather than making a duplicate.
 *
 * Usage, with the PrestaShop root as the working directory:
 *
 *   php /path/to/seed.php --status     what is missing, changes nothing
 *   php /path/to/seed.php --apply      create what is missing
 *   php /path/to/seed.php --undo       put back everything --apply changed
 *
 * In Docker:
 *
 *   docker exec -u www-data -w /var/www/html <php container> php /tmp/hb-qa/seed.php --status
 *
 * --undo restores the configuration values this script changed and deletes the
 * records it created, except the ones that cannot be withdrawn: an order is not
 * un-placed. Those are listed at the end of the run so nothing is left implicit.
 *
 * WHERE TO PUT THIS FILE WHEN YOU RUN IT
 *
 * It reads the shop through PrestaShop's own classes, so it needs the shop root
 * as its working directory, NOT as its location. Keep the file outside the
 * PrestaShop checkout and pass the root as the working directory instead:
 *
 *   docker exec -u www-data -w /var/www/html <php container> php /tmp/hb-qa/seed.php
 *
 * In a Docker setup the shop root is usually a bind mount of a git checkout, so
 * copying this script "into the container" writes it into somebody's working
 * tree and leaves untracked files behind in a repository it does not belong to.
 * That is a mistake this file has already caused once.
 */

declare(strict_types=1);

const QA_TAG = 'QA';
// Where the record of what --undo must restore is kept. It defaults to sitting
// beside this script, but this script has to live OUTSIDE the shop checkout
// (see above), and a path there is often a container's /tmp, which does not
// survive the container being recreated. Point QA_SEED_STATE at something
// durable and --undo keeps working across rebuilds.
define('STATE_FILE', getenv('QA_SEED_STATE') ?: __DIR__ . '/.seed-state.json');

// ---------------------------------------------------------------- bootstrap

$root = getcwd();
$config = $root . '/config/config.inc.php';
if (!is_file($config)) {
    fwrite(STDERR, "run this from the PrestaShop root: no config/config.inc.php under {$root}\n");
    exit(64);
}
require $config;

if (!defined('_PS_VERSION_')) {
    fwrite(STDERR, "PrestaShop did not boot\n");
    exit(2);
}

$mode = null;
foreach (array_slice($argv, 1) as $a) {
    if (in_array($a, ['--status', '--apply', '--undo'], true)) {
        $mode = substr($a, 2);
    }
}
if ($mode === null) {
    fwrite(STDERR, "usage: php docs/qa/seed.php --status | --apply | --undo\n");
    exit(64);
}

$idLang = (int) Configuration::get('PS_LANG_DEFAULT');
$idShop = (int) Configuration::get('PS_SHOP_DEFAULT') ?: 1;

/**
 * A CLI context is empty, and PrestaShop quietly assumes a web one: changing an
 * order state reaches Context::getComputingPrecision(), which reads
 * $context->currency->precision and dies on null. Fill in what the model layer
 * expects before touching anything that writes.
 */
(static function () use ($idLang, $idShop): void {
    $context = Context::getContext();
    if (!$context->shop || !$context->shop->id) {
        $context->shop = new Shop($idShop);
    }
    Shop::setContext(Shop::CONTEXT_SHOP, $idShop);
    if (!$context->language || !$context->language->id) {
        $context->language = new Language($idLang);
    }
    if (!$context->currency || !$context->currency->id) {
        $context->currency = new Currency((int) Configuration::get('PS_CURRENCY_DEFAULT'));
    }
    if (!$context->country || !$context->country->id) {
        $context->country = new Country((int) Configuration::get('PS_COUNTRY_DEFAULT'));
    }
    if (!$context->employee || !$context->employee->id) {
        // An order state change is written against an employee; take the first
        // active one rather than inventing a record.
        $id = (int) Db::getInstance()->getValue(
            'SELECT id_employee FROM ' . _DB_PREFIX_ . 'employee WHERE active = 1 ORDER BY id_employee ASC'
        );
        if ($id) {
            $context->employee = new Employee($id);
        }
    }
})();

// Note: Db::getValue() appends its own LIMIT 1, so these queries must not carry one.

// ---------------------------------------------------------------- reporting

$results = [];
$leftBehind = [];

function say(string $s): void
{
    echo $s . PHP_EOL;
}

function record(string $item, string $what, string $state, string $note = ''): void
{
    global $results;
    $results[] = compact('item', 'what', 'state', 'note');
    $mark = ['missing' => '  missing', 'present' => '  already there', 'made' => '  made', 'undone' => '  undone', 'kept' => '  kept'][$state] ?? '  ' . $state;
    say(sprintf('%-9s %-46s %s%s', $item, $what, $mark, $note !== '' ? ' — ' . $note : ''));
}

/** State written so --undo knows what this script, and nothing else, changed. */
function loadState(): array
{
    return is_file(STATE_FILE) ? (json_decode((string) file_get_contents(STATE_FILE), true) ?: []) : [];
}

function saveState(array $s): void
{
    file_put_contents(STATE_FILE, json_encode($s, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
}

$state = loadState();

/**
 * A configuration value the checklist needs set. The value it had before is
 * remembered on the first change, so --undo puts back what was really there
 * rather than a guessed default.
 */
function needConfig(string $item, string $key, string $wanted, string $why): void
{
    global $mode, $state;
    $current = Configuration::get($key);
    $current = $current === false ? null : (string) $current;

    if ($mode === 'undo') {
        if (!array_key_exists('config.' . $key, $state)) {
            record($item, $key, 'kept', 'not changed by this script');

            return;
        }
        $was = $state['config.' . $key];
        if ($was === null) {
            Configuration::deleteByName($key);
        } else {
            Configuration::updateValue($key, $was);
        }
        unset($state['config.' . $key]);
        saveState($state);
        record($item, $key, 'undone', 'back to ' . ($was ?? 'no row'));

        return;
    }

    if ($current === $wanted) {
        record($item, $key, 'present', $why);

        return;
    }
    if ($mode === 'status') {
        record($item, $key, 'missing', sprintf('reads %s, wants %s', var_export($current, true), $wanted));

        return;
    }
    if (!array_key_exists('config.' . $key, $state)) {
        $state['config.' . $key] = $current;
        saveState($state);
    }
    Configuration::updateValue($key, $wanted);
    record($item, $key, 'made', sprintf('%s -> %s', var_export($current, true), $wanted));
}

// ------------------------------------------------------------------- 1. data

/**
 * 3.4/15 to 3.4/18. The You might also like block does not render at all
 * without a linked accessory, so four checklist points cannot be answered.
 * Two existing products are linked rather than new ones created: a new product
 * would change every listing count and break the single-product and empty
 * listing checks.
 */
function accessories(): void
{
    global $mode, $state, $idLang;

    $existing = (int) Db::getInstance()->getValue('SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'accessory');

    if ($mode === 'undo') {
        if (empty($state['accessories'])) {
            record('3.4/15', 'linked accessories', 'kept', 'not created by this script');

            return;
        }
        foreach ($state['accessories'] as $pair) {
            Db::getInstance()->delete('accessory', 'id_product_1 = ' . (int) $pair[0] . ' AND id_product_2 = ' . (int) $pair[1]);
        }
        unset($state['accessories']);
        saveState($state);
        record('3.4/15', 'linked accessories', 'undone');

        return;
    }

    if ($existing > 0) {
        record('3.4/15', 'linked accessories', 'present', $existing . ' link(s) already');

        return;
    }
    if ($mode === 'status') {
        record('3.4/15', 'linked accessories', 'missing', 'the accessories block cannot render');

        return;
    }

    // the first active product, given two others from a different category
    $ids = array_column(Db::getInstance()->executeS(
        'SELECT p.id_product FROM ' . _DB_PREFIX_ . 'product p
         INNER JOIN ' . _DB_PREFIX_ . 'product_shop ps ON ps.id_product = p.id_product AND ps.active = 1
         ORDER BY p.id_product ASC LIMIT 4'
    ) ?: [], 'id_product');

    if (count($ids) < 3) {
        record('3.4/15', 'linked accessories', 'missing', 'fewer than three active products to link');

        return;
    }
    $host = (int) array_shift($ids);
    $accs = array_map('intval', array_slice($ids, 0, 2));
    Product::changeAccessoriesForProduct($accs, $host);

    $state['accessories'] = array_map(static fn ($a) => [$host, $a], $accs);
    saveState($state);
    record('3.4/15', 'linked accessories', 'made', sprintf('product %d now shows %s', $host, implode(' and ', $accs)));
}

/**
 * 3.5/09 and 3.8/09. A voucher that applies to the customer, so the cart can
 * exercise apply, invalid code and remove, and the account has something on
 * its Vouchers page.
 */
function cartRule(): void
{
    global $mode, $state, $idLang;

    $code = QA_TAG . '-VOUCHER-10';
    $found = (int) Db::getInstance()->getValue(
        'SELECT id_cart_rule FROM ' . _DB_PREFIX_ . 'cart_rule WHERE code = "' . pSQL($code) . '"'
    );

    if ($mode === 'undo') {
        if ($found) {
            (new CartRule($found))->delete();
            record('3.5/09', 'a voucher (' . $code . ')', 'undone');
        } else {
            record('3.5/09', 'a voucher (' . $code . ')', 'kept', 'not there');
        }
        unset($state['cartRule']);
        saveState($state);

        return;
    }
    if ($found) {
        record('3.5/09', 'a voucher (' . $code . ')', 'present');

        return;
    }
    if ($mode === 'status') {
        record('3.5/09', 'a voucher (' . $code . ')', 'missing', 'no cart rule exists at all');

        return;
    }

    $rule = new CartRule();
    $rule->code = $code;
    $rule->name = [$idLang => QA_TAG . ' 10% off, made for testing'];
    $rule->date_from = date('Y-m-d H:i:s', strtotime('-1 day'));
    $rule->date_to = date('Y-m-d H:i:s', strtotime('+1 year'));
    $rule->quantity = 1000;
    $rule->quantity_per_user = 1000;
    $rule->reduction_percent = 10.0;
    $rule->minimum_amount = 0;
    $rule->active = true;
    $rule->highlight = true;
    $rule->partial_use = true;
    $rule->add();

    $state['cartRule'] = (int) $rule->id;
    saveState($state);
    record('3.5/09', 'a voucher (' . $code . ')', 'made', '10% off, no minimum');
}

/**
 * 3.1/03, 3.1/05 and 3.4/19. Best sellers and ps_crossselling both read
 * ps_product_sale, which is filled from orders in a valid state. Every demo
 * order is left unvalidated, so both blocks render nothing and look broken.
 *
 * This moves one existing order to Payment accepted through the order's own
 * state machine, which is what the back office does, rather than writing the
 * sale rows directly.
 */
function validateAnOrder(): void
{
    global $mode, $state;

    $sales = (int) Db::getInstance()->getValue('SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'product_sale');

    if ($mode === 'undo') {
        if (empty($state['validatedOrder'])) {
            record('3.1/03', 'an order in a valid state', 'kept', 'not changed by this script');

            return;
        }
        record('3.1/03', 'an order in a valid state', 'kept',
            'order ' . $state['validatedOrder']['id'] . ' was moved to Payment accepted and is deliberately left that way: '
            . 'an order state change is part of the shop history and rolling it back by hand would leave stock and invoices inconsistent');

        return;
    }

    if ($sales > 0) {
        record('3.1/03', 'an order in a valid state', 'present', $sales . ' row(s) in product_sale');

        return;
    }
    if ($mode === 'status') {
        record('3.1/03', 'an order in a valid state', 'missing', 'best sellers and cross-selling have nothing to show');

        return;
    }

    $idOrder = (int) Db::getInstance()->getValue(
        'SELECT id_order FROM ' . _DB_PREFIX_ . 'orders WHERE valid = 0 ORDER BY id_order ASC'
    );
    if (!$idOrder) {
        record('3.1/03', 'an order in a valid state', 'missing', 'no order to validate');

        return;
    }
    $paid = (int) Configuration::get('PS_OS_PAYMENT');
    $order = new Order($idOrder);
    $was = (int) $order->current_state;
    $order->setCurrentState($paid);
    ProductSale::fillProductSales();

    $state['validatedOrder'] = ['id' => $idOrder, 'was' => $was];
    saveState($state);
    record('3.1/03', 'an order in a valid state', 'made', sprintf('order %d moved from state %d to Payment accepted', $idOrder, $was));
}

/**
 * 1.3/03 and 2.1/04. ps_currencyselector renders nothing at all with a single
 * currency, so the point cannot be told apart from a broken hook.
 */
function secondCurrency(): void
{
    global $mode, $state;

    $iso = 'USD';
    $id = (int) Currency::getIdByIsoCode($iso, 0, true);

    if ($mode === 'undo') {
        if (!empty($state['currency']) && (int) $state['currency'] === $id && $id) {
            $c = new Currency($id);
            $c->deleted = true;
            $c->active = false;
            $c->save();
            unset($state['currency']);
            saveState($state);
            record('1.3/03', 'a second currency (' . $iso . ')', 'undone', 'marked deleted, as PrestaShop does');
        } else {
            record('1.3/03', 'a second currency (' . $iso . ')', 'kept', 'not created by this script');
        }

        return;
    }

    $active = (int) Db::getInstance()->getValue(
        'SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'currency WHERE active = 1 AND deleted = 0'
    );
    if ($active > 1) {
        record('1.3/03', 'a second currency (' . $iso . ')', 'present', $active . ' active currencies');

        return;
    }
    if ($mode === 'status') {
        record('1.3/03', 'a second currency (' . $iso . ')', 'missing', 'only one active currency');

        return;
    }

    if ($id) {
        $c = new Currency($id);
        $c->active = true;
        $c->deleted = false;
        $c->save();
    } else {
        // The localisation helpers (refreshLocalizedCurrencyData, getContextLocale)
        // need the Symfony container, which a plain CLI script does not have, so
        // the language fields are set directly instead.
        $c = new Currency();
        $c->iso_code = $iso;
        $c->numeric_iso_code = '840';
        $c->precision = 2;
        $c->conversion_rate = 1.1;
        $c->active = true;
        $c->deleted = false;
        $c->unofficial = false;
        $c->modified = true;
        $names = [];
        $symbols = [];
        $patterns = [];
        foreach (Language::getLanguages(false) as $lang) {
            $names[(int) $lang['id_lang']] = 'US Dollar';
            $symbols[(int) $lang['id_lang']] = '$';
            $patterns[(int) $lang['id_lang']] = '¤#,##0.00';
        }
        $c->name = $names;
        $c->symbol = $symbols;
        $c->pattern = $patterns;
        $c->add();
        $id = (int) $c->id;
    }
    $c->associateTo([(int) Configuration::get('PS_SHOP_DEFAULT') ?: 1]);

    $state['currency'] = $id;
    saveState($state);
    record('1.3/03', 'a second currency (' . $iso . ')', 'made', 'so the selector has something to choose between');
}

/**
 * The B2B half of the matrix in 1.3. B2B mode is a shop-wide switch and the
 * profile also needs a group that shows prices without tax.
 */
function b2bGroup(): void
{
    global $mode, $state, $idLang;

    $name = QA_TAG . ' B2B';
    $id = (int) Db::getInstance()->getValue(
        'SELECT g.id_group FROM ' . _DB_PREFIX_ . 'group g
         INNER JOIN ' . _DB_PREFIX_ . 'group_lang gl ON gl.id_group = g.id_group
         WHERE gl.name = "' . pSQL($name) . '"'
    );

    if ($mode === 'undo') {
        if (!empty($state['b2bGroup']) && $id) {
            (new Group($id))->delete();
            unset($state['b2bGroup']);
            saveState($state);
            record('1.3/xx', 'a B2B customer group', 'undone');
        } else {
            record('1.3/xx', 'a B2B customer group', 'kept', 'not created by this script');
        }

        return;
    }
    if ($id) {
        record('1.3/xx', 'a B2B customer group', 'present');

        return;
    }
    if ($mode === 'status') {
        record('1.3/xx', 'a B2B customer group', 'missing', 'the B2B cells of the matrix cannot be run');

        return;
    }

    $g = new Group();
    $g->name = [$idLang => $name];
    $g->price_display_method = 1; // tax excluded, which is what the matrix asks for
    $g->show_prices = true;
    $g->reduction = 0;
    $g->add();
    $new = (int) $g->id;

    // A group created this way can see nothing: PrestaShop grants category and
    // module access per group, and a group with neither gets 403 on every
    // category and an empty header, which reads as the theme being broken.
    // Copy what the default customer group is allowed to see.
    $from = (int) Configuration::get('PS_CUSTOMER_GROUP') ?: 3;
    Db::getInstance()->execute(
        'INSERT IGNORE INTO ' . _DB_PREFIX_ . 'category_group (id_category, id_group)
         SELECT id_category, ' . $new . ' FROM ' . _DB_PREFIX_ . 'category_group WHERE id_group = ' . $from
    );
    Db::getInstance()->execute(
        'INSERT IGNORE INTO ' . _DB_PREFIX_ . 'module_group (id_module, id_shop, id_group)
         SELECT id_module, id_shop, ' . $new . ' FROM ' . _DB_PREFIX_ . 'module_group WHERE id_group = ' . $from
    );
    $cats = (int) Db::getInstance()->getValue('SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'category_group WHERE id_group = ' . $new);
    $mods = (int) Db::getInstance()->getValue('SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'module_group WHERE id_group = ' . $new);

    $state['b2bGroup'] = $new;
    saveState($state);
    record('1.3/xx', 'a B2B customer group', 'made',
        sprintf('prices excluding tax, with access to %d categories and %d modules copied from group %d', $cats, $mods, $from));
}

/**
 * 3.2/02 and 3.2/03. The additional description renders below the listing and
 * must be gone on page two, and no demo category carries one.
 */
function categoryAdditionalDescription(): void
{
    global $mode, $state, $idLang;

    $idCategory = (int) Db::getInstance()->getValue(
        'SELECT cp.id_category FROM ' . _DB_PREFIX_ . 'category_product cp
         GROUP BY cp.id_category ORDER BY COUNT(*) DESC'
    );
    if (!$idCategory) {
        record('3.2/02', 'a category additional description', 'missing', 'no category with products');

        return;
    }
    $category = new Category($idCategory, $idLang);
    $current = (string) ($category->additional_description ?? '');
    $text = '<p>' . QA_TAG . ' additional description, rendered below the listing and expected to be gone on page two.</p>';

    if ($mode === 'undo') {
        if (empty($state['categoryDescription'])) {
            record('3.2/02', 'a category additional description', 'kept', 'not set by this script');

            return;
        }
        $c = new Category((int) $state['categoryDescription']['id'], $idLang);
        $c->additional_description = $state['categoryDescription']['was'];
        $c->save();
        unset($state['categoryDescription']);
        saveState($state);
        record('3.2/02', 'a category additional description', 'undone');

        return;
    }
    if ($current !== '') {
        record('3.2/02', 'a category additional description', 'present');

        return;
    }
    if ($mode === 'status') {
        record('3.2/02', 'a category additional description', 'missing', 'category ' . $idCategory . ' has none');

        return;
    }

    $state['categoryDescription'] = ['id' => $idCategory, 'was' => $current];
    saveState($state);
    $category->additional_description = $text;
    $category->save();
    record('3.2/02', 'a category additional description', 'made', 'on category ' . $idCategory);
}

/**
 * 4.1/03, 3.4/03 and 5.4/03. Every demo product carries stock, so "allow
 * ordering out of stock" cannot change anything and the back in stock form
 * never renders. One product is taken to zero with ordering denied.
 *
 * ps_product.quantity is NOT the stock figure: ps_stock_available is. Reading
 * the wrong one is what made an earlier pass believe the whole catalogue was
 * out of stock.
 */
function outOfStockProduct(): void
{
    global $mode, $state;

    $id = 8; // Mug Today is a good day: in categories 6 and 8, used by no other check
    $row = Db::getInstance()->getRow(
        'SELECT quantity, out_of_stock FROM ' . _DB_PREFIX_ . 'stock_available
         WHERE id_product = ' . (int) $id . ' AND id_product_attribute = 0'
    );

    if ($mode === 'undo') {
        if (empty($state['outOfStock'])) { record('4.1/03', 'a product with no stock', 'kept', 'not changed by this script'); return; }
        $was = $state['outOfStock'];
        StockAvailable::setQuantity($id, 0, (int) $was['quantity']);
        Db::getInstance()->update('stock_available', ['out_of_stock' => (int) $was['out_of_stock']],
            'id_product = ' . (int) $id . ' AND id_product_attribute = 0');
        unset($state['outOfStock']); saveState($state);
        record('4.1/03', 'a product with no stock', 'undone', 'stock back to ' . $was['quantity']);

        return;
    }
    if ($row && (int) $row['quantity'] <= 0) { record('4.1/03', 'a product with no stock', 'present'); return; }
    if ($mode === 'status') { record('4.1/03', 'a product with no stock', 'missing', 'nothing is out of stock, so the setting cannot change anything'); return; }

    $state['outOfStock'] = ['id' => $id, 'quantity' => (int) $row['quantity'], 'out_of_stock' => (int) $row['out_of_stock']];
    saveState($state);
    StockAvailable::setQuantity($id, 0, 0);
    // 2 = follow the shop setting. Pinning the product to 0 (always deny) or 1
    // (always allow) would make PS_ORDER_OUT_OF_STOCK unable to change anything,
    // and 4.1/03 is precisely the question of whether that setting still governs.
    Db::getInstance()->update('stock_available', ['out_of_stock' => 2],
        'id_product = ' . (int) $id . ' AND id_product_attribute = 0');
    record('4.1/03', 'a product with no stock', 'made',
        sprintf('product %d taken to 0, following the shop setting for out-of-stock ordering', $id));
}

/** 3.2/10. No demo product asks for more than one, so the rule never bites. */
function minimumQuantityProduct(): void
{
    global $mode, $state;

    $id = 7;
    $was = (int) Db::getInstance()->getValue('SELECT minimal_quantity FROM ' . _DB_PREFIX_ . 'product WHERE id_product = ' . (int) $id);

    if ($mode === 'undo') {
        if (empty($state['minQuantity'])) { record('3.2/10', 'a product with a minimum quantity', 'kept', 'not changed by this script'); return; }
        $back = (int) $state['minQuantity']['was'];
        Db::getInstance()->update('product', ['minimal_quantity' => $back], 'id_product = ' . (int) $id);
        Db::getInstance()->update('product_shop', ['minimal_quantity' => $back], 'id_product = ' . (int) $id);
        unset($state['minQuantity']); saveState($state);
        record('3.2/10', 'a product with a minimum quantity', 'undone');

        return;
    }
    if ($was > 1) { record('3.2/10', 'a product with a minimum quantity', 'present', 'reads ' . $was); return; }
    if ($mode === 'status') { record('3.2/10', 'a product with a minimum quantity', 'missing', 'no product asks for more than one'); return; }

    $state['minQuantity'] = ['id' => $id, 'was' => $was]; saveState($state);
    Db::getInstance()->update('product', ['minimal_quantity' => 3], 'id_product = ' . (int) $id);
    Db::getInstance()->update('product_shop', ['minimal_quantity' => 3], 'id_product = ' . (int) $id);
    record('3.2/10', 'a product with a minimum quantity', 'made', sprintf('product %d now asks for 3', $id));
}

/** 3.10/02. The theme ships templates/errors/410.tpl and nothing reaches it. */
function goneProduct(): void
{
    global $mode, $state;

    $id = 14; // a virtual product in Art, outside every listing the suites count
    $p = new Product($id);

    if ($mode === 'undo') {
        if (empty($state['gone'])) { record('3.10/02', 'a product that answers 410', 'kept', 'not changed by this script'); return; }
        $was = $state['gone'];
        $p->active = (int) $was['active'];
        $p->redirect_type = (string) $was['redirect_type'];
        $p->save();
        unset($state['gone']); saveState($state);
        record('3.10/02', 'a product that answers 410', 'undone', 'active again');

        return;
    }
    if (!$p->id) { record('3.10/02', 'a product that answers 410', 'missing', 'product ' . $id . ' does not exist'); return; }
    if (!$p->active && $p->redirect_type === '410') { record('3.10/02', 'a product that answers 410', 'present'); return; }
    if ($mode === 'status') { record('3.10/02', 'a product that answers 410', 'missing', 'no product redirects as Gone'); return; }

    $state['gone'] = ['id' => $id, 'active' => (int) $p->active, 'redirect_type' => (string) $p->redirect_type];
    saveState($state);
    $p->active = 0;
    $p->redirect_type = '410';
    $p->save();
    record('3.10/02', 'a product that answers 410', 'made', sprintf('product %d disabled and set to Gone', $id));
}

/**
 * 3.7/01 to 3.7/07. A cart splits into several shipments only when its products
 * cannot travel by the same carrier, which means per-product carrier
 * restrictions. ps_product_carrier is empty on a demo shop, so nothing can ever
 * split and six checklist points cannot be answered at all.
 */
function carrierRestrictions(): void
{
    global $mode, $state;

    $pairs = [[16, 1], [17, 2]]; // two products, one carrier each, deliberately different
    $existing = (int) Db::getInstance()->getValue('SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'product_carrier');

    if ($mode === 'undo') {
        if (empty($state['carriers'])) { record('3.7/01', 'per-product carrier restrictions', 'kept', 'not created by this script'); return; }
        foreach ($state['carriers'] as $pair) {
            Db::getInstance()->delete('product_carrier', 'id_product = ' . (int) $pair[0] . ' AND id_carrier_reference = ' . (int) $pair[1]);
        }
        unset($state['carriers']); saveState($state);
        record('3.7/01', 'per-product carrier restrictions', 'undone');

        return;
    }
    if ($existing > 0) { record('3.7/01', 'per-product carrier restrictions', 'present', $existing . ' row(s)'); return; }
    if ($mode === 'status') { record('3.7/01', 'per-product carrier restrictions', 'missing', 'no cart can split into several shipments'); return; }

    $made = [];
    foreach ($pairs as [$idProduct, $idCarrier]) {
        $ref = (int) Db::getInstance()->getValue('SELECT id_reference FROM ' . _DB_PREFIX_ . 'carrier WHERE id_carrier = ' . (int) $idCarrier);
        if (!$ref) { continue; }
        Db::getInstance()->insert('product_carrier', [
            'id_product' => (int) $idProduct,
            'id_carrier_reference' => $ref,
            'id_shop' => (int) (Configuration::get('PS_SHOP_DEFAULT') ?: 1),
        ], false, true, Db::INSERT_IGNORE);
        $made[] = [$idProduct, $ref];
    }
    $state['carriers'] = $made; saveState($state);
    record('3.7/01', 'per-product carrier restrictions', 'made',
        implode(', ', array_map(static fn ($m) => "product {$m[0]} to carrier reference {$m[1]}", $made)));
}

/** 3.5/05 and 3.5/06: an image customisation field, and a second customisable product. */
function customisationFields(): void
{
    global $mode, $state, $idLang;

    $imageOn = 19;  // the mug that already has a text field
    $secondOn = 10; // a cushion, so two customisable products exist

    $hasImage = (int) Db::getInstance()->getValue(
        'SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'customization_field WHERE id_product = ' . (int) $imageOn . ' AND type = 0'
    );
    $hasSecond = (int) Db::getInstance()->getValue(
        'SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'customization_field WHERE id_product = ' . (int) $secondOn
    );

    if ($mode === 'undo') {
        if (empty($state['customFields'])) { record('3.5/05', 'customisation fields', 'kept', 'not created by this script'); return; }
        foreach ($state['customFields'] as $idField) {
            $f = new CustomizationField((int) $idField);
            if ($f->id) { $f->delete(); }
        }
        foreach ([$imageOn, $secondOn] as $idProduct) {
            $p = new Product($idProduct);
            if ($p->id) { $p->customizable = (int) Db::getInstance()->getValue(
                'SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'customization_field WHERE id_product = ' . (int) $idProduct) > 0 ? 1 : 0;
                $p->save(); }
        }
        unset($state['customFields']); saveState($state);
        record('3.5/05', 'customisation fields', 'undone');

        return;
    }
    if ($hasImage && $hasSecond) { record('3.5/05', 'customisation fields', 'present'); return; }
    if ($mode === 'status') {
        record('3.5/05', 'customisation fields', 'missing',
            ($hasImage ? '' : 'no image field on the customisable product; ') . ($hasSecond ? '' : 'only one customisable product'));

        return;
    }

    $made = [];
    if (!$hasImage) {
        $f = new CustomizationField();
        $f->id_product = $imageOn;
        $f->type = 0; // 0 is a file, 1 is text
        $f->required = false;
        $f->name = [$idLang => QA_TAG . ' picture'];
        $f->add();
        $made[] = (int) $f->id;
    }
    if (!$hasSecond) {
        $f = new CustomizationField();
        $f->id_product = $secondOn;
        $f->type = 1;
        $f->required = true;
        $f->name = [$idLang => QA_TAG . ' engraving'];
        $f->add();
        $made[] = (int) $f->id;
        $p = new Product($secondOn);
        $p->customizable = 1;
        $p->text_fields = 1;
        $p->save();
    }
    $state['customFields'] = $made; saveState($state);
    record('3.5/05', 'customisation fields', 'made', count($made) . ' field(s) added');
}

/**
 * 3.2/05 and 3.2/06. The demo gives every subcategory a thumbnail, so the
 * no-picture fallback never renders and no category is missing one image while
 * carrying the other. One thumbnail file is moved aside, reversibly.
 */
function categoryThumbnails(): void
{
    global $mode, $state;

    $id = 5; // Women, a child of Clothes, so /3-clothes becomes the mixed case
    $dir = _PS_CAT_IMG_DIR_;
    $live = $dir . $id . '_thumb.jpg';
    $parked = $dir . $id . '_thumb.jpg.qa-parked';

    if ($mode === 'undo') {
        if (empty($state['categoryThumb'])) { record('3.2/05', 'a subcategory without a thumbnail', 'kept', 'not changed by this script'); return; }
        if (is_file($parked)) { rename($parked, $live); }
        unset($state['categoryThumb']); saveState($state);
        record('3.2/05', 'a subcategory without a thumbnail', 'undone', 'thumbnail put back');

        return;
    }
    if (!is_file($live)) {
        record('3.2/05', 'a subcategory without a thumbnail', is_file($parked) ? 'present' : 'missing',
            is_file($parked) ? 'already parked by this script' : 'category ' . $id . ' has no thumbnail file to park');

        return;
    }
    if ($mode === 'status') { record('3.2/05', 'a subcategory without a thumbnail', 'missing', 'every subcategory has one, so the fallback never renders'); return; }

    rename($live, $parked);
    $state['categoryThumb'] = ['id' => $id, 'parked' => $parked, 'live' => $live];
    saveState($state);
    record('3.2/05', 'a subcategory without a thumbnail', 'made', sprintf('category %d thumbnail parked, so its parent lists a mix', $id));
}

// -------------------------------------------------------------- 2. settings

function settings(): void
{
    // 2.1/06: blockreassurance returns nothing from displayNavFullWidth unless
    // this reads 1, so the band the checklist asks for cannot appear.
    needConfig('2.1/06', 'PSR_HOOK_HEADER', '1', 'the reassurance band below the header');
    // 2.2/01: the same module decides the second footer band.
    needConfig('2.2/01', 'PSR_HOOK_FOOTER', '1', 'the second reassurance band in the footer');
    // 2.2/01: ps_socialfollow renders nothing until at least one URL is filled.
    needConfig('2.2/01', 'BLOCKSOCIAL_FACEBOOK', 'https://www.facebook.com/prestashop', 'so the social block has something to render');
    // 3.8/07: the merchandise returns pages 404 while this is off.
    needConfig('3.8/07', 'PS_ORDER_RETURN', '1', 'merchandise returns');
    // 3.2/18: /suppliers 404s while this is off; /brands is already on.
    needConfig('3.2/18', 'PS_DISPLAY_SUPPLIERS', '1', 'the suppliers page');
    // 1.4/01 and 1.4/02: the pass must exercise the theme's own assets rather
    // than a merged bundle, and Smarty must not serve a cached page.
    needConfig('1.4/01', 'PS_CSS_THEME_CACHE', '0', 'CCC off');
    needConfig('1.4/01', 'PS_JS_THEME_CACHE', '0', 'CCC off');
    needConfig('1.4/02', 'PS_SMARTY_CACHE', '0', 'Smarty cache off');
    needConfig('1.4/02', 'PS_SMARTY_FORCE_COMPILE', '1', 'Smarty force compile on');
}

// ------------------------------------------------------------------- run it

say('');
say(sprintf('Hummingbird QA seed, %s, on PrestaShop %s', $mode, _PS_VERSION_));
say(str_repeat('-', 78));
say('');

settings();
accessories();
cartRule();
secondCurrency();
categoryAdditionalDescription();
b2bGroup();
validateAnOrder();
outOfStockProduct();
minimumQuantityProduct();
goneProduct();
carrierRestrictions();
customisationFields();
categoryThumbnails();

say('');
$counts = array_count_values(array_column($results, 'state'));
foreach (['missing', 'made', 'present', 'undone', 'kept'] as $k) {
    if (!empty($counts[$k])) {
        say(sprintf('  %-14s %d', $k, $counts[$k]));
    }
}

if ($mode === 'apply') {
    say('');
    say('clearing the cache, because configuration changed');
    try {
        Tools::clearAllCache();
        say('  cache cleared');
    } catch (\Throwable $e) {
        // Some cache helpers reach for the Symfony container, which a plain CLI
        // script does not have. Say so rather than dying after the work is done.
        say('  could not clear the cache from here (' . $e->getMessage() . ')');
        say('  clear it yourself: php bin/console cache:clear');
    }
    say('');
    say('Records left behind on purpose, because they cannot be withdrawn cleanly:');
    say('  - the order moved to Payment accepted stays in that state');
    say('Everything else is undone by: php docs/qa/seed.php --undo');
}

if ($mode === 'status' && !empty($counts['missing'])) {
    say('');
    say(sprintf('%d thing(s) the checklist needs are not on this shop. Run --apply to create them.', $counts['missing']));
    exit(1);
}

say('');
exit(0);
