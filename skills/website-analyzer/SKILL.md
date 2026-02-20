---
name: website-analyzer
description: Deep analysis of e-commerce websites — structure, UX, SEO, performance
---

# E-commerce Website Analyzer

You perform comprehensive analysis of e-commerce websites covering structure, UX patterns, SEO, and technical quality.

## Tools

- **Playwright** — Navigate, snapshot, screenshot, execute JS for DOM inspection.
- **Python (beautifulsoup4)** — HTML parsing for structural analysis.
- **Python (advertools)** — SEO crawling and sitemap analysis.

## Workflow

### Step 1: Initial Crawl
```python
import advertools as adv
sitemap_df = adv.sitemap_to_df('{url}/sitemap.xml')
print(f"Pages in sitemap: {len(sitemap_df)}")
```
Navigate homepage with Playwright. Full-page screenshot. Capture accessibility snapshot.

### Step 2: Page Structure
For each key page type (homepage, category, product, cart), analyze:
```python
from bs4 import BeautifulSoup
import requests
resp = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})
soup = BeautifulSoup(resp.text, 'html.parser')
# Heading hierarchy, schema markup, meta tags, Open Graph
```

### Step 3: Product Page Deep Dive
Check: H1, price display, image gallery (count, alt text), variant selection, add-to-cart visibility, trust signals, cross-sell sections, Schema.org Product markup.

### Step 4: SEO Audit
Check robots.txt, internal link structure, image alt text coverage.

### Step 5: Performance (via Playwright JS)
```javascript
const entries = performance.getEntriesByType('navigation');
const nav = entries[0];
return {
  ttfb: nav.responseStart - nav.requestStart,
  domContentLoaded: nav.domContentLoadedEventEnd - nav.startTime,
  loadComplete: nav.loadEventEnd - nav.startTime,
  resourceCount: performance.getEntriesByType('resource').length
};
```

## Output Report

```markdown
# Website Analysis: {URL}
**Date:** {date} | **Pages Analyzed:** {n}

## Site Overview
- Platform: {Shopify, WooCommerce, custom, etc.}
- Sitemap pages: {n}

## Page Structure
| Page Type | H1 | Title Tag | Meta Desc | Schema | Score |
|-----------|-----|-----------|-----------|--------|-------|

## UX Observations
### Strengths
### Issues
| Issue | Severity | Page | Recommendation |

## SEO Summary
| Factor | Status | Notes |

## Performance
| Metric | Value | Rating |

## Priority Recommendations
1. {highest impact fix}
2. {second priority}
3. {third priority}
```

## Rules
- Request permission before crawling more than 20 pages.
- Respect robots.txt.
- Take screenshots to support findings.
- Compare against Baymard Institute benchmarks where applicable.
