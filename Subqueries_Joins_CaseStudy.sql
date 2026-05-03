
-- STEP 1: CREATE DATABASE
IF DB_ID('CompanyDB') IS NULL
    CREATE DATABASE CompanyDB;
GO

USE CompanyDB;
GO

-- STEP 2: DROP TABLES IF EXIST
IF OBJECT_ID('Employee', 'U') IS NOT NULL
    DROP TABLE Employee;

IF OBJECT_ID('Department', 'U') IS NOT NULL
    DROP TABLE Department;

-- STEP 3: CREATE TABLES
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- STEP 4: INSERT DATA
INSERT INTO Department VALUES
(1, 'HR', 'Delhi'),
(2, 'IT', 'Mumbai'),
(3, 'Finance', 'Delhi'),
(4, 'Sales', 'Bangalore');

INSERT INTO Employee VALUES
(101, 'Amit', 50000, 1),
(102, 'Neha', 60000, 2),
(103, 'Raj', 70000, 3),
(104, 'Simran', 80000, 1),
(105, 'Karan', 55000, 2),
(106, 'Priya', 90000, 3),
(107, 'Rohit', 75000, 4),
(108, 'Anjali', 65000, 1);

-- T1: Salary > Overall Average
SELECT * FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

-- T2: Employees in Delhi departments
SELECT * FROM Employee
WHERE DeptID IN (
    SELECT DeptID FROM Department WHERE Location = 'Delhi'
);

-- T3: Employees with max salary
SELECT * FROM Employee
WHERE Salary = (SELECT MAX(Salary) FROM Employee);

-- T4: Salary > Department Average
SELECT * FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);

-- T5: Highest salary in each department
SELECT * FROM Employee e
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);

-- T6: Departments with avg > company avg
SELECT DeptID, AVG(Salary) AS Dept_Avg
FROM Employee
GROUP BY DeptID
HAVING AVG(Salary) > (SELECT AVG(Salary) FROM Employee);

-- T7: T4 using JOIN
SELECT e.*
FROM Employee e
JOIN (
    SELECT DeptID, AVG(Salary) AS AvgSal
    FROM Employee
    GROUP BY DeptID
) d ON e.DeptID = d.DeptID
WHERE e.Salary > d.AvgSal;

-- T8: T5 using JOIN
SELECT e.*
FROM Employee e
JOIN (
    SELECT DeptID, MAX(Salary) AS MaxSal
    FROM Employee
    GROUP BY DeptID
) d ON e.DeptID = d.DeptID
AND e.Salary = d.MaxSal;

-- T9: Name + Dept + Salary (Delhi + above avg)
SELECT e.Name, d.DeptName, e.Salary
FROM Employee e
JOIN Department d ON e.DeptID = d.DeptID
JOIN (
    SELECT DeptID, AVG(Salary) AS AvgSal
    FROM Employee
    GROUP BY DeptID
) avg_table ON e.DeptID = avg_table.DeptID
WHERE e.Salary > avg_table.AvgSal
AND d.Location = 'Delhi';

-- T10: Top 2 salaries in each department
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS rank_no
    FROM Employee
) ranked
WHERE rank_no <= 2;