---
name: competitive-analysis
description: Research competitors using web search, screenshots, and structured analysis
---

# Competitive Analysis for E-commerce

You research and analyze competitors to produce actionable competitive intelligence.

## Tools & Methods

1. **Web search** — Use the WebSearch tool for competitor info: pricing, features, press releases, reviews, job postings.
2. **Gemini CLI** — For deeper synthesis:
   ```bash
   echo "{detailed research question}" | gemini
   ```
3. **Playwright screenshots** — Capture competitor websites:
   - `browser_navigate` to visit the site.
   - `browser_snapshot` for accessibility tree (structural analysis).
   - `browser_take_screenshot` for visual documentation.
   - Capture: homepage, product page, cart, checkout.

## Research Sequence

1. Ask the user for: your product/company name, 3-5 competitors, focus areas.
2. Web search each competitor for recent news, pricing, features.
3. Use Gemini for synthesis questions.
4. Screenshot key pages.
5. Compile into the framework below.

## Output Framework

```markdown
# Competitive Analysis: {Your Product} vs. Market
**Date:** {date} | **Focus:** {areas}

## 1. Competitor Overview
| Company | Founded | Target Segment | Key Differentiator |
|---------|---------|----------------|-------------------|

## 2. Feature Matrix
| Feature | {Your Product} | {Comp A} | {Comp B} | {Comp C} |
|---------|---------------|----------|----------|----------|
Rate: Y = supported, P = partial, N = not available, ? = unknown

## 3. Pricing Comparison
| Plan/Tier | {Your Product} | {Comp A} | {Comp B} | {Comp C} |
|-----------|---------------|----------|----------|----------|

## 4. SWOT per Competitor
| Strengths | Weaknesses |
|-----------|-----------|
| Opportunities (for us) | Threats (to us) |

## 5. UX Comparison
- Homepage value proposition clarity
- Product discovery (search, filtering, navigation)
- Cart & checkout friction
- Mobile experience
- Trust signals

## 6. Recommended Actions
| Priority | Action | Expected Impact | Effort |
|----------|--------|----------------|--------|
```

## Rules
- Cite sources for all factual claims. Include URLs.
- Mark uncertain information with `(unverified)`.
- Do not make up pricing or feature data. Say "Not publicly available" if unknown.
- Date all screenshots and data points.
