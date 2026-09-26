-- HCC Pantry warehouse, MySQL 8+ import script
-- This script removes and recreates only the HCC pantry warehouse tables listed below.
SET FOREIGN_KEY_CHECKS = 0;
DROP VIEW IF EXISTS v_monthly_pantry_performance;
DROP TABLE IF EXISTS data_quality_note;
DROP TABLE IF EXISTS panera_sweets_distribution;
DROP TABLE IF EXISTS meal_kit_distribution;
DROP TABLE IF EXISTS food_trash;
DROP TABLE IF EXISTS expired_but_distributed;
DROP TABLE IF EXISTS food_outgoing;
DROP TABLE IF EXISTS pantry_daily_operations;
DROP TABLE IF EXISTS food_incoming;
DROP TABLE IF EXISTS monthly_food_summary;
DROP TABLE IF EXISTS report_source;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE report_source (
    report_source_id BIGINT NOT NULL AUTO_INCREMENT,
    source_file_name VARCHAR(255) NOT NULL,
    source_sheet_name VARCHAR(255) NOT NULL,
    source_row_number INT NOT NULL,
    PRIMARY KEY (report_source_id),
    UNIQUE KEY uq_report_source (source_file_name, source_sheet_name, source_row_number)
) ENGINE=InnoDB;

CREATE TABLE monthly_food_summary (
    period_start DATE NOT NULL,
    donated_food_lb DECIMAL(12,3),
    purchased_food_lb DECIMAL(12,3),
    mfb_orders_lb DECIMAL(12,3),
    total_incoming_lb DECIMAL(12,3),
    distributed_food_lb DECIMAL(12,3),
    expired_food_lb DECIMAL(12,3),
    cart_food_lb DECIMAL(12,3),
    panera_sweets_lb DECIMAL(12,3),
    trash_food_lb DECIMAL(12,3),
    other_food_lb DECIMAL(12,3),
    total_outgoing_lb DECIMAL(12,3),
    notes TEXT,
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (period_start),
    CONSTRAINT fk_monthly_source FOREIGN KEY (report_source_id) REFERENCES report_source(report_source_id)
) ENGINE=InnoDB;

CREATE TABLE food_incoming (
    period_start DATE NOT NULL,
    donated_food_lb DECIMAL(12,3),
    purchased_food_lb DECIMAL(12,3),
    mfb_orders_lb DECIMAL(12,3),
    total_incoming_lb DECIMAL(12,3) NOT NULL,
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (period_start),
    CONSTRAINT fk_incoming_source FOREIGN KEY (report_source_id) REFERENCES report_source(report_source_id)
) ENGINE=InnoDB;

CREATE TABLE pantry_daily_operations (
    activity_date DATE NOT NULL,
    students_served INT,
    grab_and_go_visits INT,
    reusable_bags_given INT,
    operating_status VARCHAR(20) NOT NULL,
    closure_reason VARCHAR(500),
    notes TEXT,
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (activity_date),
    CONSTRAINT fk_operations_source FOREIGN KEY (report_source_id) REFERENCES report_source(report_source_id)
) ENGINE=InnoDB;

CREATE TABLE food_outgoing (
    activity_date DATE NOT NULL,
    distributed_food_lb DECIMAL(12,3) NOT NULL,
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (activity_date),
    CONSTRAINT fk_outgoing_source FOREIGN KEY (report_source_id) REFERENCES report_source(report_source_id)
) ENGINE=InnoDB;

CREATE TABLE expired_but_distributed (
    activity_date DATE NOT NULL,
    pounds_distributed DECIMAL(12,3) NOT NULL,
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (activity_date),
    CONSTRAINT fk_expired_source FOREIGN KEY (report_source_id) REFERENCES report_source(report_source_id)
) ENGINE=InnoDB;

CREATE TABLE food_trash (
    activity_date DATE NOT NULL,
    pounds_discarded DECIMAL(12,3) NOT NULL,
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (activity_date),
    CONSTRAINT fk_trash_source FOREIGN KEY (report_source_id) REFERENCES report_source(report_source_id)
) ENGINE=InnoDB;

CREATE TABLE meal_kit_distribution (
    activity_date DATE NOT NULL,
    program_name VARCHAR(50) NOT NULL,
    pounds_distributed DECIMAL(12,3),
    kits_distributed INT,
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (activity_date, program_name),
    CONSTRAINT fk_meal_kit_source FOREIGN KEY (report_source_id) REFERENCES report_source(report_source_id)
) ENGINE=InnoDB;

CREATE TABLE panera_sweets_distribution (
    activity_date DATE NOT NULL,
    pounds_distributed DECIMAL(12,3) NOT NULL,
    report_source_id BIGINT NOT NULL,
    PRIMARY KEY (activity_date),
    CONSTRAINT fk_panera_source FOREIGN KEY (report_source_id) REFERENCES report_source(report_source_id)
) ENGINE=InnoDB;

CREATE TABLE data_quality_note (
    note_id BIGINT NOT NULL AUTO_INCREMENT,
    table_name VARCHAR(100) NOT NULL,
    record_key VARCHAR(100) NOT NULL,
    issue_type VARCHAR(100) NOT NULL,
    detail TEXT NOT NULL,
    PRIMARY KEY (note_id)
) ENGINE=InnoDB;


INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (1, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (2, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (3, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (4, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (5, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (6, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (7, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (8, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (9, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (10, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (11, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (12, '2024 Pantry Stats - TZ  (1).xlsx', 'Food In and Out Totals', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (13, '2025 Pantry Stats (1).xlsx', 'Food InOut', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (14, '2025 Pantry Stats (1).xlsx', 'Food InOut', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (15, '2025 Pantry Stats (1).xlsx', 'Food InOut', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (16, '2025 Pantry Stats (1).xlsx', 'Food InOut', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (17, '2025 Pantry Stats (1).xlsx', 'Food InOut', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (18, '2025 Pantry Stats (1).xlsx', 'Food InOut', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (19, '2025 Pantry Stats (1).xlsx', 'Food InOut', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (20, '2025 Pantry Stats (1).xlsx', 'Food InOut', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (21, '2025 Pantry Stats (1).xlsx', 'Food InOut', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (22, '2025 Pantry Stats (1).xlsx', 'Food InOut', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (23, '2025 Pantry Stats (1).xlsx', 'Food InOut', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (24, '2025 Pantry Stats (1).xlsx', 'Food InOut', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (25, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (26, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (27, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (28, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (29, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (30, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (31, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (32, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (33, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (34, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (35, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (36, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (37, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (38, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (39, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (40, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (41, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (42, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (43, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (44, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (45, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (46, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (47, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 24);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (48, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 25);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (49, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 26);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (50, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 27);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (51, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 28);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (52, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 29);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (53, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 30);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (54, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 31);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (55, '2024 Pantry Stats - TZ  (1).xlsx', 'January 2024', 32);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (56, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (57, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (58, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (59, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (60, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (61, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (62, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (63, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (64, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (65, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (66, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (67, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (68, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (69, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (70, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (71, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (72, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (73, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (74, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (75, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (76, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (77, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (78, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 24);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (79, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 25);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (80, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 26);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (81, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 27);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (82, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 28);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (83, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 29);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (84, '2024 Pantry Stats - TZ  (1).xlsx', 'February 2024', 30);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (85, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (86, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (87, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (88, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (89, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (90, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (91, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (92, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (93, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (94, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (95, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (96, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (97, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (98, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (99, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (100, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (101, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (102, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (103, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (104, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (105, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (106, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (107, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 24);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (108, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 25);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (109, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 26);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (110, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 27);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (111, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 28);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (112, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 29);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (113, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 30);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (114, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 31);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (115, '2024 Pantry Stats - TZ  (1).xlsx', 'March 2024', 32);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (116, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (117, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (118, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (119, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (120, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (121, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (122, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (123, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (124, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (125, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (126, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (127, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (128, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (129, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (130, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (131, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (132, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (133, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (134, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (135, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (136, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (137, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (138, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 24);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (139, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 25);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (140, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 26);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (141, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 27);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (142, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 28);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (143, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 29);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (144, '2024 Pantry Stats - TZ  (1).xlsx', 'April 2024', 30);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (145, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (146, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (147, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (148, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (149, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (150, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (151, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (152, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (153, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (154, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (155, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (156, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (157, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (158, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (159, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (160, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (161, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (162, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (163, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (164, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (165, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (166, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (167, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (168, '2024 Pantry Stats - TZ  (1).xlsx', 'May 2024', 24);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (169, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (170, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (171, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (172, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (173, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (174, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (175, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (176, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (177, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (178, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (179, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (180, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (181, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (182, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (183, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (184, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (185, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (186, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (187, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (188, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (189, '2024 Pantry Stats - TZ  (1).xlsx', 'June 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (190, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (191, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (192, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (193, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (194, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (195, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (196, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (197, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (198, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (199, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (200, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (201, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (202, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (203, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (204, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (205, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (206, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (207, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (208, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (209, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (210, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (211, '2024 Pantry Stats - TZ  (1).xlsx', 'July 2024', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (212, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (213, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (214, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (215, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (216, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (217, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (218, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (219, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (220, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (221, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (222, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (223, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (224, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (225, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (226, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (227, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (228, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (229, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (230, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (231, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (232, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (233, '2024 Pantry Stats - TZ  (1).xlsx', 'August 2024', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (234, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (235, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (236, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (237, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (238, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (239, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (240, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (241, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (242, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (243, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (244, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (245, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (246, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (247, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (248, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (249, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (250, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (251, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (252, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (253, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (254, '2024 Pantry Stats - TZ  (1).xlsx', 'September 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (255, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (256, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (257, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (258, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (259, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (260, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (261, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (262, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (263, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (264, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (265, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (266, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (267, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (268, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (269, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (270, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (271, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (272, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (273, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (274, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (275, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (276, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (277, '2024 Pantry Stats - TZ  (1).xlsx', 'October 2024', 24);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (278, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (279, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (280, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (281, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (282, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (283, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (284, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (285, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (286, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (287, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (288, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (289, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (290, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (291, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (292, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (293, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (294, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (295, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (296, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (297, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (298, '2024 Pantry Stats - TZ  (1).xlsx', 'November 2024', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (299, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (300, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (301, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (302, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (303, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (304, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (305, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (306, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (307, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (308, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (309, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (310, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (311, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (312, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (313, '2024 Pantry Stats - TZ  (1).xlsx', 'December 2024', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (314, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (315, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (316, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (317, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (318, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (319, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (320, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (321, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (322, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (323, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (324, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (325, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (326, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (327, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (328, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (329, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (330, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (331, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (332, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (333, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (334, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (335, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (336, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 24);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (337, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 25);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (338, '2025 Pantry Stats (1).xlsx', 'Jan 2025', 26);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (339, '2025 Pantry Stats (1).xlsx', 'February', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (340, '2025 Pantry Stats (1).xlsx', 'February', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (341, '2025 Pantry Stats (1).xlsx', 'February', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (342, '2025 Pantry Stats (1).xlsx', 'February', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (343, '2025 Pantry Stats (1).xlsx', 'February', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (344, '2025 Pantry Stats (1).xlsx', 'February', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (345, '2025 Pantry Stats (1).xlsx', 'February', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (346, '2025 Pantry Stats (1).xlsx', 'February', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (347, '2025 Pantry Stats (1).xlsx', 'February', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (348, '2025 Pantry Stats (1).xlsx', 'February', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (349, '2025 Pantry Stats (1).xlsx', 'February', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (350, '2025 Pantry Stats (1).xlsx', 'February', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (351, '2025 Pantry Stats (1).xlsx', 'February', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (352, '2025 Pantry Stats (1).xlsx', 'February', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (353, '2025 Pantry Stats (1).xlsx', 'February', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (354, '2025 Pantry Stats (1).xlsx', 'February', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (355, '2025 Pantry Stats (1).xlsx', 'February', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (356, '2025 Pantry Stats (1).xlsx', 'February', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (357, '2025 Pantry Stats (1).xlsx', 'February', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (358, '2025 Pantry Stats (1).xlsx', 'February', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (359, '2025 Pantry Stats (1).xlsx', 'March ', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (360, '2025 Pantry Stats (1).xlsx', 'March ', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (361, '2025 Pantry Stats (1).xlsx', 'March ', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (362, '2025 Pantry Stats (1).xlsx', 'March ', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (363, '2025 Pantry Stats (1).xlsx', 'March ', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (364, '2025 Pantry Stats (1).xlsx', 'March ', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (365, '2025 Pantry Stats (1).xlsx', 'March ', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (366, '2025 Pantry Stats (1).xlsx', 'March ', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (367, '2025 Pantry Stats (1).xlsx', 'March ', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (368, '2025 Pantry Stats (1).xlsx', 'March ', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (369, '2025 Pantry Stats (1).xlsx', 'March ', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (370, '2025 Pantry Stats (1).xlsx', 'March ', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (371, '2025 Pantry Stats (1).xlsx', 'March ', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (372, '2025 Pantry Stats (1).xlsx', 'March ', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (373, '2025 Pantry Stats (1).xlsx', 'March ', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (374, '2025 Pantry Stats (1).xlsx', 'March ', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (375, '2025 Pantry Stats (1).xlsx', 'March ', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (376, '2025 Pantry Stats (1).xlsx', 'March ', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (377, '2025 Pantry Stats (1).xlsx', 'March ', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (378, '2025 Pantry Stats (1).xlsx', 'March ', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (379, '2025 Pantry Stats (1).xlsx', 'March ', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (380, '2025 Pantry Stats (1).xlsx', 'March ', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (381, '2025 Pantry Stats (1).xlsx', 'March ', 24);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (382, '2025 Pantry Stats (1).xlsx', 'March ', 25);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (383, '2025 Pantry Stats (1).xlsx', 'March ', 26);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (384, '2025 Pantry Stats (1).xlsx', 'March ', 27);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (385, '2025 Pantry Stats (1).xlsx', 'March ', 28);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (386, '2025 Pantry Stats (1).xlsx', 'March ', 29);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (387, '2025 Pantry Stats (1).xlsx', 'March ', 30);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (388, '2025 Pantry Stats (1).xlsx', 'April', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (389, '2025 Pantry Stats (1).xlsx', 'April', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (390, '2025 Pantry Stats (1).xlsx', 'April', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (391, '2025 Pantry Stats (1).xlsx', 'April', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (392, '2025 Pantry Stats (1).xlsx', 'April', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (393, '2025 Pantry Stats (1).xlsx', 'April', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (394, '2025 Pantry Stats (1).xlsx', 'April', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (395, '2025 Pantry Stats (1).xlsx', 'April', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (396, '2025 Pantry Stats (1).xlsx', 'April', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (397, '2025 Pantry Stats (1).xlsx', 'April', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (398, '2025 Pantry Stats (1).xlsx', 'April', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (399, '2025 Pantry Stats (1).xlsx', 'April', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (400, '2025 Pantry Stats (1).xlsx', 'April', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (401, '2025 Pantry Stats (1).xlsx', 'April', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (402, '2025 Pantry Stats (1).xlsx', 'April', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (403, '2025 Pantry Stats (1).xlsx', 'April', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (404, '2025 Pantry Stats (1).xlsx', 'April', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (405, '2025 Pantry Stats (1).xlsx', 'April', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (406, '2025 Pantry Stats (1).xlsx', 'April', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (407, '2025 Pantry Stats (1).xlsx', 'April', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (408, '2025 Pantry Stats (1).xlsx', 'April', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (409, '2025 Pantry Stats (1).xlsx', 'April', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (410, '2025 Pantry Stats (1).xlsx', 'May', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (411, '2025 Pantry Stats (1).xlsx', 'May', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (412, '2025 Pantry Stats (1).xlsx', 'May', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (413, '2025 Pantry Stats (1).xlsx', 'May', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (414, '2025 Pantry Stats (1).xlsx', 'May', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (415, '2025 Pantry Stats (1).xlsx', 'May', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (416, '2025 Pantry Stats (1).xlsx', 'May', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (417, '2025 Pantry Stats (1).xlsx', 'May', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (418, '2025 Pantry Stats (1).xlsx', 'May', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (419, '2025 Pantry Stats (1).xlsx', 'May', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (420, '2025 Pantry Stats (1).xlsx', 'May', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (421, '2025 Pantry Stats (1).xlsx', 'May', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (422, '2025 Pantry Stats (1).xlsx', 'May', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (423, '2025 Pantry Stats (1).xlsx', 'May', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (424, '2025 Pantry Stats (1).xlsx', 'May', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (425, '2025 Pantry Stats (1).xlsx', 'May', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (426, '2025 Pantry Stats (1).xlsx', 'May', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (427, '2025 Pantry Stats (1).xlsx', 'May', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (428, '2025 Pantry Stats (1).xlsx', 'May', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (429, '2025 Pantry Stats (1).xlsx', 'May', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (430, '2025 Pantry Stats (1).xlsx', 'May', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (431, '2025 Pantry Stats (1).xlsx', 'May', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (432, '2025 Pantry Stats (1).xlsx', 'June 2025', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (433, '2025 Pantry Stats (1).xlsx', 'June 2025', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (434, '2025 Pantry Stats (1).xlsx', 'June 2025', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (435, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (436, '2025 Pantry Stats (1).xlsx', 'June 2025', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (437, '2025 Pantry Stats (1).xlsx', 'June 2025', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (438, '2025 Pantry Stats (1).xlsx', 'June 2025', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (439, '2025 Pantry Stats (1).xlsx', 'June 2025', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (440, '2025 Pantry Stats (1).xlsx', 'June 2025', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (441, '2025 Pantry Stats (1).xlsx', 'June 2025', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (442, '2025 Pantry Stats (1).xlsx', 'June 2025', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (443, '2025 Pantry Stats (1).xlsx', 'June 2025', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (444, '2025 Pantry Stats (1).xlsx', 'June 2025', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (445, '2025 Pantry Stats (1).xlsx', 'June 2025', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (446, '2025 Pantry Stats (1).xlsx', 'July 2025', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (447, '2025 Pantry Stats (1).xlsx', 'July 2025', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (448, '2025 Pantry Stats (1).xlsx', 'July 2025', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (449, '2025 Pantry Stats (1).xlsx', 'July 2025', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (450, '2025 Pantry Stats (1).xlsx', 'July 2025', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (451, '2025 Pantry Stats (1).xlsx', 'July 2025', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (452, '2025 Pantry Stats (1).xlsx', 'July 2025', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (453, '2024 Pantry Stats - TZ  (1).xlsx', 'Community Work Groups', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (454, '2025 Pantry Stats (1).xlsx', 'July 2025', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (455, '2025 Pantry Stats (1).xlsx', 'July 2025', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (456, '2025 Pantry Stats (1).xlsx', 'July 2025', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (457, '2025 Pantry Stats (1).xlsx', 'July 2025', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (458, '2025 Pantry Stats (1).xlsx', 'July 2025', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (459, '2025 Pantry Stats (1).xlsx', 'July 2025', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (460, '2025 Pantry Stats (1).xlsx', 'July 2025', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (461, '2025 Pantry Stats (1).xlsx', 'August 2025', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (462, '2025 Pantry Stats (1).xlsx', 'August 2025', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (463, '2025 Pantry Stats (1).xlsx', 'August 2025', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (464, '2025 Pantry Stats (1).xlsx', 'August 2025', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (465, '2025 Pantry Stats (1).xlsx', 'August 2025', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (466, '2025 Pantry Stats (1).xlsx', 'August 2025', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (467, '2025 Pantry Stats (1).xlsx', 'August 2025', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (468, '2025 Pantry Stats (1).xlsx', 'August 2025', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (469, '2025 Pantry Stats (1).xlsx', 'August 2025', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (470, '2025 Pantry Stats (1).xlsx', 'August 2025', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (471, '2025 Pantry Stats (1).xlsx', 'August 2025', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (472, '2025 Pantry Stats (1).xlsx', 'August 2025', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (473, '2025 Pantry Stats (1).xlsx', 'August 2025', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (474, '2025 Pantry Stats (1).xlsx', 'August 2025', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (475, '2025 Pantry Stats (1).xlsx', 'August 2025', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (476, '2025 Pantry Stats (1).xlsx', 'September 2025', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (477, '2025 Pantry Stats (1).xlsx', 'September 2025', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (478, '2025 Pantry Stats (1).xlsx', 'September 2025', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (479, '2025 Pantry Stats (1).xlsx', 'September 2025', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (480, '2025 Pantry Stats (1).xlsx', 'September 2025', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (481, '2025 Pantry Stats (1).xlsx', 'September 2025', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (482, '2025 Pantry Stats (1).xlsx', 'September 2025', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (483, '2025 Pantry Stats (1).xlsx', 'September 2025', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (484, '2025 Pantry Stats (1).xlsx', 'September 2025', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (485, '2025 Pantry Stats (1).xlsx', 'September 2025', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (486, '2025 Pantry Stats (1).xlsx', 'September 2025', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (487, '2025 Pantry Stats (1).xlsx', 'September 2025', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (488, '2025 Pantry Stats (1).xlsx', 'September 2025', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (489, '2025 Pantry Stats (1).xlsx', 'September 2025', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (490, '2025 Pantry Stats (1).xlsx', 'September 2025', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (491, '2025 Pantry Stats (1).xlsx', 'September 2025', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (492, '2025 Pantry Stats (1).xlsx', 'September 2025', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (493, '2025 Pantry Stats (1).xlsx', 'September 2025', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (494, '2025 Pantry Stats (1).xlsx', 'September 2025', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (495, '2025 Pantry Stats (1).xlsx', 'September 2025', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (496, '2025 Pantry Stats (1).xlsx', 'September 2025', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (497, '2025 Pantry Stats (1).xlsx', 'September 2025', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (498, '2025 Pantry Stats (1).xlsx', 'October 2025', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (499, '2025 Pantry Stats (1).xlsx', 'October 2025', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (500, '2025 Pantry Stats (1).xlsx', 'October 2025', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (501, '2025 Pantry Stats (1).xlsx', 'October 2025', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (502, '2025 Pantry Stats (1).xlsx', 'October 2025', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (503, '2025 Pantry Stats (1).xlsx', 'October 2025', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (504, '2025 Pantry Stats (1).xlsx', 'October 2025', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (505, '2025 Pantry Stats (1).xlsx', 'October 2025', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (506, '2025 Pantry Stats (1).xlsx', 'October 2025', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (507, '2025 Pantry Stats (1).xlsx', 'October 2025', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (508, '2025 Pantry Stats (1).xlsx', 'October 2025', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (509, '2025 Pantry Stats (1).xlsx', 'October 2025', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (510, '2025 Pantry Stats (1).xlsx', 'October 2025', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (511, '2025 Pantry Stats (1).xlsx', 'October 2025', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (512, '2025 Pantry Stats (1).xlsx', 'October 2025', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (513, '2025 Pantry Stats (1).xlsx', 'October 2025', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (514, '2025 Pantry Stats (1).xlsx', 'October 2025', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (515, '2025 Pantry Stats (1).xlsx', 'October 2025', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (516, '2025 Pantry Stats (1).xlsx', 'October 2025', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (517, '2025 Pantry Stats (1).xlsx', 'October 2025', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (518, '2025 Pantry Stats (1).xlsx', 'October 2025', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (519, '2025 Pantry Stats (1).xlsx', 'October 2025', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (520, '2025 Pantry Stats (1).xlsx', 'October 2025', 24);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (521, '2025 Pantry Stats (1).xlsx', 'November 2025', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (522, '2025 Pantry Stats (1).xlsx', 'November 2025', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (523, '2025 Pantry Stats (1).xlsx', 'November 2025', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (524, '2025 Pantry Stats (1).xlsx', 'November 2025', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (525, '2025 Pantry Stats (1).xlsx', 'November 2025', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (526, '2025 Pantry Stats (1).xlsx', 'November 2025', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (527, '2025 Pantry Stats (1).xlsx', 'November 2025', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (528, '2025 Pantry Stats (1).xlsx', 'November 2025', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (529, '2025 Pantry Stats (1).xlsx', 'November 2025', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (530, '2025 Pantry Stats (1).xlsx', 'November 2025', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (531, '2025 Pantry Stats (1).xlsx', 'November 2025', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (532, '2025 Pantry Stats (1).xlsx', 'November 2025', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (533, '2025 Pantry Stats (1).xlsx', 'November 2025', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (534, '2025 Pantry Stats (1).xlsx', 'November 2025', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (535, '2025 Pantry Stats (1).xlsx', 'November 2025', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (536, '2025 Pantry Stats (1).xlsx', 'November 2025', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (537, '2025 Pantry Stats (1).xlsx', 'November 2025', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (538, '2025 Pantry Stats (1).xlsx', 'November 2025', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (539, '2025 Pantry Stats (1).xlsx', 'November 2025', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (540, '2025 Pantry Stats (1).xlsx', 'November 2025', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (541, '2025 Pantry Stats (1).xlsx', 'December 2025', 2);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (542, '2025 Pantry Stats (1).xlsx', 'December 2025', 3);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (543, '2025 Pantry Stats (1).xlsx', 'December 2025', 4);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (544, '2025 Pantry Stats (1).xlsx', 'December 2025', 5);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (545, '2025 Pantry Stats (1).xlsx', 'December 2025', 6);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (546, '2025 Pantry Stats (1).xlsx', 'December 2025', 7);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (547, '2025 Pantry Stats (1).xlsx', 'December 2025', 8);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (548, '2025 Pantry Stats (1).xlsx', 'December 2025', 9);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (549, '2025 Pantry Stats (1).xlsx', 'December 2025', 10);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (550, '2025 Pantry Stats (1).xlsx', 'December 2025', 11);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (551, '2025 Pantry Stats (1).xlsx', 'December 2025', 12);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (552, '2025 Pantry Stats (1).xlsx', 'December 2025', 13);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (553, '2025 Pantry Stats (1).xlsx', 'December 2025', 14);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (554, '2025 Pantry Stats (1).xlsx', 'December 2025', 15);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (555, '2025 Pantry Stats (1).xlsx', 'December 2025', 16);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (556, '2025 Pantry Stats (1).xlsx', 'December 2025', 17);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (557, '2025 Pantry Stats (1).xlsx', 'December 2025', 18);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (558, '2025 Pantry Stats (1).xlsx', 'December 2025', 19);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (559, '2025 Pantry Stats (1).xlsx', 'December 2025', 20);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (560, '2025 Pantry Stats (1).xlsx', 'December 2025', 21);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (561, '2025 Pantry Stats (1).xlsx', 'December 2025', 22);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (562, '2025 Pantry Stats (1).xlsx', 'December 2025', 23);

INSERT INTO report_source (report_source_id, source_file_name, source_sheet_name, source_row_number) VALUES (563, '2025 Pantry Stats (1).xlsx', 'December 2025', 24);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-01-01', 482.1, 368.5, 2350.0, 3200.6, 1923.65, NULL, NULL, 103.2, 378.45, 0.0, 2479.05, NULL, 1);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-02-01', 2359.05, 1864.9, 3280.0, 7503.95, 1998.6, NULL, NULL, 55.3, NULL, 1065.8, 3373.0, 'Meal Kits', 2);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-03-01', 1037.74, 472.48, 3482.0, 4992.22, 3581.2, NULL, NULL, 48.85, 304.65, 304.65, 3975.5, NULL, 3);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-04-01', 943.6, 1019.79, 3050.0, 5013.39, 5464.15, NULL, NULL, 33.0, 317.9, 375.5, 6178.9, 'Meal Kits', 4);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-05-01', 334.25, 193.05, 2197.0, 2724.3, 2292.8, NULL, NULL, 20.6, 0.0, 429.0, 2833.9, 'Meal Kits', 5);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-06-01', 393.45, 239.02, 3153.0, 3785.47, 2113.83, NULL, NULL, 40.0, 563.6, 0.0, 2359.03, NULL, 6);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-07-01', 356.9, 186.59, 1650.0, 2193.49, 2202.09, NULL, NULL, 53.85, 0.0, 0.0, 2468.09, NULL, 7);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-08-01', 691.12, 511.9, 2325.0, 3528.02, 1965.45, NULL, NULL, 20.05, 35.2, NULL, 2120.0, NULL, 8);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-09-01', 3170.65, 1006.36, 3080.0, 7257.01, 6453.2, NULL, NULL, 25.06, 30.09, 36.0, 6587.3, 'Recipe Meal Kits', 9);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-10-01', 2190.08, 2492.15, 3123.0, 7805.23, 8701.47, NULL, NULL, 39.3, 90.5, 963.85, 9896.22, 'Recipe Meal Kits', 10);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-11-01', 1591.4, 772.2, 3929.0, 6292.6, 6322.51, NULL, NULL, 26.2, 230.6, 425.15, 7063.81, 'Recipe Meal Kits', 11);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2024-12-01', 1140.16, 114.35, 3900.0, 5154.51, 2696.9, NULL, NULL, 10.35, 701.67, NULL, 3467.27, NULL, 12);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-01-01', 525.7, 190.2, 2491.0, 3206.9, 1199.15, NULL, NULL, 6.2, 60.0, NULL, 1310.5, NULL, 13);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-02-01', 515.4, 1389.45, 2979.0, 4883.85, 6308.45, NULL, NULL, 45.5, 222.2, 65.4, 6833.95, 'RR Soup Kits', 14);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-03-01', 891.95, 699.55, 4890.0, 6481.5, 5103.15, NULL, NULL, 43.15, 539.8, 133.2, 5804.85, 'FD Meal Kits', 15);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-04-01', 2440.06, 1612.85, 4938.0, 8990.91, 7392.7, NULL, NULL, 31.4, 360.8, 254.0, 7944.75, 'RR Meal Kits', 16);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-05-01', 254.06, 561.13, 4346.0, 5161.2, 3949.32, NULL, NULL, 2.4, 44.55, 163.35, 4092.8, 'RR Meal Kits', 17);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-06-01', 431.547, 431.55, 3255.0, 4118.097, 3031.95, NULL, NULL, 74.1, 215.2, NULL, 3526.2, NULL, 18);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-07-01', 559.05, 466.1, 4315.0, 5340.15, 4183.25, NULL, NULL, 39.45, 158.15, NULL, 4590.7, NULL, 19);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-08-01', 498.67, 611.25, 3903.0, 5012.92, 1592.15, NULL, NULL, 0.0, 8.6, NULL, 1665.45, NULL, 20);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-09-01', 500.02, 2210.03, 3923.0, 6633.05, 9376.85, NULL, NULL, 56.3, 20.1, 992.4, 23895.55, 'RR Meal Kits', 21);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-10-01', 903.5, 1401.75, 6050.0, 8355.25, 10090.36, NULL, NULL, 31.85, 249.5, 1212.0, 11711.11, 'RR Meal Kits', 22);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-11-01', 2987.35, 1777.2, 5008.0, 9772.55, 7733.85, NULL, NULL, 44.15, 223.25, 541.2, 8780.35, 'RR Meal Kits', 23);

INSERT INTO monthly_food_summary (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, distributed_food_lb, expired_food_lb, cart_food_lb, panera_sweets_lb, trash_food_lb, other_food_lb, total_outgoing_lb, notes, report_source_id) VALUES ('2025-12-01', 2000.0, 2816.45, 4268.0, 9084.45, 4805.65, NULL, NULL, 16.1, 69.0, 21.0, 5007.3, 'FD Meal Kits', 24);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-01-01', 482.1, 368.5, 2350.0, 3200.6, 1);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-02-01', 2359.05, 1864.9, 3280.0, 7503.95, 2);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-03-01', 1037.74, 472.48, 3482.0, 4992.22, 3);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-04-01', 943.6, 1019.79, 3050.0, 5013.39, 4);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-05-01', 334.25, 193.05, 2197.0, 2724.3, 5);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-06-01', 393.45, 239.02, 3153.0, 3785.47, 6);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-07-01', 356.9, 186.59, 1650.0, 2193.49, 7);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-08-01', 691.12, 511.9, 2325.0, 3528.02, 8);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-09-01', 3170.65, 1006.36, 3080.0, 7257.01, 9);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-10-01', 2190.08, 2492.15, 3123.0, 7805.23, 10);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-11-01', 1591.4, 772.2, 3929.0, 6292.6, 11);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2024-12-01', 1140.16, 114.35, 3900.0, 5154.51, 12);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-01-01', 525.7, 190.2, 2491.0, 3206.9, 13);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-02-01', 515.4, 1389.45, 2979.0, 4883.85, 14);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-03-01', 891.95, 699.55, 4890.0, 6481.5, 15);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-04-01', 2440.06, 1612.85, 4938.0, 8990.91, 16);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-05-01', 254.06, 561.13, 4346.0, 5161.2, 17);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-06-01', 431.547, 431.55, 3255.0, 4118.097, 18);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-07-01', 559.05, 466.1, 4315.0, 5340.15, 19);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-08-01', 498.67, 611.25, 3903.0, 5012.92, 20);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-09-01', 500.02, 2210.03, 3923.0, 6633.05, 21);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-10-01', 903.5, 1401.75, 6050.0, 8355.25, 22);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-11-01', 2987.35, 1777.2, 5008.0, 9772.55, 23);

INSERT INTO food_incoming (period_start, donated_food_lb, purchased_food_lb, mfb_orders_lb, total_incoming_lb, report_source_id) VALUES ('2025-12-01', 2000.0, 2816.45, 4268.0, 9084.45, 24);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-01', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed - Winter Break', 'Pantry Closed - Winter Break', 25);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-02', 11, 4, 9, 'OPEN', NULL, NULL, 26);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-03', 1, 0, 1, 'CLOSED', 'Pantry Closed - Private shopping appointment', 'Pantry Closed - Private shopping appointment', 27);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-04', 4, 1, 4, 'OPEN', NULL, NULL, 28);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-05', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 29);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-06', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 30);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-07', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 31);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-08', 8, 3, 5, 'OPEN', NULL, NULL, 32);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-09', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 33);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-10', 5, 2, 5, 'OPEN', NULL, NULL, 34);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-11', 10, 3, 10, 'OPEN', NULL, NULL, 35);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-12', NULL, NULL, NULL, 'CLOSED', 'Closed - Winter Hours', 'Closed - Winter Hours', 36);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-13', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 37);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-14', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 38);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-15', NULL, NULL, NULL, 'CLOSED', 'Closed - Holiday', 'Closed - Holiday', 39);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-16', NULL, NULL, NULL, 'CLOSED', 'Closed - Weather', 'Closed - Weather', 40);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-17', NULL, NULL, NULL, 'CLOSED', 'Closed - Winter Hours', 'Closed - Winter Hours', 41);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-18', 9, 2, 7, 'OPEN', NULL, NULL, 42);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-19', NULL, NULL, NULL, 'CLOSED', 'Closed - Winter Hours', 'Closed - Winter Hours', 43);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-20', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 44);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-21', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 45);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-22', 8, 1, 4, 'OPEN', NULL, NULL, 46);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-23', 9, 1, 6, 'OPEN', NULL, NULL, 47);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-24', NULL, NULL, NULL, 'CLOSED', 'Closed - Winter Hours', 'Closed - Winter Hours', 48);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-25', 9, 1, 6, 'OPEN', NULL, NULL, 49);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-26', NULL, NULL, NULL, 'CLOSED', 'Closed - Winter Hours', 'Closed - Winter Hours', 50);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-27', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 51);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-28', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 52);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-29', 28, 6, 11, 'OPEN', NULL, 'First Day of Spring Semester', 53);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-30', 24, 9, 24, 'OPEN', NULL, NULL, 54);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-01-31', 29, 5, 29, 'OPEN', NULL, NULL, 55);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-01', 19, 8, 19, 'OPEN', NULL, NULL, 56);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-02', 4, 2, 4, 'OPEN', NULL, NULL, 57);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-03', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 58);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-04', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 59);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-05', 39, 16, 29, 'OPEN', NULL, 'Soup Kits (Quan. 18)', 60);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-06', 34, 13, 24, 'OPEN', NULL, NULL, 61);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-07', 21, 5, 17, 'OPEN', NULL, NULL, 62);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-08', 18, 5, 5, 'OPEN', NULL, 'Soup Kits (Quan. 12)', 63);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-09', 8, 7, 8, 'OPEN', NULL, NULL, 64);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-10', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 65);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-11', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 66);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-12', 26, 12, 19, 'OPEN', NULL, 'Soup Kits (Quan. 18)', 67);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-13', 33, 9, 29, 'OPEN', NULL, NULL, 68);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-14', 23, 11, 17, 'OPEN', NULL, NULL, 69);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-15', 26, 10, 23, 'OPEN', NULL, 'Soup Kits (Quan. 12)', 70);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-16', 10, 7, 4, 'OPEN', NULL, NULL, 71);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-17', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 72);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-18', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 73);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-19', 26, 11, 7, 'OPEN', NULL, 'Soup Kits (Quan 18)', 74);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-20', 38, 11, 22, 'OPEN', NULL, 'Soup Kits (Quan. 12)', 75);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-21', 21, 11, 12, 'OPEN', NULL, NULL, 76);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-22', 25, 18, 19, 'OPEN', NULL, NULL, 77);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-23', 11, 6, 5, 'OPEN', NULL, NULL, 78);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-24', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 79);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-25', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 80);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-26', 33, 10, 22, 'OPEN', NULL, 'Soup Kits (Quan. 18)', 81);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-27', 34, 20, 21, 'OPEN', NULL, 'Taco Kits (Quan. 8)', 82);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-28', 28, 14, 16, 'OPEN', NULL, NULL, 83);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-02-29', 26, 10, 18, 'OPEN', NULL, 'Soup Kits (Quan. 12)', 84);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-01', 6, 5, 4, 'OPEN', NULL, NULL, 85);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-02', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 86);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-03', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 87);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-04', 29, 13, 16, 'OPEN', NULL, 'Meals in a Jar (10)', 88);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-05', 31, 11, 20, 'OPEN', NULL, 'Taco Kits (8), Meals in a Jar (9)', 89);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-06', 26, 11, 15, 'OPEN', NULL, 'Meals in a Jar (5)', 90);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-07', 31, 17, 17, 'OPEN', NULL, 'Meals in a Jar (20)', 91);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-08', 12, 7, 10, 'OPEN', NULL, 'Meals in a Jar (2)', 92);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-09', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 93);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-10', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 94);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-11', 38, 10, 28, 'OPEN', NULL, NULL, 95);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-12', 31, 10, 20, 'OPEN', NULL, 'Taco Kits (8)', 96);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-13', 27, 13, 17, 'OPEN', NULL, 'Meals in a Jar (10)', 97);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-14', 19, 10, 11, 'OPEN', NULL, 'Meals in a Jar (9)', 98);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-15', 9, 6, 7, 'OPEN', NULL, 'Meals in a Jar (4)', 99);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-16', NULL, NULL, NULL, 'NOT_REPORTED', NULL, 'Meals in a Jar (9)', 100);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-17', NULL, NULL, NULL, 'NOT_REPORTED', NULL, 'Meals in a Jar (9)', 101);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-18', 31, NULL, 20, 'OPEN', NULL, 'Meals in a Jar (6)', 102);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-19', 22, 7, 15, 'OPEN', NULL, NULL, 103);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-20', 20, 6, 10, 'OPEN', NULL, NULL, 104);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-21', 35, 9, 20, 'OPEN', NULL, NULL, 105);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-22', 5, 4, 3, 'OPEN', NULL, NULL, 106);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-23', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 107);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-24', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 108);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-25', NULL, NULL, NULL, 'CLOSED', 'Closed - Spring Break', 'Closed - Spring Break', 109);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-26', NULL, NULL, NULL, 'CLOSED', 'Closed - Spring Break', 'Closed - Spring Break', 110);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-27', NULL, NULL, NULL, 'CLOSED', 'Closed - Spring Break', 'Closed - Spring Break', 111);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-28', NULL, NULL, NULL, 'CLOSED', 'Closed - Spring Break', 'Closed - Spring Break', 112);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-29', NULL, NULL, NULL, 'CLOSED', 'Closed - Spring Break', 'Closed - Spring Break', 113);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-30', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 114);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-03-31', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 115);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-01', 40, 16, 23, 'OPEN', NULL, NULL, 116);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-02', 34, 12, 18, 'OPEN', NULL, NULL, 117);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-03', 27, 12, 15, 'OPEN', NULL, NULL, 118);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-04', 33, 10, 19, 'OPEN', NULL, NULL, 119);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-05', 7, 5, 6, 'OPEN', NULL, NULL, 120);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-06', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 121);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-07', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 122);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-08', 34, 17, 17, 'OPEN', NULL, NULL, 123);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-09', 30, 12, 15, 'OPEN', NULL, NULL, 124);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-10', 30, 14, 18, 'OPEN', NULL, NULL, 125);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-11', 23, 6, 10, 'OPEN', NULL, NULL, 126);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-12', 5, 3, 3, 'OPEN', NULL, NULL, 127);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-13', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 128);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-14', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 129);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-15', 32, 9, 18, 'OPEN', NULL, NULL, 130);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-16', 27, 12, 11, 'OPEN', NULL, NULL, 131);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-17', 29, 15, 22, 'OPEN', NULL, NULL, 132);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-18', 19, 14, 10, 'OPEN', NULL, NULL, 133);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-19', 8, 4, 6, 'OPEN', NULL, NULL, 134);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-20', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 135);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-21', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 136);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-22', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 137);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-23', 28, 12, 14, 'OPEN', NULL, NULL, 138);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-24', 23, 14, 19, 'OPEN', NULL, NULL, 139);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-25', 34, 15, 19, 'OPEN', NULL, NULL, 140);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-26', 10, 5, 8, 'OPEN', NULL, NULL, 141);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-27', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 142);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-28', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 143);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-29', 30, 9, 20, 'OPEN', NULL, NULL, 144);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-04-30', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 145);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-01', 26, 12, 15, 'OPEN', NULL, NULL, 146);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-02', 24, 7, 12, 'OPEN', NULL, NULL, 147);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-03', 6, 3, 4, 'OPEN', NULL, NULL, 148);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-06', 20, 5, 10, 'OPEN', NULL, NULL, 149);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-07', 30, 13, 12, 'OPEN', NULL, NULL, 150);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-08', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 151);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-09', 31, 12, 18, 'OPEN', NULL, NULL, 152);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-10', 4, 1, 1, 'OPEN', NULL, NULL, 153);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-13', 21, 6, 10, 'OPEN', NULL, NULL, 154);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-14', 25, 6, 11, 'OPEN', NULL, NULL, 155);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-15', 14, 6, 7, 'OPEN', NULL, NULL, 156);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-16', 30, 12, 14, 'OPEN', NULL, NULL, 157);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-17', 2, 6, 1, 'OPEN', NULL, NULL, 158);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-20', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 159);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-21', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 160);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-22', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 161);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-23', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 162);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-24', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 163);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-27', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 164);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-28', 7, 9, 4, 'OPEN', NULL, NULL, 165);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-29', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 166);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-30', 21, 4, 1, 'OPEN', NULL, NULL, 167);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-05-31', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 168);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-03', 23, 5, 3, 'OPEN', NULL, NULL, 169);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-04', 10, 2, 2, 'OPEN', NULL, NULL, 170);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-05', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 171);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-06', 9, 8, 2, 'OPEN', NULL, NULL, 172);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-07', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 173);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-10', 20, 6, 6, 'OPEN', NULL, NULL, 174);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-11', 19, 5, 11, 'OPEN', NULL, NULL, 175);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-12', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 176);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-13', 11, 4, 8, 'OPEN', NULL, NULL, 177);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-14', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 178);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-17', 12, 3, 7, 'OPEN', NULL, NULL, 179);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-18', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 180);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-19', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 181);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-20', 6, 1, 2, 'OPEN', NULL, NULL, 182);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-21', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 183);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-22', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 184);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-24', 23, 13, 10, 'OPEN', NULL, NULL, 185);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-25', 9, 7, 3, 'OPEN', NULL, NULL, 186);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-26', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 187);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-27', 11, 6, 2, 'OPEN', NULL, NULL, 188);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-06-28', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 189);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-01', 18, 2, 3, 'OPEN', NULL, NULL, 190);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-02', 15, 4, 3, 'OPEN', NULL, NULL, 191);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-03', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 192);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-04', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 193);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-05', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 194);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-08', 24, 4, 9, 'OPEN', NULL, NULL, 195);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-09', 13, 4, 6, 'OPEN', NULL, NULL, 196);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-10', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 197);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-11', 5, 1, 2, 'OPEN', NULL, NULL, 198);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-12', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 199);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-15', 26, 3, 10, 'OPEN', NULL, NULL, 200);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-16', 11, 4, 1, 'OPEN', NULL, NULL, 201);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-17', NULL, NULL, 1, 'OPEN', NULL, NULL, 202);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-18', 9, 5, 1, 'OPEN', NULL, NULL, 203);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-19', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 204);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-22', 23, 3, 4, 'OPEN', NULL, NULL, 205);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-23', 10, 4, 1, 'OPEN', NULL, NULL, 206);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-24', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 207);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-25', 11, 3, 5, 'OPEN', NULL, NULL, 208);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-26', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 209);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-29', 26, 4, 9, 'OPEN', NULL, NULL, 210);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-07-30', 8, 11, 8, 'OPEN', NULL, NULL, 211);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-01', 8, 2, 2, 'OPEN', NULL, NULL, 212);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-02', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 213);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-05', 22, 1, 6, 'OPEN', NULL, NULL, 214);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-06', 12, 2, 1, 'OPEN', NULL, NULL, 215);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-07', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 216);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-08', 9, 3, 3, 'OPEN', NULL, NULL, 217);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-09', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 218);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-12', 22, 2, 7, 'OPEN', NULL, NULL, 219);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-13', 5, 6, 2, 'OPEN', NULL, NULL, 220);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-14', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 221);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-15', 5, 1, 3, 'OPEN', NULL, NULL, 222);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-16', NULL, NULL, NULL, 'CLOSED', 'Closed', 'Closed', 223);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-19', NULL, NULL, NULL, 'CLOSED', 'Closed', 'Closed', 224);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-20', NULL, NULL, NULL, 'CLOSED', 'Closed', 'Closed', 225);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-21', NULL, NULL, NULL, 'CLOSED', 'Closed', 'Closed', 226);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-22', NULL, NULL, NULL, 'CLOSED', 'Closed', 'Closed', 227);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-23', NULL, NULL, NULL, 'CLOSED', 'Closed', 'Closed', 228);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-26', 29, 6, 29, 'OPEN', NULL, 'Fall Semester Begins', 229);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-27', 15, 7, 15, 'OPEN', NULL, NULL, 230);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-28', 23, 6, 23, 'OPEN', NULL, NULL, 231);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-29', 14, 4, 14, 'OPEN', NULL, NULL, 232);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-08-30', 6, 2, 6, 'OPEN', NULL, NULL, 233);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-02', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 234);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-03', 26, 10, 19, 'OPEN', NULL, NULL, 235);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-04', 29, 12, 27, 'OPEN', NULL, NULL, 236);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-05', 25, 10, NULL, 'OPEN', NULL, NULL, 237);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-06', 9, 5, 8, 'OPEN', NULL, NULL, 238);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-09', 28, 8, 16, 'OPEN', NULL, NULL, 239);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-10', 41, 14, 27, 'OPEN', NULL, NULL, 240);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-11', 33, 13, 17, 'OPEN', NULL, NULL, 241);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-12', 29, 12, 19, 'OPEN', NULL, NULL, 242);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-13', 6, 2, 4, 'OPEN', NULL, NULL, 243);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-16', 34, 12, 8, 'OPEN', NULL, NULL, 244);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-17', 32, 14, 15, 'OPEN', NULL, NULL, 245);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-18', 29, 13, 16, 'OPEN', NULL, NULL, 246);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-19', 37, 23, 15, 'OPEN', NULL, NULL, 247);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-20', 6, 2, 4, 'OPEN', NULL, NULL, 248);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-23', 56, 23, 27, 'OPEN', NULL, NULL, 249);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-24', 35, 16, 18, 'OPEN', NULL, NULL, 250);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-25', 24, 11, 13, 'OPEN', NULL, NULL, 251);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-26', 38, 22, 19, 'OPEN', NULL, NULL, 252);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-27', 8, 6, 7, 'OPEN', NULL, NULL, 253);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-09-30', 55, 16, 25, 'OPEN', NULL, NULL, 254);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-01', 28, 8, 13, 'OPEN', NULL, NULL, 255);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-02', 36, 21, NULL, 'OPEN', NULL, NULL, 256);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-03', 26, 11, 15, 'OPEN', NULL, NULL, 257);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-04', 8, 4, 5, 'OPEN', NULL, NULL, 258);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-07', 54, 21, 25, 'OPEN', NULL, NULL, 259);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-08', 19, 21, 11, 'OPEN', NULL, NULL, 260);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-09', 24, 9, 16, 'OPEN', NULL, NULL, 261);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-10', 32, 13, 16, 'OPEN', NULL, NULL, 262);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-11', 10, 8, 7, 'OPEN', NULL, NULL, 263);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-14', 39, 10, NULL, 'OPEN', NULL, NULL, 264);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-15', 37, 11, 14, 'OPEN', NULL, NULL, 265);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-16', 36, 9, 19, 'OPEN', NULL, NULL, 266);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-17', 32, 11, NULL, 'OPEN', NULL, NULL, 267);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-18', 17, 9, NULL, 'OPEN', NULL, NULL, 268);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-21', 36, 7, 15, 'OPEN', NULL, NULL, 269);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-22', 39, 8, 16, 'OPEN', NULL, NULL, 270);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-23', 43, 7, 19, 'OPEN', NULL, NULL, 271);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-24', 38, 19, 12, 'OPEN', NULL, NULL, 272);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-25', 10, 6, 5, 'OPEN', NULL, NULL, 273);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-28', 45, 10, 21, 'OPEN', NULL, NULL, 274);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-29', 50, 16, 22, 'OPEN', NULL, NULL, 275);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-30', 27, 12, 12, 'OPEN', NULL, NULL, 276);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-10-31', 34, 7, NULL, 'OPEN', NULL, NULL, 277);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-01', 9, 6, 7, 'OPEN', NULL, NULL, 278);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-04', 46, 11, 24, 'OPEN', NULL, NULL, 279);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-05', 20, 7, 6, 'OPEN', NULL, NULL, 280);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-06', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 281);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-07', 31, 11, 13, 'OPEN', NULL, NULL, 282);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-08', 9, 8, 5, 'OPEN', NULL, NULL, 283);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-11', 37, 7, 19, 'OPEN', NULL, NULL, 284);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-12', 40, 6, 26, 'OPEN', NULL, NULL, 285);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-13', 34, 9, 17, 'OPEN', NULL, NULL, 286);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-14', 39, 9, 19, 'OPEN', NULL, NULL, 287);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-15', 12, 8, 6, 'OPEN', NULL, NULL, 288);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-18', 55, 11, 31, 'OPEN', NULL, NULL, 289);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-19', 37, 7, 11, 'OPEN', NULL, NULL, 290);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-20', 40, 10, 15, 'OPEN', NULL, NULL, 291);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-21', 36, 11, 6, 'OPEN', NULL, NULL, 292);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-22', 12, 5, 5, 'OPEN', NULL, NULL, 293);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-25', 48, 5, 23, 'OPEN', NULL, NULL, 294);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-26', 52, 9, 20, 'OPEN', NULL, NULL, 295);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-27', NULL, NULL, NULL, 'CLOSED', 'Thanksgiving break - pantry closed', 'Thanksgiving break - pantry closed', 296);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-28', NULL, NULL, NULL, 'CLOSED', 'Thanksgiving break - pantry closed', 'Thanksgiving break - pantry closed', 297);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-11-29', NULL, NULL, NULL, 'CLOSED', 'Thanksgiving break - pantry closed', 'Thanksgiving break - pantry closed', 298);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-02', 37, 11, 12, 'OPEN', NULL, NULL, 299);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-03', 28, 5, 10, 'OPEN', NULL, NULL, 300);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-04', 28, 10, 17, 'OPEN', NULL, NULL, 301);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-05', 27, 12, 8, 'OPEN', NULL, NULL, 302);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-06', 12, 4, 9, 'OPEN', NULL, 'Trash - moth infested MFB food', 303);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-09', 31, 10, 11, 'OPEN', NULL, NULL, 304);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-10', 37, 3, 14, 'OPEN', NULL, NULL, 305);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-11', 15, 8, 9, 'OPEN', NULL, NULL, 306);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-12', 24, 3, 15, 'OPEN', NULL, NULL, 307);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-13', 7, 3, 5, 'OPEN', NULL, NULL, 308);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-16', 10, 2, 5, 'OPEN', NULL, NULL, 309);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-17', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 310);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-18', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 311);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-19', 23, 7, 15, 'OPEN', NULL, NULL, 312);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2024-12-20', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 313);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-01', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 314);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-02', 7, 4, 3, 'OPEN', NULL, NULL, 315);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-03', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 316);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-06', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 317);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-07', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 318);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-08', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 319);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-09', 21, 7, 14, 'OPEN', NULL, NULL, 320);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-10', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 321);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-13', 17, 5, 10, 'OPEN', NULL, NULL, 322);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-14', 12, 3, 4, 'OPEN', NULL, NULL, 323);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-15', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 324);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-16', 12, 4, 6, 'OPEN', NULL, NULL, 325);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-17', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 326);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-18', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 327);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-19', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 328);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-20', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 329);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-21', 14, 4, 10, 'OPEN', NULL, NULL, 330);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-22', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 331);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-23', 14, 5, 4, 'OPEN', NULL, NULL, 332);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-24', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 333);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-27', 51, 11, 51, 'OPEN', NULL, NULL, 334);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-28', 21, 4, 21, 'OPEN', NULL, NULL, 335);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-29', 26, 5, 26, 'OPEN', NULL, NULL, 336);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-30', 27, 9, 27, 'OPEN', NULL, NULL, 337);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-01-31', 17, 5, 17, 'OPEN', NULL, NULL, 338);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-03', 44, 9, 40, 'OPEN', NULL, NULL, 339);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-04', 31, 11, 25, 'OPEN', NULL, NULL, 340);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-05', 30, 10, 22, 'OPEN', NULL, NULL, 341);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-06', 43, 11, 15, 'OPEN', NULL, NULL, 342);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-07', 8, 6, 5, 'OPEN', NULL, NULL, 343);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-10', 65, 9, 21, 'OPEN', NULL, NULL, 344);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-11', NULL, NULL, NULL, 'CLOSED', 'SNOW', NULL, 345);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-12', NULL, NULL, NULL, 'CLOSED', 'SNOW', NULL, 346);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-13', 53, 9, 15, 'OPEN', NULL, NULL, 347);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-14', 17, 6, 10, 'OPEN', NULL, NULL, 348);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-17', 58, 11, 22, 'OPEN', NULL, NULL, 349);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-18', 26, 11, 11, 'OPEN', NULL, NULL, 350);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-19', 27, 7, 11, 'OPEN', NULL, NULL, 351);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-20', 47, 9, 17, 'OPEN', NULL, NULL, 352);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-21', 17, 5, 11, 'OPEN', NULL, NULL, 353);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-24', 47, 11, 21, 'OPEN', NULL, NULL, 354);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-25', 22, 8, 21, 'OPEN', NULL, NULL, 355);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-26', 46, 10, 17, 'OPEN', NULL, NULL, 356);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-27', 38, 13, 16, 'OPEN', NULL, NULL, 357);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-02-28', 14, 5, 7, 'OPEN', NULL, NULL, 358);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-03', 44, 6, 13, 'OPEN', NULL, NULL, 359);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-04', 39, 13, 12, 'OPEN', NULL, NULL, 360);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-05', 29, 4, 17, 'OPEN', NULL, NULL, 361);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-06', 42, 13, 21, 'OPEN', NULL, '12 Overnight Oats', 362);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-07', 13, 4, 9, 'OPEN', NULL, NULL, 363);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-08', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 364);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-09', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 365);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-10', 37, 7, 15, 'OPEN', NULL, '12 pizza mug kits', 366);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-11', 40, 9, 16, 'OPEN', NULL, NULL, 367);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-12', 22, 5, 9, 'OPEN', NULL, NULL, 368);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-13', 39, NULL, 15, 'OPEN', NULL, NULL, 369);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-14', 19, 7, 11, 'OPEN', NULL, '12 Veggie Burrito Bowl Mug Kit', 370);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-15', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 371);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-16', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 372);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-17', 41, 10, 20, 'OPEN', NULL, NULL, 373);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-18', 35, 13, 13, 'OPEN', NULL, NULL, 374);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-19', 38, 12, 18, 'OPEN', NULL, NULL, 375);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-20', 40, 12, 18, 'OPEN', NULL, NULL, 376);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-21', 7, 3, 5, 'OPEN', NULL, NULL, 377);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-22', NULL, NULL, NULL, 'NOT_REPORTED', NULL, 'Spring Break', 378);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-23', NULL, NULL, NULL, 'NOT_REPORTED', NULL, 'Spring Break', 379);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-24', NULL, NULL, NULL, 'NOT_REPORTED', NULL, 'Spring Break', 380);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-25', NULL, NULL, NULL, 'NOT_REPORTED', NULL, 'Spring Break', 381);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-26', NULL, NULL, NULL, 'NOT_REPORTED', NULL, 'Spring Break', 382);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-27', NULL, NULL, NULL, 'NOT_REPORTED', NULL, 'Spring Break', 383);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-28', NULL, NULL, NULL, 'NOT_REPORTED', NULL, 'Spring Break', 384);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-29', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 385);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-30', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 386);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-03-31', 38, 2, 17, 'OPEN', NULL, NULL, 387);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-01', 46, 11, 13, 'OPEN', NULL, NULL, 388);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-02', 32, 7, 13, 'OPEN', NULL, NULL, 389);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-03', 32, 13, 18, 'OPEN', NULL, NULL, 390);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-04', 16, 7, 11, 'OPEN', NULL, NULL, 391);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-07', 37, 9, 11, 'OPEN', NULL, NULL, 392);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-08', 31, 8, 13, 'OPEN', NULL, NULL, 393);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-09', 51, 14, 24, 'OPEN', NULL, NULL, 394);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-10', 46, 17, 13, 'OPEN', NULL, NULL, 395);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-11', 16, 9, 10, 'OPEN', NULL, NULL, 396);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-14', 51, 14, 11, 'OPEN', NULL, NULL, 397);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-15', 37, 14, 14, 'OPEN', NULL, NULL, 398);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-16', 41, 12, 16, 'OPEN', NULL, NULL, 399);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-17', 36, 9, 13, 'OPEN', NULL, NULL, 400);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-18', 13, 8, 9, 'OPEN', NULL, NULL, 401);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-21', 56, 6, 20, 'OPEN', NULL, NULL, 402);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-22', 34, 8, 10, 'OPEN', NULL, NULL, 403);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-23', 41, 9, 21, 'OPEN', NULL, NULL, 404);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-24', 34, 12, 14, 'OPEN', NULL, NULL, 405);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-25', 21, 9, 7, 'OPEN', NULL, '*Cooking class info not included', 406);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-28', 43, 13, 18, 'OPEN', NULL, NULL, 407);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-29', 38, 11, 16, 'OPEN', NULL, NULL, 408);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-04-30', 32, 9, 11, 'OPEN', NULL, NULL, 409);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-01', 31, 8, 122, 'OPEN', NULL, NULL, 410);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-02', 5, 3, NULL, 'OPEN', NULL, NULL, 411);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-05', 44, 9, 15, 'OPEN', NULL, NULL, 412);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-06', 27, 6, 8, 'OPEN', NULL, NULL, 413);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-07', 26, 9, 11, 'OPEN', NULL, NULL, 414);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-08', 35, 13, 13, 'OPEN', NULL, NULL, 415);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-09', 14, 7, 7, 'OPEN', NULL, NULL, 416);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-12', 51, 13, 19, 'OPEN', NULL, NULL, 417);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-13', 16, 9, 3, 'OPEN', NULL, NULL, 418);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-14', 30, 6, 11, 'OPEN', NULL, NULL, 419);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-15', 41, 8, 18, 'OPEN', NULL, NULL, 420);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-16', 21, 10, 12, 'OPEN', NULL, NULL, 421);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-19', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed', 'Pantry Closed', 422);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-20', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed', 'Pantry Closed', 423);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-21', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed', 'Pantry Closed', 424);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-22', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed', 'Pantry Closed', 425);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-23', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed', 'Pantry Closed', 426);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-26', NULL, NULL, NULL, 'CLOSED', 'Closed - Holiday', 'Closed - Holiday', 427);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-27', 13, 4, 13, 'OPEN', NULL, 'Summer Session Begins', 428);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-28', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed (Summer Hours)', 'Pantry Closed (Summer Hours)', 429);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-29', 19, 3, 19, 'OPEN', NULL, NULL, 430);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-05-30', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed (Summer Hours)', 'Pantry Closed (Summer Hours)', 431);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-02', 13, 3, 13, 'OPEN', NULL, NULL, 432);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-03', 15, 5, 15, 'OPEN', NULL, NULL, 433);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-05', 10, 4, 10, 'OPEN', NULL, NULL, 434);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-06', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 435);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-09', 24, 5, 24, 'OPEN', NULL, NULL, 436);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-10', 19, 6, 12, 'OPEN', NULL, NULL, 437);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-12', 22, 6, 10, 'OPEN', NULL, NULL, 438);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-16', 19, 5, 7, 'OPEN', NULL, NULL, 439);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-17', 16, 6, 8, 'OPEN', NULL, NULL, 440);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-19', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 441);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-23', 25, 3, 11, 'OPEN', NULL, NULL, 442);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-24', 30, 4, 16, 'OPEN', NULL, NULL, 443);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-26', 18, 4, 7, 'OPEN', NULL, NULL, 444);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-06-30', 25, 3, 10, 'OPEN', NULL, NULL, 445);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-01', 23, 12, 9, 'OPEN', NULL, NULL, 446);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-03', 16, 5, 5, 'OPEN', NULL, NULL, 447);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-07', 25, 8, 8, 'OPEN', NULL, NULL, 448);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-08', 26, 3, 11, 'OPEN', NULL, NULL, 449);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-10', 21, 8, 10, 'OPEN', NULL, NULL, 450);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-14', 25, 6, 6, 'OPEN', NULL, NULL, 451);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-15', 23, 8, 15, 'OPEN', NULL, NULL, 452);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-16', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 453);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-17', 20, 8, 8, 'OPEN', NULL, NULL, 454);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-21', 29, 5, 12, 'OPEN', NULL, NULL, 455);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-22', 20, 7, 7, 'OPEN', NULL, NULL, 456);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-24', 15, 8, 8, 'OPEN', NULL, NULL, 457);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-28', 25, 7, 13, 'OPEN', NULL, NULL, 458);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-29', 18, 7, 9, 'OPEN', NULL, NULL, 459);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-07-31', 11, 7, 7, 'OPEN', NULL, NULL, 460);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-04', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 461);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-05', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 462);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-07', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 463);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-11', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 464);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-12', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 465);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-14', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 466);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-18', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 467);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-19', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 468);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-20', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 469);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-21', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 470);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-25', 35, 7, 35, 'OPEN', NULL, '1st day of Fall classes', 471);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-26', 37, 10, 37, 'OPEN', NULL, NULL, 472);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-27', 27, 7, 27, 'OPEN', NULL, NULL, 473);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-28', 25, 14, 25, 'OPEN', NULL, NULL, 474);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-08-29', 12, 6, 12, 'OPEN', NULL, NULL, 475);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-01', NULL, NULL, NULL, 'NOT_REPORTED', NULL, NULL, 476);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-02', 64, 21, 31, 'OPEN', NULL, NULL, 477);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-03', 43, 17, 43, 'OPEN', NULL, NULL, 478);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-04', 33, 13, 22, 'OPEN', NULL, NULL, 479);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-05', 13, 6, 5, 'OPEN', NULL, NULL, 480);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-08', 51, 15, 51, 'OPEN', NULL, NULL, 481);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-09', 38, 13, 15, 'OPEN', NULL, NULL, 482);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-10', 51, 16, 29, 'OPEN', NULL, NULL, 483);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-11', 43, 12, 18, 'OPEN', NULL, NULL, 484);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-12', 11, 7, 6, 'OPEN', NULL, NULL, 485);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-15', 69, 20, 33, 'OPEN', NULL, NULL, 486);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-16', 45, 10, 20, 'OPEN', NULL, NULL, 487);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-17', 32, 18, 13, 'OPEN', NULL, NULL, 488);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-18', 41, 12, 24, 'OPEN', NULL, NULL, 489);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-19', 9, 6, 4, 'OPEN', NULL, NULL, 490);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-22', 49, 11, 17, 'OPEN', NULL, NULL, 491);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-23', 51, 17, 24, 'OPEN', NULL, NULL, 492);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-24', 40, 14, 15, 'OPEN', NULL, NULL, 493);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-25', 42, 13, 27, 'OPEN', NULL, NULL, 494);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-26', 11, 8, 7, 'OPEN', NULL, NULL, 495);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-29', 67, 15, 29, 'OPEN', NULL, NULL, 496);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-09-30', 48, 11, 23, 'OPEN', NULL, NULL, 497);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-01', 33, 9, 13, 'OPEN', NULL, NULL, 498);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-02', 37, 14, 17, 'OPEN', NULL, NULL, 499);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-03', 18, 9, 10, 'OPEN', NULL, NULL, 500);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-06', 54, 18, 25, 'OPEN', NULL, NULL, 501);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-07', 51, 12, 25, 'OPEN', NULL, NULL, 502);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-08', 48, 14, 30, 'OPEN', NULL, NULL, 503);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-09', 47, 13, 18, 'OPEN', NULL, NULL, 504);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-10', 16, 8, 10, 'OPEN', NULL, NULL, 505);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-13', 51, 10, 23, 'OPEN', NULL, NULL, 506);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-14', 41, 11, 19, 'OPEN', NULL, NULL, 507);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-15', 46, 9, 22, 'OPEN', NULL, NULL, 508);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-16', 47, 11, 11, 'OPEN', NULL, NULL, 509);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-17', 11, 5, 6, 'OPEN', NULL, NULL, 510);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-20', 52, 14, 24, 'OPEN', NULL, NULL, 511);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-21', 33, 9, 14, 'OPEN', NULL, NULL, 512);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-22', 49, 17, 17, 'OPEN', NULL, NULL, 513);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-23', 52, 16, 25, 'OPEN', NULL, NULL, 514);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-24', 15, 4, 6, 'OPEN', NULL, NULL, 515);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-27', 46, 14, 21, 'OPEN', NULL, NULL, 516);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-28', 47, 13, 23, 'OPEN', NULL, NULL, 517);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-29', 45, 13, 19, 'OPEN', NULL, NULL, 518);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-30', 51, 14, 30, 'OPEN', NULL, NULL, 519);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-10-31', 13, 8, 6, 'OPEN', NULL, NULL, 520);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-03', 26, 11, 15, 'OPEN', NULL, NULL, 521);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-04', 53, 16, 21, 'OPEN', NULL, NULL, 522);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-05', 64, 18, 29, 'OPEN', NULL, NULL, 523);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-06', 63, 18, 30, 'OPEN', NULL, NULL, 524);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-07', 12, 7, 6, 'OPEN', NULL, NULL, 525);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-10', 54, 14, 19, 'OPEN', NULL, NULL, 526);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-11', 43, 11, 20, 'OPEN', NULL, NULL, 527);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-12', 36, 8, 19, 'OPEN', NULL, NULL, 528);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-13', 57, 12, 23, 'OPEN', NULL, NULL, 529);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-14', 13, 6, 8, 'OPEN', NULL, NULL, 530);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-17', 63, 17, 41, 'OPEN', NULL, 'Links of Columbia Fruit Giveaway', 531);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-18', 46, 14, 24, 'OPEN', NULL, NULL, 532);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-19', 42, 14, 25, 'OPEN', NULL, NULL, 533);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-20', 46, 14, 22, 'OPEN', NULL, NULL, 534);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-21', 13, 7, 7, 'OPEN', NULL, NULL, 535);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-24', 57, 14, 21, 'OPEN', NULL, NULL, 536);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-25', 36, 12, 17, 'OPEN', NULL, NULL, 537);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-26', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 538);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-27', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 539);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-11-28', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 540);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-01', 42, 11, 17, 'OPEN', NULL, NULL, 541);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-02', 31, 10, 16, 'OPEN', NULL, NULL, 542);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-03', 48, 8, 22, 'OPEN', NULL, NULL, 543);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-04', 41, 11, 27, 'OPEN', NULL, NULL, 544);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-05', 6, 3, 4, 'OPEN', NULL, NULL, 545);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-08', 56, 9, 31, 'OPEN', NULL, NULL, 546);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-09', 38, 11, 21, 'OPEN', NULL, NULL, 547);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-10', 42, 9, 18, 'OPEN', NULL, NULL, 548);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-11', 29, 7, 13, 'OPEN', NULL, NULL, 549);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-12', 13, 5, 6, 'OPEN', NULL, NULL, 550);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-15', 15, 4, 7, 'OPEN', NULL, NULL, 551);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-16', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed', 'Pantry Closed', 552);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-17', NULL, NULL, NULL, 'CLOSED', 'Pantry Closed', 'Pantry Closed', 553);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-18', 31, 10, 19, 'OPEN', NULL, NULL, 554);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-19', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 555);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-22', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 556);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-23', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 557);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-24', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 558);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-25', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 559);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-26', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 560);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-29', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 561);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-30', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 562);

INSERT INTO pantry_daily_operations (activity_date, students_served, grab_and_go_visits, reusable_bags_given, operating_status, closure_reason, notes, report_source_id) VALUES ('2025-12-31', NULL, NULL, NULL, 'CLOSED', 'College Closed', 'College Closed', 563);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-02', 198.85, 26);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-04', 89.35, 28);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-08', 126.1, 32);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-10', 96.95, 34);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-11', 151.05, 35);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-18', 95.45, 42);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-22', 106.0, 46);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-23', 120.65, 47);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-25', 102.55, 49);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-29', 263.75, 53);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-30', 238.15, 54);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-01-31', 274.0, 55);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-01', 128.6, 56);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-02', 28.55, 57);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-05', 340.3, 60);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-06', 301.75, 61);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-07', 194.95, 62);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-08', 168.25, 63);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-09', 62.95, 64);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-12', 398.5, 67);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-13', 374.75, 68);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-14', 219.55, 69);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-15', 159.8, 70);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-16', 85.35, 71);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-19', 236.83, 74);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-20', 325.05, 75);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-21', 167.55, 76);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-22', 177.15, 77);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-23', 94.2, 78);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-26', 298.2, 81);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-27', 266.6, 82);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-28', 254.85, 83);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-02-29', 203.15, 84);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-01', 58.55, 85);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-04', 300.45, 88);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-05', 330.8, 89);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-06', 238.7, 90);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-07', 226.6, 91);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-08', 76.85, 92);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-11', 430.05, 95);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-12', 353.85, 96);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-13', 251.65, 97);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-14', 135.45, 98);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-15', 136.75, 99);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-18', 264.4, 102);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-19', 232.5, 103);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-20', 206.25, 104);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-21', 293.95, 105);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-03-22', 44.4, 106);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-01', 354.35, 116);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-02', 266.75, 117);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-03', 190.25, 118);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-04', 217.75, 119);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-05', 60.15, 120);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-08', 380.0, 123);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-09', 306.9, 124);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-10', 371.1, 125);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-11', 218.9, 126);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-12', 62.65, 127);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-15', 332.7, 130);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-16', 309.55, 131);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-17', 310.0, 132);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-18', 288.8, 133);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-19', 84.3, 134);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-23', 232.3, 138);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-24', 167.65, 139);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-25', 425.5, 140);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-26', 118.0, 141);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-04-29', 254.1, 144);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-01', 179.85, 146);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-02', 209.3, 147);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-03', 41.7, 148);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-06', 142.15, 149);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-07', 244.15, 150);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-09', 237.15, 152);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-10', 19.94, 153);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-13', 224.15, 154);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-14', 251.25, 155);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-15', 162.15, 156);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-16', 353.85, 157);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-17', 33.75, 158);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-28', 83.47, 165);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-05-30', 187.05, 167);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-03', 253.0, 169);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-04', 109.69, 170);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-06', 106.75, 172);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-10', 267.9, 174);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-11', 282.75, 175);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-13', 125.0, 177);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-17', 113.8, 179);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-20', 75.24, 182);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-24', 308.3, 185);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-25', 107.65, 186);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-06-27', 159.8, 188);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-01', 209.55, 190);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-02', 182.25, 191);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-08', 255.3, 195);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-09', 187.5, 196);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-11', 48.4, 198);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-15', 313.9, 200);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-16', 105.7, 201);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-18', 124.4, 203);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-22', 249.2, 205);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-23', 108.55, 206);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-25', 160.25, 208);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-29', 201.79, 210);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-07-30', 55.3, 211);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-01', 89.5, 212);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-05', 85.2, 214);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-06', 151.05, 215);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-08', 121.5, 217);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-12', 316.75, 219);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-13', 69.75, 220);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-15', 80.55, 222);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-26', 371.8, 229);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-27', 177.75, 230);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-28', 228.5, 231);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-29', 183.7, 232);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-08-30', 84.4, 233);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-03', 331.0, 235);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-04', 311.95, 236);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-05', 261.8, 237);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-06', 62.65, 238);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-09', 316.35, 239);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-10', 426.45, 240);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-11', 303.9, 241);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-12', 389.05, 242);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-13', 62.3, 243);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-16', 575.55, 244);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-17', 375.25, 245);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-18', 311.15, 246);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-19', 462.35, 247);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-20', 88.5, 248);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-23', 597.1, 249);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-24', 409.5, 250);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-25', 221.5, 251);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-26', 411.95, 252);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-27', 77.95, 253);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-09-30', 456.95, 254);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-01', 299.25, 255);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-02', 362.05, 256);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-03', 391.15, 257);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-04', 73.05, 258);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-07', 702.55, 259);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-08', 218.15, 260);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-09', 252.5, 261);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-10', 499.45, 262);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-11', 97.45, 263);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-14', 448.47, 264);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-15', 428.85, 265);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-16', 392.45, 266);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-17', 343.4, 267);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-18', 155.1, 268);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-21', 380.25, 269);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-22', 454.3, 270);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-23', 346.9, 271);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-24', 397.85, 272);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-25', 95.4, 273);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-28', 678.65, 274);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-29', 798.0, 275);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-30', 416.6, 276);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-10-31', 469.65, 277);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-01', 134.4, 278);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-04', 429.05, 279);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-05', 270.9, 280);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-07', 341.13, 282);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-08', 98.55, 283);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-11', 375.85, 284);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-12', 515.3, 285);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-13', 431.0, 286);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-14', 474.1, 287);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-15', 130.0, 288);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-18', 522.25, 289);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-19', 353.05, 290);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-20', 379.15, 291);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-21', 335.75, 292);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-22', 99.45, 293);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-25', 388.7, 294);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-11-26', 421.75, 295);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-02', 340.0, 299);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-03', 303.25, 300);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-04', 249.1, 301);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-05', 199.35, 302);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-06', 111.7, 303);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-09', 312.55, 304);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-10', 322.1, 305);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-11', 178.1, 306);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-12', 236.75, 307);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-13', 52.05, 308);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-16', 126.1, 309);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2024-12-19', 265.85, 312);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-02', 82.85, 315);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-09', 256.15, 320);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-13', 218.05, 322);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-14', 134.55, 323);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-16', 182.15, 325);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-21', 151.4, 330);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-23', 174.0, 332);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-27', 450.9, 334);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-28', 208.85, 335);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-29', 273.2, 336);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-30', 222.2, 337);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-01-31', 151.35, 338);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-03', 383.2, 339);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-04', 404.45, 340);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-05', 341.0, 341);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-06', 356.75, 342);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-07', 92.25, 343);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-10', 713.9, 344);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-13', 562.95, 347);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-14', 167.2, 348);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-17', 512.4, 349);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-18', 291.35, 350);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-19', 260.85, 351);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-20', 302.15, 352);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-21', 155.8, 353);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-24', 475.6, 354);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-25', 230.45, 355);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-26', 555.9, 356);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-27', 375.2, 357);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-02-28', 127.05, 358);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-03', 325.95, 359);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-04', 426.65, 360);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-05', 328.25, 361);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-06', 326.5, 362);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-07', 125.85, 363);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-10', 347.15, 366);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-11', 375.0, 367);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-12', 314.55, 368);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-13', 478.25, 369);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-14', 288.2, 370);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-17', 399.55, 373);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-18', 323.25, 374);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-19', 379.1, 375);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-20', 304.7, 376);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-21', 84.7, 377);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-03-31', 275.5, 387);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-01', 421.5, 388);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-02', 358.7, 389);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-03', 287.05, 390);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-04', 189.6, 391);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-07', 292.5, 392);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-08', 286.0, 393);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-09', 523.95, 394);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-10', 368.5, 395);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-11', 152.7, 396);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-14', 460.7, 397);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-15', 332.55, 398);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-16', 473.55, 399);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-17', 276.35, 400);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-18', 168.05, 401);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-21', 433.75, 402);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-22', 377.5, 403);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-23', 432.2, 404);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-24', 334.2, 405);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-25', 253.05, 406);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-28', 305.3, 407);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-29', 375.55, 408);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-04-30', 289.45, 409);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-01', 247.05, 410);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-02', 67.2, 411);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-05', 462.15, 412);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-06', 242.85, 413);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-07', 236.55, 414);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-08', 346.2, 415);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-09', 182.55, 416);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-12', 459.2, 417);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-13', 179.85, 418);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-14', 399.05, 419);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-15', 479.5, 420);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-16', 249.47, 421);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-27', 181.65, 428);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-05-29', 216.05, 430);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-02', 192.45, 432);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-03', 232.75, 433);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-05', 108.65, 434);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-09', 225.55, 436);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-10', 212.8, 437);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-12', 300.35, 438);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-16', 230.35, 439);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-17', 220.15, 440);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-23', 285.6, 442);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-24', 285.3, 443);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-26', 173.35, 444);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-06-30', 285.6, 445);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-01', 247.9, 446);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-03', 231.5, 447);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-07', 329.25, 448);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-08', 288.15, 449);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-10', 274.7, 450);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-14', 329.8, 451);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-15', 334.85, 452);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-17', 219.75, 454);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-21', 408.75, 455);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-22', 322.8, 456);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-24', 197.95, 457);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-28', 282.55, 458);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-29', 292.35, 459);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-07-31', 173.65, 460);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-08-25', 402.2, 471);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-08-26', 411.9, 472);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-08-27', 270.8, 473);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-08-28', 288.7, 474);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-08-29', 218.55, 475);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-02', 719.95, 477);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-03', 389.95, 478);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-04', 346.45, 479);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-05', 229.7, 480);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-08', 528.15, 481);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-09', 510.15, 482);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-10', 581.4, 483);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-11', 424.65, 484);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-12', 140.2, 485);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-15', 685.05, 486);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-16', 557.4, 487);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-17', 319.35, 488);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-18', 434.3, 489);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-19', 83.35, 490);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-22', 530.95, 491);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-23', 555.65, 492);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-24', 499.85, 493);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-25', 450.95, 494);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-26', 141.55, 495);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-29', 737.15, 496);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-09-30', 510.7, 497);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-01', 351.75, 498);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-02', 476.05, 499);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-03', 134.3, 500);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-06', 588.8, 501);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-07', 468.5, 502);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-08', 503.2, 503);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-09', 502.35, 504);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-10', 209.26, 505);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-13', 485.15, 506);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-14', 464.44, 507);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-15', 601.55, 508);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-16', 716.35, 509);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-17', 148.05, 510);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-20', 516.45, 511);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-21', 441.85, 512);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-22', 499.25, 513);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-23', 648.6, 514);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-24', 152.55, 515);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-27', 462.59, 516);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-28', 528.77, 517);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-29', 490.85, 518);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-30', 551.05, 519);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-10-31', 148.65, 520);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-03', 159.25, 521);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-04', 582.7, 522);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-05', 550.0, 523);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-06', 576.65, 524);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-07', 143.35, 525);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-10', 552.35, 526);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-11', 498.8, 527);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-12', 431.15, 528);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-13', 578.2, 529);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-14', 141.15, 530);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-17', 880.9, 531);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-18', 525.65, 532);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-19', 642.45, 533);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-20', 439.85, 534);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-21', 159.05, 535);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-24', 596.2, 536);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-11-25', 276.15, 537);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-01', 372.05, 541);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-02', 359.5, 542);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-03', 628.25, 543);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-04', 429.4, 544);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-05', 61.7, 545);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-08', 636.05, 546);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-09', 525.25, 547);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-10', 461.55, 548);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-11', 425.15, 549);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-12', 142.55, 550);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-15', 216.15, 551);

