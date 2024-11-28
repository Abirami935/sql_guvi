CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE customers(
id INT auto_increment PRIMARY KEY,
name varchar(50) NOT NULL,
email VARCHAR(50) NOT NULL,
address VARCHAR(100) NOT Null
);
CREATE TABLE orders(
id INT auto_increment PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount INT NOT NULL,
foreign key (customer_id) references customers(id)
);
CREATE TABLE products(
id INT auto_increment PRIMARY KEY,
name varchar(50) NOT NULL,
price INT NOT NULL,
description varchar(200)
);
/*Retrieve all customers who have placed an order in the last 30 days*/

SELECT customers.id,customers.name,customers.email,customers.address
FROM customers
JOIN orders ON customers.id = orders.customer_id
WHERE orders.order_date >= curdate() - interval 30 day;

/*Get the total amount of all orders placed by each customer*/
SELECT customers.id, customers.name, SUM(orders.total_amount) AS total_spent
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id, customers.name;

/*Update the price of Product C to 45.00*/
UPDATE products
SET price = 45
WHERE id = 3;

/*Add a new column discount to the products table*/

ALTER TABLE products
ADD discount DECIMAL(5, 2);

/*Retrieve the top 3 products with the highest price*/

SELECT id, name, price, description
FROM products
ORDER BY price DESC
LIMIT 3;

/* Get the names of customers who have ordered Product A */
SELECT DISTINCT customers.name
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN products ON orders.products_id = products.id
WHERE products.name = 'Product A';

/*Join the orders and customers tables to retrieve the customer's name and order date for each order*/

SELECT customers.name, orders.order_date
FROM customers
JOIN orders ON customers.id = orders.customer_id;

/*Retrieve the orders with a total amount greater than 150.00*/
SELECT * 
FROM orders
WHERE total_amount > 150.00;

/*Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table*/

/* Create the order_items table*/
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

/* Retrieve the average total of all orders */
SELECT AVG(total_amount) AS average_order_amount
FROM orders;













