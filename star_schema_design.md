## Section 1: Schema Overview

The FlexiMart data warehouse is designed using a star schema to support efficient analytical queries on historical sales data. The schema consists of one central fact table surrounded by multiple dimension tables.

### FACT TABLE: fact_sales

**Grain:**  
One row per product per order line item.

**Business Process:**  
Sales transactions.

**Measures (Numeric Facts):**
- quantity_sold: Number of units sold
- unit_price: Price per unit at the time of sale
- discount_amount: Discount applied to the line item
- total_amount: Final amount calculated as (quantity_sold × unit_price − discount_amount)

**Foreign Keys:**
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer

---

### DIMENSION TABLE: dim_date

**Purpose:**  
Stores date-related attributes for time-based analysis.

**Type:**  
Conformed dimension.

**Attributes:**
- date_key (PK): Surrogate key in YYYYMMDD format
- full_date: Actual calendar date
- day_of_week: Name of the day (Monday, Tuesday, etc.)
- month: Numeric month (1–12)
- month_name: Month name (January, February, etc.)
- quarter: Calendar quarter (Q1–Q4)
- year: Calendar year
- is_weekend: Boolean indicator

---

### DIMENSION TABLE: dim_product

**Purpose:**  
Stores descriptive information about products.

**Attributes:**
- product_key (PK): Surrogate key
- product_id: Original product identifier from source system
- product_name: Name of the product
- category: Product category (Electronics, Fashion, etc.)
- subcategory: Sub-category of product
- brand: Product brand

---

### DIMENSION TABLE: dim_customer

**Purpose:**  
Stores descriptive information about customers.

**Attributes:**
- customer_key (PK): Surrogate key
- customer_id: Original customer identifier from source system
- customer_name: Full name of the customer
- email: Customer email address
- city: Customer city

## Section 2: Design Decisions

The star schema uses a transaction-level grain with one row per product per order line item to ensure the highest level of detail is captured. This granularity allows analysts to perform flexible analysis, such as evaluating sales by product, customer, date, or category, without losing transactional accuracy. Aggregations such as daily, monthly, or yearly sales can be derived easily from this base level.

Surrogate keys are used instead of natural keys to improve performance and manage slowly changing dimensions. Natural keys from source systems may change over time or differ across systems, whereas surrogate keys remain stable and compact, enabling faster joins between fact and dimension tables.

This design supports drill-down and roll-up operations effectively. Users can drill down from yearly sales to quarterly, monthly, or daily levels using the date dimension. Similarly, sales can be rolled up by product category or customer location. The separation of facts and dimensions ensures efficient querying and scalability as data volume grows.


## Section 3: Sample Data Flow

**Source Transaction:**  
Order #101, Customer "John Doe", Product "Laptop", Quantity: 2, Unit Price: 50,000, Order Date: 2024-01-15.

**Data Warehouse Representation:**

**fact_sales:**

{
  date_key: 20240115,
  product_key: 5,
  customer_key: 12,
  quantity_sold: 2,
  unit_price: 50000,
  discount_amount: 0,
  total_amount: 100000
}


**dim_date:**
{
  date_key: 20240115,
  full_date: "2024-01-15",
  month: 1,
  month_name: "January",
  quarter: "Q1",
  year: 2024,
  is_weekend: false
}


**dim_product:**
{
  product_key: 5,
  product_name: "Laptop",
  category: "Electronics",
  brand: "Dell"
}

**dim_customer:**
{
  customer_key: 12,
  customer_name: "John Doe",
  city: "Mumbai"
}


This example demonstrates how a single source transaction is decomposed into a fact record and linked dimension records in the data warehouse.
