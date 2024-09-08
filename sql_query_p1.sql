-- DROP TABLE if exists retail_sales;
-- create table retail_sales(
-- 	transactions_id	INT PRIMARY KEY,
-- 	sale_date DATE,
-- 	sale_time TIME,
-- 	customer_id	INT,
-- 	gender VARCHAR(15),
-- 	age	INT,
-- 	category VARCHAR(20),	
-- 	quantity INT,
-- 	price_per_unit FLOAT,
-- 	cogs FLOAT,
-- 	total_sale FLOAT
-- );

-- ALTER TABLE retail_sales
-- RENAME COLUMN quantiy to quantity;

--select * from retail_sales
--limit 10;

select count(*) from retail_sales;

--select count(distinct(customer_id)) from retail_sales;

--select DISTINCT category FROM retail_sales;

-- SELECT * FROM retail_sales
-- WHERE 
--     sale_date IS NULL 
-- 	OR 
-- 	sale_time IS NULL 
-- 	OR 
-- 	customer_id IS NULL 
-- 	OR 
--     gender IS NULL 
-- 	OR 
-- 	category IS NULL 
-- 	OR 
--     quantity IS NULL 
-- 	OR 
-- 	price_per_unit IS NULL 
-- 	OR 
-- 	cogs IS NULL;
	
-- DELETE FROM retail_sales
-- WHERE 
--     sale_date IS NULL 
-- 	OR 
-- 	sale_time IS NULL 
-- 	OR 
-- 	customer_id IS NULL 
-- 	OR 
--     gender IS NULL 
-- 	OR 
-- 	category IS NULL 
-- 	OR 
--     quantity IS NULL 
-- 	OR 
-- 	price_per_unit IS NULL 
-- 	OR 
-- 	cogs IS NULL;

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales
where
	sale_date = '2022-11-05'

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from retail_sales
where 
	category = 'Clothing'
	and
	TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	and 
	quantity >= 4

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale)
from retail_sales
group by category

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age))
from retail_sales
where category = 'Beauty'


--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select gender,category, count(transactions_id) from retail_sales
group by gender, category;

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select
	extract(year from sale_date) as years,
	extract (month from sale_date) months,
	avg(total_sale) as best_sale_month
from retail_sales
group by 1,2
order by 3 desc
limit 2
-- select years, months, best_sale_month
-- from(
-- select
-- 	extract(year from sale_date) as years,
-- 	extract (month from sale_date) months,
-- 	avg(total_sale) as best_sale_month,
-- 	rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
-- from retail_sales
-- group by 1,2
-- ) as t1
-- where rank = 1

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select customer_id, sum(total_sale) from retail_sales
group by customer_id
order by 2 desc
limit 5

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
	category, 
	count(distinct(customer_id))
from retail_sales
group by 1

--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale as(
	SELECT *,
		CASE
			WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END as shift
	FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift



















