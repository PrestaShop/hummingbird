<?php
/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

/**
 * Read and write one shop setting through PrestaShop's own Configuration API,
 * which is what the back office calls, so multistore scoping and the
 * configuration cache behave the same way they do for a merchant.
 *
 * It exists for QA passes over docs/qa/testing-checklist.md section 4, where
 * every point means: flip a setting, look at the front office, put it back.
 * Driving 24 back office forms for that is slower and far more brittle than
 * calling the setter the forms themselves call, and a QA run that cannot put a
 * setting back is worse than one that never changed it.
 *
 * Usage, with the PrestaShop root as the working directory:
 *
 *   php /path/to/config.php --get PS_CATALOG_MODE         prints the value, or __UNSET__
 *   php /path/to/config.php --set PS_CATALOG_MODE=1       sets it, prints the value read back
 *   php /path/to/config.php --unset PS_CATALOG_MODE       removes the row
 *
 * --set always prints what the value reads AFTER the write, not what was asked
 * for, so a caller can verify rather than assume. Exit 0 on success, 1 when a
 * write did not take, 64 on bad arguments.
 *
 * WHERE TO PUT THIS FILE WHEN YOU RUN IT
 *
 * It reads the shop through PrestaShop's own classes, so it needs the shop root
 * as its working directory, NOT as its location. Keep the file outside the
 * PrestaShop checkout and pass the root as the working directory instead:
 *
 *   docker exec -u www-data -w /var/www/html <php container> php /tmp/hb-qa/config.php
 *
 * In a Docker setup the shop root is usually a bind mount of a git checkout, so
 * copying this script "into the container" writes it into somebody's working
 * tree and leaves untracked files behind in a repository it does not belong to.
 * That is a mistake this file has already caused once.
 */

declare(strict_types=1);

const UNSET_MARKER = '__UNSET__';

$root = getcwd();
if (!is_file($root . '/config/config.inc.php')) {
    fwrite(STDERR, "run this from the PrestaShop root\n");
    exit(64);
}
require $root . '/config/config.inc.php';

// A CLI context is empty and Configuration writes reach for the shop.
$idShop = (int) Configuration::get('PS_SHOP_DEFAULT') ?: 1;
$context = Context::getContext();
if (!$context->shop || !$context->shop->id) {
    $context->shop = new Shop($idShop);
}
Shop::setContext(Shop::CONTEXT_SHOP, $idShop);

$argvRest = array_slice($argv, 1);
$op = $argvRest[0] ?? null;
$arg = $argvRest[1] ?? null;

function readValue(string $key): string
{
    $v = Configuration::get($key);

    return ($v === false || $v === null) ? UNSET_MARKER : (string) $v;
}

switch ($op) {
    case '--get':
        if (!$arg) { fwrite(STDERR, "usage: --get KEY\n"); exit(64); }
        echo readValue($arg) . PHP_EOL;
        exit(0);

    case '--set':
        if (!$arg || !str_contains($arg, '=')) { fwrite(STDERR, "usage: --set KEY=VALUE\n"); exit(64); }
        [$key, $value] = explode('=', $arg, 2);
        Configuration::updateValue($key, $value);
        // Configuration keeps a static cache; reload so the read-back is the
        // database's answer rather than the one we just put in memory.
        Configuration::loadConfiguration();
        $now = readValue($key);
        echo $now . PHP_EOL;
        exit($now === $value ? 0 : 1);

    case '--unset':
        if (!$arg) { fwrite(STDERR, "usage: --unset KEY\n"); exit(64); }
        Configuration::deleteByName($arg);
        Configuration::loadConfiguration();
        $now = readValue($arg);
        echo $now . PHP_EOL;
        exit($now === UNSET_MARKER ? 0 : 1);

    // 4.2/02 asks for the customer group price display, which is a column on the
    // group rather than a setting, so it needs its own pair of verbs.
    case '--get-group-price-display':
        if (!$arg) { fwrite(STDERR, "usage: --get-group-price-display ID\n"); exit(64); }
        $g = new Group((int) $arg);
        if (!$g->id) { fwrite(STDERR, "no group {$arg}\n"); exit(1); }
        echo (string) (int) $g->price_display_method . PHP_EOL;
        exit(0);

    case '--set-group-price-display':
        if (!$arg || !str_contains($arg, '=')) { fwrite(STDERR, "usage: --set-group-price-display ID=0|1\n"); exit(64); }
        [$gid, $method] = explode('=', $arg, 2);
        $g = new Group((int) $gid);
        if (!$g->id) { fwrite(STDERR, "no group {$gid}\n"); exit(1); }
        $g->price_display_method = (int) $method;
        $g->save();
        $again = new Group((int) $gid);
        echo (string) (int) $again->price_display_method . PHP_EOL;
        exit((int) $again->price_display_method === (int) $method ? 0 : 1);

    // Feature flags live in their own table rather than in configuration, and
    // the manager that writes them is a Symfony service a CLI script cannot
    // reach, so the row is read and written directly. It is a single boolean
    // column with no dependent rows, and --get-flag lets a caller put it back.
    case '--get-flag':
        if (!$arg) { fwrite(STDERR, "usage: --get-flag NAME\n"); exit(64); }
        $v = Db::getInstance()->getValue(
            'SELECT state FROM ' . _DB_PREFIX_ . 'feature_flag WHERE name = "' . pSQL($arg) . '"'
        );
        echo ($v === false || $v === null ? UNSET_MARKER : (string) (int) $v) . PHP_EOL;
        exit(0);

    case '--set-flag':
        if (!$arg || !str_contains($arg, '=')) { fwrite(STDERR, "usage: --set-flag NAME=0|1\n"); exit(64); }
        [$flag, $state] = explode('=', $arg, 2);
        Db::getInstance()->update('feature_flag', ['state' => (int) $state], 'name = "' . pSQL($flag) . '"');
        $now = Db::getInstance()->getValue(
            'SELECT state FROM ' . _DB_PREFIX_ . 'feature_flag WHERE name = "' . pSQL($flag) . '"'
        );
        $now = ($now === false || $now === null) ? UNSET_MARKER : (string) (int) $now;
        echo $now . PHP_EOL;
        exit($now === (string) (int) $state ? 0 : 1);

    default:
        fwrite(STDERR, "usage: config.php --get KEY | --set KEY=VALUE | --unset KEY\n");
        fwrite(STDERR, "       config.php --get-flag NAME | --set-flag NAME=0|1\n");
        fwrite(STDERR, "       config.php --get-group-price-display ID | --set-group-price-display ID=0|1\n");
        exit(64);
}
