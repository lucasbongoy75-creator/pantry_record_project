-- HCC Pantry Silver layer, MySQL 8+
-- Prerequisite: run hcc_pantry_warehouse_2024_2025_mysql_import.sql in the bronze schema first.
-- This script drops and recreates only tables whose names start with silver_.

SET FOREIGN_KEY_CHECKS = 0;
DROP VIEW IF EXISTS silver_v_monthly_incoming_food;
DROP VIEW IF EXISTS silver_v_monthly_operations;
DROP TABLE IF EXISTS silver_data_quality_issue;
DROP TABLE IF EXISTS silver_food_activity;
DROP TABLE IF EXISTS silver_pantry_daily_operations;
DROP TABLE IF EXISTS silver_monthly_food_incoming;
DROP TABLE IF EXISTS silver_program;
DROP TABLE IF EXISTS silver_report_source;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE silver_report_source (
    report_source_id BIGINT NOT NULL,
    source_file_name VARCHAR(255) NOT NULL,
    source_sheet_name VARCHAR(255) NOT NULL,
    source_row_number INT NOT NULL,
    PRIMARY KEY (report_source_id),
    UNIQUE KEY uq_silver_report_source (source_file_name, source_sheet_name, source_row_number)
) ENGINE=InnoDB;

CREATE TABLE silver_program (
    program_id TINYINT NOT NULL,
    program_code VARCHAR(50) NOT NULL,
    program_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (program_id),
    UNIQUE KEY uq_silver_program_code (program_code)
) ENGINE=InnoDB;

CREATE TABLE silver_monthly_food_incoming (
    period_start DATE NOT NULL,
    donated_food_lb DECIMAL(12,3),
    purchased_food_lb DECIMAL(12,3),
    mfb_orders_lb DECIMAL(12,3),
    reported_total_incoming_lb DECIMAL(12,3) NOT NULL,
    component_total_incoming_lb DECIMAL(12,3),
    incoming_reconciliation_difference_lb DECIMAL(12,3),
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (period_start),
    CONSTRAINT fk_silver_incoming_source
        FOREIGN KEY (report_source_id) REFERENCES silver_report_source(report_source_id)
) ENGINE=InnoDB;

CREATE TABLE silver_pantry_daily_operations (
    activity_date DATE NOT NULL,
    operating_status ENUM('OPEN', 'CLOSED', 'NOT_REPORTED') NOT NULL,
    closure_reason VARCHAR(500),
    students_served INT,
    grab_and_go_visits INT,
    reusable_bags_given INT,
    notes TEXT,
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (activity_date),
    CONSTRAINT fk_silver_operations_source
        FOREIGN KEY (report_source_id) REFERENCES silver_report_source(report_source_id),
    CONSTRAINT chk_students_served_nonnegative CHECK (students_served IS NULL OR students_served >= 0),
    CONSTRAINT chk_grab_and_go_nonnegative CHECK (grab_and_go_visits IS NULL OR grab_and_go_visits >= 0),
    CONSTRAINT chk_bags_nonnegative CHECK (reusable_bags_given IS NULL OR reusable_bags_given >= 0)
) ENGINE=InnoDB;

