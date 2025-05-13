---
author:
- Kazi Tanvir Hasan, Dr. Gabriel Odom, Cristian Guerini, Dr. Zoran
  Bursac, Dr. Roberto Lucchini, and Dr. Boubakari Ibrahimou
bibliography: references.bib
date: 5/13/25
subtitle: Simulating Multivariate Environmental Exposure Data and
  Estimating Feature Selection Thresholds
title: Helper Functions for Bayesian Kernel Machine Regression
toc-title: Table of contents
vignette: |
  \%`\VignetteIndexEntry{Calculate PIP Threshold from Response Vector}`{=tex}
  %`\VignetteEngine{quarto::html}`{=tex} %`\VignetteLanguage{en}`{=tex}
---

# Abstract

In environmental health studies, the relationship between multiple
environmental exposures and health outcomes, such as cognitive
development, is often investigated using complex datasets that exhibit
non-normality. This paper introduces an R package designed to simulate
multivariate environmental exposure data and estimate feature selection
thresholds to aid in research to apply and extend the Bayesian Kernel
Machine Regression (BKMR) methodology. The package enables researchers
to generate data from multivariate normal and multivariate skewed Gamma
distributions, common in environmental exposure research, and calculate
multivariate statistical features such as mean, variance, skewness,
shape, and rate vectors, and correlation matrices. This package also
facilitates the calculation of a Posterior Inclusion Probability (PIP)
threshold for feature selection in BKMR, offering an approach that
accounts for non-normal data (based on the forthcoming work of
@hasan2025). The effectiveness of the package is demonstrated through a
real-world application using data from an adolescent environmental
exposure study, where metal exposures are related to IQ scores.

## Keywords

R package, Bayesian Kernel Machine Regression, multivariate simulation,
feature selection, environmental exposure, statistical moments,
multivariate Gamma distribution, skewed data

# Introduction

Environmental exposure to metals such as Cadmium, Mercury, Arsenic, and
Lead is linked to various adverse health outcomes, especially among
children [@Horton2013]. In particular, these exposures may influence
cognitive functions, with effects that often vary based on the
concentration of metals in the environment
[@Sanders2015; @trasande2011; @tyler2014; @tolins2014]. Research into
these relationships frequently involves complex, multivariate datasets
where environmental factors are correlated, and data distributions often
exhibit skewness rather than normality
[@bobb2014; @bobb2018; @hasan2024].

The Bayesian Kernel Machine Regression (BKMR) model is a powerful method
for identifying relevant environmental factors and interactions
[@bobb2014; @bobb2018; @wilson2022; @devick2022; @gerwinn2010; @ibrahimou2024].
However, its effectiveness is typically constrained by its assumption of
normality in the data, which is frequently violated in environmental
health studies [@bobb2014; @bobb2018; @hasan2024; @Van2021]. To allow
BKMR to flexibly handle multivariate skewed data, ongoing methodological
innovation is needed, and synthetic data sets are a critical component
of this research. To fill this need for realistic synthetic data sets,
we have developed an R package that facilitates parametric bootstrap
data simulation for multivariate environmental exposures. Further, this
package includes computational results to estimate a Posterior Inclusion
Probability (PIP) threshold which enables feature selection for BKMR via
a hypothesis testing framework with controlled test size, which is
particularly useful when data deviate from multivariate normality
[@hasan2024]. In this chapter, we show how to estimate key statistical
moments from a real data set which includes effects of metals exposures
on children's IQ scores. Then, to facilitate future methodological
innovation, we show how to use these moments as parameter estimates to
simulate multiple synthetic environmental exposure data sets from
multivariate normal and multivariate (skewed) Gamma distributions.
Finally, for the real data analysis application examining exposure to
mixture metals and IQ in a cohort of Italian children, we show how to
apply our threshold equation and to use BKMR results for feature
selection.

# Materials and Methods

## Functionality in this R Package

The package aims to provide a robust framework for simulating non-normal
environmental exposure data and estimating feature selection thresholds
in the context of BKMR. The function names were carefully chosen to
reflect their purpose and actions within the package. We chose simple,
descriptive names to maintain consistency with R's convention of
function names being indicative of their functionality, ensuring that
users can quickly grasp their purpose without extensive documentation.
The core functions of the package include:

1.  Data Simulation: Functions for generating multivariate data from
    Normal, Gamma, and skewed Gamma distributions with the
    `simulate_group_data()` function; this generates data using
    multivariate Normal or Gamma distributions.
2.  Statistical Parameters Estimation: The function
    `calculate_stats_gaussian()` calculates key statistical moments,
    including mean, variance, skewness, and correlation matrix, which
    are essential for understanding the underlying structure of the
    normally distributed data. This function computes the sample size,
    gamma distribution parameters (shape and rate), and Spearman
    correlation matrix for each group, based on the grouping column.
3.  Data Transformation Functions:
    -   Scaling by Standard Deviation or MAD: The `trans_ratio()`
        function scales data by either the standard deviation (SD) or
        the median absolute deviation (MAD).
    -   Logarithmic and Root Transformations: The `trans_log()` function
        applies a logarithmic transformation to the data, and the
        `trans_root()` function allows for fractional root
        transformations, helping to manage skewed data.
