
# HCC Pantry Data Warehouse Architecture

## Purpose and scope

The HCC Pantry Data Warehouse consolidates pantry records from 2024–2025 into a reliable reporting model. It supports analysis of recorded incoming food, food distribution, food-handling activity, pantry operations, student service visits, and reusable-bag activity.

The available source records do **not** contain beginning or ending inventory balances. Consequently, the warehouse is an activity and performance-reporting system; it does not calculate stock on hand or a reconciled inventory balance.

## Architecture pattern

The project uses a three-layer Medallion Architecture:
## Bronze layer

The Bronze layer is the raw staging layer. It retains the reporting values extracted from the pantry workbooks and supports traceability back to the original workbook, worksheet, and row.

Key Bronze tables include:

- `report_source` — workbook, worksheet, and source-row lineage.
- `monthly_food_summary` — monthly Food In/Out report values.
- `food_incoming` — monthly incoming-food components and reported total.
- `pantry_daily_operations` — daily students served, Grab and Go visits, reusable bags, status, closures, and notes.
- `food_outgoing`, `expired_but_distributed`, `food_trash`, `meal_kit_distribution`, and `panera_sweets_distribution` — separately reported food activities.
- `data_quality_note` — known source and reconciliation issues.

Bronze does not overwrite raw reporting meaning or silently convert missing values to zero.

## Silver layer

The Silver layer standardizes Bronze data for analytics while preserving report-source lineage through `report_source_id`.

It standardizes:

- Dates and reporting periods.
- Operating statuses: `OPEN`, `CLOSED`, and `NOT_REPORTED`.
- Program names and identifiers.
- Food-activity types and units.
- Numeric data types and nonnegative-value checks.

The core Silver tables are `silver_report_source`, `silver_program`, `silver_monthly_food_incoming`, `silver_pantry_daily_operations`, `silver_food_activity`, and `silver_data_quality_issue`.

## Gold layer

The Gold layer is a read-only reporting model built entirely from views. It follows a star-schema design.

### Dimension views

| View | Purpose |
|---|---|
| `dim_date` | Calendar date, month, quarter, year, and weekday attributes. |
| `dim_program` | General pantry, Panera Sweets, Roving Radish Meal Kits, and Recipe Meal Kits. |
| `dim_food_activity_type` | Controlled food-activity definitions. |
| `dim_operating_status` | Standardized pantry operating-status definitions. |

### Fact views

| View | Grain | Purpose |
|---|---|---|
| `fact_daily_pantry_operations` | One reported pantry date | Student service visits, Grab and Go, reusable bags, status, and notes. |
| `fact_food_activity` | One food activity/date/program | Reported food distribution, waste, meal kits, and special distributions. |
| `fact_monthly_food_incoming` | One reporting month | Incoming-food components, reported total, and reconciliation fields. |
| `fact_monthly_pantry_performance` | One reporting month | Dashboard-ready incoming, distribution, operational, and student-service measures. |

## Reporting rules and limitations

- Use `reported_general_food_distributed_lb` as the primary general food-distribution measure.
- Show trash, past-best-by distribution, Panera sweets, and meal-kit activity separately. Source measures can overlap and must not be automatically added into one outgoing-food total.
- Incoming food is available by monthly source category—donated, purchased, and MFB orders—not by individual donor or vendor.
- Student service visits are daily totals, not counts of unique students.
- Reusable bags are used in reporting as an estimated new-registration proxy only when the business rule is one bag per first-time registration.

See [Data Flow](dataflow.md) for lineage and transformation flow, and [Data Dictionary](datadictionary.md) for table and field definitions.
