create database homework15
go
use homework15
--------------------------------------------------
-- 1. Find Employees with Minimum Salary
-- Task: Retrieve employees who earn the minimum salary in the company.
--------------------------------------------------
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

DROP TABLE employees;
GO


--------------------------------------------------
-- 2. Find Products Above Average Price
-- Task: Retrieve products priced above the average price.
--------------------------------------------------
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);

DROP TABLE products;
GO


--------------------------------------------------
-- 3. Find Employees in Sales Department
-- Task: Retrieve employees who work in the "Sales" department.
--------------------------------------------------
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);

SELECT *
FROM employees
WHERE department_id = (
    SELECT id FROM departments WHERE department_name = 'Sales'
);

DROP TABLE employees;
DROP TABLE departments;
GO


--------------------------------------------------
-- 4. Find Customers with No Orders
-- Task: Retrieve customers who have not placed any orders.
--------------------------------------------------
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);

SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
);

DROP TABLE orders;
DROP TABLE customers;
GO


--------------------------------------------------
-- 5. Find Products with Max Price in Each Category
-- Task: Retrieve products with the highest price in each category.
--------------------------------------------------
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);

SELECT p.*
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);

DROP TABLE products;
GO


--------------------------------------------------
-- 6. Find Employees in Department with Highest Average Salary
-- Task: Retrieve employees working in the department with the highest average salary.
--------------------------------------------------
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);

SELECT e.*
FROM employees e
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

DROP TABLE employees;
DROP TABLE departments;
GO


--------------------------------------------------
-- 7. Find Employees Earning Above Department Average
-- Task: Retrieve employees earning more than the average salary in their department.
--------------------------------------------------
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);

SELECT e.*
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

DROP TABLE employees;
GO


--------------------------------------------------
-- 8. Find Students with Highest Grade per Course
-- Task: Retrieve students who received the highest grade in each course.
--------------------------------------------------
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

SELECT s.student_id, s.name, g.course_id, g.grade
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);

DROP TABLE grades;
DROP TABLE students;
GO


--------------------------------------------------
-- 9. Find Third-Highest Price per Category
-- Task: Retrieve products with the third-highest price in each category.
--------------------------------------------------
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

;WITH RankedProducts AS (
    SELECT p.*,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rnk
    FROM products p
)
SELECT *
FROM RankedProducts
WHERE rnk = 3;

DROP TABLE products;
GO


--------------------------------------------------
-- 10. Find Employees whose Salary Between Company Average and Department Max Salary
-- Task: Retrieve employees with salaries above the company average but below the maximum in their department.
--------------------------------------------------
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);

SELECT e.*
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees)
  AND e.salary < (
        SELECT MAX(salary)
        FROM employees
        WHERE department_id = e.department_id
  );

