# Known Limitations and Reporting Assumptions

## Purpose

This document describes the limitations of the available 2024–2025 HCC Pantry records and the assumptions used in the data warehouse and Power BI reports. These constraints are documented so report users do not interpret activity measures as inventory balances, unique-person counts, or donor-level records when the source data cannot support those conclusions.

## 1. No inventory-level data

The source records do not provide reliable beginning inventory, ending inventory, stock counts, or item-level inventory movements. The warehouse is therefore an **activity and performance-reporting system**, not an inventory-management system.

The difference between reported incoming food and reported food distributed must not be interpreted as inventory loss, waste, or ending inventory.

Possible contributors to the difference include:

- Food received in one reporting period and distributed in a later period.
- Existing stock distributed without a receipt recorded in the same period.
- Food remaining in stock at the end of a reporting period.
- Separately reported activities, including food trash, meal kits, Panera sweets, cart food, and past-best-by food distribution.
- Missing, incomplete, or inconsistent source records.

## 2. Incoming food is not available by individual source

Incoming food is available by monthly category only:

- Donated food
- Purchased food
- Maryland Food Bank (MFB) orders

The data does not reliably identify the pounds received from individual donors, vendors, or organizations. Reports can compare incoming **source categories**, but they cannot rank individual food sources.

## 3. Outgoing-food measures may overlap

The source reports contain multiple food-related measures, including general food distribution, past-best-by food distribution, food trash, Panera sweets, and meal kits. These measures may overlap in scope.

For this reason:

- `reported_general_food_distributed_lb` is used as the primary general food-distribution measure.
- Trash, past-best-by distribution, Panera sweets, and meal-kit activity are shown as separate supporting measures.
- The warehouse does not automatically add all food-activity records into one total-outgoing-food measure.

## 4. Daily and monthly source reports may differ

Some monthly Food In/Out totals do not reconcile exactly to sums of daily records. The warehouse retains both reporting levels and records known issues in `data_quality_note` / `silver_data_quality_issue`.

Monthly summary values are retained as the source-reported monthly figures. Daily records are retained for operational analysis. Neither source is silently overwritten by the other.

## 5. Student service visits are not unique students

The `students_served` metric records daily student totals. A student who uses the pantry on multiple dates can be counted more than once.

Report labels use **student service visits** where possible to distinguish this measure from a unique-student count.

## 6. Estimated new registrations use reusable bags as a proxy

The reports use reusable bags given as an estimate of new student registrations based on the operating assumption that reusable bags are issued only to first-time registered students.

This measure should be interpreted as an estimate, not a verified count of unique new registrants. It assumes one reusable bag represents one first-time registration.

## 7. Missing values are not assumed to be zero

A blank source value is retained as `NULL` when the source report did not provide a value. It does not automatically mean that no activity occurred.

This is particularly important for students served, Grab and Go visits, reusable bags, and supporting food-activity measures.

## 8. Semester labels are reporting groupings

Power BI reports use the following calendar-based semester grouping:

| Semester | Months |
|---|---|
| Spring | January–May |
| Summer | June–July |
| Fall | August–December |

The available 2023 record is included in Spring 2024 for reporting consistency. Semester labels are analytical groupings and do not replace official institutional enrollment or academic-calendar records.

## Recommended future data collection

To improve future reconciliation and PantrySoft comparison, collect:

- Beginning and ending inventory counts for each reporting period.
- Date, pounds, item, and source for every food receipt.
- Date, pounds, and program for each distribution event.
- Waste/disposal quantities with a standardized reason.
- Unique, privacy-appropriate student identifiers or deduplicated visit counts where permitted.
- A direct first-time-registration field rather than reusable bags as a proxy.
- Standard definitions for general distribution, special distributions, meal kits, trash, and other outgoing-food measures.
