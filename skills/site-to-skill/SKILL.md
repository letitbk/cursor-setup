---
name: site-to-skill
description: Analyze a website and auto-generate a reusable SKILL.md for competitive audits
---

# Site-to-Skill Generator

Analyze a website and produce a reusable SKILL.md file that automates weekly competitive audits.

## Purpose

After running this skill, the user gets a new custom skill file that:
- Navigates to specific pages on the target site
- Extracts key data points using CSS selectors
- Compares against previous snapshots
- Produces a structured diff/report

## Process

### Step 1: Discover Site Structure

1. Navigate to the target URL with Playwright.
2. Capture the accessibility snapshot.
3. Identify navigation structure (mega menu, header links, footer links).
4. Build an information architecture map of page types and URL patterns.
5. Ask the user: "Which areas are most important for monitoring?"
   - Pricing & product catalog
   - Feature/product pages
   - Homepage messaging & positioning
   - Blog/content strategy
   - Promotional campaigns

### Step 2: Map Data Extraction Points

Use Playwright to inspect the DOM:
```javascript
document.querySelectorAll('[class*="price"]').forEach(el => {
    console.log(el.className, el.textContent.trim());
});
```

Build a selector map with multiple fallbacks per data point.

### Step 3: Test Extraction

Run selectors against live pages. For each:
- Verify selector returns data
- Record current value as baseline
- Note JS-rendered content needing `browser_wait_for`

### Step 4: Generate the SKILL.md

Output a complete skill file:
```markdown
---
name: audit-{domain}
description: Weekly competitive audit of {domain}
---
# Competitive Audit: {Domain}
## Pages to Monitor
## Data Extraction (per page with CSS selectors)
## Output Format (changes table, snapshots, screenshots)
## Baseline Data (JSON of previous results)
```

### Step 5: Save & Validate

1. Write to `~/.claude/skills/{domain}-audit/SKILL.md`.
2. Dry run to verify all selectors work.
3. Report failed selectors and offer fixes.

## Rules
- Use at least 2 fallback CSS selectors per data point.
- Include `browser_wait_for` for JS-heavy sites.
- Always capture screenshots as evidence.
- Generated skill must be self-contained.
- Store baseline data in the skill file for diffs.
- Note Cloudflare/CAPTCHA blocks and suggest workarounds.
- Keep generated skill under 80 lines.
