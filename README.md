# Duncan Index Analysis: 50-Year Longitudinal Study of Gender Occupational Segregation

## Overview

This comprehensive project analyzes gender occupational segregation across UK regions using the Duncan Index of Dissimilarity over a 50-year period (1971-2021). The study employs advanced statistical analysis, geospatial visualization, and temporal trend analysis to examine how occupational gender segregation has evolved across different regions and time periods using census data.

## What is the Duncan Index?

The Duncan Index ranges from 0 to 1, where:
- **0** = Perfect integration (no segregation)
- **1** = Complete segregation

The index represents the proportion of one group that would need to change occupations to achieve an even distribution across all occupational categories.

## Dataset

- **Source**: UK Census data spanning 50 years
- **Time Period**: 1971, 1981, 1991, 2001, 2011, 2021
- **Population**: Ages 16 and over
- **Geographic Level**: Regional analysis (10 UK regions)
- **Occupational Categories**: 
  - 9 major occupation groups (1981-2021)
  - 27 detailed occupation categories (1971)
- **Input Files**: Paired male/female employment data by region and census year

## Key Features

### Longitudinal Analysis
- **50-year trend analysis** across six census periods
- **Regional comparison** across 10 UK regions
- **Time series visualization** showing occupational segregation evolution
- **Statistical significance testing** for temporal changes

### Advanced Visualizations
1. **Spaghetti Plots**: Individual region trajectories over time
2. **Ridgeline Plots**: Distribution analysis by region and time period
3. **Geospatial Heatmaps**: Interactive maps showing regional variations
4. **Histograms**: Frequency distributions for each census year

### Statistical Analysis
- **Paired t-tests** for temporal comparisons
- **Friedman test** for non-parametric analysis across multiple time points
- **ANOVA** for variance analysis between periods
- **Pairwise comparisons** with significance testing

## File Structure

```
project/
├── DI_by_region_1971_to_2021_Ridgeline_Geospatial_&_Stats_Final_Sara_Paths.R
├── Data Files/
│   ├── f_1971r.xlsx, m_1971r.xlsx    # 1971 Census data
│   ├── f_1981r.xlsx, m_1981r.xlsx    # 1981 Census data
│   ├── f_1991r.xlsx, m_1991r.xlsx    # 1991 Census data
│   ├── f_2001r.xlsx, m_2001r.xlsx    # 2001 Census data
│   ├── f_2011r.xlsx, m_2011r.xlsx    # 2011 Census data
│   └── f_2021r.xlsx, m_2021r.xlsx    # 2021 Census data
├── Shapefiles/
│   └── shapefiles_december_2021/     # Geographic boundary data
└── Output/
    ├── duncan_per_region_[year].csv  # Results by year
    └── Generated visualizations
```

## Dependencies

```r
library(tidyverse)
library(readxl)
library(dplyr)
library(ggplot2)
library(ggridges)
library(maps)
library(mapdata)
library(maptools)
library(rgdal)
library(ggmap)
library(rgeos)
library(broom)
library(plyr)
```

## Key Analytical Components

### 1. Duncan Index Calculation
Core function applies the standardized formula:
```
Duncan Index = (1/2) × Σ|Fi/F - Mi/M|
```

### 2. Temporal Analysis
**Spaghetti Plot Visualization**: Tracks each region's trajectory across all six census periods, revealing:
- Regional convergence patterns
- Persistent regional differences
- Periods of rapid change vs. stability

### 3. Distribution Analysis
**Ridgeline Plots**: Show distribution density of Duncan indices:
- **By Region**: Comparing occupational segregation patterns across geographic areas
- **By Time Period**: Examining how the overall distribution has shifted over 50 years

### 4. Geospatial Analysis
**Interactive Heatmaps**: Six choropleth maps (one per census year) showing:
- Geographic clustering of high/low segregation
- Regional diffusion patterns over time
- Spatial autocorrelation in occupational patterns

### 5. Statistical Validation
**Comprehensive Testing Suite**:
- **Paired t-tests**: All pairwise temporal comparisons (15 combinations)
- **Friedman test**: Overall significance across all time periods
- **Post-hoc analysis**: Wilcoxon signed-rank tests for detailed comparisons

## Key Findings Framework

### Regional Patterns
The analysis enables identification of:
- **Persistent leaders** in gender integration
- **Lagging regions** with continued high segregation
- **Convergence patterns** between regions over time

### Temporal Trends
Statistical analysis reveals:
- **Significant overall decline** in occupational segregation (1971-2021)
- **Period-specific changes** during economic transitions
- **Regional variation** in pace of change

### Geographic Insights
Spatial analysis shows:
- **Urban-rural differences** in occupational integration
- **Economic base effects** on segregation patterns
- **Policy impact zones** where intervention may be most effective

## Applications

This comprehensive analysis framework supports:

**Academic Research**:
- Longitudinal studies of labor market evolution
- Gender equality research with spatial components
- Economic geography and regional development studies

**Policy Development**:
- Evidence-based gender equality initiatives
- Regional economic development strategies
- Targeted intervention program design

**Economic Analysis**:
- Labor market flexibility assessment
- Regional competitiveness evaluation
- Skills gap identification by geography

## Technical Innovation

### Data Processing Pipeline
1. **Multi-year harmonization** of occupational classifications
2. **Robust validation** with cross-checking across regions
3. **Automated workflow** for consistent analysis across time periods

### Visualization Advancement
- **Multi-layered temporal mapping** showing change over time
- **Interactive ridgeline analysis** for detailed distribution examination
- **Statistical overlay** on geographic visualization

### Statistical Rigor
- **Multiple testing correction** for temporal comparisons
- **Non-parametric alternatives** for robust analysis
- **Effect size calculation** beyond significance testing

## Reproducibility Notes

- File paths require updating for local system implementation
- Shapefile dependencies need local installation
- Statistical output formatting may vary by R version
- Color schemes optimized for accessibility and publication

## Future Extensions

**Enhanced Analysis**:
- **Machine learning models** for trend prediction
- **Causal inference** methods for policy evaluation
- **Multi-level modeling** incorporating economic indicators

**Expanded Scope**:
- **International comparative analysis** using similar methodology
- **Sub-regional analysis** at county/local authority level
- **Sectoral decomposition** beyond broad occupational categories

**Technical Development**:
- **Interactive dashboard** for real-time exploration
- **Automated reporting** pipeline for policy updates
- **API integration** for live data feeds

## Citation and Methodology

This analysis builds upon established segregation measurement techniques while introducing innovative longitudinal and spatial components. When using this methodology, please cite relevant literature on Duncan Index applications and acknowledge the comprehensive temporal scope of this particular implementation.

## Data Sources and Acknowledgments

Census data sourced from UK National Statistics with appropriate permissions. Geographic boundary data from official UK mapping sources. Statistical methodology validated against established econometric literature on occupational segregation measurement.
