---
name: datacheck
description: Use when starting work with a new data file, before any analysis or visualization. Also use when encountering parsing errors, unexpected values, or when the user says "check this data" or "what's in this file".
---

# Data Check

Inspect and validate a data file before analysis. Report findings with suggested fixes. Do not auto-fix.

## When to Use

- Before any analysis or visualization on a new data file
- When parsing errors or unexpected values appear
- When switching to a different dataset mid-session
- User says "check", "inspect", "what's in this", "profile" a data file

## When NOT to Use

- File has already been checked in this session and nothing changed
- User just wants to read a specific value (use Read tool directly)

## Workflow

### Step 1: Raw File Inspection

**Before loading into Python**, check the raw file:

```bash
file <filename>                          # encoding detection
head -c 500 <filename> | cat -v          # hidden chars: ^M (CR), BOM, non-UTF8
wc -l <filename>                         # row count sanity check
head -3 <filename>                       # peek at delimiter and header
```

Flag these issues:
| Symptom | Meaning |
|---------|---------|
| `^M` at line ends | Classic Mac `\r` or Windows `\r\n` line endings |
| `\xEF\xBB\xBF` at start | UTF-8 BOM marker |
| Only 1 line from `wc -l` | Entire file on one line (wrong line endings) |
| Mixed delimiters | Inconsistent separator characters |

### Step 2: Load and Summarize

**For CSV/TSV files:**
```python
import pandas as pd
df = pd.read_csv("file.csv")  # or sep='\t' for TSV
```

**For Excel files:**
```python
import pandas as pd
xls = pd.ExcelFile("file.xlsx")
print(f"Sheets: {xls.sheet_names}")
df = pd.read_excel("file.xlsx", sheet_name=0)  # or specific sheet name
```

**For JSON files:**
```python
df = pd.read_json("file.json")
```

Report this table:

| Item | Value |
|------|-------|
| Dimensions | rows x cols |
| Column names | list all |
| Column types | int, float, object, datetime, bool |
| Total missing | count and % |

Then per column:
```
Column          Type        Missing   Unique   Example Values
─────────────────────────────────────────────────────────────
revenue         float64     12 (2%)   845      19.99, 49.50, 129.00
category        object      0 (0%)    8        Electronics, Clothing, Home
order_date      datetime    3 (0.5%)  365      2024-01-15, 2024-02-20
```

### Step 3: Excel-Specific Checks

When the file is `.xlsx` or `.xls`, also report:

1. **Sheet names**: List all sheets and row counts per sheet
2. **Merged cells**: Flag if any exist (they break pandas parsing)
3. **Header row position**: Check if header is row 0 or if there are title rows above
4. **Formula columns**: Columns that had formulas (now resolved to values)
5. **Named ranges**: If any relevant data is in named ranges

### Step 4: Data Quality Checks

Scan ALL columns for common issues:

| Check | What to Look For |
|-------|-----------------|
| Coded missings | 97/98/99, -1/-9/-99 in numeric columns with lower range |
| Placeholder values | "N/A", "n/a", "#N/A", "NULL", "-", "" in string columns |
| Date parsing | Dates stored as strings, mixed formats (MM/DD vs DD/MM) |
| Currency strings | "$1,234.56" stored as text instead of numeric |
| Duplicate rows | Exact duplicates and near-duplicates (same key columns) |
| ID uniqueness | If a column looks like an ID, check it's actually unique |

Report as:
```
DATA QUALITY ISSUES:
  revenue: 15 values are "$X,XXX.XX" strings. Needs: df['revenue'] = df['revenue'].str.replace('[$,]', '', regex=True).astype(float)
  status: contains {'N/A', '-', ''} (n=23). Likely missing values.
  order_date: mixed formats detected (2024-01-15 and 01/15/2024). Needs standardization.
```

### Step 5: Light Profiling

After the structural check:

1. **Numeric columns**: Basic stats (mean, median, min, max, std) + correlation matrix (top 10 strongest pairs)
2. **Categorical columns**: Value counts (top 10 levels per column, flag if >50 unique levels)
3. **Flag**: Numeric columns stored as object (likely parsing issue), zero-variance columns, constant columns

```python
# Quick profiling
print(df.describe(include='all'))
print(df.nunique())

# Correlation matrix for numeric columns
numeric_cols = df.select_dtypes(include='number')
if len(numeric_cols.columns) > 1:
    corr = numeric_cols.corr()
    # Show top correlated pairs
```

### Step 6: Report Summary

Present a concise summary with three sections:

**Clean:** Columns ready for analysis (no issues)

**Needs attention:** Columns with data quality issues. Include suggested fix code but do NOT execute.

```python
# SUGGESTED FIX for revenue currency strings:
df['revenue'] = df['revenue'].str.replace('[$,]', '', regex=True).astype(float)

# SUGGESTED FIX for placeholder missings:
df['status'] = df['status'].replace({'N/A': pd.NA, '-': pd.NA, '': pd.NA})
```

**Notes:** Observations about the data structure (time series detected, panel structure, likely join keys, etc.)

## Quick Reference

| File type | Load with | Extra checks |
|-----------|-----------|-------------|
| `.csv` | `pd.read_csv()` | encoding, delimiter, line endings |
| `.tsv` | `pd.read_csv(sep='\t')` | encoding, line endings |
| `.xlsx` / `.xls` | `pd.read_excel()` | sheets, merged cells, header row |
| `.json` | `pd.read_json()` | nested structure, normalize if needed |
| `.parquet` | `pd.read_parquet()` | just structure check |

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Loading Excel without checking sheets | Always check `pd.ExcelFile(f).sheet_names` first |
| Assuming column types are correct | Check with `df.dtypes` — revenue as object means string |
| Ignoring encoding issues | ALWAYS run `file` and `cat -v` before loading |
| Auto-fixing without asking | Report + suggest. Never auto-recode values |
| Not checking for duplicate rows | Always run `df.duplicated().sum()` |