CREATE TABLE silver_food_activity (
    food_activity_id BIGINT NOT NULL AUTO_INCREMENT,
    activity_date DATE NOT NULL,
    activity_type ENUM(
        'GENERAL_FOOD_DISTRIBUTION',
        'PAST_BEST_BY_FOOD_DISTRIBUTION',
        'FOOD_DISCARDED',
        'PANERA_SWEETS_DISTRIBUTION',
        'MEAL_KIT_DISTRIBUTION'
    ) NOT NULL,
    program_id TINYINT NULL,
    condition_at_distribution ENUM('IN_DATE', 'PAST_BEST_BY', 'NOT_APPLICABLE') NOT NULL,
    weight_lb DECIMAL(12,3),
    quantity_count INT,
    quantity_uom ENUM('LB', 'MEAL_KIT') NULL,
    report_source_id BIGINT NOT NULL,
    source_table VARCHAR(100) NOT NULL,
    source_measure VARCHAR(100) NOT NULL,
    PRIMARY KEY (food_activity_id),
    KEY ix_silver_food_activity_date (activity_date),
    KEY ix_silver_food_activity_type (activity_type),
    CONSTRAINT fk_silver_activity_program
        FOREIGN KEY (program_id) REFERENCES silver_program(program_id),
    CONSTRAINT fk_silver_activity_source
        FOREIGN KEY (report_source_id) REFERENCES silver_report_source(report_source_id),
    CONSTRAINT chk_activity_weight_nonnegative CHECK (weight_lb IS NULL OR weight_lb >= 0),
    CONSTRAINT chk_activity_quantity_nonnegative CHECK (quantity_count IS NULL OR quantity_count >= 0)
) ENGINE=InnoDB;

CREATE TABLE silver_data_quality_issue (
    issue_id BIGINT NOT NULL AUTO_INCREMENT,
    affected_table VARCHAR(100) NOT NULL,
    record_key VARCHAR(100) NOT NULL,
    issue_type VARCHAR(100) NOT NULL,
    detail TEXT NOT NULL,
    PRIMARY KEY (issue_id)
) ENGINE=InnoDB;

-- Lineage: retain the original workbook, worksheet, and source-row identifiers.
INSERT INTO silver_report_source (report_source_id, source_file_name, source_sheet_name, source_row_number)
SELECT report_source_id, source_file_name, source_sheet_name, source_row_number
FROM bronze.report_source;

INSERT INTO silver_program (program_id, program_code, program_name) VALUES
    (1, 'GENERAL_PANTRY', 'General Pantry Distribution'),
    (2, 'PANERA_SWEETS', 'Panera Sweets'),
    (3, 'ROVING_RADISH_MEAL_KITS', 'Roving Radish Meal Kits'),
    (4, 'RECIPE_MEAL_KITS', 'Recipe Meal Kits');

-- NULL remains NULL: it means the source report did not supply that component.
INSERT INTO silver_monthly_food_incoming (
    period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb,
    reported_total_incoming_lb, component_total_incoming_lb,
    incoming_reconciliation_difference_lb, report_source_id
)
SELECT
    period_start,
    donated_food_lb,
    purchased_food_lb,
    mfb_orders_lb,
    total_incoming_lb,
    CASE
        WHEN donated_food_lb IS NOT NULL
         AND purchased_food_lb IS NOT NULL
         AND mfb_orders_lb IS NOT NULL
        THEN donated_food_lb + purchased_food_lb + mfb_orders_lb
    END,
    CASE
        WHEN donated_food_lb IS NOT NULL
         AND purchased_food_lb IS NOT NULL
         AND mfb_orders_lb IS NOT NULL
        THEN total_incoming_lb - (donated_food_lb + purchased_food_lb + mfb_orders_lb)
    END,
    report_source_id
FROM bronze.food_incoming;

INSERT INTO silver_pantry_daily_operations (
    activity_date, operating_status, closure_reason, students_served,
    grab_and_go_visits, reusable_bags_given, notes, report_source_id
)
SELECT
    activity_date,
    operating_status,
    NULLIF(TRIM(closure_reason), ''),
    students_served,
    grab_and_go_visits,
    reusable_bags_given,
    NULLIF(TRIM(notes), ''),
    report_source_id
FROM bronze.pantry_daily_operations;

-- These activity types remain separate. Do not sum all types as a single "outgoing"
-- measure until their overlap with the original reports has been formally reconciled.
INSERT INTO silver_food_activity (
    activity_date, activity_type, program_id, condition_at_distribution,
    weight_lb, quantity_count, quantity_uom, report_source_id, source_table, source_measure
)
SELECT
    activity_date, 'GENERAL_FOOD_DISTRIBUTION', 1, 'IN_DATE',
    distributed_food_lb, NULL, 'LB', report_source_id, 'food_outgoing', 'Outgoing # Pounds'
