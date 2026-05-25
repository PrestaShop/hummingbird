# Hummingbird — Product Context

## Product Role

Hummingbird is the official default theme for PrestaShop 9.1+. It ships with
the platform as the production-ready reference implementation — the theme a
merchant gets out of the box and a developer forks as their baseline.

It defines what "correct" looks like for PrestaShop frontend development. All
other themes, modules, and integrations are implicitly measured against it.

As a developer-first product, most of its value is architectural: a structured
SCSS system, a declarative JS/TS component model, and a clear boundary with the
Core. New features are predominantly technical — better patterns, stronger
conventions, improved tooling — rather than new user-facing UI. Accessibility
and performance are first-class quality requirements: regressions in either are
treated as product bugs.

Hummingbird is a rendering layer. It consumes what the PrestaShop Core provides
and renders it — it does not own business logic, and it never will.

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

## Out of Scope

- **Business logic** — pricing rules, promotions, tax calculations, inventory.
  These belong in the PrestaShop Core or dedicated modules.
- **Module-owned features** — payment, B2B workflows, loyalty, marketplace, and
  any other feature delivered by a module. Modules bring their own templates;
  the theme provides no dedicated UI for them.
- **Multi-shop configuration** — shop group logic, domain routing.
- **Back-office UI** — admin panels, product editing, order management.
- **Session state and data persistence** — the theme has no ownership over user
  state or stored data.
- **SEO meta strategy** — meta content and structured data are the Core's
  responsibility; the theme renders what it receives.
