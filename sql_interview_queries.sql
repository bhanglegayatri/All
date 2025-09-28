-- 📄 SQL Interview Preparation Queries

-- 1. Display name of Employees, Department, Country, and department manager for all employees.
SELECT 
     e.Name AS Employee, 
     d.department, 
     c.country, 
     m.Name AS Manager 
FROM emi_employee e
JOIN emi_Dept d ON e.dept_id = d.dept_id
JOIN emi_country c ON d.c_id = c.c_id
LEFT JOIN emi_employee m ON e.mngr_id = m.emp_id;

-- 2. Display Manager of the Employee
SELECT 
     e.Name AS Employee, 
     m.Name AS Manager
FROM emi_employee e
JOIN emi_employee m ON m.emp_id = e.mngr_id;

-- 3. Total salary paid in each department
SELECT 
     d.Department, SUM(e.Salary) AS Total_Salary_Paid
FROM 
     emi_employee e
RIGHT JOIN 
     emi_dept d ON e.dept_id = d.dept_id
GROUP BY 
     d.Department
ORDER BY 
     Total_Salary_Paid;

-- 4. Total number of employees in each department
SELECT 
     d.Department, COUNT(e.emp_id) AS No_of_Employees
FROM 
     emi_employee e
RIGHT JOIN 
     emi_dept d ON e.dept_id = d.dept_id
GROUP BY 
     d.Department
ORDER BY 
     No_of_Employees;

-- 5. Average salary per department
SELECT 
     d.Department, AVG(e.Salary) AS Avg_Salary
FROM 
     emi_employee e
RIGHT JOIN 
     emi_dept d ON e.dept_id = d.dept_id
GROUP BY 
     d.Department;

-- 6. Min and Max salary per department with more than 2 employees
SELECT 
     d.department, MIN(e.Salary) AS Min_Salary, MAX(e.Salary) AS Max_Salary
FROM 
     emi_employee e
JOIN 
     emi_dept d ON e.dept_id = d.dept_id
GROUP BY 
     d.Department
HAVING 
     COUNT(e.emp_id) > 2;

-- 7. Employees who are not managers
SELECT emp_id 
FROM emi_employee 
WHERE emp_id NOT IN (SELECT DISTINCT mngr_id FROM emi_employee WHERE mngr_id IS NOT NULL);

-- 8. Departments where average salary > 20000
SELECT 
     d.department, AVG(e.salary) AS Avg_Salary
FROM 
     emi_dept d
JOIN 
     emi_employee e ON d.dept_id = e.dept_id
GROUP BY 
     d.department
HAVING 
     AVG(e.salary) > 20000
ORDER BY 
     AVG(e.salary);

-- 9. Departments with more than 1 employee earning > 25000
SELECT d.department
FROM emi_dept d
JOIN emi_employee e ON e.dept_id = d.dept_id
WHERE e.salary > 25000
GROUP BY d.department
HAVING COUNT(e.emp_id) > 1;

-- 10. Managers managing more than 2 employees
SELECT mngr_id AS ManagerId
FROM emi_employee
GROUP BY mngr_id
HAVING COUNT(emp_id) > 2
ORDER BY ManagerId;

-- 11. Department Managers of employees who are not managers
SELECT DISTINCT dm.department_manager
FROM emi_employee e
JOIN emi_dept d ON e.dept_id = d.dept_id
JOIN emi_dept_mngr dm ON d.dept_id = dm.dept_id
WHERE e.emp_id NOT IN (
    SELECT DISTINCT mngr_id FROM emi_employee WHERE mngr_id IS NOT NULL
);

-- 12. Number of employees and average salary for each country
SELECT 
    c.country, COUNT(e.emp_id) AS Num_Employees, AVG(e.salary) AS Avg_Salary
FROM emi_employee e
JOIN emi_dept d ON e.dept_id = d.dept_id
JOIN emi_country c ON d.c_id = c.c_id
GROUP BY c.country;

-- 13. Salary analytics using RANK functions
SELECT 
    name, 
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS RowNum,
    RANK() OVER (ORDER BY salary DESC) AS RankNum,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS DenseRankNum
FROM emi_employee;

-- 14. Second highest salary
SELECT MAX(salary) AS second_highest
FROM emi_employee
WHERE salary < (
    SELECT MAX(salary) FROM emi_employee
);

-- 15. Top 3 highest salaries
SELECT * FROM (
    SELECT name, salary, RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM emi_employee
) WHERE rnk <= 3;

-- 16. Update salary of Technical department by 25%
UPDATE emi_employee
SET salary = salary * 1.25
WHERE dept_id IN (
    SELECT dept_id FROM emi_dept WHERE department = 'Technical'
);

-- 17. Employees with same salary as someone in 'd1' department
SELECT name, salary
FROM emi_employee
WHERE salary IN (
    SELECT salary FROM emi_employee WHERE dept_id = 'd1'
);

-- 18. DUAL queries
SELECT CEIL(12.90) AS Ceil_Value FROM DUAL;
-- Oracle doesn’t have RAND(), use DBMS_RANDOM.VALUE
SELECT DBMS_RANDOM.VALUE AS Random_Value FROM DUAL;

-- END OF DOCUMENT
