HCC PANTRY DATA WAREHOUSE PROJECT
Main statement: Create a reliable and scalable data warehouse containing data from the hcc pantry records from 2024-2025.
Purpose: To compare the performance of the pantry in relation to the implementation of Pantry soft.
Current structure: The data warehouse is build using a medaillon architecture, raw data from the pantry's internal storage is split between Bronze, silver and Gold layer.
Bronze layer: The bronze layer acts as a staging layer, it consits of tables which hosts the pantry's raw and unfiltered data, within this layer my goal is to identify any errors within the raw data, any missing values, any duplicates any values that are not in accordance with the rest of the data, within the bronze layer is also metadata describing the information oin gested within the tables, this metadata helps us identify from which file does the data originate from, which makes it easier to backtrack during the development of the product in order to catch any mistake that could happen.
Silver layer: 
