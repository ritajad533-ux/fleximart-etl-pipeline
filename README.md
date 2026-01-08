# FlexiMart ETL Pipeline

This repository contains a complete ETL pipeline for the FlexiMart e-commerce dataset.

## Files Included
- etl_pipeline.py – Python ETL script
- data_quality_report.txt – Data quality metrics report
- customers_raw.csv – Raw customer data
- products_raw.csv – Raw product data
- sales_raw.csv – Raw sales data

## Technologies Used
- Python (Pandas, SQLAlchemy)
- MySQL / PostgreSQL
- GitHub

## ETL Overview
- Extracts data from CSV files
- Cleans and standardizes data
- Loads data into relational database
- Generates data quality report

## How to Run
1. Update database credentials in `etl_pipeline.py`
2. Ensure database schema is created
3. Run:
   ```bash
   python etl_pipeline.py
