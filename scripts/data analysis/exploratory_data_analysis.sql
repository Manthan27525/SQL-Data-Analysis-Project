USE master;
USE DataWarehouseAnalytics;

SELECT * FROM INFORMATION_SCHEMA.TABLES;

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

SELECT DISTINCT country FROM gold.dim_customers;

SELECT DISTINCT category, subcategory, product_names FROM gold.dim_products;

SELECT 
MIN(order_date) first_order_dt,
MAX(order_date) last_oredr_dt,
DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) order_range_years
FROM gold.fact_sales;

SELECT 
MIN(birthdate) oldest_birthdate,
MAX(birthdate) oldest_birthdate,
DATEDIFF(YEAR,MIN(birthdate),MAX(birthdate)) order_range_years
FROM gold.dim_customers;



SELECT SUM(sales_amount) total_sales FROM gold.fact_sales;

SELECT SUM(quantity) total_quantity_sold FROM gold.fact_sales;

SELECT AVG(sales_amount) total_sales FROM gold.fact_sales;

SELECT COUNT(DISTINCT order_number) total_orders FROM gold.fact_sales;

SELECT COUNT(DISTINCT product_key) total_products FROM gold.dim_products;

SELECT COUNT(customer_key) total_customers FROM gold.dim_customers;

SELECT COUNT(DISTINCT customer_key) total_customers_orders FROM gold.fact_sales;


-- Report
SELECT 'Total Sales' as measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION
SELECT 'Total Quantity' as measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION
SELECT 'Average Price' as measure_name, AVG(sales_amount) AS measure_value FROM gold.fact_sales
UNION
SELECT 'Total Orders' as measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION
SELECT 'Total Products' as measure_name, COUNT(DISTINCT product_key) AS measure_value FROM gold.fact_sales
UNION
SELECT 'Total Customers' as measure_name, COUNT(customer_key) AS measure_value FROM gold.dim_customers
UNION
SELECT 'Total Customers Orders' as measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold.fact_sales;



SELECT country, COUNT(customer_key) total_customers FROM gold.dim_customers 
GROUP BY country ORDER BY total_customers DESC;

SELECT gender, COUNT(customer_key) total_customers FROM gold.dim_customers 
GROUP BY gender ORDER BY total_customers DESC;

SELECT category, COUNT(product_key) total_products FROM gold.dim_products 
GROUP BY category ORDER BY total_products DESC;

SELECT category, AVG(cost) average_cost FROM gold.dim_products 
GROUP BY category ORDER BY average_cost DESC;

SELECT di.category, SUM(fa.sales_amount) total_revenue FROM gold.dim_products di
LEFT JOIN gold.fact_sales fa ON di.product_key = fa.product_key
GROUP BY di.category ORDER BY total_revenue DESC;

SELECT c.customer_key,c.first_name,c.last_name,SUM(f.sales_amount) total_revenue FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key,c.first_name,c.last_name ORDER BY total_revenue DESC;

SELECT c.country,SUM(f.quantity) total_quantity FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.country ORDER BY total_quantity DESC;


