# Hummingbird — Product Context

## Product Role

Hummingbird is the official default theme for PrestaShop 9.1+. Its primary purpose
is to serve as the production-ready reference implementation that ships with the
platform — not a blank starter, not a showcase, but the theme a merchant gets
out of the box and a developer forks as their baseline.

It defines what "correct" looks like for PrestaShop frontend development:
accessibility, performance, separation of concerns, and compatibility with the
Core's Smarty variable contracts. All other themes, modules, and integrations
are implicitly measured against it.

## Users

**Theme developers (primary)**
Agencies, freelancers, and in-house teams who fork Hummingbird to build custom
themes for merchants. They need the codebase to be predictable, well-structured,
and safe to extend without fighting the architecture.

**PrestaShop Core contributors**
Members of the PS team and open-source contributors who evolve the theme
alongside the Core. They need clear boundaries between what belongs in the theme
versus the Core, and reliable conventions for adding features without regressions.

**Module developers**
Developers building PrestaShop modules who need their front-office templates to
integrate cleanly with the default theme. They rely on Hummingbird's HTML
structure, CSS layers, and JS architecture to be stable and documented.

**Merchants (indirect)**
End users of PrestaShop stores running Hummingbird. They are not direct consumers
of this repo but are the ultimate beneficiaries of its quality. Performance,
accessibility, and browser compatibility decisions are made with them in mind.

## Key Flows

These are the storefront flows Hummingbird owns end-to-end:

- **Product catalog** — category listing, search results, filters
- **Product page** — detail, gallery, variants, add-to-cart
- **Cart** — line items, quantity update, coupon, summary
- **Checkout** — address, shipping, payment selection, order confirmation
- **Customer account** — login, registration, order history, returns
- **CMS pages** — static content, contact form
- **Error pages** — 404, maintenance

## Business Rules

- **Strict presentation boundary.** Hummingbird is a rendering layer only. It
  consumes Smarty variables injected by the Core and renders HTML. It never
  queries the database, overrides controllers, or duplicates business logic.

- **Core contract compliance.** The theme must remain compatible with every
  Smarty variable and hook provided by the supported PrestaShop version (9.1+).
  If a variable or hook is missing, the fix belongs in the Core — not in a
  Smarty plugin workaround inside the theme.

- **Module template isolation.** Modules may override theme templates via the
  standard PrestaShop override mechanism. The theme must not break this contract
  by hardcoding assumptions about module output.

- **Accessibility is non-negotiable.** All rendered markup must meet W3C
  WAI-ARIA standards. Accessibility regressions are treated as bugs, not
  cosmetic issues.

- **No jQuery.** The theme targets modern browsers and must not introduce jQuery
  as a dependency, even transitively through third-party scripts.

## Out of Scope

The following are explicitly not the theme's responsibility:

- **Business logic** — pricing rules, promotions, tax calculations, inventory.
  These belong in the PrestaShop Core or dedicated modules.
- **Module-owned features** — payment, B2B workflows, loyalty, marketplace, and
  any other feature delivered by a module. These render via the standard
  PrestaShop override mechanism; the theme provides no dedicated templates for
  them.
- **Multi-shop configuration** — shop group logic, domain routing.
- **Back-office UI** — admin panels, product editing, order management.
- **Data persistence** — the theme holds no state beyond the current page render.
- **SEO meta strategy** — meta tags are injected by the Core; the theme renders
  what it receives.
