/*CALCULATING KPI'S*/

-- Total Revenue:
SELECT SUM(total_price) AS 'Total Revenue' FROM pizza_sales;

-- Average Order Value:
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS 'Average Order Value' FROM pizza_sales;

-- Total Pizzas Sold:
SELECT SUM(quantity) AS 'Total Pizzas Sold' FROM pizza_sales;

-- Total Orders:
SELECT COUNT(DISTINCT order_id) AS 'Total Orders' FROM pizza_sales;

-- Average Pizzas Per Order:
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(3,2))
AS 'Average Pizzas Per Order'
FROM pizza_sales;

/*DAILY TREND FOR TOTAL ORDERS*/

SELECT DATENAME(WEEKDAY, order_date) AS Weekdays,
		COUNT(DISTINCT order_id) AS Orders
FROM pizza_sales 
GROUP BY DATENAME(WEEKDAY, order_date), DATEPART(WEEKDAY, order_date)
ORDER BY DATEPART(WEEKDAY, order_date);

/*MONTHLY TREND FOR ORDERS*/

SELECT DATENAME(MONTH, order_date) AS Months, 
		COUNT(DISTINCT order_id) AS Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date), DATEPART(MONTH, order_date)
ORDER BY DATEPART(MONTH, order_date);

/*PERCENTAGE OF SALES BY PIZZA CATEGORY*/

SELECT pizza_category, 
		CAST(SUM(total_price) AS DECIMAL(10,2)) AS revenue,
		CAST(SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales) * 100 AS DECIMAL(4,2)) AS percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY 2 DESC;

/*PERCENTAGE OF SALES BY PIZZA SIZE*/

SELECT pizza_size, 
		CAST(SUM(total_price) AS DECIMAL(10,2)) AS revenue,
		CAST(SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales) * 100 AS DECIMAL(4,2)) AS percentage
FROM pizza_sales 
GROUP BY pizza_size
ORDER BY 2 DESC;

/*TOTAL PIZZAS SOLD BY PIZZA CATEGORY*/

SELECT pizza_category,
		SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_category
ORDER BY 2 DESC;

/*BEST SELLERS*/

-- Top 5 Pizzas by Revenue:
SELECT TOP 5 pizza_name,
		SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC;

-- Top 5 Pizzas by Quantity:
SELECT TOP 5 pizza_name,
		SUM(quantity) AS quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC;

-- Top 5 Pizzas by Total Orders:
SELECT TOP 5 pizza_name,
		COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC;

/*WORST SELLERS*/

-- Bottom 5 Pizzas by Revenue:
SELECT TOP 5 pizza_name,
		SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2;

-- Bottom 5 Pizzas by Quantity:
SELECT TOP 5 pizza_name,
		SUM(quantity) AS quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2;

-- Bottom 5 Pizzas by Total Orders:
SELECT TOP 5 pizza_name,
		COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2;