FROM bronze.food_outgoing;

INSERT INTO silver_food_activity (
    activity_date, activity_type, program_id, condition_at_distribution,
    weight_lb, quantity_count, quantity_uom, report_source_id, source_table, source_measure
)
SELECT
    activity_date, 'PAST_BEST_BY_FOOD_DISTRIBUTION', 1, 'PAST_BEST_BY',
    pounds_distributed, NULL, 'LB', report_source_id,
    'expired_but_distributed', '# Expired but Still Distributed'
FROM bronze.expired_but_distributed;

INSERT INTO silver_food_activity (
    activity_date, activity_type, program_id, condition_at_distribution,
    weight_lb, quantity_count, quantity_uom, report_source_id, source_table, source_measure
)
SELECT
    activity_date, 'FOOD_DISCARDED', NULL, 'NOT_APPLICABLE',
    pounds_discarded, NULL, 'LB', report_source_id, 'food_trash', '# Trash'
FROM bronze.food_trash;

INSERT INTO silver_food_activity (
    activity_date, activity_type, program_id, condition_at_distribution,
    weight_lb, quantity_count, quantity_uom, report_source_id, source_table, source_measure
)
SELECT
    activity_date, 'PANERA_SWEETS_DISTRIBUTION', 2, 'IN_DATE',
    pounds_distributed, NULL, 'LB', report_source_id,
    'panera_sweets_distribution', 'Panera Sweets Distributed'
FROM bronze.panera_sweets_distribution;

INSERT INTO silver_food_activity (
    activity_date, activity_type, program_id, condition_at_distribution,
    weight_lb, quantity_count, quantity_uom, report_source_id, source_table, source_measure
)
SELECT
    activity_date,
    'MEAL_KIT_DISTRIBUTION',
    CASE program_name
        WHEN 'ROVING_RADISH_MEAL_KITS' THEN 3
        WHEN 'RECIPE_MEAL_KITS' THEN 4
    END,
    'IN_DATE',
    pounds_distributed,
    kits_distributed,
    'MEAL_KIT',
    report_source_id,
    'meal_kit_distribution',
    program_name
FROM bronze.meal_kit_distribution;

INSERT INTO silver_data_quality_issue (affected_table, record_key, issue_type, detail)
SELECT table_name, record_key, issue_type, detail
FROM bronze.data_quality_note;

-- Silver reporting views: standardized labels and no duplicate rollup logic.
CREATE OR REPLACE VIEW silver_v_monthly_incoming_food AS
SELECT
    period_start,
    donated_food_lb,
    purchased_food_lb,
    mfb_orders_lb,
    reported_total_incoming_lb,
    component_total_incoming_lb,
    incoming_reconciliation_difference_lb
FROM silver_monthly_food_incoming;

CREATE OR REPLACE VIEW silver_v_monthly_operations AS
SELECT
    DATE_FORMAT(activity_date, '%Y-%m-01') AS period_start,
    SUM(CASE WHEN operating_status = 'OPEN' THEN 1 ELSE 0 END) AS open_days,
    SUM(CASE WHEN operating_status = 'CLOSED' THEN 1 ELSE 0 END) AS closed_days,
    SUM(CASE WHEN operating_status = 'NOT_REPORTED' THEN 1 ELSE 0 END) AS not_reported_days,
    SUM(students_served) AS students_served,
    SUM(grab_and_go_visits) AS grab_and_go_visits,
    SUM(reusable_bags_given) AS reusable_bags_given
FROM silver_pantry_daily_operations
GROUP BY DATE_FORMAT(activity_date, '%Y-%m-01');

-- Validation checks after running the script:
-- SELECT COUNT(*) FROM silver_monthly_food_incoming;       -- expected: 24
-- SELECT COUNT(*) FROM silver_pantry_daily_operations;     -- expected: 539
-- SELECT activity_type, COUNT(*) FROM silver_food_activity GROUP BY activity_type;
-- SELECT * FROM silver_data_quality_issue ORDER BY issue_id;
