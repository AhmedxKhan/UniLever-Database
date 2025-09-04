 -------------------------------- UNILEVER COMPANY DATABASE --------------------------------



 ----- DEPARTMENT TABLE:
 CREATE TABLE Department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(100)
);



-------- EMPLOYEE TABLE:
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    gender CHAR(1),
    hire_date DATE,
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id),
    FOREIGN KEY (manager_id) REFERENCES Employee(emp_id)
);


-------- PRODUCT TABLE:
CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);


-------- SUPPLIER TABLE:
CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100),
    contact_name VARCHAR(100),
    phone VARCHAR(20),
    supply_type VARCHAR(50)
);


-------- PRODUCT_SUPPLIER TABLE:
CREATE TABLE Product_Supplier (
    product_id INT,
    supplier_id INT,
    PRIMARY KEY(product_id, supplier_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);


----- CUSTOMER TABLE:
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50)
);



----- ORDERS TABLE:
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    customer_id INT,
    emp_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);


----- ORDERS DETAILS TABLE:
CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY(order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);



----- INSERT RECORD INTO DEPARTMENTS TABLE:
INSERT INTO Department (dept_name, location) VALUES
 ('HR', 'Karachi Head Office'),
 ('Finance', 'Karachi Head Office'),
 ('Sales', 'Lahore Regional Office'),
 ('Supply Chain', 'Karachi Factory'),
 ('Marketing', 'Islamabad Office');




----- INSERT RECORD INTO EMPLOYEE TABLE:
INSERT INTO Employee (first_name, last_name, birth_date, gender, hire_date, salary, dept_id, manager_id) VALUES
('Ali', 'Khan', '1985-06-15', 'M', '2010-03-01', 150000, 3, NULL),
('Sara', 'Ahmed', '1990-09-20', 'F', '2015-05-11', 120000, 5, 1),
('Usman', 'Raza', '1992-01-12', 'M', '2018-07-19', 90000, 4, 1),
('Hina', 'Shah', '1988-04-03', 'F', '2012-09-01', 110000, 2, 1),
('Zeeshan', 'Ali', '1995-12-10', 'M', '2020-01-15', 75000, 3, 1);


----- INSERT RECORD INTO PRODUCTS (UNILEVER BRAND0) TABLE:
INSERT INTO Product (product_name, brand, category, price) VALUES
('Surf Excel Washing Powder 1kg', 'Surf Excel', 'Home Care', 450),
('Dove Shampoo 200ml', 'Dove', 'Personal Care', 600),
('Lux Soap 100g', 'Lux', 'Personal Care', 120),
('Knorr Chicken Cubes 24-pack', 'Knorr', 'Food', 350),
('Lipton Yellow Label Tea 250g', 'Lipton', 'Beverages', 280);


----- INSERT RECORD INTO SUPPLIERS TABLE:
INSERT INTO Supplier (supplier_name, contact_name, phone, supply_type) VALUES
('PakChem Industries', 'Bilal Hussain', '03001234567', 'Chemicals'),
('Global Packaging Ltd', 'Imran Sheikh', '03009876543', 'Packaging'),
('Edible Oils Pvt Ltd', 'Kashif Ali', '03111222333', 'Raw Materials');


----- INSERT RECORD INTO PRODUCT_SUPPLIER TABLE:
INSERT INTO Product_Supplier VALUES
(1, 1),
(1, 3),
(2, 1),
(3, 2),
(4, 3),
(5, 2);


----- INSERT RECORD INTO Customers (Supermarkets & Distributors) TABLE:
INSERT INTO Customer (customer_name, email, phone, city, country) VALUES
('Metro Cash & Carry', 'metro@metro.com', '02133445566', 'Karachi', 'Pakistan'),
('Imtiaz Supermarket', 'info@imtiaz.com', '02122334455', 'Karachi', 'Pakistan'),
('Carrefour', 'sales@carrefour.com', '04255667788', 'Lahore', 'Pakistan'),
('Al-Fatah Mall', 'contact@alfatah.com', '04288997766', 'Lahore', 'Pakistan');


----- INSERT RECORD INTO ORDERS TABLE:
INSERT INTO Orders (order_date, customer_id, emp_id) VALUES
('2023-08-01', 1, 1),
('2023-08-03', 2, 5),
('2023-08-05', 3, 1),
('2023-08-07', 4, 2);


----- INSERT RECORD INTO ORDERS_DETAILS TABLE:
INSERT INTO Order_Details VALUES
(1, 1, 100),  -- Metro bought 100 Surf Excel
(1, 3, 200),  -- Metro bought 200 Lux
(2, 2, 150),  -- Imtiaz bought 150 Dove
(3, 4, 50),   -- Carrefour bought 50 Knorr
(4, 5, 80);   -- Al-Fatah bought 80 Lipton


----------------- QUERIES WITH HEADINGS:

-------- 1: BUSINESS QUERIES:


