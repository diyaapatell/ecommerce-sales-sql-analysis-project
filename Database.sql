USE ecommerce_analysis;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers (customer_id, customer_name, city)
VALUES
(1, 'Aarav Shah', 'Mumbai'),
(2, 'Riya Patel', 'Ahmedabad'),
(3, 'Arjun Mehta', 'Delhi'),
(4, 'Siya Desai', 'Pune'),
(5, 'Kabir Joshi', 'Bangalore'),
(6, 'Anaya Rao', 'Hyderabad'),
(7, 'Vivaan Shah', 'Mumbai'),
(8, 'Meera Patel', 'Ahmedabad'),
(9, 'Aditya Singh', 'Delhi'),
(10, 'Tara Kapoor', 'Pune');

SELECT * FROM customers;

INSERT INTO products (product_id, product_name, category, price)
VALUES
(101, 'Wireless Mouse', 'Electronics', 799),
(102, 'Keyboard', 'Electronics', 1299),
(103, 'USB-C Cable', 'Electronics', 499),
(104, 'Water Bottle', 'Home', 599),
(105, 'Notebook', 'Stationery', 199),
(106, 'Backpack', 'Accessories', 1499),
(107, 'Desk Lamp', 'Home', 999),
(108, 'Headphones', 'Electronics', 1999);

SELECT * FROM products;

INSERT INTO orders (order_id, customer_id, order_date)
VALUES
(1001, 1, '2026-01-05'),
(1002, 2, '2026-01-08'),
(1003, 3, '2026-01-15'),
(1004, 1, '2026-02-03'),
(1005, 4, '2026-02-10'),
(1006, 5, '2026-02-18'),
(1007, 6, '2026-03-02'),
(1008, 7, '2026-03-11'),
(1009, 8, '2026-03-20'),
(1010, 9, '2026-04-01'),
(1011, 10, '2026-04-12'),
(1012, 2, '2026-04-25');

SELECT * FROM orders;

INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1001, 101, 2),
(1001, 105, 3),
(1002, 102, 1),
(1002, 104, 2),
(1003, 108, 1),
(1003, 103, 2),
(1004, 106, 1),
(1004, 101, 1),
(1005, 107, 2),
(1005, 105, 5),
(1006, 108, 2),
(1007, 104, 3),
(1007, 103, 1),
(1008, 106, 2),
(1009, 102, 1),
(1009, 101, 2),
(1010, 108, 1),
(1011, 107, 1),
(1011, 105, 4),
(1012, 106, 1);

SELECT * FROM order_items;

SELECT
    SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id;

    SELECT
    COUNT(*) AS total_orders
FROM orders;

SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC;

SELECT
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

SELECT
    p.category,
    SUM(oi.quantity * p.price) AS category_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

SELECT
    SUM(oi.quantity * p.price) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;

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


SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(oi.quantity) > 5
ORDER BY units_sold DESC;