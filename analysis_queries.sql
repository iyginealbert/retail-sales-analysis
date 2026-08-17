CREATE TABLE sales (
    Order_ID VARCHAR(20),
    Date DATE,
    Customer VARCHAR(50),
    Region VARCHAR(20),
    Category VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Sales DECIMAL(10,2),
    Profit DECIMAL(10,2)
);
SELECT COUNT(*) FROM SAles;

-- Q1. Total revenue, profit and orders
SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS profit_margin_pct
FROM sales;


-- Q2. Revenue and profit by region
SELECT
    Region,
    COUNT(*) AS num_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY Region
ORDER BY total_sales DESC;


-- Q3. Top 5 best selling products
SELECT
    Product,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales
GROUP BY Product
ORDER BY total_sales DESC
LIMIT 5;


-- Q4. Category wise performance
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Discount) * 100, 1) AS avg_discount_pct
FROM sales
GROUP BY Category
ORDER BY total_sales DESC;


-- Q5. Monthly sales trend
SELECT
    DATE_FORMAT(Date, '%Y-%m') AS month,
    ROUND(SUM(Sales), 2) AS monthly_sales,
    ROUND(SUM(Profit), 2) AS monthly_profit
FROM sales
GROUP BY month
ORDER BY month;


-- Q6. Impact of discount on profit
SELECT
    CASE
        WHEN Discount = 0    THEN 'No discount'
        WHEN Discount <= 0.1 THEN 'Low 1-10%'
        WHEN Discount <= 0.2 THEN 'Medium 11-20%'
        ELSE 'High above 20%'
    END AS discount_band,
    COUNT(*) AS num_orders,
    ROUND(AVG(Profit), 2) AS avg_profit
FROM sales
GROUP BY discount_band
ORDER BY avg_profit DESC;


-- Q7. Top 10 most valuable customers
SELECT
    Customer,
    COUNT(*) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_spent,
    ROUND(SUM(Profit), 2) AS profit_generated
FROM sales
GROUP BY Customer
ORDER BY total_spent DESC
LIMIT 10;


-- Q8. Products that lose money
SELECT
    Product,
    Category,
    COUNT(*) AS loss_orders,
    ROUND(SUM(Profit), 2) AS total_loss
FROM sales
WHERE Profit < 0
GROUP BY Product, Category
ORDER BY total_loss ASC;


-- Q9. Sales by year
SELECT
    YEAR(Date) AS year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY year
ORDER BY year;


-- Q10. Region and category breakdown
SELECT
    Region,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY Region, Category
ORDER BY Region, total_sales DESC;
