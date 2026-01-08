# Database Schema Documentation

## Entity–Relationship Description


### ENTITY: customers

**Purpose:**  
Stores customer information for the FlexiMart platform.

**Attributes:**
- customer_id: Unique identifier for each customer (Primary Key)
- first_name: Customer's first name
- last_name: Customer's last name
- email: Customer email address (unique)
- phone: Contact phone number
- city: City of residence
- registration_date: Date the customer registered

**Relationships:**
- One customer can place many orders (1:M relationship with the orders table)

### ENTITY: products

**Purpose:**  
Stores product information available for sale on the FlexiMart platform.

**Attributes:**
- product_id: Unique identifier for each product (Primary Key)
- product_name: Name of the product
- category: Product category (e.g., Electronics, Fashion, Groceries)
- price: Selling price of the product
- stock_quantity: Available inventory quantity

**Relationships:**
- One product can appear in many order items (1:M relationship with order_items table)


### ENTITY: orders

**Purpose:**  
Stores order-level information for purchases made by customers.

**Attributes:**
- order_id: Unique identifier for each order (Primary Key)
- customer_id: Identifier of the customer who placed the order (Foreign Key)
- order_date: Date the order was placed
- total_amount: Total monetary value of the order
- status: Current order status (Completed, Pending, Cancelled)

**Relationships:**
- Each order is placed by one customer (M:1 relationship with customers table)
- One order can contain many order items (1:M relationship with order_items table)

### ENTITY: order_items

**Purpose:**  
Stores detailed information about individual products included in an order.

**Attributes:**
- order_item_id: Unique identifier for each order item (Primary Key)
- order_id: Identifier of the related order (Foreign Key)
- product_id: Identifier of the related product (Foreign Key)
- quantity: Number of units ordered
- unit_price: Price per unit at the time of order
- subtotal: Total price for the order item (quantity × unit_price)

**Relationships:**
- Each order item belongs to one order (M:1 relationship with orders table)
- Each order item refers to one product (M:1 relationship with products table)


## Normalization Explanation

The FlexiMart database schema is designed to satisfy Third Normal Form (3NF) principles, ensuring data integrity, consistency, and minimal redundancy. A database schema is in 3NF when it is in Second Normal Form (2NF) and all non-key attributes are fully functionally dependent only on the primary key, with no transitive dependencies.

In the customers table, the primary key customer_id uniquely determines all customer-related attributes such as first_name, last_name, email, phone, city, and registration_date. There are no attributes that depend on non-key fields, ensuring the table is free from partial and transitive dependencies. Similarly, in the products table, product_id determines product_name, category, price, and stock_quantity, satisfying 3NF requirements.

The orders table separates order-level information from customer details. The functional dependency order_id → customer_id, order_date, total_amount, and status ensures that customer information is not duplicated across multiple orders. This design prevents update anomalies, such as having to update customer details in multiple rows. The order_items table further decomposes order data by storing product-level details per order, with functional dependencies order_item_id → order_id, product_id, quantity, unit_price, and subtotal.

This normalized design avoids insert anomalies by allowing customers and products to be added independently of orders. Delete anomalies are prevented because removing an order does not result in the loss of customer or product information. Overall, the schema adheres to 3NF by ensuring each table represents a single subject, eliminating redundancy and maintaining referential integrity.



## Sample Data Representation

### customers (Sample Data)

| customer_id | first_name | last_name | email                | city       | registration_date |
|------------|------------|-----------|----------------------|------------|-------------------|
| 1          | Rahul      | Sharma    | rahul@gmail.com      | Bangalore  | 2023-01-15        |
| 2          | Priya      | Patel     | priya@yahoo.com      | Mumbai     | 2023-02-20        |


### products (Sample Data)

| product_id | product_name           | category     | price    | stock_quantity |
|-----------|------------------------|--------------|----------|----------------|
| 1         | Samsung Galaxy S21     | Electronics  | 45999.00 | 150            |
| 2         | Nike Running Shoes     | Fashion      | 3499.00  | 80             |



### orders (Sample Data)

| order_id | customer_id | order_date | total_amount | status     |
|---------|-------------|------------|--------------|------------|
| 101     | 1           | 2024-01-15 | 45999.00     | Completed  |
| 102     | 2           | 2024-01-16 | 5998.00      | Completed  |

### order_items (Sample Data)

| order_item_id | order_id | product_id | quantity | unit_price | subtotal |
|--------------|----------|------------|----------|------------|----------|
| 1001         | 101      | 1          | 1        | 45999.00   | 45999.00 |
| 1002         | 102      | 2          | 2        | 2999.00    | 5998.00  |