INSERT INTO food_outgoing (activity_date, distributed_food_lb, report_source_id) VALUES ('2025-12-18', 548.05, 554);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-01-22', 14.95, 46);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-01-23', 20.5, 47);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-01-25', 38.3, 49);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-06', 29.9, 61);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-12', 104.95, 67);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-14', 27.4, 69);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-16', 32.15, 71);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-23', 40.25, 78);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-27', 7.45, 82);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-29', 11.2, 84);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-03-19', 40.8, 103);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-02', 23.8, 117);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-05', 76.5, 120);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-08', 40.15, 123);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-09', 41.35, 124);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-11', 45.6, 126);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-12', 29.5, 127);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-18', 49.35, 133);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-05-03', 16.5, 148);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-05-13', 29.3, 154);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-03', 16.3, 169);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-04', 19.4, 170);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-06', 14.3, 172);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-10', 45.55, 174);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-11', 16.25, 175);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-13', 74.45, 177);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-20', 18.95, 182);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-07-09', 41.5, 196);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-07-11', 76.9, 198);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-07-22', 47.7, 205);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-07-30', 46.05, 211);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-08-08', 32.0, 217);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-08-26', 24.2, 229);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-08-29', 43.1, 232);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-09-05', 13.1, 237);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-09-09', 2.85, 239);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-09-12', 27.0, 242);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-10-01', 22.35, 255);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-10-07', 28.75, 259);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-10-11', 50.0, 263);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-11-07', 26.4, 282);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-11-11', 16.45, 284);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-11-18', 16.5, 289);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-12-09', 28.2, 304);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2024-12-12', 30.15, 307);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-01-16', 45.15, 325);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-01-29', 47.35, 336);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-07', 50.5, 343);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-18', 32.55, 350);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-19', 37.15, 351);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-20', 40.3, 352);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-24', 42.3, 354);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-25', 41.5, 355);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-28', 13.5, 358);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-03-10', 34.8, 366);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-03-13', 42.3, 369);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-03-17', 41.65, 373);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-04-08', 60.75, 393);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-04-14', 58.75, 397);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-04-23', 35.45, 404);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-04-24', 3.8, 405);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-04-25', 1.1, 406);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-05-05', 1.9, 412);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-05-12', 2.55, 417);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-05-15', 50.28, 420);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-05-29', 41.8, 430);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-06-05', 20.0, 434);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-06-17', 106.55, 440);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-06-23', 43.4, 442);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-06-26', 35.0, 444);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-07-01', 53.3, 446);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-07-08', 76.45, 449);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-07-17', 5.05, 454);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-07-24', 4.5, 457);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-07-29', 28.85, 459);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-07-31', 41.7, 460);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-08-25', 53.35, 471);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-08-27', 3.5, 473);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-08-28', 7.85, 474);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-09-05', 43.2, 480);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-09-16', 53.9, 487);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-09-24', 73.2, 493);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-09-29', 13.5, 496);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-01', 3.75, 498);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-02', 3.55, 499);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-07', 57.8, 502);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-09', 1.5, 504);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-22', 57.95, 513);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-24', 2.85, 515);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-07', 17.15, 525);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-11', 19.8, 527);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-14', 61.35, 530);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-17', 29.95, 531);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-18', 37.35, 532);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-19', 15.2, 533);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-20', 8.1, 534);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-21', 18.5, 535);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-24', 27.0, 536);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-25', 3.5, 537);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-01', 6.25, 541);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-02', 2.6, 542);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-03', 59.5, 543);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-04', 8.3, 544);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-05', 0.5, 545);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-09', 1.55, 547);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-10', 3.3, 548);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-11', 7.5, 549);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-12', 2.55, 550);

