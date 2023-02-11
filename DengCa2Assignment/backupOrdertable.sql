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



DROP TABLE Sales.ordersTemp

BULK INSERT Sales.ordersTemp
 FROM 'D:\DengCa2Assignment\Orders.csv'
WITH
(FORMAT ='CSV',
FIRSTROW = 2
)

select * from Sales.ordersTemp

update Sales.ordersTemp
set shipped_date = null
where shipped_date = 'NULL'



SET DATEFORMAT DMY
insert into Sales.orders



