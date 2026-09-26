-- HCC Pantry Gold layer, MySQL 8+
-- Prerequisites:
--   1. Bronze reporting tables are loaded in the bronze schema.
--   2. The Silver transformation has completed in the silver schema.
-- This script creates views only in the gold schema. It does not create or alter tables.

USE gold;

DROP VIEW IF EXISTS fact_monthly_pantry_performance;
DROP VIEW IF EXISTS fact_monthly_food_incoming;
DROP VIEW IF EXISTS fact_food_activity;
DROP VIEW IF EXISTS fact_daily_pantry_operations;
DROP VIEW IF EXISTS dim_operating_status;
DROP VIEW IF EXISTS dim_food_activity_type;
DROP VIEW IF EXISTS dim_program;
DROP VIEW IF EXISTS dim_date;

-- Dimension: one calendar date represented in either a Silver fact table or a Bronze monthly summary.
CREATE OR REPLACE VIEW dim_date AS
SELECT
    CAST(DATE_FORMAT(calendar_date, '%Y%m%d') AS UNSIGNED) AS date_key,
    calendar_date,
    YEAR(calendar_date) AS calendar_year,
    QUARTER(calendar_date) AS calendar_quarter,
    MONTH(calendar_date) AS month_number,
    MONTHNAME(calendar_date) AS month_name,
    DATE_FORMAT(calendar_date, '%Y-%m') AS year_month,
    DATE_FORMAT(calendar_date, '%Y-%m-01') AS month_start_date,
    DAY(calendar_date) AS day_of_month,
    DAYNAME(calendar_date) AS day_name,
    WEEKDAY(calendar_date) + 1 AS weekday_number,
    CASE WHEN WEEKDAY(calendar_date) >= 5 THEN 1 ELSE 0 END AS is_weekend
FROM (
    SELECT activity_date AS calendar_date
    FROM silver.silver_pantry_daily_operations
    UNION
    SELECT period_start
    FROM silver.silver_monthly_food_incoming
    UNION
    SELECT period_start
    FROM bronze.monthly_food_summary
) AS calendar_dates;

-- Dimension: programs recorded in Silver, plus a member for movements with no program.
CREATE OR REPLACE VIEW dim_program AS
SELECT
    0 AS program_key,
    'NOT_APPLICABLE' AS program_code,
    'Not applicable / not recorded' AS program_name
UNION ALL
SELECT
    program_id AS program_key,
    program_code,
    program_name
FROM silver.silver_program;

-- Dimension: controlled definitions for each Silver food-activity type.
CREATE OR REPLACE VIEW dim_food_activity_type AS
SELECT 'GENERAL_FOOD_DISTRIBUTION' AS activity_type, 'OUT' AS movement_direction, 'Food distributed through the general pantry measure' AS activity_type_description
UNION ALL SELECT 'PAST_BEST_BY_FOOD_DISTRIBUTION', 'OUT', 'Food distributed after its reported best-by date'
UNION ALL SELECT 'FOOD_DISCARDED', 'OUT', 'Food recorded as trash or discarded'
UNION ALL SELECT 'PANERA_SWEETS_DISTRIBUTION', 'OUT', 'Panera sweets distributed'
UNION ALL SELECT 'MEAL_KIT_DISTRIBUTION', 'OUT', 'Roving Radish or Recipe meal kits distributed';

-- Dimension: standardized operations statuses.
CREATE OR REPLACE VIEW dim_operating_status AS
SELECT 'OPEN' AS operating_status, 'Pantry activity was reported for the date' AS status_description
UNION ALL SELECT 'CLOSED', 'The source report identifies the pantry as closed'
UNION ALL SELECT 'NOT_REPORTED', 'The date appears in a report but no operating status or metrics were reported';

-- Fact at daily grain: one row per reported pantry date.
CREATE OR REPLACE VIEW fact_daily_pantry_operations AS
SELECT
    CAST(DATE_FORMAT(o.activity_date, '%Y%m%d') AS UNSIGNED) AS date_key,
    o.activity_date,
    o.operating_status,
    o.students_served,
    o.grab_and_go_visits,
    o.reusable_bags_given,
    o.closure_reason,
    o.notes,
    o.report_source_id
FROM silver.silver_pantry_daily_operations AS o;

