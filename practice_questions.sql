
-- 1. List all employees who earn more than 70,000

SELECT first_name, last_name, salary
FROM Employee
WHERE salary > 70000;

--------------------------------

-- 2. Find all female employees working in the Scranton branch

SELECT first_name, last_name
FROM Employee
WHERE sex = 'F' AND branch_id = 2;

--------------------------------

-- 3. Employees whose salary is between 60,000 and 100,000

SELECT first_name, last_name, salary
FROM Employee
WHERE salary BETWEEN 60000 AND 100000;

--------------------------------

-- 4. Employees with no supervisor

SELECT first_name, last_name
FROM Employee
WHERE super_id IS NULL;

--------------------------------

-- 5. Employees whose last name starts with 'H'

SELECT first_name, last_name
FROM Employee
WHERE last_name LIKE 'H%';

--------------------------------

-- 6. List all employees with their branch names

SELECT e.first_name, e.last_name, b.branch_name
FROM Employee e
JOIN Branch b ON e.branch_id = b.branch_id;

--------------------------------

-- 7. Find the manager name of each branch

SELECT b.branch_name, e.first_name, e.last_name AS manager_name
FROM Branch b
JOIN Employee e ON b.mgr_id = e.emp_id;

--------------------------------

-- 8. Show all clients handled by employees in Scranton branch

SELECT c.client_name
FROM Client c
JOIN Works_With w ON c.client_id = w.client_id
JOIN Employee e ON w.emp_id = e.emp_id
WHERE e.branch_id = 2;

--------------------------------

-- 9. Find suppliers who provide paper to Scranton branch

SELECT supplier_name
FROM Branch_Supplier
WHERE branch_id = 2 AND supply_type = 'Paper';

--------------------------------

-- 10. Show each employee’s total sales value

SELECT e.first_name, e.last_name, SUM(w.total_sales) AS total_sales
FROM Employee e
JOIN Works_With w ON e.emp_id = w.emp_id
GROUP BY e.emp_id;

--------------------------------

-- 11. Find the average salary of employees in each branch

SELECT branch_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY branch_id;

--------------------------------

-- 12. Count how many employees work under each manager

SELECT super_id AS manager_id, COUNT(*) AS num_employees
FROM Employee
WHERE super_id IS NOT NULL
GROUP BY super_id;

--------------------------------

-- 13. Show the total sales per client

SELECT c.client_name, SUM(w.total_sales) AS total_sales
FROM Client c
JOIN Works_With w ON c.client_id = w.client_id
GROUP BY c.client_id;

--------------------------------

-- 14. Find the branch with the highest average salary

SELECT branch_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY branch_id
ORDER BY avg_salary DESC
LIMIT 1;

--------------------------------

-- 15. Display the top 2 employees with highest sales

SELECT e.first_name, e.last_name, SUM(w.total_sales) AS total_sales
FROM Employee e
JOIN Works_With w ON e.emp_id = w.emp_id
GROUP BY e.emp_id
ORDER BY total_sales DESC
LIMIT 2;

--------------------------------

-- 16. Employees who earn more than the average salary

SELECT first_name, last_name, salary
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

--------------------------------

-- 17. Clients handled by the branch that Michael Scott manages

SELECT client_name
FROM Client
WHERE branch_id = (
    SELECT branch_id
    FROM Branch
    WHERE mgr_id = (
        SELECT emp_id FROM Employee
        WHERE first_name = 'Michael' AND last_name = 'Scott'
    )
);

--------------------------------

-- 18. Employees who have never made a sale

SELECT first_name, last_name
FROM Employee
WHERE emp_id NOT IN (SELECT emp_id FROM Works_With);

--------------------------------

-- 19. Employee with the second-highest salary

SELECT first_name, last_name, salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

--------------------------------

-- 20. Clients handled by more than one employee

SELECT c.client_name
FROM Works_With w
JOIN Client c ON w.client_id = c.client_id
GROUP BY w.client_id
HAVING COUNT(DISTINCT w.emp_id) > 1;

--------------------------------

-- 21. Rank employees by salary in each branch

SELECT e.emp_id, e.first_name, e.last_name, e.branch_id, e.salary,
       RANK() OVER (PARTITION BY e.branch_id ORDER BY e.salary DESC) AS salary_rank
FROM Employee e;

--------------------------------

-- 22. Running total of sales for each employee

SELECT w.emp_id, e.first_name, e.last_name, w.total_sales,
       SUM(w.total_sales) OVER (PARTITION BY w.emp_id ORDER BY w.client_id) AS running_total
FROM Works_With w
JOIN Employee e ON w.emp_id = e.emp_id;

--------------------------------

-- 23. Salary difference compared to branch average

SELECT e.emp_id, e.first_name, e.last_name, e.branch_id, e.salary,
       e.salary - AVG(e.salary) OVER (PARTITION BY e.branch_id) AS diff_from_branch_avg
FROM Employee e;

--------------------------------

-- 24. Employees born in the 1970s

SELECT first_name, last_name, birth_date
FROM Employee
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979;

--------------------------------

-- 25. Age of each employee today

SELECT first_name, last_name,
       TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age
FROM Employee;

--------------------------------

-- 26. Employees’ first names in uppercase

SELECT UPPER(first_name) AS first_name_upper, last_name
FROM Employee;

--------------------------------

-- 27. Employees whose last name length > 6

SELECT first_name, last_name
FROM Employee
WHERE LENGTH(last_name) > 6;

--------------------------------

-- 28. Insert a new client into Scranton branch

INSERT INTO Client (client_id, client_name, branch_id)
VALUES (500, 'New Scranton Client', 2);

--------------------------------

-- 29. Update Stanley’s salary by 10%

UPDATE Employee
SET salary = salary * 1.10
WHERE first_name = 'Stanley' AND last_name = 'Hudson';

--------------------------------

-- 30. Delete a client who belongs to Stamford branch

DELETE FROM Client
WHERE branch_id = 3;

--------------------------------

-- 31. Create new Project table

CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

--------------------------------

-- 32. Copy employees with salary > 80,000 into new table

CREATE TABLE HighSalaryEmployees AS
SELECT emp_id, first_name, last_name, salary, branch_id
FROM Employee
WHERE salary > 80000;

--------------------------------
