

-- PIZZA DATABASE


-- to see databases
show databases;



-- using database
use new_project;



-- lets see how many many tables our database have
show tables;

-- we have 4 table 
select * from address_data;
select * from customers_data;
select * from orders_data;
select * from item_data;

-- ******************************************************************************************************************//


-- lets drop unnecessary column from a table
alter table address_data
drop column add_2;

-- describing table to check keys and datatypes
desc address_data;
desc customers_data;
desc item_data;
desc orders_data;


-- lets rename the unproper column name
alter table address_data
rename column ï»¿add_id to add_id;

alter table address_data
rename column delivery_address1 to add_1;

alter table address_data
rename column delivery_address2 to add_2;

-- lets see the existing table
select * from customers_data;

-- lets delete unnecessary column from table
alter table customers_data drop column MyUnknownColumn;
ALTER TABLE customers_data DROP COLUMN `MyUnknownColumn_[0]`;
ALTER TABLE customers_data DROP COLUMN `MyUnknownColumn_[1]`;
ALTER TABLE customers_data DROP COLUMN `MyUnknownColumn_[2]`;
ALTER TABLE customers_data DROP COLUMN `MyUnknownColumn_[3]`;

-- lets see selected table
select * from orders_data;

-- lets rename column name
alter table orders_data
rename column ï»¿row_id to sr_no;

-- lets see selected table
select * from staff_data;

-- rename column name

alter table customers_data 
rename column  cus_id to cust_id;

alter table item_data
rename column ï»¿item_id to item_id;

alter table item_data
rename column sku to item_code;

-- lets add primary key to the existing column
alter table address_data modify add_id int primary key;

-- lets add foreign key to the existing column
alter table orders_data add foreign key (add_id) references address_data(add_id);

-- lets describe the tables one by one
desc address_data;
desc customers_data;
desc items_data;
desc orders_data;


-- *****************************************************************************************************************

select * from address_data;
select * from customers_data;
select * from orders_data;
select * from item_data;


-- Now Our Dataset is cleaned

-- Desribing the tables

desc address_data;
desc customers_data;
desc items_data;
desc orders_data;

-- lets see all the different values in particular column from a table

select distinct item_size from item_data;
select distinct delivery_city from address_data;

-- lets see rows from column using where clouse

select * from address_data where delivery_city="Summit Peaks";
select * from address_data where delivery_city="Ravencrest";

-- lets select the column using order by statement
select * from item_data order by item_price;

-- lets select minimum value, maximum value, count of values and avverage value from the particular column
select min(item_price) from item_data;
select max(item_price) from item_data;
select avg(item_price) from item_data;
select count(item_code) from item_data;
select sum(item_price) from item_data where item_price>8;

-- group by
select count(item_cat), item_name from item_data where item_cat like "a%" group by item_name;

-- item status as cheap, expensive or affordable in whole table
select *, 
item_price, case
when item_price>=30 then "Expensive"
when item_price>=20 then "Affordable"
else "Cheap"
end as item_status
from item_data;

-- item status as cheap, affordable pr expensive in table with respect to item_name, item_price and item_cat
select item_name,item_cat,item_price,
case 
when item_price>=30 then "Expensive"
when item_price>=20 then "Affordable"
else "Cheap"
end as item_status
from item_data;

-- displaying msg for item_price either its okay, either its very good or either it have to be improved as per price of items
select item_price,
case 
when item_price>=30 then "okay"
when item_price>=20 then "very good"
else "improve"
end as Item_suggestion
from item_data;

-- show how many item price is between 3-10
select * from item_data
where item_price between 3 and 10;

-- shoiw how many book price is between 10-20
select * from item_data
where item_price between 10 and 30;

-- joinings two table progamming address_data and customers_data
select * from address_data inner join customers_data on address_data.add_1=customers_data.cust_firstname;
select * from address_data left join customers_data on address_data.add_1=customers_data.cust_firstname;
select * from address_data right join customers_data on address_data.add_1=customers_data.cust_firstname;
select * from address_data cross join customers_data on address_data.add_1=customers_data.cust_firstname;

-- showing address belonging to Particular city
select * from address_data;
select add_id,add_1,delivery_city from address_data where delivery_city = "Ravencrest";

-- Group by and like a%
select add_id,delivery_city from address_data where delivery_city like "a%" group by add_id;



-- List all addresses in a specific city

SELECT * 
FROM address_data 
WHERE delivery_city = 'Ravencrest';


-- Find all orders placed by a specific customer:

SELECT * 
FROM orders_data 
WHERE cust_id = 1;  -- Replace 1 with the desired customer ID


-- Find all orders placed by a specific customer

SELECT cust_id, SUM(quantity) AS total_quantity
FROM orders_data
GROUP BY cust_id;


-- Get the total quantity of items ordered by each customer

SELECT o.*, a.add_1, a.delivery_city, a.delivery_postcode
FROM orders_data o
JOIN address_data a ON o.add_id = a.add_id
WHERE a.add_1 = '12 Main Street';  -- Replace with desired address line


-- Get the total number of orders and total quantity ordered per city

SELECT a.delivery_city, COUNT(o.order_id) AS total_orders, SUM(o.quantity) AS total_quantity
FROM orders_data o
JOIN address_data a ON o.add_id = a.add_id
GROUP BY a.delivery_city;



-- Find orders that were delivered to a specific address

SELECT a.delivery_city, COUNT(o.order_id) AS number_of_orders
FROM orders_data o
JOIN address_data a ON o.add_id = a.add_id
GROUP BY a.delivery_city;


-- Count the number of orders per delivery city

SELECT a.add_id, a.add_1, a.delivery_city, a.delivery_postcode, o.order_id, o.created_at, o.item_id, o.quantity
FROM address_data a
JOIN orders_data o ON a.add_id = o.add_id
WHERE a.delivery_city = 'Ravencrest';


-- List all addresses in Ravencrest with their corresponding order details

SELECT a.add_id, a.add_1, a.delivery_city, a.delivery_postcode, o.order_id, o.created_at, o.item_id, o.quantity
FROM address_data a
JOIN orders_data o ON a.add_id = o.add_id
WHERE a.delivery_city = 'Ravencrest';

-- Get the details of orders that have not been delivered (delivery = 0)

SELECT o.order_id, o.created_at, o.item_id, o.quantity, a.add_1, a.delivery_city, a.delivery_postcode
FROM orders_data o
JOIN address_data a ON o.add_id = a.add_id
WHERE o.delivery = 0;


-- Find the most ordered item

SELECT o.item_id, SUM(o.quantity) AS total_quantity
FROM orders_data o
GROUP BY o.item_id
ORDER BY total_quantity DESC
LIMIT 1;


-- Get the order details for a specific customer

SELECT o.order_id, o.created_at, o.item_id, o.quantity, a.add_1, a.delivery_city, a.delivery_postcode
FROM orders_data o
JOIN address_data a ON o.add_id = a.add_id
WHERE o.cust_id = 5;


-- Find the average quantity of items ordered per order

SELECT AVG(total_quantity) AS average_quantity_per_order
FROM (
    SELECT order_id, SUM(quantity) AS total_quantity
    FROM orders_data
    GROUP BY order_id
) AS order_totals;


-- Get the number of orders for each delivery address

SELECT a.add_id, a.add_1, a.delivery_city, a.delivery_postcode, COUNT(o.order_id) AS number_of_orders
FROM address_data a
JOIN orders_data o ON a.add_id = o.add_id
GROUP BY a.add_id, a.add_1, a.delivery_city, a.delivery_postcode;


