-- dim_date data (Jan–Feb 2024)

INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,false),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,false),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,false),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,false),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,false),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,true),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,true),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,false),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,false),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,false),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,false),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,true),
(20240125,'2024-01-25','Thursday',25,1,'January','Q1',2024,false),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,false),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,false),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,true),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,true),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,false),
(20240206,'2024-02-06','Tuesday',6,2,'February','Q1',2024,false),
(20240207,'2024-02-07','Wednesday',7,2,'February','Q1',2024,false),
(20240208,'2024-02-08','Thursday',8,2,'February','Q1',2024,false),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,true),
(20240212,'2024-02-12','Monday',12,2,'February','Q1',2024,false),
(20240214,'2024-02-14','Wednesday',14,2,'February','Q1',2024,false),
(20240215,'2024-02-15','Thursday',15,2,'February','Q1',2024,false),
(20240218,'2024-02-18','Sunday',18,2,'February','Q1',2024,true),
(20240220,'2024-02-20','Tuesday',20,2,'February','Q1',2024,false),
(20240222,'2024-02-22','Thursday',22,2,'February','Q1',2024,false),
(20240225,'2024-02-25','Sunday',25,2,'February','Q1',2024,true),
(20240228,'2024-02-28','Wednesday',28,2,'February','Q1',2024,false);

-- dim_product data

INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Samsung Galaxy S21','Electronics','Mobile',45999),
('P002','Apple MacBook Air','Electronics','Laptop',99999),
('P003','Sony Headphones','Electronics','Audio',19999),
('P004','Dell Monitor','Electronics','Display',29999),
('P005','HP Laptop','Electronics','Laptop',74999),

('P006','Nike Running Shoes','Fashion','Footwear',3499),
('P007','Levis Jeans','Fashion','Clothing',2999),
('P008','Adidas T-Shirt','Fashion','Clothing',1499),
('P009','Puma Sneakers','Fashion','Footwear',4999),
('P010','H&M Shirt','Fashion','Clothing',1999),

('P011','Basmati Rice 5kg','Groceries','Grains',650),
('P012','Organic Almonds','Groceries','Dry Fruits',899),
('P013','Olive Oil 1L','Groceries','Cooking Oil',1200),
('P014','Masoor Dal 1kg','Groceries','Pulses',120),
('P015','Organic Honey','Groceries','Health Food',450);

-- dim_customer data

INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','Rahul Sharma','Bangalore','Karnataka','Retail'),
('C002','Priya Patel','Mumbai','Maharashtra','Retail'),
('C003','Amit Kumar','Delhi','Delhi','Corporate'),
('C004','Sneha Reddy','Bangalore','Karnataka','Retail'),
('C005','Vikram Singh','Delhi','Delhi','Corporate'),
('C006','Anjali Mehta','Mumbai','Maharashtra','Retail'),
('C007','Ravi Verma','Kolkata','West Bengal','Retail'),
('C008','Pooja Iyer','Bangalore','Karnataka','Online'),
('C009','Karthik Nair','Mumbai','Maharashtra','Online'),
('C010','Deepa Gupta','Delhi','Delhi','Retail'),
('C011','Arjun Rao','Bangalore','Karnataka','Corporate'),
('C012','Swati Desai','Kolkata','West Bengal','Online');

-- fact_sales data (40 transactions)

INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240106,1,1,2,45999,2000,89998),
(20240107,2,2,1,99999,5000,94999),
(20240110,3,3,3,19999,0,59997),
(20240115,4,4,1,29999,1000,28999),
(20240120,5,5,2,74999,5000,144998),

(20240125,6,6,2,3499,0,6998),
(20240201,7,7,3,2999,0,8997),
(20240202,8,8,4,1499,500,5496),
(20240203,9,9,1,4999,0,4999),
(20240204,10,10,2,1999,0,3998),

(20240205,11,11,5,650,0,3250),
(20240206,12,12,3,899,0,2697),
(20240207,13,1,2,1200,100,2300),
(20240208,14,2,6,120,0,720),
(20240210,15,3,4,450,0,1800),

(20240106,1,4,1,45999,0,45999),
(20240107,2,5,1,99999,10000,89999),
(20240110,3,6,2,19999,0,39998),
(20240115,4,7,2,29999,2000,57998),
(20240120,5,8,1,74999,0,74999),

(20240125,6,9,3,3499,0,10497),
(20240201,7,10,1,2999,0,2999),
(20240202,8,11,2,1499,0,2998),
(20240203,9,12,2,4999,0,9998),
(20240204,10,1,1,1999,0,1999),

(20240205,11,2,10,650,500,6000),
(20240206,12,3,2,899,0,1798),
(20240207,13,4,1,1200,0,1200),
(20240208,14,5,3,120,0,360),
(20240210,15,6,5,450,0,2250),

(20240212,1,7,1,45999,0,45999),
(20240214,2,8,1,99999,15000,84999),
(20240215,3,9,2,19999,0,39998),
(20240218,4,10,1,29999,0,29999),
(20240220,5,11,2,74999,8000,141998),
(20240225,6,12,2,3499,0,6998),
(20240228,7,1,3,2999,0,8997);
