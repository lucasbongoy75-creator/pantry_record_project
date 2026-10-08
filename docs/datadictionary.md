The data flow moves records from pantry workbooks into raw Bronze tables, standardized Silver tables, Gold reporting views, and finally Power BI dashboards.
## Source inputs

The project uses the available 2024–2025 pantry reporting workbooks. The records contain two principal grains:

| Source content | Grain | Examples |
|---|---|---|
| Monthly Food In/Out report | One reporting month | Donated pounds, purchased pounds, MFB pounds, total incoming, reported distribution, trash. |
| Daily pantry report | One reported pantry date | Students served, Grab and Go visits, outgoing pounds, reusable bags, meal kits, closures, notes. |

## Bronze ingestion

Bronze stores source-aligned records in separate tables rather than forcing all activities into one total. Every reporting record is linked to `report_source` through `report_source_id`.

| Bronze table | Incoming source or activity |
|---|---|
| `monthly_food_summary` | Monthly Food In/Out summary row. |
| `food_incoming` | Monthly donated, purchased, MFB, and total incoming food. |
| `pantry_daily_operations` | Daily operations and service metrics. |
| `food_outgoing` | Daily reported `Outgoing # Pounds`. |
| `expired_but_distributed` | Daily past-best-by food that was distributed. |
| `food_trash` | Daily food recorded as trash. |
| `meal_kit_distribution` | Roving Radish and Recipe meal-kit pounds and counts. |
| `panera_sweets_distribution` | Daily Panera sweets pounds distributed. |
| `data_quality_note` | Documented source-quality and reconciliation issues. |

## Silver transformations

Silver applies standard names, types, checks, and controlled reporting categories.

| Silver output | Transformation |
|---|---|
| `silver_report_source` | Preserves workbook, worksheet, and row lineage. |
| `silver_program` | Assigns controlled program IDs and names. |
| `silver_monthly_food_incoming` | Preserves missing components as `NULL`; calculates component totals and reconciliation differences only when all components are reported. |
| `silver_pantry_daily_operations` | Standardizes operation status, closure reason, notes, and daily metrics. |
| `silver_food_activity` | Converts separate activity tables into controlled activity types while retaining date, program, pounds/counts, source table, and source measure. |
| `silver_data_quality_issue` | Carries forward recorded quality issues. |

## Gold reporting flow

Gold joins and presents standardized data through views only.

| Gold view | Source | Reporting use |
|---|---|---|
| `dim_date` | Silver dates and monthly source dates | Calendar, semester, month, quarter, and year filters in Power BI. |
| `dim_program` | `silver_program` | Program analysis. |
| `dim_food_activity_type` | Controlled Gold definitions | Food-activity filtering. |
| `dim_operating_status` | Controlled Gold definitions | Pantry status filtering. |
| `fact_daily_pantry_operations` | `silver_pantry_daily_operations` | Student service visits and daily operations. |
| `fact_food_activity` | `silver_food_activity` | Food-handling and program activity. |
| `fact_monthly_food_incoming` | `silver_monthly_food_incoming` | Incoming-food composition. |
| `fact_monthly_pantry_performance` | Silver incoming/operations plus Bronze monthly summary | Primary pantry-performance dashboard. |

## Power BI reporting flow

Power BI connects to the Gold views through the configured MySQL/ODBC connection. The report uses the dimensions to filter fact views and provides three report pages:

1. **Pantry Performance Overview** — incoming food, general distribution, student service visits, source categories, and semester comparison.
2. **Food Handling and Programs** — trash, special distributions, meal kits, Panera sweets, and program activity.
3. **Student Registrations and Service Visits** — service visits and reusable-bag-based estimated new registrations.

## Reconciliation boundary

This flow does not create an inventory balance. The source data lacks beginning inventory, ending inventory, and complete receipt/distribution transactions. Incoming food and general food distribution are therefore separate reported operational measures, not two sides of a reconciled stock ledger.