INSERT INTO expired_but_distributed (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-15', 3.5, 551);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-01-02', 2.0, 26);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-01-04', 1.0, 28);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-01-08', 11.55, 32);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-01-18', 231.35, 42);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-01-22', 17.45, 46);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-01-23', 114.0, 47);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-01-25', 1.1, 49);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-02-01', 2.2, 56);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-02-02', 6.75, 57);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-02-05', 4.4, 60);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-02-06', 3.75, 61);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-02-09', 101.65, 64);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-02-15', 5.25, 70);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-02-20', 168.7, 75);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-02-23', 1.5, 78);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-02-27', 446.1, 82);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-03-11', 6.8, 95);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-03-13', 1.3, 97);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-03-14', 5.2, 98);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-03-15', 91.45, 99);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-03-18', 8.6, 102);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-03-19', 93.25, 103);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-03-20', 4.8, 104);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-03-22', 93.25, 106);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-04-01', 5.65, 116);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-04-04', 2.3, 119);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-04-09', 124.25, 124);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-04-11', 23.6, 126);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-04-18', 2.5, 133);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-04-23', 159.6, 138);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-06-10', 5.65, 174);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-06-11', 282.75, 175);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-06-13', 125.0, 177);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-06-17', 1.5, 179);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-06-25', 148.7, 186);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-08-15', 35.2, 222);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-09-03', 4.6, 235);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-09-04', 5.7, 236);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-09-09', 11.6, 239);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-09-16', 7.9, 244);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-09-24', 1.1, 250);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-10-01', 90.5, 255);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-10-07', 5.5, 259);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-10-08', 4.4, 260);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-10-09', 3.9, 261);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-10-11', 3.3, 263);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-10-22', 203.35, 270);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-10-24', 12.2, 272);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-10-25', 27.6, 273);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-10-30', 3.2, 276);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-11-04', 15.7, 279);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-11-05', 98.4, 280);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-11-12', 116.5, 285);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-12-06', 519.92, 303);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-12-11', 1.3, 306);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-12-12', 179.35, 307);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2024-12-19', 1.1, 312);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-01-13', 60.0, 322);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-01-27', 2.2, 334);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-01-28', 3.4, 335);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-01-29', 4.4, 336);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-01-30', 4.4, 337);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-04', 23.2, 340);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-05', 5.6, 341);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-07', 3.65, 343);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-17', 4.4, 349);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-18', 3.5, 350);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-19', 11.55, 351);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-20', 1.1, 352);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-21', 2.2, 353);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-24', 1.1, 354);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-25', 162.6, 355);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-02-28', 3.3, 358);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-03', 4.4, 359);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-04', 6.55, 360);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-07', 25.8, 363);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-10', 34.5, 366);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-11', 143.0, 367);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-12', 2.65, 368);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-13', 2.2, 369);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-14', 3.3, 370);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-17', 3.95, 373);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-18', 272.95, 374);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-20', 35.9, 376);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-21', 3.5, 377);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-03-31', 1.1, 387);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-01', 41.4, 388);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-02', 3.2, 389);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-03', 4.8, 390);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-04', 5.55, 391);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-07', 2.2, 392);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-08', 2.2, 393);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-09', 2.2, 394);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-11', 2.2, 396);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-15', 5.7, 398);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-16', 7.5, 399);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-17', 150.95, 400);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-18', 4.4, 401);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-21', 5.55, 402);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-22', 109.25, 403);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-24', 5.9, 405);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-25', 2.3, 406);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-28', 3.3, 407);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-04-29', 2.2, 408);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-05-01', 4.5, 410);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-05-05', 67.0, 412);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-05-06', 35.0, 413);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-05-09', 1.5, 416);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-05-12', 8.95, 417);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-05-13', 25.95, 418);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-05-27', 3.65, 428);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-06-02', 194.9, 432);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-06-16', 4.6, 439);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-06-23', 3.55, 442);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-06-24', 9.65, 443);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-06-26', 2.5, 444);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-07-01', 3.4, 446);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-07-03', 4.1, 447);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-07-07', 1.1, 448);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-07-08', 112.65, 449);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-07-14', 23.0, 451);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-07-21', 6.8, 455);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-07-24', 2.5, 457);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-07-28', 1.1, 458);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-07-29', 3.5, 459);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-08-26', 3.6, 472);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-08-27', 2.8, 473);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-08-28', 1.1, 474);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-08-29', 1.1, 475);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-02', 11.95, 477);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-03', 3.5, 478);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-09', 2.2, 482);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-10', 7.3, 483);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-15', 7.9, 486);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-16', 351.45, 487);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-24', 6.75, 493);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-26', 13.5, 495);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-29', 5.9, 496);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-09-30', 8.55, 497);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-01', 1.1, 498);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-02', 2.6, 499);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-03', 1.1, 500);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-06', 5.65, 501);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-07', 6.85, 502);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-08', 4.4, 503);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-09', 1.1, 504);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-10', 3.3, 505);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-13', 5.65, 506);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-14', 1.55, 507);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-15', 3.75, 508);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-16', 7.15, 509);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-17', 3.55, 510);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-20', 11.55, 511);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-21', 112.55, 512);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-22', 11.55, 513);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-23', 8.55, 514);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-24', 3.5, 515);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-27', 5.25, 516);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-28', 41.8, 517);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-29', 1.25, 518);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-30', 2.2, 519);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-10-31', 3.55, 520);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-04', 5.35, 522);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-05', 3.7, 523);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-06', 6.75, 524);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-07', 3.3, 525);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-10', 2.2, 526);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-11', 22.55, 527);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-12', 3.5, 528);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-13', 2.35, 529);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-17', 9.9, 531);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-18', 135.4, 532);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-19', 5.5, 533);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-20', 4.5, 534);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-21', 7.55, 535);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-24', 8.5, 536);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-11-25', 2.2, 537);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-01', 3.5, 541);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-02', 3.5, 542);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-03', 8.5, 543);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-04', 9.7, 544);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-05', 1.1, 545);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-08', 2.2, 546);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-09', 11.1, 547);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-10', 12.3, 548);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-11', 9.5, 549);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-12', 3.3, 550);

