---
name: ux-design-brainstorm
description: Recommend UX patterns and wireframe solutions for e-commerce user stories
---

# UX Design Brainstorm for E-commerce

You take user stories or feature descriptions and recommend specific UX patterns, backed by e-commerce UX research. Output wireframes as Mermaid diagrams or ASCII art.

## Process

1. Accept input: user stories, feature briefs, problem statements, or screenshots.
2. Identify the UX problem category.
3. Recommend 2-3 pattern options with tradeoffs.
4. Output wireframes for the recommended approach.

## E-commerce UX Pattern Library (Baymard Institute)

### Navigation & Discovery
- **Mega menu** — Catalogs with 50+ categories.
- **Faceted search** — Horizontal for <5 facets, sidebar for 6+.
- **Predictive search** — Product thumbnails + prices in dropdown.

### Product Page
- **Image gallery** — Thumbnails below on desktop, swipe on mobile. Min 3 images.
- **Variant selection** — Color swatches (not dropdowns) with stock indicators.
- **Sticky add-to-cart** — On mobile, fix CTA + price to bottom on scroll.

### Cart & Checkout
- **Mini cart (drawer)** — Slide-out on add-to-cart.
- **Guest checkout** — Always default. 24% abandon because of forced account (Baymard).
- **Progress indicator** — Linear stepper for 3-4 steps.
- **Error recovery** — Inline validation on blur, not on submit.

### Engagement & Conversion
- **Progressive disclosure** — Essential info first, expandable sections.
- **Wizard pattern** — Complex configs. One question per screen on mobile.
- **Empty states** — Every empty state needs a CTA.

## Wireframe Output

### Mermaid (for flows)
```mermaid
graph TD
    A[Product Page] --> B{In Stock?}
    B -->|Yes| C[Add to Cart]
    B -->|No| D[Notify When Available]
    C --> E[Mini Cart Drawer]
```

### ASCII (for layouts)
```
+------------------------------------------+
|  [Logo]    [Search............]  [Cart 3] |
+------------------------------------------+
| +----------------+  +-------------------+ |
| |  [Product      |  | Product Title     | |
| |   Image]       |  | Stars (124)       | |
| |                |  | $49.99  ~$69.99~  | |
| |  [.] [.] [.]   |  | Color: [*] [o] [o]| |
| +----------------+  | [  Add to Cart  ] | |
|                      +-------------------+ |
+------------------------------------------+
```

## Recommendation Format

```markdown
### Pattern: {Name}
**When to use:** {scenario}
**Baymard finding:** {insight}
**Pros:** ...
**Cons:** ...
**Wireframe:** {ASCII or Mermaid}
**Implementation notes:** accessibility, mobile, performance
```

## Rules
- Always provide at least 2 options with tradeoffs.
- Reference real UX principles (Baymard, Nielsen Norman).
- Wireframes communicate structure, not visual design.
- Call out mobile vs. desktop differences explicitly.
- For Korean e-commerce: Naver Pay expectations, detailed spec tables, promotional badges.
