# FlexiMart Data Architecture Project

**Student Name:** Ritaja Sarkar  
**Student ID:** bitsom_ba_25071066 
**Email:** ritajad533@gmail.com  
**Date:** January 2026  

---

## Project Overview

This project implements an end-to-end data architecture solution for the FlexiMart e-commerce platform. It includes an ETL pipeline for cleaning and loading CSV data into a relational database, NoSQL modeling using MongoDB for flexible product catalogs, and a star-schema-based data warehouse for analytical reporting and OLAP queries.

---

## Repository Structure


---

## Technologies Used

- Python 3.x, pandas, mysql-connector-python  
- MySQL 8.0 / PostgreSQL  
- MongoDB 6.0  
- SQL (Joins, Aggregations, Window Functions)

---

## Setup Instructions

### Relational Database Setup

```bash
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run ETL pipeline
python part1-database-etl/etl_pipeline.py

# Run business queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Data warehouse setup
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql
mongosh < part2-nosql/mongodb_operations.js
Key Learnings

Built a complete ETL pipeline with data quality handling

Learned relational modeling and normalization principles

Implemented NoSQL document modeling for flexible schemas

Designed a star schema for analytical workloads

Wrote OLAP queries for business insights

Challenges Faced

Handling inconsistent and missing data
Solved using pandas-based cleaning, validation, and deduplication logic.

Managing multiple database paradigms
Solved by separating transactional, NoSQL, and analytical workloads clearl
