--sql retail sales analysis-p1
CREATE DATABASE sql_project_p2

--create table
CREATE TABLE retail_sales(

		transactions_id INT PRIMARY KEY,
		sale_date DATE,	
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15), 
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT

);

--data cleaning
SELECT * FROM retail_sales LIMIT 10;


SELECT 
COUNT(*)
FROM retail_sales

SELECT * FROM retail_sales WHERE transactions_id IS NULL

SELECT * FROM retail_sales WHERE sale_date IS NULL

SELECT * FROM retail_sales WHERE sale_time IS NULL

SELECT * FROM retail_sales WHERE transactions_id IS NULL
OR sale_date IS NULL
OR
sale_time IS NULL 
OR
gender IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL



DELETE FROM retail_sales 
WHERE transactions_id IS NULL
OR 
sale_date IS NULL
OR
sale_time IS NULL 
OR
gender IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL



--data exploration

--how many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

--how many UNIQUE customers we have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

SELECT DISTINCT category FROM retail_sales

--data analysis and business key prob and ans



--write a sql query to retrieve all coloums for sales made on 2022-11-05 a

SELECT * FROM retail_sales WHERE sale_date='2022-11-05'

SELECT category, SUM(quantiy) From retail_sales WHERE category='Clothing'  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' GROUP BY 1



SELECT * from retail_sales
--Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category, SUM(total_sale) as net_sale FROm retail_sales GROUP BY 1


--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT AVG(age) FROM retail_sales WHERE category='Beauty'


--Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * FROM retail_sales WHERE total_sale>1000


--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category, gender, COUNT(*) as total_tra FROM retail_sales GROUP BY category, gender



--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1



--Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT category, COUNT( DISTINCT customer_id) FROM retail_sales GROUP BY category 

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale
AS
(
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



--END







