# 🏢 Unilever Company Database (MySQL Project)

This project is a **real-world inspired database** for Unilever, built with **MySQL**.  
It models a company’s operations, including departments, employees, customers, suppliers, products, and orders.  
The project also includes **SQL queries** to analyze company data.

---

## 📊 Entity Relationship Diagram (ERD)

> Place your ERD image file in the repo root with the exact name **Unilever_ERD.png**.  
> The image below will render automatically after you push your repo.

![Unilever ERD](./Unilever_ERD.png)

---

## 📂 Project Structure
- `unilever_database.sql` → All **CREATE TABLE** and **INSERT** statements  
- `queries.sql` → Useful **SQL queries** for analysis (employees, sales, suppliers, etc.)  
- `Unilever_ERD.png` → ERD diagram of the database  

---

## 📌 Features
✔️ Departments & Employees (with manager-subordinate relationships)  
✔️ Customers placing orders via employees  
✔️ Products supplied by multiple suppliers  
✔️ Orders with detailed line items  
✔️ Realistic company workflow  

---

## 🛠️ Tech Stack
- MySQL 8
- SQL (DDL + DML + Analytics)

---

## 🚀 How to Run
1. Create the database and tables + sample data:
   ```sql
   SOURCE unilever_database.sql;
   ```
2. Run analysis queries:
   ```sql
   SOURCE queries.sql;
   ```

---

## 📝 Example Insights (from queries.sql)
- Top 5 best-selling products  
- Monthly revenue trends  
- Revenue by customer & brand  
- Employee sales performance  
- Suppliers that provide multiple products  

---

## 📬 Contribution
Feel free to fork this repo, improve queries, and open a pull request.

---

## ⭐ Show Your Support
If you like this project, **give it a star** ⭐ on GitHub.  
Would love to hear your feedback! 💬
