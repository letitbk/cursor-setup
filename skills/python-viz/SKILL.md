---
name: python-viz
description: Publication-quality charts with plotnine and plotly for e-commerce data
---

# Python Visualization for E-commerce

Primary: plotnine (ggplot2 syntax). Secondary: plotly for interactive charts.

## Setup

```python
import pandas as pd
import numpy as np
from plotnine import *
import plotly.express as px
import plotly.graph_objects as go

ecom_theme = (
    theme_minimal() +
    theme(
        figure_size=(10, 6),
        plot_title=element_text(size=14, weight='bold', margin={'b': 12}),
        axis_title=element_text(size=11),
        axis_text=element_text(size=10),
        legend_position='bottom',
        panel_grid_minor=element_blank(),
    )
)

COLORS = ['#2563EB', '#F59E0B', '#10B981', '#EF4444', '#8B5CF6', '#EC4899', '#6B7280']
```

## Chart Templates

### 1. Funnel Chart
```python
def funnel_chart(data, step_col, value_col, title="Conversion Funnel"):
    data = data.copy()
    data['pct'] = data[value_col] / data[value_col].iloc[0] * 100
    data[step_col] = pd.Categorical(data[step_col], categories=data[step_col].tolist(), ordered=True)
    return (ggplot(data, aes(x=step_col, y=value_col))
         + geom_col(fill='#2563EB', width=0.6)
         + geom_text(aes(label='pct'), format_string='{:.1f}%', va='bottom', size=10)
         + labs(title=title, x='', y='Users') + ecom_theme + coord_flip())
```

### 2. Time Series with Rolling Average
```python
def time_series(data, date_col, value_col, title, window=7):
    data = data.copy()
    data[date_col] = pd.to_datetime(data[date_col])
    data['rolling'] = data[value_col].rolling(window).mean()
    return (ggplot(data, aes(x=date_col))
         + geom_line(aes(y=value_col), color='#93C5FD', alpha=0.5)
         + geom_line(aes(y='rolling'), color='#2563EB', size=1)
         + labs(title=title, x='', y=value_col, caption=f'{window}-day rolling avg') + ecom_theme)
```

### 3. A/B Test Results
```python
def ab_test_chart(control_rate, variant_rate, control_ci, variant_ci, metric_name="Conversion Rate"):
    df = pd.DataFrame({
        'Group': ['Control', 'Variant'],
        'Rate': [control_rate, variant_rate],
        'CI_low': [control_ci[0], variant_ci[0]],
        'CI_high': [control_ci[1], variant_ci[1]],
    })
    return (ggplot(df, aes(x='Group', y='Rate', fill='Group'))
         + geom_col(width=0.5) + geom_errorbar(aes(ymin='CI_low', ymax='CI_high'), width=0.15)
         + scale_fill_manual(values=['#6B7280', '#2563EB'])
         + labs(title=f'A/B Test: {metric_name}', x='', y=metric_name)
         + ecom_theme + theme(legend_position='none'))
```

### 4. Cohort Retention Heatmap
```python
def cohort_heatmap(cohort_data, title="Cohort Retention"):
    melted = cohort_data.melt(id_vars='cohort', var_name='period', value_name='retention')
    melted['label'] = melted['retention'].apply(lambda x: f'{x:.0f}%')
    return (ggplot(melted, aes(x='period', y='cohort', fill='retention'))
         + geom_tile(color='white', size=0.5) + geom_text(aes(label='label'), size=8, color='white')
         + scale_fill_gradient(low='#DBEAFE', high='#1E3A8A')
         + labs(title=title, x='Period', y='Cohort') + ecom_theme + theme(legend_position='none'))
```

### 5. KPI Dashboard
```python
def kpi_sparklines(data, date_col, metrics, title="KPI Dashboard"):
    melted = data.melt(id_vars=date_col, value_vars=metrics, var_name='Metric', value_name='Value')
    return (ggplot(melted, aes(x=date_col, y='Value'))
         + geom_line(color='#2563EB', size=0.8) + geom_area(fill='#DBEAFE', alpha=0.3)
         + facet_wrap('~Metric', scales='free_y', ncol=2)
         + labs(title=title, x='', y='') + ecom_theme
         + theme(axis_text_x=element_text(rotation=45, ha='right')))
```

## Export
```python
ggsave(plot, 'chart.png', dpi=300, width=10, height=6)  # Static
fig.write_html('chart.html', include_plotlyjs='cdn')      # Interactive
```

## Rules
- ALWAYS inspect data before plotting: `print(df[col].unique())`, `print(df.head())`.
- ALWAYS label axes, include title, annotate key values.
- Use plotnine by default. Plotly only when interactivity is needed.
- Format: commas for thousands, 1 decimal for %, currency symbols for revenue.
- Save as PNG at 300 DPI by default.