4.  Feature Selection Threshold Calculation: The PIP threshold for
    feature selection is computed using the `calculate_pip_threshold()`
    function. This function estimates the threshold based on a
    Four-Parameter Logistic Regression model (Richard's curve), which
    adjusts for variations in data and sample size[@richards1959]. The
    formula used to calculate the PIP threshold is:

```{=tex}
\begin{equation}
y = A + \frac{K - A}{\left( C + e^{-\beta_1 x_1} \right)^{\beta_2 x_2}}.\label{eq1}
\end{equation}
```
In this equation:

-   $y$: the 95th percentile of the PIP values $PIP_{q_{95}}$
-   $A$: Left asymptote, fixed at 0.
-   $K$: Right asymptote, bounded above by 1.
-   $C$: Scaling fit constant.
-   $\beta_1, \beta_2$: Midpoint shift parameters for CV and sample
    size.
-   $x_1$: Log-transformed CV $\log_2(\text{CV})$.
-   $x_2$: Log-transformed sample size $\log_{10} (\text{Sample Size})$.

A dynamic threshold function was derived from the logistic model to
adjust thresholds based on CV and sample size[@hasan2024].

```{=tex}
\begin{equation}
    \text{Threshold} = \frac{1}{\left( 1.30460 + e^{-0.59867 \log_2 (\text{CV})} \right)^{0.43565 \log_{10} (\text{SampleSize})}}
\end{equation}
```
## Software Implementation

The simBKMRdata software is implemented as an R package. It depends on
the following packages: bkmr[@bkmr], fields[@fields], base[@base] and
MASS[@MASS]. The R software and these required packages can be obtained
from the CRAN website. Furthermore, daily builds of package simBKMRdata
are provided on the CRAN website
\[https://cran.r-project.org/web/packages/simBKMRdata/index.html\]. It
has been published under GPL version 3. The source code is available on
GitHub at \[https://github.com/khasa006/simBKMRdata\].

To install the package from CRAN, use:

::: cell
``` {.r .cell-code}
install.packages("simBKMRdata")
```
:::

For GitHub installation of development version (potentially unstable),
use:

::: cell
``` {.r .cell-code}
devtools::install_github("khasa006/simBKMRdata")
```
:::

Now we load the necessary libraries:

::: cell
``` {.r .cell-code}
library(tidyverse)
library(simBKMRdata)
library(gt)
```
:::

# Example Analysis of Heavy Metal Exposure

We began by examining the real-world environmental exposure dataset
derived from the cohort study led by Lucchini and colleagues. The
dataset comprises measurements of five key metal concentrations in
children---Cadmium, Mercury and Arsenic from urine, Lead from blood and
Manganese from hair, along with corresponding intelligence quotient (IQ)
scores, evaluated using the Wechsler Intelligence Scale for Children
(WISC-IV), a standardised instrument for assessing children's Full-Scale
IQ (FSIQ)[@wechsler2003; @orsini2012; @grizzle2011; @renzetti2021].

## Data Exploration

Our example pediatric heavy metals exposure data set is included in the
package as `metalExposChildren_df`. We include biological sex as a
covariate. The data set includes other variables, but we ignore these
for the scope of this work.

::: cell
``` {.r .cell-code}
data("metalExposChildren_df")

analysisData_df <- metalExposChildren_df %>%
  select(QI, Cadmium:Manganese, Sex)

head(analysisData_df) %>%
  gt() %>%
  tab_header(
    title = "Top Rows of the Data"
  ) %>%
  fmt_number(
    decimals = 2
  ) %>%
  opt_table_outline()
```

::: cell-output-display
```{=html}
<div id="awxelhtwhp" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#awxelhtwhp table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#awxelhtwhp thead, #awxelhtwhp tbody, #awxelhtwhp tfoot, #awxelhtwhp tr, #awxelhtwhp td, #awxelhtwhp th {
  border-style: none;
}

#awxelhtwhp p {
  margin: 0;
  padding: 0;
}

#awxelhtwhp .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 3px;
  border-top-color: #D3D3D3;
  border-right-style: solid;
  border-right-width: 3px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 3px;
  border-bottom-color: #D3D3D3;
  border-left-style: solid;
  border-left-width: 3px;
  border-left-color: #D3D3D3;
}

#awxelhtwhp .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#awxelhtwhp .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#awxelhtwhp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#awxelhtwhp .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#awxelhtwhp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#awxelhtwhp .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#awxelhtwhp .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#awxelhtwhp .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#awxelhtwhp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#awxelhtwhp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#awxelhtwhp .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#awxelhtwhp .gt_spanner_row {
  border-bottom-style: hidden;
}

#awxelhtwhp .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#awxelhtwhp .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#awxelhtwhp .gt_from_md > :first-child {
  margin-top: 0;
}

#awxelhtwhp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#awxelhtwhp .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#awxelhtwhp .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#awxelhtwhp .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#awxelhtwhp .gt_row_group_first td {
  border-top-width: 2px;
}

#awxelhtwhp .gt_row_group_first th {
  border-top-width: 2px;
}

#awxelhtwhp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#awxelhtwhp .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#awxelhtwhp .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#awxelhtwhp .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#awxelhtwhp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#awxelhtwhp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#awxelhtwhp .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#awxelhtwhp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#awxelhtwhp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#awxelhtwhp .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#awxelhtwhp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#awxelhtwhp .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#awxelhtwhp .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#awxelhtwhp .gt_left {
  text-align: left;
}

#awxelhtwhp .gt_center {
  text-align: center;
}

#awxelhtwhp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#awxelhtwhp .gt_font_normal {
  font-weight: normal;
}

#awxelhtwhp .gt_font_bold {
  font-weight: bold;
}

#awxelhtwhp .gt_font_italic {
  font-style: italic;
}

#awxelhtwhp .gt_super {
  font-size: 65%;
}

#awxelhtwhp .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#awxelhtwhp .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#awxelhtwhp .gt_indent_1 {
  text-indent: 5px;
}

#awxelhtwhp .gt_indent_2 {
  text-indent: 10px;
}

#awxelhtwhp .gt_indent_3 {
  text-indent: 15px;
}

#awxelhtwhp .gt_indent_4 {
  text-indent: 20px;
}

#awxelhtwhp .gt_indent_5 {
  text-indent: 25px;
}

#awxelhtwhp .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#awxelhtwhp div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="7" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Top Rows of the Data</td>
    </tr>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="QI">QI</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Cadmium">Cadmium</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Mercury">Mercury</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Arsenic">Arsenic</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Lead">Lead</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Manganese">Manganese</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Sex">Sex</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="QI" class="gt_row gt_right">123.00</td>
<td headers="Cadmium" class="gt_row gt_right">0.36</td>
<td headers="Mercury" class="gt_row gt_right">0.03</td>
<td headers="Arsenic" class="gt_row gt_right">4.41</td>
<td headers="Lead" class="gt_row gt_right">6.33</td>
<td headers="Manganese" class="gt_row gt_right">439.74</td>
<td headers="Sex" class="gt_row gt_center">Female</td></tr>
    <tr><td headers="QI" class="gt_row gt_right">123.00</td>
<td headers="Cadmium" class="gt_row gt_right">1.01</td>
<td headers="Mercury" class="gt_row gt_right">4.12</td>
<td headers="Arsenic" class="gt_row gt_right">6.21</td>
<td headers="Lead" class="gt_row gt_right">10.12</td>
<td headers="Manganese" class="gt_row gt_right">119.55</td>
<td headers="Sex" class="gt_row gt_center">Female</td></tr>
    <tr><td headers="QI" class="gt_row gt_right">104.00</td>
<td headers="Cadmium" class="gt_row gt_right">0.28</td>
<td headers="Mercury" class="gt_row gt_right">0.62</td>
<td headers="Arsenic" class="gt_row gt_right">16.96</td>
<td headers="Lead" class="gt_row gt_right">13.46</td>
<td headers="Manganese" class="gt_row gt_right">176.16</td>
<td headers="Sex" class="gt_row gt_center">Female</td></tr>
    <tr><td headers="QI" class="gt_row gt_right">135.00</td>
<td headers="Cadmium" class="gt_row gt_right">0.27</td>
<td headers="Mercury" class="gt_row gt_right">0.53</td>
<td headers="Arsenic" class="gt_row gt_right">2.69</td>
<td headers="Lead" class="gt_row gt_right">2.94</td>
<td headers="Manganese" class="gt_row gt_right">110.49</td>
<td headers="Sex" class="gt_row gt_center">Male</td></tr>
    <tr><td headers="QI" class="gt_row gt_right">94.00</td>
<td headers="Cadmium" class="gt_row gt_right">0.36</td>
<td headers="Mercury" class="gt_row gt_right">1.03</td>
<td headers="Arsenic" class="gt_row gt_right">24.39</td>
<td headers="Lead" class="gt_row gt_right">6.09</td>
<td headers="Manganese" class="gt_row gt_right">630.43</td>
<td headers="Sex" class="gt_row gt_center">Male</td></tr>
    <tr><td headers="QI" class="gt_row gt_right">119.00</td>
<td headers="Cadmium" class="gt_row gt_right">0.44</td>
<td headers="Mercury" class="gt_row gt_right">0.03</td>
<td headers="Arsenic" class="gt_row gt_right">5.68</td>
<td headers="Lead" class="gt_row gt_right">8.22</td>
<td headers="Manganese" class="gt_row gt_right">170.04</td>
<td headers="Sex" class="gt_row gt_center">Female</td></tr>
  </tbody>
  
  
</table>
</div>
```
:::
:::

We show the density plots of these raw exposure levels:

::: cell
``` {.r .cell-code}
ggplot(
  data = analysisData_df %>%
    select(Cadmium:Manganese) %>%
    pivot_longer(
      cols = everything(), names_to = "Metal", values_to = "Value"
    )
) + 
  aes(x = Value, fill = Metal) + 
  theme_minimal() + 
  theme(legend.position = "none") + 
  labs(
    title = "Histogram with Density Plot for Metals", 
    x = "Concentration", 
    y = "Density"
  ) +
  geom_histogram(
    aes(y = ..density..), bins = 30, alpha = 0.5, position = "identity"
  ) + 
  geom_density(aes(color = Metal), linewidth = 1) + 
  facet_wrap(~Metal, scales = "free")
```

::: cell-output-display
![Figure 1: Histogram with Density Plot for
Metals](packageOverview_files/figure-markdown/fig-metals-density-1.png){#fig-metals-density}
:::
:::

These exposure profiles are not Normally distributed, as we see in
[Figure 1](#fig-metals-density). Visualization of the marginal
distributions of these metal concentrations using histograms and kernel
density plots revealed marked right-skewness across all analytes,
suggesting the need for distribution-sensitive modeling approaches.

## Parameter Estimation

To capture the empirical distributional features of the observed data,
we implemented the `calculate_stats_gamma()` function to estimate
parameters for Gamma distributions within male and female subgroups.
This method-of-moments approach yielded group-specific descriptors,
including sample sizes, means, Gamma shape and rate parameters, and
Spearman correlation matrices among the metals. These parameters served
as foundational elements for generating realistic synthetic data that
preserve sex-specific distribution and correlation structures of the
environmental exposures.

Given the skewness present in the metals data, the Multivariate Gamma
distribution is a better fit if we plan to use parametric bootstrap
techniques downstream in the analysis. The `calculate_stats_gamma()`
function allows us to calculate group-specific estimators using the
`group_col` argument (in our case, for Males and Females), and it has
options with the `using` argument to estimate parameters via Method of
Moments (`"MoM"`) and generalized Maximum Likelihood Estimation
(`"gMLE"`)[@weiss1966; @eladlouni2007]. For this example, we calculate
the Method of Moments parameter estimates of this estimated distribution
via `"MoM"`.

::: cell
``` {.r .cell-code}
param_list <- calculate_stats_gamma(
  data_df = analysisData_df, 
  group_col = "Sex", 
  using = "MoM"
)

# Examine list contents
str(
  param_list,
  max.level = 2,
  give.attr = FALSE
)
```

::: {.cell-output .cell-output-stdout}
    List of 2
     $ Female:List of 5
      ..$ sampSize    : int 242
      ..$ mean_vec    : Named num [1:6] 101.893 0.554 0.701 24.566 10.439 ...
      ..$ sampCorr_mat: num [1:6, 1:6] 1 -0.0942 -0.0625 -0.114 -0.019 ...
      ..$ shape_num   : Named num [1:6] 44.706 0.343 0.242 0.897 1.033 ...
      ..$ rate_num    : Named num [1:6] 0.4388 0.6185 0.3444 0.0365 0.0989 ...
     $ Male  :List of 5
      ..$ sampSize    : int 186
      ..$ mean_vec    : Named num [1:6] 101.108 0.506 0.723 25.67 11.042 ...
      ..$ sampCorr_mat: num [1:6, 1:6] 1 -0.08159 -0.00122 -0.00365 0.16943 ...
      ..$ shape_num   : Named num [1:6] 46.1 0.757 0.282 0.174 0.544 ...
      ..$ rate_num    : Named num [1:6] 0.45595 1.49634 0.38964 0.00679 0.04928 ...
:::
:::

## Data Simulation

With the estimated parameters, we used the `simulate_group_data()`
function to generate synthetic multivariate Gamma-distributed exposure
data and preserve the distributional properties of the original data.
The simulated data maintained inter-variable correlations and
group-specific skewness patterns, effectively replicating real-world
exposure profiles. Based on the Method of Moments estimates that were
calculated, we can draw a parametric bootstrap sample by passing in the
list of group-specific parameter estimates found above:

::: cell
``` {.r .cell-code}
gamma_samples <- simulate_group_data(
  param_list = param_list, 
  data_gen_fn = generate_mvGamma_data, 
  group_col_name = "Sex"
)

head(gamma_samples) %>% 
  gt() %>%
  tab_header(
    title = "Top Rows of the gamma Sample"
  ) %>%
  fmt_number(
    decimals = 2
  ) %>%
  opt_table_outline()
```

::: cell-output-display
```{=html}
<div id="vnmddzwtoe" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#vnmddzwtoe table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#vnmddzwtoe thead, #vnmddzwtoe tbody, #vnmddzwtoe tfoot, #vnmddzwtoe tr, #vnmddzwtoe td, #vnmddzwtoe th {
  border-style: none;
}

#vnmddzwtoe p {
  margin: 0;
  padding: 0;
}

#vnmddzwtoe .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 3px;
  border-top-color: #D3D3D3;
  border-right-style: solid;
  border-right-width: 3px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 3px;
  border-bottom-color: #D3D3D3;
  border-left-style: solid;
  border-left-width: 3px;
  border-left-color: #D3D3D3;
}

#vnmddzwtoe .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#vnmddzwtoe .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vnmddzwtoe .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vnmddzwtoe .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#vnmddzwtoe .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vnmddzwtoe .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#vnmddzwtoe .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#vnmddzwtoe .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#vnmddzwtoe .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vnmddzwtoe .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vnmddzwtoe .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#vnmddzwtoe .gt_spanner_row {
  border-bottom-style: hidden;
}

#vnmddzwtoe .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#vnmddzwtoe .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#vnmddzwtoe .gt_from_md > :first-child {
  margin-top: 0;
}

#vnmddzwtoe .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vnmddzwtoe .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#vnmddzwtoe .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#vnmddzwtoe .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#vnmddzwtoe .gt_row_group_first td {
  border-top-width: 2px;
}

#vnmddzwtoe .gt_row_group_first th {
  border-top-width: 2px;
}

#vnmddzwtoe .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnmddzwtoe .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#vnmddzwtoe .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#vnmddzwtoe .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vnmddzwtoe .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnmddzwtoe .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vnmddzwtoe .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#vnmddzwtoe .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vnmddzwtoe .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vnmddzwtoe .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#vnmddzwtoe .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnmddzwtoe .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#vnmddzwtoe .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnmddzwtoe .gt_left {
  text-align: left;
}

#vnmddzwtoe .gt_center {
  text-align: center;
}

#vnmddzwtoe .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vnmddzwtoe .gt_font_normal {
  font-weight: normal;
}

#vnmddzwtoe .gt_font_bold {
  font-weight: bold;
}

#vnmddzwtoe .gt_font_italic {
  font-style: italic;
}

#vnmddzwtoe .gt_super {
  font-size: 65%;
}

#vnmddzwtoe .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#vnmddzwtoe .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#vnmddzwtoe .gt_indent_1 {
  text-indent: 5px;
}

#vnmddzwtoe .gt_indent_2 {
  text-indent: 10px;
}

#vnmddzwtoe .gt_indent_3 {
  text-indent: 15px;
}

#vnmddzwtoe .gt_indent_4 {
  text-indent: 20px;
}

#vnmddzwtoe .gt_indent_5 {
  text-indent: 25px;
}

#vnmddzwtoe .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#vnmddzwtoe div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="7" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Top Rows of the gamma Sample</td>
    </tr>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="V1">V1</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="V2">V2</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="V3">V3</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="V4">V4</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="V5">V5</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="V6">V6</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Sex">Sex</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="V1" class="gt_row gt_right">105.18</td>
<td headers="V2" class="gt_row gt_right">3.13</td>
<td headers="V3" class="gt_row gt_right">2.99</td>
<td headers="V4" class="gt_row gt_right">25.10</td>
<td headers="V5" class="gt_row gt_right">17.52</td>
<td headers="V6" class="gt_row gt_right">529.38</td>
<td headers="Sex" class="gt_row gt_left">Female</td></tr>
    <tr><td headers="V1" class="gt_row gt_right">82.51</td>
<td headers="V2" class="gt_row gt_right">1.44</td>
<td headers="V3" class="gt_row gt_right">0.27</td>
<td headers="V4" class="gt_row gt_right">2.21</td>
<td headers="V5" class="gt_row gt_right">1.83</td>
<td headers="V6" class="gt_row gt_right">123.33</td>
<td headers="Sex" class="gt_row gt_left">Female</td></tr>
    <tr><td headers="V1" class="gt_row gt_right">115.46</td>
<td headers="V2" class="gt_row gt_right">0.93</td>
<td headers="V3" class="gt_row gt_right">0.08</td>
<td headers="V4" class="gt_row gt_right">29.88</td>
<td headers="V5" class="gt_row gt_right">6.51</td>
<td headers="V6" class="gt_row gt_right">725.13</td>
<td headers="Sex" class="gt_row gt_left">Female</td></tr>
    <tr><td headers="V1" class="gt_row gt_right">103.90</td>
<td headers="V2" class="gt_row gt_right">0.46</td>
<td headers="V3" class="gt_row gt_right">0.03</td>
<td headers="V4" class="gt_row gt_right">27.66</td>
<td headers="V5" class="gt_row gt_right">21.34</td>
<td headers="V6" class="gt_row gt_right">473.50</td>
<td headers="Sex" class="gt_row gt_left">Female</td></tr>
    <tr><td headers="V1" class="gt_row gt_right">96.98</td>
<td headers="V2" class="gt_row gt_right">0.60</td>
<td headers="V3" class="gt_row gt_right">0.10</td>
<td headers="V4" class="gt_row gt_right">59.33</td>
<td headers="V5" class="gt_row gt_right">24.56</td>
<td headers="V6" class="gt_row gt_right">1,721.85</td>
<td headers="Sex" class="gt_row gt_left">Female</td></tr>
    <tr><td headers="V1" class="gt_row gt_right">73.98</td>
<td headers="V2" class="gt_row gt_right">0.22</td>
<td headers="V3" class="gt_row gt_right">0.03</td>
<td headers="V4" class="gt_row gt_right">31.11</td>
<td headers="V5" class="gt_row gt_right">10.27</td>
<td headers="V6" class="gt_row gt_right">792.50</td>
<td headers="Sex" class="gt_row gt_left">Female</td></tr>
  </tbody>
  
  
</table>
</div>
```
:::
:::

We account for the grouping variable column name with `group_col_name`,
and we specify the Multivariate Gamma distribution by invoking the
helper function `generate_mvGamma_data()`. This function can be
repeatedly invoked to create hundreds of parametric bootstrap resamples
to test future methodological developments. These simulation results are
extensively discussed in @hasan2024 and @hasan2025.

## Dynamic Threshold Calculation

As with any hypothesis-testing paradigm, we must set the threshold of
rejection before we perform an experiment. For variable selection with
BKMR, this is no different. In previous
studies[@ibrahimou2024; @pesenti2023; @li2022; @zhang2019; @coker2018; @barbieri2004; @zheng2024],
a static threshold 50% was used to delineate which exposures were
statistically related to the outcome. However, as shown in @hasan2024
and @hasan2025, using a static threshold often results in either highly
conservative (underpowered) tests, or tests that have a poorly
controlled $\alpha$ size (greater than the expected 5%).

To address the challenge of determining meaningful PIP thresholds under
skewed data conditions, we applied the `calculate_pip_threshold()`
function. This function dynamically estimates a threshold based on the
dataset's coefficient of variation (CV) and sample size using an
estimate for the Four-Parameter Logistic Regression model (Richard's
Curve) described above.

::: cell
``` {.r .cell-code}
pipThresh_num <- calculate_pip_threshold(
  y = na.omit(analysisData_df$QI)
)
pipThresh_num
```

::: {.cell-output .cell-output-stdout}
    [1] 0.11728
:::
:::

Therefore, based on this response vector's distribution, we have shown
that a threshold of approximately 0.117 should yield a better
controlled, more powerful test than using a static threshold of 0.5.

## Bayesian Kernel Machine Regression Analysis

To assess the relationship between metal exposures and cognitive
outcomes, we will need to execute BKMR on the real data. To assess the
relationship between metal exposures and cognitive outcomes, we employed
BKMR using the kmbayes() function from the bkmr package. Prior to
analysis, we omit the missing values and the metal concentration
variables were log-transformed using the `trans_log()` function to
mitigate skewness. Because we want to transform by $\log_{10}(x+1)$, we
will use the function `trans_log()` which uses base 10 and a one-unit
positive shift by default. The exposure matrix thus comprised
log-transformed values of the five metals, with IQ as the continuous
outcome variable.

::: cell
``` {.r .cell-code}
bkmrAnalysisData_df <- 
  analysisData_df %>%
  drop_na() %>%
  mutate_at(
    vars(Cadmium:Manganese), ~ trans_log(.) %>% as.vector
  )
```
:::

The BKMR package expects the response as a vector and the exposure as a
`data.matrix()` object. Covariates must be numeric, so we will recode
Sex as a binary variable. To enhance computational efficiency, we select
a matrix of knots that span the exposure space, allowing the Gaussian
process to be approximated using a reduced set of representative points.

::: cell
``` {.r .cell-code}
set.seed(2025)
expos <- bkmrAnalysisData_df %>%
  select(Cadmium:Manganese) %>% 
  data.matrix()
is_female <- (bkmrAnalysisData_df$Sex == "Female") + 0L

# Generate knot points using a cover design for Bayesian modeling
knots50 <- fields::cover.design(expos, nd = 50)$design
```
:::

Now that we have set up our data and search grid, we can run BKMR using
MCMC. The BKMR model was fit with 2,000 MCMC iterations, allowing for
variable selection via computation of Posterior Inclusion Probabilities
(PIPs).

::: cell
``` {.r .cell-code}
library(bkmr)

set.seed(2025)

# Fit the BKMR model using MCMC
modelFit <- kmbayes(
  # Response variable
  y = bkmrAnalysisData_df$QI,
  # Exposure matrix (metal concentrations)
  Z = expos,     
  # Sex at birth covariate
  X = is_female,   
  # Number of MCMC iterations; set to at least 10000 for real analysis
  iter = 2000,         
  family = "gaussian", # Gaussian response
  verbose = FALSE,     # Output progress for each iteration
  varsel = TRUE,       # Perform variable selection
  knots = knots50      # Knot points generated earlier
)
```
:::

To further explore the nature of these associations, we examined the
exposure-response relationships between each metal and IQ using
univariate predictor-response functions. The PredictorResponseUnivar()
function generated marginal effects, where the value of each metal
varied while keeping the remaining exposures fixed at the 75th
percentile.

::: cell
``` {.r .cell-code}
# Generate univariate predictor-response relationships
predRespUnivar <- PredictorResponseUnivar(fit = modelFit)

# Plot univariate predictor-response functions
predRespUnivarPlot <- ggplot(
  predRespUnivar, 
  aes(
    z, 
    est, 
    ymin = est - 1.96 * se, 
    ymax = est + 1.96 * se
  )
) + 
  geom_smooth(stat = "identity") +  # Add smooth lines with confidence intervals
  facet_wrap(~ variable) +          # Create separate plots for each variable
  ylab("h(z)")                      # Label the y-axis
```
:::

# Results

We want to know which metals are related to cognitive ability, as
measured by IQ. To extraction the PIPs from the `modelFit` model object,
we use the `ExtractPIPs()` function.

::: cell
::: cell-output-display
```{=html}
<div id="wqmchutvjx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#wqmchutvjx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#wqmchutvjx thead, #wqmchutvjx tbody, #wqmchutvjx tfoot, #wqmchutvjx tr, #wqmchutvjx td, #wqmchutvjx th {
  border-style: none;
}

#wqmchutvjx p {
  margin: 0;
  padding: 0;
}

#wqmchutvjx .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#wqmchutvjx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#wqmchutvjx .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#wqmchutvjx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#wqmchutvjx .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#wqmchutvjx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wqmchutvjx .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#wqmchutvjx .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#wqmchutvjx .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#wqmchutvjx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#wqmchutvjx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#wqmchutvjx .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#wqmchutvjx .gt_spanner_row {
  border-bottom-style: hidden;
}

#wqmchutvjx .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#wqmchutvjx .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#wqmchutvjx .gt_from_md > :first-child {
  margin-top: 0;
}

#wqmchutvjx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#wqmchutvjx .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#wqmchutvjx .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#wqmchutvjx .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#wqmchutvjx .gt_row_group_first td {
  border-top-width: 2px;
}

#wqmchutvjx .gt_row_group_first th {
  border-top-width: 2px;
}

#wqmchutvjx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wqmchutvjx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#wqmchutvjx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#wqmchutvjx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wqmchutvjx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wqmchutvjx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#wqmchutvjx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#wqmchutvjx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#wqmchutvjx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wqmchutvjx .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#wqmchutvjx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#wqmchutvjx .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#wqmchutvjx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#wqmchutvjx .gt_left {
  text-align: left;
}

#wqmchutvjx .gt_center {
  text-align: center;
}

#wqmchutvjx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#wqmchutvjx .gt_font_normal {
  font-weight: normal;
}

#wqmchutvjx .gt_font_bold {
  font-weight: bold;
}

#wqmchutvjx .gt_font_italic {
  font-style: italic;
}

#wqmchutvjx .gt_super {
  font-size: 65%;
}

#wqmchutvjx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#wqmchutvjx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#wqmchutvjx .gt_indent_1 {
  text-indent: 5px;
}

#wqmchutvjx .gt_indent_2 {
  text-indent: 10px;
}

#wqmchutvjx .gt_indent_3 {
  text-indent: 15px;
}

#wqmchutvjx .gt_indent_4 {
  text-indent: 20px;
}

#wqmchutvjx .gt_indent_5 {
  text-indent: 25px;
}

#wqmchutvjx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#wqmchutvjx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="2" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Posterior Inclusion Probabilities (PIPs)</td>
    </tr>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="variable">variable</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="PIP">PIP</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="variable" class="gt_row gt_left">Cadmium</td>
<td headers="PIP" class="gt_row gt_right">0.993</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">Lead</td>
<td headers="PIP" class="gt_row gt_right">0.611</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">Manganese</td>
<td headers="PIP" class="gt_row gt_right">0.307</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">Mercury</td>
<td headers="PIP" class="gt_row gt_right">0.276</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">Arsenic</td>
<td headers="PIP" class="gt_row gt_right">0.151</td></tr>
  </tbody>
  
  
</table>
</div>
```
:::
:::

Notably, Cadmium and Lead emerged as the strongest contributors to
cognitive development outcomes, as indicated by elevated PIP values
(**?@tbl-PIPs**) substantially above the baseline. Cadmium demonstrated
a near-certain inclusion probability (PIP = 0.993), suggesting a strong
association with IQ outcomes, while Lead also displayed a high PIP
(0.611), reinforcing previous epidemiological findings on its neurotoxic
effects[@bakulski2020; @Sanders2015; @henn2012; @ciesielski2012].

However, proper feature selection in the BKMR framework requires a
calibrated, data-driven threshold rather than a fixed conventional
cutoff (e.g., 0.5). Using the `calculate_pip_threshold()` function, we
computed a dynamic PIP threshold of 0.117. This threshold adapts to
sample size and characteristics and adjusts the selection criterion
accordingly, making it especially suitable for non-normal data
distributions.

By comparing each metal's PIP against the calculated threshold, we
identified a refined subset of significant exposures, which included not
only cadmium and lead but also manganese, mercury and arsenic. This
approach allows for a statistically principled method of feature
selection within the BKMR framework, ensuring robust and interpretable
results even when the data deviate from normality.

[Figure 2](#fig-Univariate-exposure-response-plot) shows the
relationship of each individual metals with the outcome, where all of
the other exposures are fixed to a particular quantile (e.g., 75th
percentile). The results indicate non-linear associations for several
metals. For instance, Cadmium exhibited a consistently negative
association with IQ across a wide range of concentrations, whereas the
relationship for Lead suggested a decline at higher concentrations.
Associations for Manganese, Mercury, and Arsenic were comparatively
weaker but statistically distinguishable from zero, consistent with
their PIP values exceeding the dynamic threshold. The consistent
patterns identified between PIP-based feature selection and univariate
exposure-response functions validate the efficacy of the dynamic
threshold method for BKMR feature selection in practical, non-normal
environmental datasets.

::: cell
``` {.r .cell-code}
# Plot univariate predictor-response functions
predRespUnivarPlot <- ggplot(
  predRespUnivar, 
  aes(
    z, 
    est, 
    ymin = est - 1.96 * se, 
    ymax = est + 1.96 * se
  )
) + 
  geom_smooth(stat = "identity") +  # Add smooth lines with confidence intervals
  facet_wrap(~ variable) +          # Create separate plots for each variable
  ylab("h(z)")                      # Label the y-axis

predRespUnivarPlot
```

::: cell-output-display
![Figure 2: Univariate exposure-response function
plot](packageOverview_files/figure-markdown/fig-Univariate-exposure-response-plot-1.png){#fig-Univariate-exposure-response-plot}
:::
:::

# Discussion

The R package we developed is a valuable tool for simulating
multivariate environmental exposure data and estimating feature
selection thresholds for BKMR. By supporting multivariate normal and
multivariate skewed Gamma distributions, the package is particularly
well-suited for handling non-normal environmental exposure data, which
is common in health studies.

## Implications of Pediatric Heavy Metal Exposure

In addition to describing the software package, we present an analysis
of an annonymus but original real-world dataset (which includes
measurements of metal exposure and children's IQ scores). Using BKMR
within this framework allowed us to rigorously assess the relationships
between multiple environmental exposures and cognitive development. The
analysis of the original dataset adds to the growing body of literature
on the impacts of heavy metal exposure on cognitive
outcomes[@porru2024; @karri2016; @rafiee2020a]. However, supporting
literature is sparse when applied to pediatric exposure
cases[@ouyang2023; @saxena2022; @Kim2023; @bora2019], so this analysis
offers a valuable corroborating perspective.

The results highlighted cadmium, and lead as significant contributors to
cognitive decline---findings well supported by prior epidemiological
research highlighting their neurotoxic effects
[@bakulski2020; @Sanders2015; @henn2012; @ciesielski2012]. In addition,
the dynamic, data-driven PIP threshold, included additional metals -
manganese, mercury and arsenic, which showed strong evidence for
neurotoxicity[@balachandran2020; @levin-schwartz2021; @oliveira2018; @grandjean2006; @tian2025; @rosado2007].
Notably, if we relied on a static threshold (e.g., PIP \> 0.5), these
additional exposures would have been incorrectly excluded, potentially
underestimating the true burden of environmental neurotoxicity. The
univariate exposure-response plots further corroborated these
associations, providing visualization of dose-response relationships for
each metal with IQ outcomes. These results underscore the advantage of
the dynamic threshold approach: it enhances the sensitivity of feature
selection while maintaining control over false positive rates, thereby
improving the robustness and interpretability of BKMR analyses in
complex, real-world exposure settings.

## Utility in Future Methodological Research

In this analysis, we show how to simulate multiple datasets to assess
the robustness of new methodological findings under various conditions
of environmental exposure. The purpose of generating these datasets is
to test the applicability of the BKMR model and feature selection
process in the presence of non-normal (skewed) data. By simulating
multiple datasets from both multivariate normal and skewed Gamma
distributions, we can compare how the model performs across different
data distributions. This approach ensures that the conclusions drawn
from a target (real-world) dataset are robust and generalizable, not
merely an artifact of that specific dataset. By simulating multiple
datasets and applying the same analysis framework, we test the
reproducibility of the results and gain confidence in the model's
ability to handle different data conditions.

We showed how this package can be used to generate multiple new
simulated datasets which allow us to explore the model's performance
under controlled, synthetic conditions that mimic real-world skewed
exposure data. We could then analyze the multiple generated datasets
using the same statistical and modeling procedures we would plan to
apply to any new data. Specifically, we calculate the statistical
moments for each simulated dataset, then use those to generate exposure
data. The results from the multiple datasets can then be summarized by
comparing the feature selection outcomes (PIPs) across different
simulations. These PIPs would help identify which metals have the most
significant association with cognitive outcomes. We could aggregate
these findings and provide a summary of how consistent or variable the
results are across different simulations, strengthening the validity of
newly developed modeling algorithms.

# Conclusion

This R package provides essential tools for simulating multivariate
environmental exposure data, estimating statistical moments, and
calculating PIP thresholds for feature selection in Bayesian Kernel
Machine Regression. While BKMR is an excellent tool for feature
selection, its reliance on normality can limit its application to
real-world datasets. The ability to simulate data from multivariate
normal and skewed Gamma distributions makes the package particularly
valuable for environmental health studies where data often deviate from
normality. Our package fills this gap by enabling researchers to model
and analyze non-normally distributed data, ensuring that feature
selection remains robust even in complex scenarios.
