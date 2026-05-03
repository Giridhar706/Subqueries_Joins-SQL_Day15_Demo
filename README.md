# SQL Subqueries and Joins Case Study

This repository contains solutions to a SQL case study focused on subqueries, joins, and analytical functions.

## 📌 Tasks Covered

The case study includes 10 tasks (T1–T10):

- T1: Employees earning above average salary
- T2: Employees working in departments located in Delhi
- T3: Employees with maximum salary
- T4: Employees earning more than their department average
- T5: Highest paid employee in each department
- T6: Departments with average salary greater than company average
- T7: Rewrite T4 using JOIN
- T8: Rewrite T5 using JOIN
- T9: Employee name, department, and salary (Delhi + above average)
- T10: Top 2 highest salaries in each department using DENSE_RANK()

## 🛠️ Concepts Used

- Subqueries
- Correlated Subqueries
- Aggregate Functions (AVG, MAX)
- GROUP BY & HAVING
- INNER JOIN
- Window Functions (DENSE_RANK)

## 🗄️ Database Schema

### Department Table
- DeptID (Primary Key)
- DeptName
- Location

### Employee Table
- EmpID (Primary Key)
- Name
- Salary
- DeptID (Foreign Key)

## ▶️ How to Run

1. Open SQL Server Management Studio (SSMS)
2. Copy the SQL script
3. Execute the script
4. All tasks (T1–T10) will run sequentially

## 📊 Output

Each query produces results based on the respective task requirements.

## 👩‍💻 Author

Giridhar Gopal