INSERT INTO food_trash (activity_date, pounds_discarded, report_source_id) VALUES ('2025-12-15', 5.2, 551);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-05', 'ROVING_RADISH_MEAL_KITS', 158.1, NULL, 60);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-08', 'ROVING_RADISH_MEAL_KITS', 105.4, NULL, 63);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-12', 'ROVING_RADISH_MEAL_KITS', 130.8, NULL, 67);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-15', 'ROVING_RADISH_MEAL_KITS', 89.8, NULL, 70);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-19', 'ROVING_RADISH_MEAL_KITS', 144.9, NULL, 74);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-20', 'ROVING_RADISH_MEAL_KITS', 138.6, NULL, 75);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-22', 'ROVING_RADISH_MEAL_KITS', 96.6, NULL, 77);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-26', 'ROVING_RADISH_MEAL_KITS', 182.1, NULL, 81);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-27', 'ROVING_RADISH_MEAL_KITS', 266.6, NULL, 82);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-02-29', 'ROVING_RADISH_MEAL_KITS', 121.4, NULL, 84);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-03-04', 'RECIPE_MEAL_KITS', 13.05, NULL, 88);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-03-05', 'RECIPE_MEAL_KITS', 35.15, NULL, 89);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-03-06', 'RECIPE_MEAL_KITS', 6.95, NULL, 90);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-03-07', 'RECIPE_MEAL_KITS', 20.95, NULL, 91);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-03-08', 'RECIPE_MEAL_KITS', 2.2, NULL, 92);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-03-12', 'RECIPE_MEAL_KITS', 23.2, NULL, 96);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-03-13', 'RECIPE_MEAL_KITS', 13.9, NULL, 97);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-03-14', 'RECIPE_MEAL_KITS', 12.8, NULL, 98);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-03-15', 'RECIPE_MEAL_KITS', 5.85, NULL, 99);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-04-23', 'ROVING_RADISH_MEAL_KITS', 7.65, NULL, 138);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-04-25', 'ROVING_RADISH_MEAL_KITS', 95.2, NULL, 140);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-04-29', 'ROVING_RADISH_MEAL_KITS', 123.0, NULL, 144);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-05-06', 'ROVING_RADISH_MEAL_KITS', 60.75, NULL, 149);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-05-09', 'ROVING_RADISH_MEAL_KITS', 74.5, NULL, 152);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-05-13', 'ROVING_RADISH_MEAL_KITS', 60.45, NULL, 154);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-05-14', 'ROVING_RADISH_MEAL_KITS', 66.8, NULL, 155);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-05-15', 'ROVING_RADISH_MEAL_KITS', 49.0, NULL, 156);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-05-16', 'ROVING_RADISH_MEAL_KITS', 104.3, NULL, 157);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-09-09', 'ROVING_RADISH_MEAL_KITS', 94.95, NULL, 239);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-09-12', 'ROVING_RADISH_MEAL_KITS', 104.6, NULL, 242);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-09-16', 'ROVING_RADISH_MEAL_KITS', 100.65, NULL, 244);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-09-17', 'ROVING_RADISH_MEAL_KITS', 48.0, NULL, 245);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-09-18', 'ROVING_RADISH_MEAL_KITS', 36.0, NULL, 246);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-09-19', 'ROVING_RADISH_MEAL_KITS', 89.9, NULL, 247);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-09-23', 'ROVING_RADISH_MEAL_KITS', 164.1, NULL, 249);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-09-26', 'ROVING_RADISH_MEAL_KITS', 109.4, NULL, 252);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-09-30', 'ROVING_RADISH_MEAL_KITS', 214.65, NULL, 254);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-10-07', 'ROVING_RADISH_MEAL_KITS', 179.85, NULL, 259);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-10-10', 'ROVING_RADISH_MEAL_KITS', 119.9, NULL, 262);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-10-14', 'ROVING_RADISH_MEAL_KITS', 126.6, NULL, 264);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-10-17', 'ROVING_RADISH_MEAL_KITS', 84.4, NULL, 267);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-10-21', 'ROVING_RADISH_MEAL_KITS', 183.75, NULL, 269);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-10-24', 'ROVING_RADISH_MEAL_KITS', 122.5, NULL, 272);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-10-28', 'ROVING_RADISH_MEAL_KITS', 146.85, NULL, 274);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-11-04', 'ROVING_RADISH_MEAL_KITS', 209.85, NULL, 279);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-11-07', 'ROVING_RADISH_MEAL_KITS', 139.9, NULL, 282);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-11-11', 'ROVING_RADISH_MEAL_KITS', 171.15, NULL, 284);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2024-11-14', 'ROVING_RADISH_MEAL_KITS', 114.1, NULL, 287);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-01-27', 'ROVING_RADISH_MEAL_KITS', 126.8, NULL, 334);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-01-27', 'RECIPE_MEAL_KITS', 12.0, NULL, 334);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-01-30', 'ROVING_RADISH_MEAL_KITS', 63.4, NULL, 337);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-01-30', 'RECIPE_MEAL_KITS', 6.0, NULL, 337);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-03', 'ROVING_RADISH_MEAL_KITS', 109.8, 12, 339);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-06', 'ROVING_RADISH_MEAL_KITS', 54.9, 6, 342);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-10', 'ROVING_RADISH_MEAL_KITS', 135.1, 13, 344);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-13', 'ROVING_RADISH_MEAL_KITS', 88.6, 11, 347);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-18', 'ROVING_RADISH_MEAL_KITS', 77.7, 7, 350);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-19', 'ROVING_RADISH_MEAL_KITS', 42.7, 5, 351);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-20', 'ROVING_RADISH_MEAL_KITS', 120.4, 12, 352);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-24', 'ROVING_RADISH_MEAL_KITS', 68.15, 9, 354);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-25', 'RECIPE_MEAL_KITS', 34.2, 6, 355);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-27', 'ROVING_RADISH_MEAL_KITS', 93.8, 12, 357);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-02-28', 'RECIPE_MEAL_KITS', 31.2, 12, 358);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-03-06', 'RECIPE_MEAL_KITS', 31.2, NULL, 362);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-03-10', 'RECIPE_MEAL_KITS', 34.2, NULL, 366);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-03-14', 'RECIPE_MEAL_KITS', 67.8, NULL, 370);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-04-21', 'ROVING_RADISH_MEAL_KITS', 80.2, NULL, 402);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-04-24', 'ROVING_RADISH_MEAL_KITS', 80.2, NULL, 405);

