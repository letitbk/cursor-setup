Analyze the e-commerce data file for key metrics: $ARGUMENTS

If no file path was provided above (blank after the colon), ask the user for the path to their data file (CSV, TSV, Excel, or JSON).

## Step 1: Data Validation

Before analysis, validate the file:
- Check the file exists and is readable
- Inspect encoding and line endings: `file {path}` and `head -c 200 {path} | cat -v`
- Print column names, row count, and first 5 rows
- Check for missing values, duplicate rows, and data type issues
- Report any problems found before proceeding

Ask the user to confirm the data looks correct before continuing.

## Step 2: E-Commerce Metrics Analysis

Analyze for these metric categories (report whichever are present in the data):

**Revenue Metrics**: GMV, AOV, revenue by channel/category, refund rate
**Conversion Metrics**: Conversion rate, cart abandonment rate, funnel drop-off points
**Customer Metrics**: CAC, LTV, repeat purchase rate, cohort retention
**Product Metrics**: Top/bottom sellers, inventory turnover, return rate by product
**Growth Metrics**: MoM and YoY trends, new vs returning customer split

For each metric:
- State current value with date range
- Flag anomalies (spikes, drops, outliers)
- Compare to typical e-commerce benchmarks

## Step 3: Summary & Recommendations

Output markdown with:
- Executive dashboard of top-line numbers
- 3-5 actionable insights ranked by potential revenue impact
- Suggested follow-up analyses
- Data quality warnings

Save as `metrics-analysis-{date}.md` in the current working directory.
