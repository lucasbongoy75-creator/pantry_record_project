**HCC Pantry Data Warehouse Project**
**Main Statement**
Create a reliable and scalable data warehouse that consolidates HCC Pantry records from 2024–2025.
**Purpose**
The warehouse provides a historical view of pantry operations before and during the implementation of PantrySoft. It supports performance comparison across time, including food received and distributed, student service visits, estimated new student registrations, operating status, and food-handling activity.
Because inventory-level data was not available, the warehouse is designed as a pantry activity and performance-reporting system rather than an inventory-management system.
**Current Structure**
The warehouse uses a Medallion Architecture that separates data into Bronze, Silver, and Gold layers. This approach preserves raw records, standardizes them for analysis, and delivers a reporting-ready model.
**Bronze Layer**
The Bronze layer is the staging layer. It stores the pantry’s raw, unfiltered records as they were extracted from internal pantry files.
Its purpose is to:
- Preserve original data for traceability.
- Identify missing values, duplicates, inconsistencies, and possible reporting errors.
- Retain source metadata, including the originating file, worksheet, and row number.
- Support backtracking when a data issue is found during development or reporting.
**Silver Layer**
The Silver layer stores the cleaned and standardized version of Bronze data.
It standardizes:
- Dates and monthly reporting periods
- Operating-status values
- Program names
- Food activity categories
- Food weights and count fields
- Report-source lineage
The Silver layer also maintains the connection to the original source record through report_source_id, allowing each transformed record to be traced back to its source.
**Gold Layer**
The Gold layer is the reporting and analytics layer. It is built entirely from views and follows a star-schema model consisting of fact and dimension views.
Dimension views provide descriptive context used to filter and organize reports, including:
- Date
- Program
- Food activity type
- Operating status
Fact views store the measurable pantry activity, including:
- Daily pantry operations
- Food activity
- Monthly incoming food
- Monthly pantry performance
Together, the Gold layer provides Power BI with consistent, reporting-ready data for dashboards, semester comparisons, pantry performance analysis, and student-service reporting.