-----  Top Selling Products:
SELECT P.product_name, SUM(OD.quantity) AS total_sold
FROM Order_Details OD
JOIN Product P ON OD.product_id = P.product_id
GROUP BY P.product_name
ORDER BY total_sold DESC
LIMIT 5;


----- Monthly Revenue:
SELECT DATE_FORMAT(order_date, '%Y-%m') AS Month, 
       SUM(OD.quantity * P.price) AS Revenue
FROM Orders O
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Product P ON OD.product_id = P.product_id
GROUP BY Month;


----- Revenue by Customer:
SELECT C.customer_name, SUM(OD.quantity * P.price) AS Total_Spend
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Product P ON OD.product_id = P.product_id
GROUP BY C.customer_name
ORDER BY Total_Spend DESC;


----- Employees by Department:
SELECT D.dept_name, COUNT(E.emp_id) AS num_employees
FROM Employee E
JOIN Department D ON E.dept_id = D.dept_id
GROUP BY D.dept_name;



-------- 2: Employee & HR Analytics:

----- Highest paid employees (Top 5):
SELECT first_name, last_name, salary, dept_id
FROM Employee
ORDER BY salary DESC
LIMIT 5;


----- Average salary per department:
SELECT D.dept_name, ROUND(AVG(E.salary), 2) AS avg_salary
FROM Employee E
JOIN Department D ON E.dept_id = D.dept_id
GROUP BY D.dept_name;


----- Employees hired in the last 5 years:
SELECT first_name, last_name, hire_date
FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);


----- Managers and their team size:
SELECT M.first_name AS manager, COUNT(E.emp_id) AS team_size
FROM Employee E
JOIN Employee M ON E.manager_id = M.emp_id
GROUP BY M.first_name;



----------- 3: Product & Sales Analytics:

----- Total revenue by brand:
SELECT brand, SUM(OD.quantity * P.price) AS total_revenue
FROM Product P
JOIN Order_Details OD ON P.product_id = OD.product_id
GROUP BY brand
ORDER BY total_revenue DESC;


----- Top 3 categories by sales:
SELECT category, SUM(OD.quantity * P.price) AS revenue
FROM Product P
JOIN Order_Details OD ON P.product_id = P.product_id
GROUP BY category
ORDER BY revenue DESC
LIMIT 3;



-------- 4: Customer Insights:

----- Customers with highest lifetime value (spending):
SELECT C.customer_name, SUM(OD.quantity * P.price) AS total_spent
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Product P ON OD.product_id = P.product_id
GROUP BY C.customer_name
ORDER BY total_spent DESC
LIMIT 5;


----- Orders per customer (loyalty analysis):
SELECT C.customer_name, COUNT(O.order_id) AS total_orders
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
GROUP BY C.customer_name
ORDER BY total_orders DESC;


----- Customers who bought Dove products:
SELECT DISTINCT C.customer_name
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Product P ON OD.product_id = P.product_id
WHERE P.brand = 'Dove';


----------- 5: Supplier & Supply Chain:

----- Suppliers and their products:
SELECT S.supplier_name, GROUP_CONCAT(P.product_name) AS supplied_products
FROM Supplier S
JOIN Product_Supplier PS ON S.supplier_id = PS.supplier_id
JOIN Product P ON PS.product_id = P.product_id
GROUP BY S.supplier_name;


----- Products supplied by more than one supplier:
SELECT P.product_name, COUNT(PS.supplier_id) AS supplier_count
FROM Product P
JOIN Product_Supplier PS ON P.product_id = PS.product_id
GROUP BY P.product_name
HAVING supplier_count > 1;


----------------- 6: Advanced / Business-Oriented:

----- Monthly top customer:
SELECT DATE_FORMAT(O.order_date, '%Y-%m') AS month,
       C.customer_name,
       SUM(OD.quantity * P.price) AS total_spent
FROM Orders O
JOIN Customer C ON O.customer_id = C.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Product P ON OD.product_id = P.product_id
GROUP BY month, C.customer_name
ORDER BY month, total_spent DESC;


----- Employee sales performance:
SELECT E.first_name, E.last_name, SUM(OD.quantity * P.price) AS total_sales
FROM Employee E
JOIN Orders O ON E.emp_id = O.emp_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Product P ON OD.product_id = P.product_id
GROUP BY E.emp_id
ORDER BY total_sales DESC;


----- Top 5 products each month:

SELECT month, product_name, total_sold
FROM (
    SELECT DATE_FORMAT(O.order_date, '%Y-%m') AS month,
           P.product_name,
           SUM(OD.quantity) AS total_sold,
           ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(O.order_date, '%Y-%m')
                              ORDER BY SUM(OD.quantity) DESC) AS rn
    FROM Orders O
    JOIN Order_Details OD ON O.order_id = OD.order_id
    JOIN Product P ON OD.product_id = P.product_id
    GROUP BY month, P.product_name
) ranked
WHERE rn <= 5;


