---create database
CREATE DATABASE BikeSalesGroup6;



---use database

use [BikeSalesGroup6]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---create 2 schema in one database 
CREATE SCHEMA Sales;
GO

CREATE SCHEMA Production;
GO

drop table if exists sales.orderitems,sales.orders, sales.staffs, sales.customers, sales.stores, production.stocks,production.products, production.brands,  production.categories 
 ---create table for stores in sales schema


CREATE TABLE Sales.stores (
store_id varchar(5) PRIMARY KEY,
store_name VARCHAR (255) NOT NULL,
phone VARCHAR (25),
email VARCHAR (255),
street VARCHAR (255),
city VARCHAR (255),
state VARCHAR (10),
zip_code VARCHAR (5)
);



---create table for staff in sales schema

CREATE TABLE Sales.staffs (
staff_id varchar(5) PRIMARY KEY,
first_name VARCHAR (50) NOT NULL,
last_name VARCHAR (50) NOT NULL,
email VARCHAR (255) NOT NULL UNIQUE,
phone VARCHAR (25),
active int NOT NULL,
store_id varchar(5) NOT NULL,
manager_id varchar(5),
FOREIGN KEY (store_id) REFERENCES Sales.stores (store_id)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (manager_id) REFERENCES Sales.staffs (staff_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);

-----use of Sales schema------

---create table for Customers in  Sales schema
CREATE TABLE Sales.customers (
customer_id varchar(10) PRIMARY KEY,
first_name VARCHAR (255) NOT NULL,
last_name VARCHAR (255) NOT NULL,
phone VARCHAR (25),
email VARCHAR (255) NOT NULL,
street VARCHAR (255),
city VARCHAR (50),
state VARCHAR (25),
zip_code VARCHAR (5)
);
---create table for orders in sales schema

CREATE TABLE Sales.orders (
order_id varchar(10) PRIMARY KEY,
customer_id varchar(10),
order_status int NOT NULL,
-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
order_date DATE NOT NULL,
required_date DATE NOT NULL,
shipped_date DATE,
store_id varchar(5) NOT NULL,
staff_id varchar(5) NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Sales.customers (customer_id)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (store_id) REFERENCES Sales.stores (store_id)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (staff_id) REFERENCES Sales.staffs (staff_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);








----------use of Production schema----------
---create table for brands in Production schema

CREATE TABLE Production.brands (
brand_id varchar(5) PRIMARY KEY,
brand_name VARCHAR (255) NOT NULL
);
---create table for categories in Production schema


CREATE TABLE Production.categories (
category_id varchar(5) PRIMARY KEY,
category_name VARCHAR (255) NOT NULL
);

---create table for products in Production schema


CREATE TABLE Production.products (
product_id varchar(10) PRIMARY KEY,
product_name VARCHAR (255) NOT NULL,
brand_id varchar(5) NOT NULL,
category_id varchar(5) NOT NULL,
model_year int NOT NULL,
list_price DECIMAL (10, 2) NOT NULL,
FOREIGN KEY (category_id) REFERENCES Production.categories (category_id)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id)
ON DELETE CASCADE ON UPDATE CASCADE
);

---create table for stocks in Production schema

CREATE TABLE Production.stocks (
store_id varchar(5),
product_id varchar(10),
quantity INT,
PRIMARY KEY (store_id, product_id),
FOREIGN KEY (store_id) REFERENCES Sales.stores (store_id)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (product_id) REFERENCES Production.products (product_id)
ON DELETE CASCADE
ON UPDATE CASCADE
 );



 ---create table for orderItems in sales schema
 select * from Sales.order_items

CREATE TABLE Sales.order_items(
order_id varchar(10),
item_id INT,
product_id varchar(10) NOT NULL,
quantity INT NOT NULL,
list_price DECIMAL (10,2) NOT NULL,
discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
PRIMARY KEY (order_id, item_id),
FOREIGN KEY (order_id) REFERENCES Sales.orders (order_id)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (product_id) REFERENCES Production.products (product_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

---Create Backup table for orders in sales schema 


CREATE TABLE Sales.ordersTemp (
order_id varchar(10) PRIMARY KEY,
customer_id varchar(10),
order_status int NOT NULL,
-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
order_date varchar(max) NOT NULL,
required_date varchar(max) NOT NULL,
shipped_date varchar(max),
store_id varchar(5) NOT NULL,
staff_id varchar(5) NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Sales.customers (customer_id)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (store_id) REFERENCES Sales.stores (store_id)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (staff_id) REFERENCES Sales.staffs (staff_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);



---//To Drop All table //-----
DROP Table Sales.stores
Drop Table Sales.staffs
Drop Table Sales.customers
Drop Table Sales.orders
Drop Table Production.brands
Drop Table Production.categories
Drop Table Production.products
Drop Table Production.stocks
Drop Table Sales.order_items
DROP TABLE Sales.ordersTemp
