use Company_SD;


---------Display the department ID, department name, manager ID, and the full name of the manager------

SELECT d.Dnum,
       d.Dname,
       d.MGRSSN,
       e.Fname + ' ' + e.Lname AS Manager_Name
FROM Departments d
INNER JOIN Employee e
  ON d.MGRSSN = e.SSN;

  ----- Display the names of departments and the names of the projects they control-------

  SELECT d.Dname AS Department_Name,
       p.Pname AS Project_Name
FROM Departments d
INNER JOIN Project p ON d.Dnum = p.Dnum;

---- Display full data of all dependents, along with the full name of the employee they depend on-----------

SELECT dep.*,
       e.Fname + ' ' + e.Lname AS Employee_FullName
FROM Dependent dep
INNER JOIN Employee e 
    ON dep.Essn = e.SSN;
-----Display the project ID, name, and location of all projects located in Cairo or Alex-----
SELECT Pnumber AS Project_ID,
Pname AS Project_Name,
Plocation AS Project_Location,City
FROM Project
WHERE City IN ('Cairo', 'Alex');
SELECT*FROM Project;

---------Display all project data where the project name starts with the letter 'A'---------

SELECT *FROM Project
WHERE Pname LIKE 'A%';

-----Display the IDs and names of employees in department 30 with a salary between 1000 and 2000 LE----

SELECT SSN AS Employee_ID,
       Fname + ' ' + Lname AS Employee_Name
FROM Employee
WHERE Dno = 30
  AND Salary BETWEEN 1000 AND 2000;

  SELECT SSN AS Employee_ID,
       Fname + ' ' + Lname AS Employee_Name,
       Dno
FROM Employee
WHERE Dno = 30
  AND Salary BETWEEN 1000 AND 2000;


-----Retrieve the names of employees in department 10 who work ? 10 hours/week on the "AL Rabwah" project-------

SELECT e.Fname + ' ' + e.Lname AS Employee_Name
FROM Employee e
JOIN Works_for wf ON e.SSN = wf.ESSn
JOIN Project p ON wf.Pno = p.Pnumber
WHERE e.Dno = 10
  AND wf.Hours >= 10
  AND p.Pname = 'AL Rabwah';

 ----- Find the names of employees who are directly supervised by "Kamel Mohamed"--------

 SELECT e.Fname + ' ' + e.Lname AS Employee_Name
FROM Employee e
 INNER JOIN Employee s ON e.SSN = s.Superssn
WHERE s.Fname = 'Kamel' AND s.Lname = 'Mohamed';

-----Retrieve the names of employees and the names of the projects they work on, sorted by project name---------


SELECT e.Fname + ' ' + e.Lname AS Employee_Name,
       p.Pname AS Project_Name
FROM Employee e
JOIN Works_for wf ON e.SSN = wf.ESSn
JOIN Project p ON wf.Pno = p.Pnumber
ORDER BY p.Pname;

---------For each project located in Cairo, display the project number, controlling department name, manager's last name,
--address, and birthdate-------------

SELECT p.Pnumber AS Project_Number,
       d.Dname AS Department_Name,
       e.Lname AS Manager_LastName,
       e.Address,
       e.Bdate
FROM Project p
JOIN Departments d ON p.Dnum = d.Dnum
JOIN Employee e ON d.MGRSSN = e.SSN
WHERE p.City = 'Cairo';

--------Display all data of managers in the company----------

SELECT e.*
FROM Employee e
INNER JOIN Departments d ON e.SSN = d.MGRSSN;

-------Display all employees and their dependents, even if some employees have no dependents-----

SELECT e.Fname + ' ' + e.Lname AS Employee_Name,
       d.Dependent_name,
       d.Sex,
       d.Bdate,ESSN
FROM Employee e
LEFT JOIN Dependent d ON e.SSN = d.ESSN;



