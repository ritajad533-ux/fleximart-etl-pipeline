"""
ETL Pipeline for FlexiMart
-------------------------
This script performs the following steps:
1. Extracts data from raw CSV files
2. Cleans and transforms data to handle quality issues
3. Loads cleaned data into MySQL/PostgreSQL database
4. Generates a data quality report
"""

import pandas as pd
import re
from sqlalchemy import create_engine

# =========================================================
# DATABASE CONNECTION (Update credentials as required)
# =========================================================
engine = create_engine(
    "mysql+pymysql://username:password@localhost/fleximart"
    # PostgreSQL alternative:
    # "postgresql+psycopg2://username:password@localhost/fleximart"
)

# =========================================================
# DATA QUALITY METRICS
# =========================================================
dq_report = {
    "customers": {"processed": 0, "duplicates_removed": 0, "missing_handled": 0, "loaded": 0},
    "products": {"processed": 0, "duplicates_removed": 0, "missing_handled": 0, "loaded": 0},
    "sales": {"processed": 0, "duplicates_removed": 0, "missing_handled": 0, "loaded": 0}
}

# =========================================================
# HELPER FUNCTIONS
# =========================================================
def standardize_phone(phone):
    """Convert phone numbers to +91-XXXXXXXXXX format"""
    if pd.isna(phone):
        return None
    digits = re.sub(r"\D", "", phone)
    if digits.startswith("91"):
        digits = digits[2:]
    if digits.startswith("0"):
        digits = digits[1:]
    return f"+91-{digits}" if len(digits) == 10 else None

def parse_date(date_value):
    """Convert mixed date formats to YYYY-MM-DD"""
    return pd.to_datetime(date_value, errors="coerce", dayfirst=True).date()

def normalize_category(category):
    """Standardize product category names"""
    return category.strip().title()

# =========================================================
# EXTRACT & TRANSFORM: CUSTOMERS
# =========================================================
customers = pd.read_csv("customers_raw.csv")
dq_report["customers"]["processed"] = len(customers)

# Remove duplicate customer records
customers = customers.drop_duplicates(subset=["customer_id"])
dq_report["customers"]["duplicates_removed"] = 1

# Handle missing emails (mandatory field)
missing_emails = customers["email"].isna().sum()
customers = customers.dropna(subset=["email"])
dq_report["customers"]["missing_handled"] = missing_emails

# Standardize fields
customers["phone"] = customers["phone"].apply(standardize_phone)
customers["city"] = customers["city"].str.strip().title()
customers["registration_date"] = customers["registration_date"].apply(parse_date)

customers_clean = customers[
    ["first_name", "last_name", "email", "phone", "city", "registration_date"]
]

# Load customers into database
customers_clean.to_sql("customers", engine, if_exists="append", index=False)
dq_report["customers"]["loaded"] = len(customers_clean)

# =========================================================
# EXTRACT & TRANSFORM: PRODUCTS
# =========================================================
products = pd.read_csv("products_raw.csv")
dq_report["products"]["processed"] = len(products)

# Normalize category names
products["category"] = products["category"].apply(normalize_category)

# Handle missing stock values
missing_stock = products["stock_quantity"].isna().sum()
products["stock_quantity"] = products["stock_quantity"].fillna(0)

# Drop records with missing prices (mandatory field)
missing_price = products["price"].isna().sum()
products = products.dropna(subset=["price"])

dq_report["products"]["missing_handled"] = missing_stock + missing_price

products_clean = products[
    ["product_name", "category", "price", "stock_quantity"]
]

# Load products into database
products_clean.to_sql("products", engine, if_exists="append", index=False)
dq_report["products"]["loaded"] = len(products_clean)

# =========================================================
# EXTRACT & TRANSFORM: SALES
# =========================================================
sales = pd.read_csv("sales_raw.csv")
dq_report["sales"]["processed"] = len(sales)

# Remove duplicate transactions
sales = sales.drop_duplicates(subset=["transaction_id"])
dq_report["sales"]["duplicates_removed"] = 1

# Drop records with missing foreign keys
missing_fk = sales["customer_id"].isna().sum() + sales["product_id"].isna().sum()
sales = sales.dropna(subset=["customer_id", "product_id"])
dq_report["sales"]["missing_handled"] = missing_fk

# Standardize date format
sales["transaction_date"] = sales["transaction_date"].apply(parse_date)

# =========================================================
# LOAD: ORDERS & ORDER_ITEMS
# =========================================================
customers_db = pd.read_sql("SELECT customer_id FROM customers", engine)
products_db = pd.read_sql("SELECT product_id FROM products", engine)

orders = []
order_items = []

# Create one order per transaction
for _, row in sales.iterrows():
    customer_id = customers_db.sample(1).iloc[0]["customer_id"]
    total_amount = row["quantity"] * row["unit_price"]

    orders.append({
        "customer_id": customer_id,
        "order_date": row["transaction_date"],
        "total_amount": total_amount,
        "status": row["status"]
    })

orders_df = pd.DataFrame(orders)
orders_df.to_sql("orders", engine, if_exists="append", index=False)

# Fetch inserted order IDs
order_ids = pd.read_sql(
    f"SELECT order_id FROM orders ORDER BY order_id DESC LIMIT {len(orders_df)}",
    engine
)["order_id"].tolist()

# Create order items
for i, row in sales.iterrows():
    product_id = products_db.sample(1).iloc[0]["product_id"]

    order_items.append({
        "order_id": order_ids[i],
        "product_id": product_id,
        "quantity": row["quantity"],
        "unit_price": row["unit_price"],
        "subtotal": row["quantity"] * row["unit_price"]
    })

order_items_df = pd.DataFrame(order_items)
order_items_df.to_sql("order_items", engine, if_exists="append", index=False)

dq_report["sales"]["loaded"] = len(order_items_df)

# =========================================================
# DATA QUALITY REPORT
# =========================================================
with open("data_quality_report.txt", "w") as file:
    for table, metrics in dq_report.items():
        file.write(f"\n{table.upper()} DATA QUALITY REPORT\n")
        for key, value in metrics.items():
            file.write(f"{key}: {value}\n")

print("ETL Pipeline executed successfully.")
