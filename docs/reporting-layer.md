# Reporting Layer

The reporting layer is implemented in Power BI using the Gold-layer star schema. It provides interactive dashboards for analyzing pantry activity from 2024–2025.

## Report Pages

### 1. Pantry Performance Overview

This page provides a high-level summary of pantry performance by reporting period and semester.

Key metrics include:

- Total incoming food, in pounds
- General food distributed, in pounds
- Student service visits
- Pounds distributed per student service visit
- Incoming food by source category:
  - Donated food
  - Purchased food
  - Maryland Food Bank (MFB) orders

The page includes a semester slicer and a comparison chart for incoming food versus general food distributed.
<img width="1902" height="862" alt="image" src="https://github.com/user-attachments/assets/21a36379-25b0-451c-b356-aee9f4188728" />


### 2. Food Handling and Programs

This page provides operational detail about food activity and pantry programs.

It includes:

- Reported food trash
- General food distribution
- Past-best-by food distribution
- Panera sweets distribution
- Meal-kit distribution
- Program-level filtering for:
  - General Pantry Distribution
  - Panera Sweets
  - Roving Radish Meal Kits
  - Recipe Meal Kits

> **Important:** Food activity categories are displayed separately because they may overlap in the source reports. They should not automatically be added together as one total-outgoing-food measure.
<img width="1917" height="817" alt="image" src="https://github.com/user-attachments/assets/5a5297d0-905b-4b77-8335-09760efdd53f" />


### 3. Student Registrations and Service Visits

This page focuses on pantry participation and student activity.

It includes:

- Student service visits by month and semester
- Average students served per reported service day
- Estimated new student registrations
- Average estimated new registrations per reported day
- Comparison of estimated registrations and student service visits by semester

Estimated new student registrations are calculated using reusable bags issued by the pantry. This is a proxy measure based on the assumption that reusable bags are issued only to first-time registered students and that one bag represents one new registration.
<img width="1917" height="857" alt="image" src="https://github.com/user-attachments/assets/e19c31e1-9ecd-4af7-ac47-e817cbdbcf62" />

## Semester Filtering

The report uses a semester-based calendar:

| Semester | Months Included |
|---|---|
| Spring | January–May |
| Summer | June–July |
| Fall | August–December |

The single available 2023 record is included in Spring 2024. Semester filters support analysis across Spring 2024 through Fall 2025.

## Data Model

The Power BI report connects to views in the Gold layer:

| View Type | Gold Views |
|---|---|
| Dimensions | `dim_date`, `dim_program`, `dim_food_activity_type`, `dim_operating_status` |
| Facts | `fact_daily_pantry_operations`, `fact_food_activity`, `fact_monthly_food_incoming`, `fact_monthly_pantry_performance` |

Dimensions provide descriptive filtering context, while fact views store measurable pantry activity.

## Reporting Limitations

- The warehouse does not contain beginning or ending inventory balances.
- Incoming food and distributed food are operational measures, not an inventory reconciliation.
- Individual donors and vendors cannot be compared because incoming food is available only by monthly source category.
- Student service visits are daily totals and do not represent unique students.
- Estimated new registrations are based on reusable-bag distribution and should be interpreted as a proxy.
- Food trash, meal kits, Panera sweets, and past-best-by distribution are supporting measures and should not automatically be added to general food-distribution totals.
