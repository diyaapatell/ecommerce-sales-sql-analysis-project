USE ecommerce_analysis;

-- 1. Total Revenue
SELECT
    SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id;


-- 2. Total Number of Orders
SELECT
    COUNT(*) AS total_orders
FROM orders;


-- 3. Best-Selling Products by Units
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC;


-- 4. Products Generating the Most Revenue
SELECT
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;


-- 5. Revenue by Product Category
SELECT
    p.category,
    SUM(oi.quantity * p.price) AS category_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;


-- 6. Average Order Value
SELECT
    SUM(oi.quantity * p.price) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;


-- 7. Highest-Spending Customers
SELECT
    c.customer_name,
    SUM(oi.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


-- 8. Monthly Sales
SELECT
    MONTH(o.order_date) AS sales_month,
    SUM(oi.quantity * p.price) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY MONTH(o.order_date)
ORDER BY sales_month;


-- 9. Revenue by City
SELECT
    c.city,
    SUM(oi.quantity * p.price) AS city_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.city
ORDER BY city_revenue DESC;


-- 10. Products Selling More Than 5 Units
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(oi.quantity) > 5
ORDER BY units_sold DESC;