INSERT INTO meal_kit_distribution (activity_date, program_name, pounds_distributed, kits_distributed, report_source_id) VALUES ('2025-04-28', 'ROVING_RADISH_MEAL_KITS', 93.6, NULL, 407);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-01-08', 19.15, 32);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-01-18', 18.95, 42);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-01-22', 23.55, 46);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-01-23', 13.85, 47);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-01-25', 17.85, 49);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-01-29', 9.85, 53);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-05', 11.2, 60);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-12', 19.6, 67);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-19', 10.4, 74);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-02-26', 10.5, 81);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-03-04', 18.15, 88);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-03-11', 9.7, 95);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-03-18', 21.0, 102);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-01', 3.3, 116);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-08', 12.55, 123);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-15', 4.85, 130);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-04-29', 10.8, 144);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-05-06', 10.1, 149);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-05-13', 10.55, 154);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-05-30', 23.8, 167);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-03', 0.0, 169);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-10', 6.15, 174);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-17', 17.85, 179);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-06-24', 16.0, 185);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-07-01', 13.85, 190);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-07-08', 7.3, 195);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-07-15', 15.95, 200);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-07-29', 16.75, 210);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-08-05', 5.95, 214);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-08-12', 7.5, 219);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-08-26', 6.6, 229);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-09-09', 9.0, 239);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-09-16', 19.11, 244);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-09-30', 5.95, 254);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-10-07', 13.0, 259);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-10-14', 15.85, 264);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-10-21', 6.75, 269);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-10-28', 3.7, 274);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-11-04', 8.35, 279);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-11-11', 6.35, 284);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-11-18', 11.5, 289);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2024-12-09', 10.35, 304);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-01-13', 0.2, 322);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-01-27', 7.9, 334);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-03', 12.75, 339);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-10', 8.55, 344);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-17', 6.15, 349);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-02-24', 18.05, 354);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-03-03', 2.2, 359);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-03-10', 9.5, 366);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-03-17', 25.1, 373);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-03-31', 6.35, 387);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-04-07', 8.75, 392);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-04-14', 10.55, 397);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-04-21', 5.6, 402);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-04-28', 6.5, 407);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-05-05', 0.5, 412);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-05-12', 1.9, 417);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-06-02', 23.5, 432);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-06-09', 16.1, 436);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-06-16', 9.85, 439);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-06-23', 7.25, 442);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-06-30', 17.4, 445);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-07-07', 19.2, 448);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-07-21', 14.55, 455);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-07-28', 5.7, 458);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-09-08', 7.6, 481);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-09-15', 6.0, 486);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-09-22', 22.6, 491);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-09-29', 20.1, 496);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-06', 13.2, 501);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-13', 4.6, 506);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-20', 8.55, 511);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-10-27', 5.5, 516);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-03', 9.25, 521);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-10', 9.0, 526);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-17', 8.5, 531);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-11-24', 17.4, 536);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-01', 11.55, 541);

