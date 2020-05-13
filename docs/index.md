---
title: "Office of Student Financial Aid"
subtitle: "2019-20 Annual Reports"
# author: "Glen C. Falk"
# date: "2020-05-13"
# site: bookdown::bookdown_site
output:
  bookdown::gitbook: default
  theme: readable  
  highlight: tango
  html_document:
    df_print: kable
  pdf_document:
      includes:
          in_header: header.tex
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
linestretch: 1.15
link-citations: yes
links-as-notes: true
description: "This is a minimal example of using the bookdown package to write a book. The output format for this example is bookdown::gitbook."
cover-image: "images/cover.pdf"
---



## Table of Contents

- [01. Student Financial Aid Summary](#intro)
    - [Student Financial Aid Summary Undergraduate Cost of Attendance](#student-financial-aid-summary-undergraduate-cost-of-attendance)
    - [Financial Aid Applications and Awards](#financial-aid-applications-and-awards)

- [Undergraduate Cost of Attendance](#undergraduate-cost-of-attendance)
    - [Undergrad COA Percentage of Total Cost](#undergrad-coa-percentage-of-total-cost)
    - [Grad Resident COA](#grad-resident-coa)
    - [Grad Non-Resident COA](#grad-non-resident-coa)

- [Financial Aid Awarded to Students - Five-Year Comparison](#financial-aid-awarded-to-students---five-year-comparison)
    - [Average Award Per Recipient chart](#average-award-per-recipient-chart)
    - [Average Award Per Recipient Chart](#average-award-per-recipient-chart)

- [Types and Sources of Aid](#types-and-sources-of-aid)
    - [Financial Aid Awarded: Sources of Financial Aid Table](#financial-aid-awarded:-sources-of-financial-aid-table)
    - [Financial Aid Awarded: Sources of Financial Aid Chart](#financial-aid-awarded:-sources-of-financial-aid-chart)
    - [Financial Aid Awarded: Types of Financial Aid Table](#financial-aid-awarded:-types-of-financial-aid-table)
    - [Financial Aid Awarded: Types of Financial Aid Chart](#financial-aid-awarded:-types-of-financial-aid-chart)

- [Academic Year Student Financial Aid Awards by Type](#academic-year-student-financial-aid-awards-by-type)
    - [Academic Year Student Financial Aid Awards by Type Table\elandscape](#academic-year-student-financial-aid-awards-by-type-table\elandscape)

- [HOPE Scholarship Awards by Tier](#hope-scholarship-awards-by-tier)
    - [Financial Aid Awarded: Sources of Financial Aid Table\elandscape](#financial-aid-awarded:-sources-of-financial-aid-table\elandscape)
    - [HOPE Scholarship Awards by Tier](#hope-scholarship-awards-by-tier)
    - [HOPE Scholarship Awards by Tier](#hope-scholarship-awards-by-tier)
    - [Percent Change in HOPE Scholarship Awards by Tier](#percent-change-in-hope-scholarship-awards-by-tier)

- [ZELL Scholarship Awards by Tier](#zell-scholarship-awards-by-tier)
    - [Financial Aid Awarded: Sources of Financial Aid Table\elandscape](#financial-aid-awarded:-sources-of-financial-aid-table\elandscape)
    - [ZELL Scholarship Awards by Tier](#zell-scholarship-awards-by-tier)
    - [ZELL Scholarship Awards by Tier](#zell-scholarship-awards-by-tier)
    - [Percent Change in ZELL Scholarship Awards by Tier](#percent-change-in-zell-scholarship-awards-by-tier)

- [HOPE-ZELL Scholarship Awards by Tier](#hope-zell-scholarship-awards-by-tier)
    - [Percent of Undergraduates with HOPE/Zell Scholarship Awards](#percent-of-undergraduates-with-hope/zell-scholarship-awards)
    - [Pct Undergraduates with HOPE or Zell](#pct-undergraduates-with-hope-or-zell)
- [HOPE-ZELL Scholarship Award Totals](#hope-zell-scholarship-award-totals)
    - [HOPE-ZELL Scholarship Award Totals](#hope-zell-scholarship-award-totals)
    - [HOPE-ZELL Scholarship Award Totals Comparison](#hope-zell-scholarship-award-totals-comparison)

- [HOPE-ZELL Max Awards Compared to Tuition](#hope-zell-max-awards-compared-to-tuition)
    - [HOPE-ZELL Scholarship Award Totals](#hope-zell-scholarship-award-totals)

- [History of Average Federal Pell Grant Awards](#history-of-average-federal-pell-grant-awards)
    - [History of Average Federal Pell Grant Awards](#history-of-average-federal-pell-grant-awards)

- [Pell-Max-Awards](#pell-max-awards)
    - [Pell Grant Maximum Award and In-State COA](#pell-grant-maximum-award-and-in-state-coa)
    - [Pell Grant Max Award and Out-of-State COA](#pell-grant-max-award-and-out-of-state-coa)

- [Pell-Grant-Comparison](#pell-grant-comparison)
    - [UGA Pell Grant Recipients to SEC Institutions ](#uga-pell-grant-recipients-to-sec-institutions)
    - [UGA Pell Grant Recipients to Comparator Institutions ](#uga-pell-grant-recipients-to-comparator-institutions)
    - [UGA Pell Grant Recipients to Aspirational Peer Institutions ](#uga-pell-grant-recipients-to-aspirational-peer-institutions)

- [Student-Parent-Loan](#student-parent-loan)
    - [Student and Parent Loans Table](#student-and-parent-loans-table)
    - [Student and Parent Loans Bar Chart](#student-and-parent-loans-bar-chart)
    - [Student and Parent Loans Line Chart](#student-and-parent-loans-line-chart)
    - [Student and Parent Loans Horizontal Bar Chart](#student-and-parent-loans-horizontal-bar-chart)

- [Cohort-Default-Rates](#cohort-default-rates)
    - [Cohort Default Rates: SEC Institutions](#cohort-default-rates:-sec-institutions)
    - [SEC Cohort Default Rate by Institution Bar Chart](#sec-cohort-default-rate-by-institution-bar-chart)
    - [SEC Cohort Default Rate by Year Bar Chart](#sec-cohort-default-rate-by-year-bar-chart)
    - [Cohort Default Rates: Aspirational Institutions](#cohort-default-rates:-aspirational-institutions)
    - [Aspirational Cohort Default Rate by Institution Bar Chart](#aspirational-cohort-default-rate-by-institution-bar-chart)
    - [Aspirational Cohort Default Rate by Year Bar Chart](#aspirational-cohort-default-rate-by-year-bar-chart)
    - [Cohort Default Rates: Comparator Institutions](#cohort-default-rates:-comparator-institutions)
    - [Comparator Cohort Default Rate by Institution Bar Chart](#comparator-cohort-default-rate-by-institution-bar-chart)
    - [Comparator Cohort Default Rate by Year Bar Chart](#comparator-cohort-default-rate-by-year-bar-chart)
    - [Cohort Default Rates: Comparator Institutions](#cohort-default-rates:-comparator-institutions)
    - [Cohort Default Rates: Comparator Institutions](#cohort-default-rates:-comparator-institutions)

- [Gap-Analysis](#gap-analysis)
    - [Resident Undergraduates Table](#resident-undergraduates-table)
    - [Resident Undergraduates Pie Chart](#resident-undergraduates-pie-chart)
    - [Non-Resident Undergraduates Table](#non-resident-undergraduates-table)
    - [Non-Resident Undergraduates Pie Chart](#non-resident-undergraduates-pie-chart)
    - [Combined Undergraduates Table](#combined-undergraduates-table)
    - [Combined Undergraduates Pie Chart](#combined-undergraduates-pie-chart)

```{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
```

# OSFA Org Chart {-}

Here is the current OSFA Organization chart.

![(\#fig:label)OSFA Org Chart](images/OSFAOrgChart.png){width=100%}

<!-- Remember each Rmd file contains one and only one chapter, and a chapter is defined by the first-level heading `#`. -->

<!-- To compile this example to PDF, you need XeLaTeX. You are recommended to install TinyTeX (which includes XeLaTeX): <https://yihui.name/tinytex/>. -->


```{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
```


