-- Analysis Queries for UnileverDB
USE UnileverDB;

-- 1) Highest paid employees (Top 5)
SELECT first_name, last_name, salary, dept_id
FROM Employee
ORDER BY salary DESC
LIMIT 5;

-- 2) Average salary per department
SELECT D.dept_name, ROUND(AVG(E.salary), 2) AS avg_salary
FROM Employee E
JOIN Department D ON E.dept_id = D.dept_id
GROUP BY D.dept_name;

-- 3) Employees hired in the last 5 years
SELECT first_name, last_name, hire_date
FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 4) Managers and their team size
SELECT CONCAT(M.first_name, ' ', M.last_name) AS manager, COUNT(E.emp_id) AS team_size
FROM Employee E
JOIN Employee M ON E.manager_id = M.emp_id
GROUP BY M.emp_id, manager
ORDER BY team_size DESC;

-- 5) Total revenue by brand
SELECT P.brand, SUM(OD.quantity * P.price) AS total_revenue
FROM Product P
JOIN Order_Details OD ON P.product_id = OD.product_id
GROUP BY P.brand
ORDER BY total_revenue DESC;

-- 6) Top 3 categories by revenue
SELECT P.category, SUM(OD.quantity * P.price) AS revenue
FROM Product P
JOIN Order_Details OD ON P.product_id = OD.product_id
GROUP BY P.category
ORDER BY revenue DESC
LIMIT 3;

-- 7) Products never ordered
SELECT P.product_name
FROM Product P
LEFT JOIN Order_Details OD ON P.product_id = OD.product_id
WHERE OD.product_id IS NULL;

-- 8) Customers with highest lifetime value (spending)
SELECT C.customer_name, SUM(OD.quantity * P.price) AS total_spent
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Product P ON OD.product_id = P.product_id
GROUP BY C.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- 9) Orders per customer
SELECT C.customer_name, COUNT(O.order_id) AS total_orders
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
GROUP BY C.customer_name
ORDER BY total_orders DESC;

-- 10) Customers who bought Dove products
SELECT DISTINCT C.customer_name
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Product P ON OD.product_id = P.product_id
WHERE P.brand = 'Dove';

-- 11) Suppliers and their products
SELECT S.supplier_name, GROUP_CONCAT(P.product_name ORDER BY P.product_name SEPARATOR ', ') AS supplied_products
FROM Supplier S
JOIN Product_Supplier PS ON S.supplier_id = PS.supplier_id
JOIN Product P ON PS.product_id = P.product_id
GROUP BY S.supplier_name;

-- 12) Products supplied by more than one supplier
SELECT P.product_name, COUNT(PS.supplier_id) AS supplier_count
FROM Product P
JOIN Product_Supplier PS ON P.product_id = PS.product_id
GROUP BY P.product_name
HAVING supplier_count > 1;

-- 13) Monthly top customer by spend
SELECT month, customer_name, total_spent FROM (
  SELECT DATE_FORMAT(O.order_date, '%Y-%m') AS month,
         C.customer_name,
         SUM(OD.quantity * P.price) AS total_spent,
         ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(O.order_date, '%Y-%m')
                            ORDER BY SUM(OD.quantity * P.price) DESC) AS rn
  FROM Orders O
  JOIN Customer C ON O.customer_id = C.customer_id
  JOIN Order_Details OD ON O.order_id = OD.order_id
  JOIN Product P ON OD.product_id = P.product_id
  GROUP BY month, C.customer_name
) ranked
WHERE rn = 1
ORDER BY month;

-- 14) Employee sales performance
SELECT E.emp_id, CONCAT(E.first_name, ' ', E.last_name) AS employee,
       SUM(OD.quantity * P.price) AS total_sales
FROM Employee E
JOIN Orders O ON E.emp_id = O.emp_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Product P ON OD.product_id = P.product_id
GROUP BY E.emp_id, employee
ORDER BY total_sales DESC;

-- 15) Top 5 products each month (window function)
SELECT month, product_name, total_sold
FROM (
  SELECT DATE_FORMAT(O.order_date, '%Y-%m') AS month,
         P.product_name,
         SUM(OD.quantity) AS total_sold,
         ROW_NUMBER() OVER (
           PARTITION BY DATE_FORMAT(O.order_date, '%Y-%m')
           ORDER BY SUM(OD.quantity) DESC
         ) AS rn
  FROM Orders O
  JOIN Order_Details OD ON O.order_id = OD.order_id
  JOIN Product P ON OD.product_id = P.product_id
  GROUP BY month, P.product_name
) t
WHERE rn <= 5
ORDER BY month, total_sold DESC;
