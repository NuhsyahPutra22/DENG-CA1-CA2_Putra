

--------//Insert Stores table from Oltp database to DW database//---------
Insert into
BikeSalesDWGroup6..Stores(store_key,store_name,phone,email,street,city,state,zip_code)
select
store_id,store_name,phone,email,street,city,state,zip_code
from
BikeSalesGroup6.Sales.stores


-----Insert Customers table from oltp database to DW database//------
Insert into
BikeSalesDWGroup6..Customers(customer_key,first_name,last_name,phone,email,street,city,state,zip_code)
select 
customer_id,first_name,last_name,phone,email,street,city,state,zip_code
from 
BikeSalesGroup6.Sales.customers


----Insert Staffs table from from oltp database to DW database//------
Insert into 
BikeSalesDWGroup6..Staffs(staff_key,first_name,last_name,email,phone,active,store_key,manager_id)
select 
staff_id,first_name,last_name,email,phone,active,store_id,manager_id
from BikeSalesGroup6.Sales.staffs


----Insert Products table from oltp database to DW database//----------
Insert into 
BikeSalesDWGroup6..Products(product_key,brand_id,category_id,product_name,model_year)
select 
product_id,brand_id,category_id,product_name,model_year
from BikeSalesGroup6.Production.products
---(not complete)


----Insert Orders table from oltp database to DW database//-----
Insert into 
BikeSalesDWGroup6..Orders(order_key,order_status,order_date,required_date,shipped_date,customer_key,store_key,staff_key)
select 
order_id,order_status,order_date,required_date,shipped_date,customer_id,store_id,staff_id
from 
BikeSalesGroup6.Sales.orders 


----Create Data for Time Dimensions//----
use BikeSalesDWGroup6
DECLARE @StartDate DATETIME = '20160101' --Starting value of Date Range
DECLARE @EndDate DATETIME = '20181231' --End Value of Date Range
DECLARE @curDate DATE
SET @curdate = @StartDate
while @curDate < @EndDate 
  Begin
  Insert into [Time]
  select 
  CONVERT(char(8),@curDate,112) as time_key,
    DatePart(Year, @curDate) as Year,
	 DatePart(Quarter, @curDate) as Quarter,
	  DatePart(Month, @curDate) AS Month,
	  DATENAME(WeekDay, @curDate) AS DayName,
	   @CurDate AS Date,
	   DatePart(DayOfYear, @curDate) AS DayOfYear,
	   CASE DATEPART(Month, @curdate)
	   when 3 then 'Spring'
	   when 4 then 'Spring'
	   when 5 then 'Spring'
	   when 6 then 'Summer'
	   when 7 then 'Summer'
	   when 8 then 'Summer'
	   when 9 then 'Fall'
	   when 10 then 'Fall'
	   when 11 then 'Fall'
	   when 12 then 'Winter'
	   when 1  then 'Winter'
	   when 2 then 'Winter'
	   END AS season
	   /* Increate @curDate by 1 day */
	SET @curDate = DateAdd(Day, 1, @curDate)
  END


  ---Insert  Fact DW table//
  
use BikeSalesDWGroup6

INSERT INTO BikeSalesDWGroup6..Fact
(
order_key,time_key,customer_key,staff_key,product_key,store_key,quantity,list_price,discount
 )
  
--select column name from respective table from DW and Oltp // 
SELECT
 o.order_key,
 replace (CONVERT(DATE,o.order_date, 112),'-',''),
 c.customer_key,
 s.staff_key,
 p.product_key, 
 st.store_key,
 od.quantity,
 od.list_price,
 od.discount

FROM 
BikeSalesDWGroup6..[Orders] o INNER JOIN BikeSalesGroup6.Sales.order_items od ON o.order_key = od.order_id
INNER JOIN BikeSalesDWGroup6..[Staffs]    s  ON o.staff_key = s.staff_key
INNER JOIN BikeSalesDWGroup6..[Customers] c  ON o.customer_key = c.customer_key
INNER JOIN BikeSalesDWGroup6..[Stores]    st  ON o.store_key = st.store_key
INNER JOIN BikeSalesDWGroup6..[Products]  p  ON od.product_id = p.product_key





----Delete All table info//
Delete from Stores;
Delete  from Customers;
Delete from Staffs;
Delete from Products;
Delete from Orders;
Delete from Time;
Delete from Fact;

