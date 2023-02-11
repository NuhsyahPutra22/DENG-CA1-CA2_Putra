---//create Database//

create Database BikeSalesDWGroup6;



---//use Database //
use BikeSalesDWGroup6;


--//Create Store table//
create Table Stores(
store_key varchar(5) NOT NULL,
store_name varchar(255) NOT NULL,
phone VARCHAR (25),
email VARCHAR (255),
street VARCHAR (255),
city VARCHAR (255),
state VARCHAR (10),
zip_code VARCHAR (5)
PRIMARY KEY (store_key));

--//Create Customer table//
create Table Customers(
customer_key varchar(10),
first_name VARCHAR (255) NOT NULL,
last_name VARCHAR (255) NOT NULL,
phone VARCHAR (25),
email VARCHAR (255) NOT NULL,
street VARCHAR (255),
city VARCHAR (50),
state VARCHAR (25),
zip_code VARCHAR (5)
PRIMARY KEY (customer_key)
);

--//create Staff table//
CREATE TABLE Staffs (
staff_key varchar(5) ,
first_name VARCHAR (50) NOT NULL,
last_name VARCHAR (50) NOT NULL,
email VARCHAR (255) NOT NULL UNIQUE,
phone VARCHAR (25),
active int NOT NULL,
store_key varchar(5) NOT NULL,
manager_id varchar(5),
PRIMARY KEY (staff_key),
FOREIGN KEY (store_key) REFERENCES stores (store_key)
ON DELETE CASCADE
ON UPDATE CASCADE,
);

--//create product table//
create Table Products(
product_key varchar(10),
brand_id varchar(5) NOT NULL,
category_id varchar(5) NOT NULL,
product_name VARCHAR (255) NOT NULL,
model_year int NOT NULL,
PRIMARY KEY (product_key));




--//create order table//

create Table Orders(
order_key varchar(10),
order_status int NOT NULL,
order_date DATE NOT NULL,
required_date DATE NOT NULL,
shipped_date DATE,
customer_key varchar(10),
store_key varchar(5),
staff_key varchar(5)
PRIMARY KEY (order_key)
FOREIGN KEY (customer_key) REFERENCES Customers (customer_key)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (store_key) REFERENCES Stores (store_key)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (staff_key) REFERENCES Staffs (staff_key)
);


--//create time table//
CREATE TABLE Time
	(	[time_key] INT primary key,
		[Year] CHAR(4),-- Year value of Date stored in Row
		[Quarter] CHAR(1),
		[Month] VARCHAR(2), --Number of the Month 1 to 12
		[DayName] VARCHAR(9),
		[Date] DATETIME,
		[DayOfYear] VARCHAR(3),
		[season] VARCHAR(10)
		);

--//create Fact table//
CREATE TABLE Fact(
	time_Key int NOT NULL,
	store_key varchar(5),
	customer_key varchar(10),
	staff_key varchar(5) ,
	product_key varchar(10),
	order_key varchar(10),
	quantity INT NOT NULL,
	list_price DECIMAL(10,2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	CONSTRAINT SalesKey PRIMARY KEY(time_key,store_key,customer_key,staff_key,product_key,order_key),
	FOREIGN KEY (time_key) REFERENCES Time (time_key),
	FOREIGN KEY (store_key) REFERENCES Stores (store_key),
	FOREIGN KEY (customer_key) REFERENCES Customers (customer_key),
	FOREIGN KEY (staff_key) REFERENCES Staffs (staff_key),
	FOREIGN KEY (product_key) REFERENCES Products (product_key),
	FOREIGN KEY (order_key) REFERENCES Orders (order_key));



--//Drop  All table//
Drop table Customers;
Drop table Staffs;
Drop table Stores;
Drop table Products;
Drop table Orders;
Drop table Time;
Drop table Fact;





