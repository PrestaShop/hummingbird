# Hummingbird QA checklist

Full test pass on the Hummingbird theme, from environment setup to sign-off. Run it before a release, after a dependency bump, or when a change touches shared layout, JS or SCSS.

Hummingbird is a presentation layer. Bugs in business logic, database queries or controller behaviour belong to [PrestaShop/PrestaShop](https://github.com/PrestaShop/PrestaShop). Bugs in a module's own markup or logic belong to that module's repository; a theme-side override is a shim, not a fix.

For QA scoped to one pull request, use the `prestashop-pr-qa` skill instead.

This file describes the theme as it is today and goes stale on its own. Update it in the same pull request as the change whenever the theme evolves. Section 9 lists what it is derived from.

Items marked **(config)** change a shop-wide setting. Note the current value first, and restore it before moving on, or every item after it is testing a different shop.

## 1. Environment

### 1.1 Build the theme

Requirements and commands are in the README: [Develop on Hummingbird](../../README.md#-develop-on-hummingbird).

- [ ] Dependencies installed and assets built, no errors and no new warnings
- [ ] Linters and Prettier clean
- [ ] `npm test` green

### 1.2 Run PrestaShop

Two options. Pick the first one to test the working copy, the second one to test the released theme against a core checkout.

#### Option A: docker from this repo

Follow [Run Hummingbird with Docker](../../README.md#-run-hummingbird-with-docker) in the README. The compose files mount the repository root on `themes/hummingbird`, so the install runs the working copy.

- [ ] Front office and back office both respond (the compose files serve them on port 8887, back office on `/admin-dev`)

#### Option B: a PrestaShop/PrestaShop checkout

`composer install` in the core repository pulls `prestashop/hummingbird` at the constraint set in its `composer.json`, so you get a released tag, not the branch under test. `composer/installers` puts it in `themes/hummingbird`.

Hummingbird is the default theme of a fresh core install: the core ships `PS_FF_DEFAULT_THEME=hummingbird` in `.env`, and `Theme::DEFAULT_THEME` falls back to the same value. Nothing to switch on in the back office.

- [ ] Confirm which tag composer resolved: `composer show prestashop/hummingbird`
- [ ] To test local changes instead, replace `themes/hummingbird` with a symlink to this working copy, or declare a composer path repository pointing at it

#### Both options

- [ ] Theme version in Design > Theme & Logo matches the version under test, and the PrestaShop version is within the compatibility range declared in `config/theme.yml`
- [ ] Demo catalogue installed, native modules enabled and up to date

Record the environment before starting. Section 8 refers back to it, and a defect without it is not reproducible.

| Field | Value |
| --- | --- |
| Front office URL | |
| Back office URL | |
| Install method | Option A or Option B |
| Theme version | |
| PrestaShop version | |
| Date of the pass | |

### 1.3 Test matrix

Run the pass twice on Chrome, once per profile. Use two Chrome profiles, or a separate incognito window, so the two sessions and carts do not collide.

| Profile | Customer group | Viewport |
| --- | --- | --- |
| Standard B2C | Visitor, then registered customer, prices incl. tax | Desktop and mobile |
| B2B | B2B group, prices excl. tax | Desktop and mobile |

Cover at least once:

- [ ] Safari, desktop and iOS
- [ ] A second language (`ps_languageselector`, translations, date and price formats)
- [ ] A second currency (`ps_currencyselector`)
- [ ] Multistore, if the change touches header, footer or URLs **(config)**

### 1.4 Cache

In Advanced Parameters > Performance:

- [ ] CCC (Combine, Compress and Cache): all options disabled, so the pass exercises the theme's own assets rather than a merged bundle
- [ ] Smarty: Force compilation set to Yes, Cache set to No (`PS_DEV_MODE: 1` in the compose files already forces compilation)
- [ ] Cache cleared, and cleared again after each configuration change
- [ ] Browser cache disabled in DevTools, or a hard reload after `npm run build`

See [Troubleshooting](../../README.md#-troubleshooting) in the README if assets still do not update.

## 2. Cross-page checks

Do these once per profile on any page, then spot-check elsewhere.

### 2.1 Header

- [ ] Logo, and its link to the home page
- [ ] `ps_mainmenu`: desktop dropdowns, mobile burger, keyboard traversal
- [ ] `ps_searchbar`: autocomplete, no-result state, submit
- [ ] `ps_customersignin`, `ps_shoppingcart`, `ps_languageselector`, `ps_currencyselector` in the top nav
- [ ] `ps_contactinfo` in `displayNav1`
- [ ] `blockreassurance` band in `displayNavFullWidth`
- [ ] Sticky behaviour, no layout shift on scroll

### 2.2 Footer

- [ ] `ps_socialfollow`, `ps_emailsubscription`, `blockreassurance` in `displayFooterBefore`
- [ ] `ps_linklist`, `ps_customeraccountlinks`, `ps_contactinfo` in `displayFooter`
- [ ] Copyright block
- [ ] All links resolve, no 404 and no `#`

### 2.3 Shared partials

- [ ] Breadcrumb: correct trail, current page not a link
- [ ] Notifications and toasts: success, warning, error
- [ ] Pagination: first, last, middle page, and the SEO `rel` links
- [ ] Page title section, section titles
- [ ] Quantity input (`useQuantityInput`): min, max, step, manual typing
- [ ] Password fields: reveal toggle, password policy meter
- [ ] Modals: focus trap, `Esc`, backdrop click, scroll lock released on close

### 2.4 Regression sweep

- [ ] No JS error in the console on any page visited
- [ ] No 404 on CSS, JS, fonts or images
- [ ] No unstyled flash
- [ ] Images use the image types declared in `config/theme.yml` and are not upscaled
- [ ] If the change touches `templates/layouts/`, each layout declared in `config/theme.yml` still renders, with no empty column

## 3. Page by page

### 3.1 Home

- [ ] `ps_imageslider`: autoplay, arrows, dots, swipe, single slide, no slide
- [ ] `ps_customtext`
- [ ] `ps_featuredproducts`, `ps_newproducts`, `ps_bestsellers`: each shows the number of products its own configuration asks for. `config/theme.yml` seeds `HOME_FEATURED_NBR`, `NEW_PRODUCTS_NBR` and `PS_BLOCK_BESTSELLERS_TO_DISPLAY` at theme install only, so read the current value rather than expecting the seeded one
- [ ] `ps_banner`
- [ ] Empty state of each block

### 3.2 Category and listings

Applies to `category`, `search`, `best-sales`, `new-products`, `prices-drop`, `manufacturer`, `supplier`.

- [ ] Category header: name, description, cover image, subcategories
- [ ] Category additional description, rendered below the listing
- [ ] Header and additional description show on the first page only, both gone on page 2
- [ ] Subcategory thumbnails, three cases: every subcategory has one, none has one (the list renders text only), and a mix
- [ ] In the mixed case the thumbnail-less subcategories fall back to the no-picture image, which is served at `small_default` while real thumbnails use `category_default`, so check size and alignment
- [ ] Category with a cover image but no thumbnail, and the reverse, since the two images are separate fields
- [ ] `displaySubcategories` hook: the list still renders when a module provides content and there is no native subcategory
- [ ] Product miniatures: image, name, price, flags (new, on sale, pack, out of stock), review stars
- [ ] Add to cart from a miniature: toast, cart preview and totals updated, quantity input respected
- [ ] Miniature quantity input honours the product's minimum quantity, and a lower value is refused
- [ ] Product with combinations added from a miniature lands in the cart with its default combination
- [ ] Miniature falls back to a See details link when the product has no `add_to_cart_url`, so not available for order, or out of stock with orders denied
- [ ] Sort orders: each option changes the order
- [ ] `ps_facetedsearch`: each facet type (checkbox, dropdown, slider, colour), active filters, clear all, shareable URL, browser back and forward
- [ ] `ps_categorytree` in the left column
- [ ] Pagination and items per page (Shop Parameters > Product Settings > Pagination)
- [ ] Empty listing, and listing with a single product
- [ ] `/brands` and `/suppliers` (enable `ps_brandlist` and `ps_supplierlist` first, both disabled by default)

### 3.3 Quickview

Reachable from every product miniature, and it reuses the product page partials, so a regression there shows up here too.

- [ ] Opens from the quickview button and from the touch button, and the live region announces it
- [ ] Content: gallery and thumbnails, prices, short description, combination selectors, customisation fields, `ps_sharebuttons`, All details link
- [ ] Changing a combination updates price, availability and image inside the modal
- [ ] Add to cart from inside the modal, then close it: cart preview correct, focus returned to the miniature
- [ ] Customisable product: required fields block add to cart from the modal, errors shown on the field
- [ ] Save customization posts to the product URL, so from the quickview it leaves the modal and lands on the product page with the customisation saved
- [ ] Two quickviews opened in a row show the right product each time

### 3.4 Product page

The tab list depends on the product type, so cover all four types. Only the third tab changes, except for a virtual product, which has no Shipping tab at all:

| Product type | Tabs |
| --- | --- |
| Standard product | Description, Details, Stocks, Shipping, Pricing, SEO, Options |
| Product with combinations | Description, Details, Combinations, Shipping, Pricing, SEO, Options |
| Pack of products | Description, Details, Pack, Shipping, Pricing, SEO, Options |
| Virtual product | Description, Details, Virtual product, Pricing, SEO, Options |

BO tab and its front-office footprint:

| BO tab | Check in FO |
| --- | --- |
| Description | Summary in the buy block, Description under the gallery, rich text and inline images, Categories and Default category (breadcrumb, URL, structured data), Brand, Related products in the You might also like block |
| Details | Reference, MPN, UPC barcode, GTIN and ISBN in Product details, Display condition on product page, Features in Data sheet, Attached files in Download, and the Customization fields |
| Stocks (standard product) | Quantity, Minimum quantity for sale, When out of stock (deny, allow, or the shop default), Label when in stock, Label when out of stock, Availability date, `ps_emailalerts` back-in-stock form |
| Combinations (combination product) | Selector rendering per attribute type (select, radio, colour swatch), price and quantity update on selection, image swap, combination reference, impossible combination, default combination on load. When out of stock and the two labels are set here, there is no Stocks tab |
| Pack (pack) | Pack content, Pack stock behavior (pack quantity, quantity of the products in the pack, or whichever is lower), availability derived from that setting, pack price different from the sum of its items |
| Virtual product (virtual product) | Add downloadable file: file, filename, Number of allowed downloads, Expiration date, Number of days. Download available from the order once payment is accepted, and no shipping step at checkout since the type has no Shipping tab |
| Shipping | Delivery time, either the shop default or a specific one with separate in-stock and out-of-stock texts, shipping fees, and the Available carriers restriction at checkout. Package dimensions and weight have no visible effect on the product page |
| Pricing | Retail price tax excl. and incl., Tax rule, Display retail price per unit, On sale flag, specific prices with a struck-through price, the quantity discount table and its priority order, price excl. tax for B2B |
| SEO | Meta title, Meta description, Friendly URL, canonical, Redirection page and Redirection when offline with its Target category, Tags |
| Options | Visibility (everywhere, catalog only, search only, nowhere), Available for order, Show price, Web only, Suppliers |

Also on the product page:

- [ ] Image gallery: thumbnails, zoom, fullscreen modal, keyboard arrows
- [ ] Add to cart: toast, cart preview updated, quantity respected
- [ ] Quantity below the minimum is refused
- [ ] Customisation, from the Customization fields on the Details tab: text and file fields, required ones block add to cart while optional ones do not, errors shown on the field, saved value visible in the cart and on the order
- [ ] Accessories block, titled You might also like: rendered when Related products are set on the Description tab, absent when none are
- [ ] Accessory miniatures behave like listing ones: flags, review stars, add to cart, quickview, and the See details fallback
- [ ] A disabled or non-visible product set as an accessory does not appear
- [ ] The block is rendered without the `container` wrapper, so check its width against the rest of the page
- [ ] `ps_sharebuttons`, `productcomments`, `ps_productinfo`, `ps_categoryproducts`, `ps_crossselling`, `ps_viewedproduct`
- [ ] Product JSON-LD present and valid

### 3.5 Cart

- [ ] Empty cart page
- [ ] Product lines: image, attributes, unit price, line total
- [ ] Customised product: a Customized button on the line, opening a modal that lists each field label with the value entered
- [ ] Text field shown as entered, including a long value and special characters
- [ ] Image field: thumbnail in the modal, clicking it opens the large image in a second modal, and Back returns to the first with focus and scroll lock intact
- [ ] Two customised products in the cart each open their own modal, and the same product added twice with different customisations makes two lines with their own values
- [ ] Customisation still readable further down the funnel: checkout summary, order confirmation, order detail. The checkout summary line renders attributes only, so confirm what is expected there
- [ ] Quantity update and removal recompute the totals
- [ ] Voucher: apply, invalid code, remove
- [ ] Subtotals: products, shipping, taxes, discounts, gift wrapping
- [ ] Minimum cart total blocks checkout (Shop Parameters > Order settings)
- [ ] `ps_featuredproducts` in `displayCrossSellingShoppingCart`
- [ ] Cart preview modal from the header

### 3.6 Checkout

- [ ] Personal information: guest checkout on and off, account creation, login from inside checkout
- [ ] Addresses: new address, address selector, invoice address different from delivery, required fields per country
- [ ] Shipping: carrier list, price per carrier, gift options, order message
- [ ] Payment: each native payment module, mandatory terms checkbox, terms modal
- [ ] Final summary step (Order settings)
- [ ] Step navigation: back to a completed step, unreachable step, mobile step navigation
- [ ] Cart of virtual products only: the Shipping step is gone, the desktop steps are numbered 1 to 3, and the mobile progress ring and its Next labels count three steps rather than four
- [ ] Mixed cart, one virtual and one physical product: the Shipping step is back, and the virtual item is still downloadable from the order
- [ ] Order confirmation: recap table, `ps_cashondelivery`, `ps_checkpayment` and `ps_wirepayment` return pages, `ps_featuredproducts` in `displayOrderConfirmation2`

### 3.7 Multishipment

Enable the `improved_shipment` feature flag in Advanced Parameters > Feature flags **(config)**, then walk the funnel again. It swaps in four templates the default pass never renders, so a change to the single-carrier ones has to be mirrored here.

- [ ] Shipping step: a cart whose products cannot ship together splits into several shipments, each with its own carrier and price
- [ ] Final summary: products grouped by carrier, one Delivery option label and delay per group, and the Edit button returns to the delivery step
- [ ] Order confirmation: the multishipment recap replaces the single-carrier table, and the single Shipping method line in Order details is gone
- [ ] Cart mixing physical and virtual products: physical ones grouped by carrier, virtual ones in their own block below
- [ ] Virtual-only cart with the flag on: no carrier group rendered, and the virtual block sits flush at the top
- [ ] Order detail in the account: Shipment tracking details, one row per shipment, a tracking link when there is one and a dash when there is not
- [ ] Merchandise return on a multishipment order, in both the return and no-return variants of the order detail
- [ ] Flag turned back off: the single-carrier templates return and nothing is left over

### 3.8 Customer account

- [ ] Login, logout, wrong credentials, password reset (`password-email`, `password-new`, `password-infos`)
- [ ] Registration, guest account transformation
- [ ] `my-account` links grid, each tile
- [ ] Identity form, GDPR consent (`psgdpr`), personal data export
- [ ] Addresses: create, edit, delete
- [ ] Order history, order detail, reorder button
- [ ] Merchandise returns (Customer Service > Merchandise Returns): request, detail, no-return variants, multishipment variants
- [ ] Credit slips
- [ ] Vouchers page, once a cart rule applies to the customer
- [ ] `ps_emailalerts` notification list
- [ ] Guest tracking

### 3.9 CMS and static pages

- [ ] CMS page and CMS category
- [ ] Sitemap, including the nested list
- [ ] Stores page: map, store list, opening hours (Shop Parameters > Contact > Stores)
- [ ] Contact page: `contactform` widget, file attachment, order selector, `ps_contactinfo` in both side columns

### 3.10 Error and edge pages

- [ ] 404 and not-found
- [ ] 410
- [ ] Forbidden
- [ ] Maintenance **(config)**
- [ ] Restricted country **(config)**
- [ ] Catalogue mode: no price, no add to cart **(config)**
- [ ] Shop closed for visitors **(config)**

## 4. Back-office settings and their front-office impact

Not a separate pass. These are the settings that change what section 3 renders, so the default install only ever shows one side of each. Flip a setting, re-check the page named in the impact column, then restore it. Everything in this section is **(config)**.

### 4.1 Product settings

| Setting | FO impact |
| --- | --- |
| Pagination and products per page (Shop Parameters > Product Settings) | Pagination on every listing |
| Display available quantities | Stock counter on the product page |
| Allow ordering of out-of-stock products | Add to cart enabled while out of stock |
| Display unavailable attributes | Impossible combinations shown or hidden |
| Catalogue mode | Prices and add to cart removed site-wide |

### 4.2 Customer settings

| Setting | FO impact |
| --- | --- |
| Enable B2B mode (Customer settings > General) | Adds the Identification number field |
| Customer group price display, tax incl. or excl. | Every price on the site |
| Ask for birth date, opt-in, partner offers | Registration and identity forms |
| Enable guest checkout | Checkout personal information step |

### 4.3 General settings

| Setting | FO impact |
| --- | --- |
| Contact details and stores (Contact > Stores) | Header, footer, Stores page, Contact page |
| Display suppliers | Enables `/suppliers` |
| Display brands | Enables `/brands` |
| Display best sellers | Enables `/best-sales` |
| Display merchandise returns | Returns section in the customer account |
| Cart rules (Catalog > Discounts) | Voucher block in the customer account and in the cart |

### 4.4 Order settings

| Setting | FO impact |
| --- | --- |
| Final summary | Recap step before confirmation |
| Guest checkout | Order without account creation |
| Reorder from order history | Reorder button |
| Minimum cart total | Checkout blocked under the threshold |
| Terms and conditions | Mandatory checkbox before validation |
| Gift options | Extra field on the shipping step |

### 4.5 Coverage

- [ ] Every setting above flipped, its impact page re-checked, and the original value restored
- [ ] Settings that gate a whole page (suppliers, brands, best sellers, merchandise returns) checked in both states
- [ ] Every setting left as it was found, verified before starting section 5

## 5. Native module test list

Every native module Hummingbird overrides or hooks. Hooks come from `config/theme.yml`, templates from `modules/<name>/`. JS means the module has theme-side TypeScript in `src/js/modules/`.

Module versions are pinned by the core, not by the theme. Record the ones you tested against, from the PrestaShop checkout:

```
composer show 'prestashop/*' --direct | grep -E 'blockreassurance|contactform|productcomments|psgdpr|ps_'
```

Three overrides target modules the core does not require, so a stock install will not exercise them. They are still published on Packagist and can be installed by hand: `ps_advertising`, `ps_productinfo`, `ps_rssfeed`. Check them against the core's `composer.json` before reporting them as dead overrides.

### 5.1 Header and navigation

| Module | Hook or location | Check |
| --- | --- | --- |
| `ps_mainmenu` (JS) | `displayTop` | Desktop dropdowns, mega menu, mobile burger, deep category trees, keyboard and screen reader traversal |
| `ps_searchbar` (JS) | `displayTop`, unhooked from `displaySearch` | Autocomplete list, debounce, no-result state, submit, mobile layout |
| `ps_customersignin` | `displayNav2` | Signed-out and signed-in states, dropdown, links |
| `ps_shoppingcart` (JS) | `displayNav2` | Item count badge, preview modal, product lines, empty cart, update after add to cart |
| `ps_languageselector` (JS) | `displayNav2` | Switch stays on the current page, single-language shop |
| `ps_currencyselector` (JS) | `displayNav2` | Switch reformats prices, single-currency shop |
| `ps_contactinfo` | `displayNav1`, `displayFooter`, `displayContactLeftColumn`, `displayContactRightColumn` | `nav.tpl` in the header, full and rich variants, empty fields hidden |
| `blockreassurance` | `displayAfterBodyOpeningTag`, `displayNavFullWidth`, `displayFooterBefore`, `displayFooterAfter`, `displayReassurance` | Block and white block variants, product variant, custom icons and colours (`PSR_ICON_COLOR`, `PSR_TEXT_COLOR`) |

### 5.2 Home page blocks

| Module | Hook or location | Check |
| --- | --- | --- |
| `ps_imageslider` | `displayHome` | Autoplay, arrows, dots, swipe, single slide, no slide, image sizes |
| `ps_customtext` | `displayHome` | Rich text, images, empty content |
| `ps_featuredproducts` | `displayHome`, `displayCrossSellingShoppingCart`, `displayOrderConfirmation2` | Product count from its configuration, category selection, empty state |
| `ps_banner` | `displayHome` | Image, link, empty state |
| `ps_newproducts` | `displayHome`, `/new-products` | Block and page, no-new-product state |
| `ps_bestsellers` | `displayHome`, `/best-sales` | Block and page, needs order history |

### 5.3 Listings and catalogue

| Module | Hook or location | Check |
| --- | --- | --- |
| `ps_facetedsearch` (JS) | `displayLeftColumn` | Each facet widget type, active filters, clear all, URL sync, browser back and forward, mobile filter panel, slider bounds |
| `ps_categorytree` (JS) | `displayLeftColumn` | Expand and collapse, current category highlighted, deep nesting |
| `ps_specials` | Column or home block, `/prices-drop` | Needs an active specific price |
| `ps_brandlist` | Column block, `/brands` | Disabled by default. Block, form variant, text variant |
| `ps_supplierlist` | Column block, `/suppliers` | Disabled by default. Same three variants |
| `ps_advertising` | Column block | Not required by the core, install it first. Image, link, empty state |
| `ps_rssfeed` | Column block | Not required by the core, install it first. Valid feed, unreachable feed, malformed feed |

### 5.4 Product page

| Module | Hook or location | Check |
| --- | --- | --- |
| `productcomments` (JS) | `displayProductAdditionalInfo`, `displayProductListReviews`, `displayFooterProduct` | Average grade stars on miniatures and product page, review list and pagination, post-comment modal, validation errors, confirm and alert modals, empty state, moderation on and off |
| `ps_sharebuttons` | `displayProductAdditionalInfo` | Each network, share URL |
| `ps_emailalerts` (JS) | `displayProductAdditionalInfo`, `displayCustomerAccount` | Back-in-stock form on an out-of-stock product, email validation, account notification list |
| `ps_viewedproduct` | `displayProductAdditionalInfo`, `displayFooterProduct` | Fills after browsing, respects `PRODUCTS_VIEWED_NBR` |
| `ps_categoryproducts` | `displayFooterProduct` | Same-category products, `CATEGORYPRODUCTS_DISPLAY_PRODUCTS`, product alone in its category |
| `ps_crossselling` | Product page and cart | Needs order history, empty state |
| `ps_productinfo` | Product page | Not required by the core, install it first. Additional information block |

### 5.5 Checkout and payment

| Module | Hook or location | Check |
| --- | --- | --- |
| `ps_cashondelivery` | Payment step, `payment_return`, `displayOrderConfirmation` | Option listed, return page, order state |
| `ps_checkpayment` | Payment step, `payment_return` | Option listed, payee details on the return page |
| `ps_wirepayment` | Payment step, `payment_return` | Option listed, bank details on the return page |

### 5.6 Footer, account and legal

| Module | Hook or location | Check |
| --- | --- | --- |
| `ps_linklist` | `displayFooter` | Footer link blocks and column variant, several blocks, empty block |
| `ps_customeraccountlinks` | `displayFooter` | Links match the enabled account features |
| `ps_emailsubscription` | `displayFooterBefore` | Subscribe, unsubscribe, invalid email, already subscribed, GDPR consent, column variant |
| `ps_socialfollow` | `displayFooterBefore`, unhooked from `displayFooter` | Each network, empty configuration |
| `contactform` | `displayContactContent` | Subject list, order selector for logged-in customers, file attachment, validation errors, success message |
| `psgdpr` (JS) | `displayGDPRConsent`, `displayCustomerAccount` | Consent checkbox blocks submission on every form that hosts it, personal data page, export and deletion request |

### 5.7 Coverage

- [ ] Each module above visited once per profile
- [ ] Modules whose absence changes the layout checked disabled, so at least one per hook position: header nav, home block, column block, footer block, product block. No empty wrapper, no collapsed grid **(config)**
- [ ] Each column module checked in the left and the right column
- [ ] Each product block checked with 0, 1 and several products
- [ ] Module versions under test recorded alongside the results
- [ ] `ps_advertising`, `ps_productinfo` and `ps_rssfeed` either installed and tested, or reported as out of scope for this pass

## 6. Accessibility

Run on home, a category, a product, the cart, the checkout and the account.

- [ ] Keyboard only: every page usable and every form completable, in a sensible order
- [ ] Focus always visible, and never lost or stranded after a modal or a panel closes
- [ ] Forms: every field labelled, errors reaching the user and pointing at the field
- [ ] Colour contrast at WCAG AA
- [ ] Zoomed in, without loss of content or function
- [ ] VoiceOver on macOS and iOS through the full purchase funnel, including cart and filter updates
- [ ] axe or Lighthouse accessibility audit clean

## 7. Responsive and performance

Minimum tested width is 375px. Widths come from `$grid-breakpoints` in `src/scss/bootstrap/overrides/variables/_variables.scss`; the `xxs` tier and the 360px start of `xs` sit below the floor and are out of scope:

| Breakpoint | From | In scope |
| --- | --- | --- |
| `xxs` | 0 | no |
| `xs` | 360px | from 375px |
| `sm` | 576px | yes |
| `md` | 768px | yes |
| `lg` | 992px | yes |
| `xl` | 1200px | yes |
| `xxl` | 1400px | yes |

- [ ] 375px, the narrowest supported width
- [ ] Every boundary from `sm` up, entered from below and from above, checking the boundary itself and one pixel under it
- [ ] No horizontal scroll at any width
- [ ] Touch targets large enough on mobile
- [ ] Tables and wide blocks scroll inside their own container
- [ ] Lighthouse on home, category and product, compared with the previous release
- [ ] No layout shift from images or late-loading modules
- [ ] Fonts and above-the-fold assets preloaded (`_partials/preload.tpl`)

## 8. Sign-off

For each defect, record:

- Page and URL, profile, browser, viewport
- Steps to reproduce from a clean cart and session
- Expected result, actual result, screenshot or recording
- Whether it reproduces on the previous theme version
- Layer (theme, module or core) and the repository it belongs to

The pass is signed off when every section is checked or has an issue linked against it.

## 9. Keeping this file current

Every list here is derived from something in the repository, so a change to one of these means a change to this file, in the same pull request:

| Source | What it drives |
| --- | --- |
| `config/theme.yml` | Hook assignments and the modules disabled by default in section 5, the layouts in the regression sweep, image types, the per-block product counts in 3.1 |
| `modules/` | The module list in section 5, one entry per overridden module |
| `templates/` | The pages in section 3 and the partials in 2.3. A new page or partial needs a line |
| `src/js/modules/` | Which modules are marked JS in section 5 |
| `src/scss/bootstrap/overrides/variables/_variables.scss` | The breakpoint table in section 7 |
| `README.md` | Sections 1.1 and 1.2, which link to it rather than restate it |
| The core's `composer.json` | Which native modules ship, and the theme version an Option B install resolves |

Also worth a pass when the back office changes: the product tabs in 3.4 and the settings in section 4 were read from a running back office, so a renamed tab or a moved field silently invalidates a row. Feature flags are the other moving part, since a new one can add a template path the way `improved_shipment` did in 3.7.
