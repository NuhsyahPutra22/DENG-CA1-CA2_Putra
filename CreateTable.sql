
 create Database DengCa1VideoRentalSystem;
 

CREATE TABLE Store (
Store_ID INT NOT NULL,
Location  varchar(25),
Street  varchar(255),
State  varchar(50),
City  varchar(50),
ZipCode INT,
Primary Key(Store_id));
;

create table Employee (
Employee_id INT NOT NULL,
First_name varchar(255) NOT NULL,
Last_name varchar(255) NOT NULL,
minit  varchar(255),
street  varchar(255),
city  varchar(100),
state  varchar(100),
zipcode INT,
country  varchar(255),
title   varchar(50),
paytype  varchar(50),
payrate decimal(18,2),
storeID INT,
Primary Key (Employee_id),
FOREIGN KEY (storeID) REFERENCES Store(Store_ID));

CREATE TABLE Customer (
CustomerID int not null,
First_name varchar(50),
Last_name varchar(50),
Password varchar(25),
Phone  varchar(50),
Driver_License varchar(25) not null,
Card_number varchar(50) not null,
Card_type varchar(20) not null,
Minit varchar(255),
Street  varchar(255),
State  varchar(50),
City  varchar(50),
ZipCode INT,
PRIMARY KEY (CustomerID));

CREATE TABLE movie (
Catalog_id int not null,
Movie_name  varchar(255),
director  varchar(100),
producer   varchar(255),
Actor  varchar(255),
Actor2  varchar(255),
PRIMARY KEY (Catalog_id),
Foreign Key (Catalog_id) REFERENCES  Catalog(Catalog_id));


CREATE TABLE VideoCamera (
Catalog_id int not null,
Video_camera_brand varchar(100),
madeBy varchar(100),
purchasedDate DATE,
PRIMARY KEY (Catalog_id),
Foreign Key (Catalog_id) REFERENCES Catalog(Catalog_id));

CREATE TABLE VCR (
Catalog_id int not null,
Type Varchar(50),
VCR_brand varchar(100),
madeBy varchar(100),
purchasedDate DATE,
PRIMARY KEY (Catalog_id),
Foreign Key (Catalog_id) REFERENCES Catalog(Catalog_id));



CREATE TABLE Catalog (
Catalog_id INT NOT NULL,
chargeperday DECIMAL(18,2),
Imageurl  varchar(255),
PRIMARY KEY (Catalog_ID));



CREATE table Transaction_tab (
Transaction_ID int not null,
Transaction_Type varchar(20),
Customer_ID INT NOT NULL,
Transaction_Date DATE,
Due_date DATE,
return_date DATE,
rental_charge Decimal(18,2),
penalty_Charge Decimal(18,2),
TotalCharge Decimal(18,2),
Store_ID INT NOT NULL,
Primary Key (Transaction_ID),
Foreign Key (Store_ID) REFERENCES Store (Store_ID),
Foreign Key (Customer_ID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Item (
Catalog_id int not null,
COPY_ID INT NOT NULL,
PRIMARY KEY (Catalog_id,COPY_ID),
Foreign Key (Catalog_id) REFERENCES Catalog(Catalog_id)
);

CREATE TABLE TransactionItem (
Catalog_id int not null,
Transaction_ID int not null,
COPY_ID INT NOT NULL,
PRIMARY KEY (Catalog_id,Transaction_ID,COPY_ID),
Foreign Key (Catalog_id,COPY_ID) REFERENCES Item(Catalog_Id,COPY_ID),
Foreign Key (Transaction_ID) REFERENCES Transaction_tab(Transaction_ID)
);