-- Fact at activity grain: one row per reported food movement type, date, and program.
-- Do not sum all rows as a single outgoing-food number: reported measures may overlap.
CREATE OR REPLACE VIEW fact_food_activity AS
SELECT
    a.food_activity_id,
    CAST(DATE_FORMAT(a.activity_date, '%Y%m%d') AS UNSIGNED) AS date_key,
    a.activity_date,
    a.activity_type,
    COALESCE(a.program_id, 0) AS program_key,
    a.condition_at_distribution,
    a.weight_lb,
    a.quantity_count,
    a.quantity_uom,
    a.source_table,
    a.source_measure,
    a.report_source_id
FROM silver.silver_food_activity AS a;

-- Fact at monthly grain: incoming-food components and reported total, with a reconciliation field.
CREATE OR REPLACE VIEW fact_monthly_food_incoming AS
SELECT
    CAST(DATE_FORMAT(i.period_start, '%Y%m%d') AS UNSIGNED) AS date_key,
    i.period_start,
    i.donated_food_lb,
    i.purchased_food_lb,
    i.mfb_orders_lb,
    i.component_total_incoming_lb,
    i.reported_total_incoming_lb,
    i.incoming_reconciliation_difference_lb,
    i.report_source_id
FROM silver.silver_monthly_food_incoming AS i;

-- Fact at monthly grain for a dashboard or BI semantic model.
-- Incoming values and service counts come from Silver; reported outgoing/supporting totals come from Bronze.
-- The reported monthly distributed-food total is retained as the general pantry distribution measure.
CREATE OR REPLACE VIEW fact_monthly_pantry_performance AS
SELECT
    CAST(DATE_FORMAT(i.period_start, '%Y%m%d') AS UNSIGNED) AS date_key,
    i.period_start,
    i.reported_total_incoming_lb,
    i.donated_food_lb,
    i.purchased_food_lb,
    i.mfb_orders_lb,
    i.incoming_reconciliation_difference_lb,
    b.distributed_food_lb AS reported_general_food_distributed_lb,
    b.expired_food_lb AS reported_past_best_by_distributed_lb,
    b.trash_food_lb AS reported_food_trash_lb,
    b.panera_sweets_lb AS reported_panera_sweets_distributed_lb,
    b.cart_food_lb AS reported_cart_food_lb,
    b.other_food_lb AS reported_other_food_lb,
    b.total_outgoing_lb AS reported_total_outgoing_lb,
    COALESCE(o.open_days, 0) AS open_days,
    COALESCE(o.closed_days, 0) AS closed_days,
    COALESCE(o.not_reported_days, 0) AS not_reported_days,
    COALESCE(o.students_served, 0) AS students_served,
    COALESCE(o.grab_and_go_visits, 0) AS grab_and_go_visits,
    COALESCE(o.reusable_bags_given, 0) AS reusable_bags_given,
    i.report_source_id AS incoming_report_source_id,
    b.report_source_id AS monthly_summary_report_source_id
FROM silver.silver_monthly_food_incoming AS i
LEFT JOIN bronze.monthly_food_summary AS b
    ON b.period_start = i.period_start
LEFT JOIN (
    SELECT
        DATE_FORMAT(activity_date, '%Y-%m-01') AS period_start,
        SUM(CASE WHEN operating_status = 'OPEN' THEN 1 ELSE 0 END) AS open_days,
        SUM(CASE WHEN operating_status = 'CLOSED' THEN 1 ELSE 0 END) AS closed_days,
        SUM(CASE WHEN operating_status = 'NOT_REPORTED' THEN 1 ELSE 0 END) AS not_reported_days,
        SUM(students_served) AS students_served,
        SUM(grab_and_go_visits) AS grab_and_go_visits,
        SUM(reusable_bags_given) AS reusable_bags_given
    FROM silver.silver_pantry_daily_operations
    GROUP BY DATE_FORMAT(activity_date, '%Y-%m-01')
) AS o
    ON o.period_start = i.period_start;

-- Validation checks after running the script:
-- SELECT COUNT(*) FROM dim_date;
-- SELECT COUNT(*) FROM fact_daily_pantry_operations;       -- expected: 539
-- SELECT COUNT(*) FROM fact_monthly_food_incoming;          -- expected: 24
-- SELECT COUNT(*) FROM fact_monthly_pantry_performance;     -- expected: 24
-- SELECT activity_type, COUNT(*) FROM fact_food_activity GROUP BY activity_type;
