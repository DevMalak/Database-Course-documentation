DQL
select*from employee;    -----all employee data

SELECT Fname, Lname, Salary, Dno FROM Employee;

SELECT Fname+ ' '+ Lname AS FullName,
       (Salary * 12 * 0.10) AS ANNUAL_COMM
FROM Employee; 

SELECT SSN,Fname+ ' '+ Lname AS Name
FROM Employee
WHERE Salary > 1000;  ----monthly

SELECT SSN, Fname+ ' '+ Lname AS Name
FROM Employee
WHERE (Salary * 12) > 10000; -------annual salary (monthly × 12)

SELECT Fname, Lname, Salary
FROM Employee
WHERE sex = 'F';

SELECT Fname, Lname, Salary
FROM Employee
WHERE Salary BETWEEN 2000 AND 5000;

SELECT Fname, Lname
FROM Employee
ORDER BY Salary DESC

SELECT MAX(Salary), MIN(Salary), AVG(Salary)
FROM Employee;

SELECT COUNT(*) AS TotalEmployees FROM Employee;

SELECT * FROM Employee WHERE Fname LIKE 'A%';

SELECT * FROM Employee WHERE Superssn IS NULL;

SELECT * FROM Employee WHERE HireDate > '2020-01-01'; -----in database there is no hiredate that is why is error

--DML--
INSERT INTO Employee (Fname, Lname, Dno, SSN, Superssn, Salary)
VALUES ('MKM', 'YourLastName', 30, 102672, 112233, 3000);
select*from employee;
INSERT INTO Employee (Fname, Lname, Dno, SSN, Salary, Superssn)
VALUES ('Friend', 'Name', 30, 102660, NULL, NULL);
select*from employee;

UPDATE Employee
SET Salary = Salary * 1.20
WHERE SSN = 102672;
select*from employee;

UPDATE Employee
SET Salary = Salary * 1.05
WHERE Dno = 30
select*from employee;

UPDATE Employee
SET Commission = NULL
WHERE Salary < 2000;  ------errors because there is no commission

DELETE FROM Employee WHERE Salary IS NULL;
select*from employee;