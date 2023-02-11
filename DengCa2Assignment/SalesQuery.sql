----Query 1 Sales/profits/discounts/revenue-----
select order_key 'OrderNumber',
sum(list_price*quantity)-sum(list_price*(quantity-discount))'Profit',
sum(discount)*100 'Total Discount',sum(list_price*quantity) 'Total Revenue Earn',
SUM(list_price*(quantity - discount)) 'Expected Revenue'
from Fact 
Group by order_key
ORDER BY order_key ASC




--------Query 2 Sales/Staff/stores--------
select f.order_key'OrderNumber',
sum(f.list_price*f.quantity-f.discount)'Total Sales',
s.staff_key,s.first_name+s.last_name'StaffName',
st.store_key,st.store_name
from Fact f
inner join Staffs s
on f.staff_key=s.staff_key
inner join Stores st
on f.store_key=st.store_key
Group by f.order_key,s.staff_key,
s.first_name+s.last_name,st.store_key,st.store_name
order by f.order_key ASC,s.staff_key ASC,s.first_name+s.last_name ASC,
st.store_key ASC,st.store_name ASC


--Query 3 - Sales/Seasons of Sales/time--
Select order_key 'OrderNumber',Year,Quarter,Season,
SUM(list_price*quantity) AS "Revenue From Orders by Season"
From Fact f
INNER JOIN Time t
ON f.time_key = t.time_key
Group By order_key,Year,Quarter,Season
Order By order_key ASC,Year ASC, Quarter ASC,Season ASC



Select order_key'OrderNumber',SUM(List_Price*quantity) AS "Total Revenue"
From Fact
Group by order_key




-- Query 4 sales/ orders/ customer
select o.order_key 'Order No', c.customer_key,c.first_name + c.last_name 'Customer Name',
sum(f.list_price + f.quantity) 'Total Sales'
from Fact f 
inner join Orders o on f.order_key = o.order_key
inner join Customers c on f.customer_key = c.customer_key
group by o.order_key,c.customer_key,c.first_name + c.last_name
order by o.order_key ASC,c.first_name + c.last_name ASC,c.customer_key



---Query 5 Sales/Products/brands/categories/inventory-----
select f.order_key 'OrderNumber', f.list_price 'SalesPrice', 
f.product_key'productNumber',
p.brand_id'BrandNumber',p.category_id'CategoryNumber',
p.product_name 'ProductName',
p.model_year'ModelYear',
f.quantity'Quantity'
from 
Fact f 
inner join 
Products p
on f.product_key=p.product_key
order by f.order_key ASC,f.list_price ASC,
f.product_key ASC,p.brand_id ASC,
p.category_id ASC,p.product_name ASC,p.model_year ASC,
f.quantity ASC

