# Hummingbird — Design System

## Source of Truth

The Figma file is the visual reference for all Hummingbird components and pages.
It is public and open to the community, agencies, and module developers without
login.

**Figma:** [HUMMINGBIRD — new](https://www.figma.com/design/ZlLqiOjTVXVlVu49sSsD8P/HUMMINGBIRD--new-?node-id=0-1)
Access: public, read-only.

The file is organized as follows:

- **One Figma page per storefront page** — each contains a `DESKTOP` frame and
  a `MOBILE` frame side by side.
- **Components** — component library (atoms, molecules, organisms).
- **Icons** — icon set.

Storefront pages covered: Home, Product, Category, Cart, Checkout, Sign in,
Contact, Stores, My account, 404.

### Desktop vs. Mobile coverage

| Version | Status | Notes |
|---------|--------|-------|
| Desktop ✅ | Complete | All storefront pages designed. Reference for implementation. |
| Mobile 🏗️ | In progress | Frames exist for all pages but coverage is incomplete. Do not treat mobile frames as final — verify before implementing. |

The Figma is the reference for new component design and for verifying visual
regressions on desktop. For mobile, align with the desktop Figma intent and flag
gaps rather than improvising.

## Design System

**Framework:** Bootstrap 5.3.3
**Package:** `bootstrap` (npm)
**Override layer:** `src/scss/bootstrap/overrides/` — Bootstrap variable overrides (loaded before Bootstrap core)

Hummingbird does not ship a standalone design system. Bootstrap 5.3.3 is the
design system. The theme's role is to customize it as little as possible while
meeting PrestaShop storefront requirements.

**Maturity:** Production — this is the shipped default theme for PrestaShop 9.1+.
Visual regressions and accessibility regressions are treated as bugs.
