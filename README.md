# Duncan Index Analysis: Gender Occupational Segregation by County

## Overview

This project calculates the Duncan Index of Dissimilarity to measure gender occupational segregation across counties using 2011 census data. The Duncan Index is a widely-used measure in sociology and economics that quantifies the degree of segregation between two groups - in this case, males and females across different occupations.

## What is the Duncan Index?

The Duncan Index ranges from 0 to 1, where:
- **0** = Perfect integration (no segregation)
- **1** = Complete segregation

The index represents the proportion of one group that would need to change occupations to achieve an even distribution across all occupational categories.

## Dataset

- **Source**: 2011 Census data
- **Population**: Ages 16 and over
- **Geographic Level**: County-level analysis
- **Occupational Categories**: 9 major occupation groups
- **Input Files**: 
  - `f_2011.xlsx` - Female employment by occupation and county
  - `m_2011.xlsx` - Male employment by occupation and county

## Key Features

### Core Functionality
- Calculates Duncan Index for individual counties
- Processes multiple counties simultaneously
- Generates comparative rankings from most to least segregated
- Creates visualization through histogram
- Exports results for further analysis

### Analysis Outputs
1. **County Rankings**: Sorted list showing gender equality levels
2. **Summary Statistics**: Distribution of segregation across all counties
3. **Visualization**: Histogram showing frequency distribution of Duncan indices
4. **Export**: CSV file with complete results

## File Structure

```
project/
├── duncan_index_script.R          # Main analysis script
├── f_2011.xlsx                    # Female employment data
├── m_2011.xlsx                    # Male employment data
└── duncan_per_county_2011.csv     # Output results
```

## How to Run

### Prerequisites
```r
library(tidyverse)
library(readxl)
```

### Execution Steps
1. Ensure input Excel files are in the correct directory
2. Update file paths in the script to match your system
3. Run the complete script in R/RStudio
4. Results will be displayed in console and saved as CSV

### Key Functions

#### `calc_duncan(f, m)`
Core function that calculates the Duncan Index for given male and female occupation vectors.

**Formula**: 
```
Duncan Index = (1/2) × Σ|Fi/F - Mi/M|
```
Where:
- Fi = females in occupation i
- F = total females
- Mi = males in occupation i  
- M = total males

#### `calc_duncan_per_county(x)`
Wrapper function that applies the Duncan calculation to each county column.

## Results Interpretation

### Low Duncan Index (≤ 0.3)
- **Meaning**: Relatively integrated occupational structure
- **Interpretation**: Gender distribution across occupations is fairly even

### Moderate Duncan Index (0.3 - 0.6)
- **Meaning**: Moderate occupational segregation
- **Interpretation**: Some concentration of genders in specific occupations

### High Duncan Index (≥ 0.6)
- **Meaning**: High occupational segregation
- **Interpretation**: Strong gender concentration in different occupational categories

## Data Processing Pipeline

1. **Import**: Read Excel files containing county-level occupation data
2. **Validate**: Verify column alignment between male and female datasets
3. **Extract**: Isolate the 9 occupation columns for analysis
4. **Transform**: Transpose data so counties become columns, occupations become rows
5. **Calculate**: Apply Duncan Index formula to each county
6. **Analyze**: Sort results and generate descriptive statistics
7. **Visualize**: Create histogram showing distribution of indices
8. **Export**: Save results for further use

## Applications

This analysis can inform:
- **Policy Development**: Understanding regional variations in gender occupational patterns
- **Economic Research**: Studying labor market dynamics and gender equality
- **Social Planning**: Identifying areas for targeted intervention programs
- **Academic Research**: Comparative studies of occupational segregation

## Validation

The script includes validation steps:
- Test calculation using toy data from reference material
- Verification of individual county calculations
- Cross-checking with known examples (Darlington, Newport counties)

## Technical Notes

- Data is automatically converted to numeric format for calculations
- Missing or invalid data should be cleaned before running analysis
- File paths need to be updated for different systems
- Output preserves county names as row identifiers

## Future Enhancements

Potential improvements could include:
- Automated file path detection
- Additional segregation measures (e.g., Gini coefficient)
- Time series analysis across multiple census years
- Geographic visualization mapping
- Statistical significance testing
- Confidence interval calculations

## Contact & Citation

When using this analysis, please cite appropriate census data sources and methodology references for the Duncan Index of Dissimilarity.