INSERT INTO panera_sweets_distribution (activity_date, pounds_distributed, report_source_id) VALUES ('2025-12-08', 4.55, 546);

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (1, 'monthly_food_summary', '2024-01 through 2025-12', 'MEASURE_SCOPE', 'Monthly total outgoing includes source-specific columns in some months. Do not add food_outgoing, expired_but_distributed, food_trash, meal_kit_distribution, or panera_sweets_distribution together without a documented reconciliation rule.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (2, 'food_incoming', '2024-01 through 2025-12', 'SOURCE_ATTRIBUTION', 'Incoming pounds are recorded as monthly category totals only. The data cannot accurately allocate total incoming food to individual donors or sources.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (3, 'food_outgoing', '2024-01-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 1923.65 lb; sum of recorded daily outgoing pounds is 1862.85 lb. Difference: -60.80 lb. Preserve both source measures until reviewed.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (4, 'food_outgoing', '2024-02-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 1998.60 lb; sum of recorded daily outgoing pounds is 4486.88 lb. Difference: 2488.28 lb. Preserve both source measures until reviewed.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (5, 'food_outgoing', '2024-04-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 5464.15 lb; sum of recorded daily outgoing pounds is 4951.70 lb. Difference: -512.45 lb. Preserve both source measures until reviewed.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (6, 'food_outgoing', '2024-05-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 2292.80 lb; sum of recorded daily outgoing pounds is 2369.91 lb. Difference: 77.11 lb. Preserve both source measures until reviewed.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (7, 'food_outgoing', '2024-06-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 2113.83 lb; sum of recorded daily outgoing pounds is 1909.88 lb. Difference: -203.95 lb. Preserve both source measures until reviewed.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (8, 'food_outgoing', '2024-08-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 1965.45 lb; sum of recorded daily outgoing pounds is 1960.45 lb. Difference: -5.00 lb. Preserve both source measures until reviewed.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (9, 'food_outgoing', '2024-11-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 6322.51 lb; sum of recorded daily outgoing pounds is 5700.38 lb. Difference: -622.13 lb. Preserve both source measures until reviewed.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (10, 'food_outgoing', '2025-01-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 1199.15 lb; sum of recorded daily outgoing pounds is 2505.65 lb. Difference: 1306.50 lb. Preserve both source measures until reviewed.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (11, 'food_outgoing', '2025-06-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 3031.95 lb; sum of recorded daily outgoing pounds is 2752.90 lb. Difference: -279.05 lb. Preserve both source measures until reviewed.');

INSERT INTO data_quality_note (note_id, table_name, record_key, issue_type, detail) VALUES (12, 'food_outgoing', '2025-07-01', 'MONTHLY_DAILY_RECONCILIATION', 'Monthly distributed-food total is 4183.25 lb; sum of recorded daily outgoing pounds is 3933.95 lb. Difference: -249.30 lb. Preserve both source measures until reviewed.');


CREATE OR REPLACE VIEW v_monthly_pantry_performance AS
SELECT
    m.period_start,
    m.total_incoming_lb,
    m.distributed_food_lb,
    m.expired_food_lb AS expired_but_distributed_lb,
    m.trash_food_lb,
    m.total_outgoing_lb,
    COALESCE(SUM(o.students_served), 0) AS students_served,
    COALESCE(SUM(o.grab_and_go_visits), 0) AS grab_and_go_visits,
    COALESCE(SUM(o.reusable_bags_given), 0) AS reusable_bags_given
FROM monthly_food_summary m
LEFT JOIN pantry_daily_operations o
    ON o.activity_date >= m.period_start
    AND o.activity_date < DATE_ADD(m.period_start, INTERVAL 1 MONTH)
GROUP BY m.period_start, m.total_incoming_lb, m.distributed_food_lb, m.expired_food_lb, m.trash_food_lb, m.total_outgoing_lb;

