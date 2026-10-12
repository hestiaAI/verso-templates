import VersoManual

open Verso.Genre Manual

#doc (Manual) "Formal Report Title" =>

%%%
authors := ["Report Author"]
shortTitle := "Report Title"
%%%

*Prepared for:* Client or organization

*Prepared by:* Author or team

*Report number:* RPT-000

*Date:* YYYY-MM-DD

*Status:* Draft

# Executive Summary
%%%
tag := "executive-summary"
number := false
%%%

Summarize the purpose, approach, principal findings, and most important recommendations. Write this
section for readers who may not read the full report.

# Introduction

## Purpose

State why the report was commissioned and the decision or question it is intended to support.

## Audience

Identify the intended readers and any assumptions about their background.

## Structure

Briefly explain how the report is organized.

# Background

Provide the context needed to understand the report. Define important terms and summarize relevant
prior work, policy, or operating conditions.

# Scope and Objectives

## Objectives

List the questions this report answers or the outcomes it evaluates.

## Scope

Describe what is included, what is excluded, and the period or population covered.

## Constraints and Assumptions

Record material constraints, assumptions, and dependencies that affect interpretation.

# Methodology

Describe the data sources, selection criteria, procedures, and analysis used. Include enough detail
for a qualified reader to assess or reproduce the work.

## Limitations

Explain sources of uncertainty and any limitations in the evidence or method.

# Findings

Present results in a neutral, traceable form. Number findings if later sections refer to them.

## Finding One

State the finding, summarize the supporting evidence, and identify its source.

## Finding Two

State the finding, summarize the supporting evidence, and identify its source.

# Discussion

Interpret the findings in relation to the objectives and background. Distinguish observed evidence
from inference, and discuss implications and uncertainty.

# Conclusions

Answer the report's principal questions. Keep conclusions supported by the findings presented above.

# Recommendations

Make each recommendation specific and actionable. Include a priority, responsible owner, and target
timeframe where applicable.

1. *Recommendation:* Describe the action. *Priority:* High. *Owner:* Role or team.
   *Target:* YYYY-MM-DD.
2. *Recommendation:* Describe the action. *Priority:* Medium. *Owner:* Role or team.
   *Target:* YYYY-MM-DD.

# References
%%%
tag := "references"
number := false
%%%

List every source cited in the report using one consistent citation style. Replace these prompts
with complete references.

- Author, A. A. (Year). *Title of work*. Publisher or journal. DOI or URL.
- Organization. (Year). *Title of report*. URL.

# Appendix A. Supporting Material
%%%
tag := "appendix-supporting-material"
number := false
%%%

Include supplementary tables, instruments, calculations, or other material needed to support the
main report but not essential to its flow.

# Appendix B. Terms and Abbreviations
%%%
tag := "appendix-terms"
number := false
%%%

Define specialized terms and abbreviations used in the report.