use BikeSalesGroup6
-------------------------------------------------------
---Insert Stock csv in Production.stock table 
---(done)
select * from Production.stocks

BULK INSERT Production.stocks
FROM 'D:\DengCa2Assignment\stocks.csv'
WITH (fieldterminator=',',rowterminator='\n')
---(done)
----------------------------------------------------
select * from Production.products

---Insert products json in Production.products table
    Declare @Products varchar(max)
Select @Products =
BulkColumn
from OPENROWSET(BULK 'D:\DengCa2Assignment\products.json', SINGLE_BLOB) JSON
Insert into Production.products
Select * From OpenJSON(@Products, '$')
with (
product_id varchar(10) '$.product_id',
product_name varchar(255) '$.product_name',
brand_id varchar(5) '$.brand_id',
category_id varchar(5) '$.category_id',
model_year int '$.model_year',
list_price decimal(10,2) '$.list_price')


select * from Production.brands 
--Insert brands text in Production.brands table 
BULK INSERT Production.brands
FROM 'D:\DengCa2Assignment\brands.txt'
WITH (fieldterminator=',', rowterminator='0x0A')

Select * from Production.categories

---Insert categories text in Production.categories table 
BULK INSERT Production.categories
FROM 'D:\DengCa2Assignment\categories.txt'
WITH (fieldterminator='\t', rowterminator='0x0A')


------------------------------------------------------
select * from Sales.customers

----Insert Customers csv in Sales.customer table 
 BULK INSERT Sales.customers
 FROM 'D:\DengCa2Assignment\customers.csv'
WITH (fieldterminator=',',rowterminator='\n')
--(done)
----------------------------------------------------------
---------------------------------------------------------
select * from Sales.order_items

----Insert orderItems csv in Sales.order_items table 
 BULK INSERT Sales.order_items
 FROM 'D:\DengCa2Assignment\OrderItems.csv'
WITH (fieldterminator=',',rowterminator='\n')
-----------------------------------------------------------

----------------------------------------------------------
select * from Sales.orders

----Insert orders csv in Sales.order table 
 BULK INSERT Sales.orders
 FROM 'D:\DengCa2Assignment\Orders.csv'
WITH
(
FIRSTROW = 2,
FIELDTERMINATOR= ',',
ROWTERMINATOR = '\n'
)
-------------------------------------------------------------

select * from Sales.staffs

---insert staff text in Sales.staffs table 
BULK INSERT Sales.staffs
FROM 'D:\DengCa2Assignment\staff.txt'
WITH (fieldterminator=',', rowterminator='\n')


---insert stores text in Sales.stores table 
select * from Sales.stores
BULK INSERT Sales.stores
FROM 'D:\DengCa2Assignment\stores.txt'
WITH (fieldterminator=',', rowterminator='\n')



--Insert Backup ordersTemp in Sales table---
BULK INSERT Sales.ordersTemp
 FROM 'D:\DengCa2Assignment\Orders.csv'
WITH
(FORMAT ='CSV',
FIRSTROW = 2
)


--To update the "Null" to Null

select * from Sales.ordersTemp

update Sales.ordersTemp
set shipped_date = null
where shipped_date = 'NULL'

SET DATEFORMAT DMY


