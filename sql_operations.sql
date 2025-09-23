
--   SQL Cheat Sheet - Complete Reference



--  Basic SQL Operations
-- ============================================

--  Select all employees
SELECT * FROM Employee;

--  Select employee names and salaries
SELECT first_name, last_name, salary FROM Employee;

--  Use DISTINCT (unique departments/branches)
SELECT DISTINCT branch_id FROM Employee;

--  WHERE clause (employees earning above 70,000)
SELECT first_name, salary FROM Employee
WHERE salary > 70000;

--  LIKE (find employees with last name starting with 'S')
SELECT first_name, last_name FROM Employee
WHERE last_name LIKE 'S%';

--  BETWEEN (salary range)
SELECT first_name, salary FROM Employee
WHERE salary BETWEEN 60000 AND 100000;

--  IN operator
SELECT first_name, branch_id FROM Employee
WHERE branch_id IN (1, 3);


--  Aggregate Functions
-- ============================================

--  Count total employees
SELECT COUNT(*) AS total_employees FROM Employee;

--  Average salary
SELECT AVG(salary) AS avg_salary FROM Employee;

--  Max and Min salary
SELECT MAX(salary) AS max_salary, MIN(salary) AS min_salary FROM Employee;


--  GROUP BY and HAVING
-- ============================================

--  Average salary by branch
SELECT branch_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY branch_id;

--  Branches with avg salary > 70,000
SELECT branch_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY branch_id
HAVING AVG(salary) > 70000;


--  Joins
-- ============================================

--  Employees with their branch name
SELECT e.first_name, e.last_name, b.branch_name
FROM Employee e
JOIN Branch b ON e.branch_id = b.branch_id;


--  Nested Queries
-- ============================================

--  Employees earning more than average salary
SELECT first_name, salary
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);


--  Find branch with highest avg salary
SELECT branch_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY branch_id
ORDER BY avg_salary DESC
LIMIT 1;


--  UNION
-- ============================================

--  All employee and client names together
SELECT first_name AS name FROM Employee
UNION
SELECT client_name FROM Client;


--  NULL Handling
-- ============================================

--  Employees with no supervisor
SELECT first_name, last_name
FROM Employee
WHERE super_id IS NULL;


--  ORDER BY & LIMIT
-- ============================================

--  Top 3 highest-paid employees
SELECT first_name, salary
FROM Employee
ORDER BY salary DESC
LIMIT 3;


--  Duplicates
-- ============================================

--  Find duplicate clients (by name)
SELECT client_name, COUNT(*) AS cnt
FROM Client
GROUP BY client_name
HAVING COUNT(*) > 1;


--  Indexes, Views, Alter
-- ============================================

--  Create an index on employee salary
CREATE INDEX idx_salary ON Employee(salary);

--  Create a view to show employees with their branch name
CREATE VIEW employee_branch AS
SELECT e.emp_id, e.first_name, e.last_name, b.branch_name
FROM Employee e
JOIN Branch b ON e.branch_id = b.branch_id;

--  Alter table: Add a new column for employee email
ALTER TABLE Employee ADD email VARCHAR(100);

--  Drop the column if no longer needed
ALTER TABLE Employee DROP COLUMN email;


--  Truncate & Drop
-- ============================================

--  Truncate table (removes all rows but keeps structure)
TRUNCATE TABLE Works_With;

--  Drop table completely
DROP TABLE Branch_Supplier;



