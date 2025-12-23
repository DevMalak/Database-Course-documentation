use college2

-------1. Display the department ID, name, and the full name of the faculty managing it.

SELECT 
    d.D_id,
    d.D_Name,
    f.F_Name AS Faculty_Manager
FROM department d

INNER JOIN faculty f
    ON d.D_id = f.D_id;

----2. Display each program's name and the name of the department offering it.

SELECT 
    c.c_Name AS Program_Name,
    d.D_Name AS Department_Name
FROM course c

INNER JOIN department d
    ON c.D_id = d.D_id;

----3. Display the full student data and the full name of their faculty advisor.
SELECT 
    s.*,
    f.F_Name AS Faculty_Advisor
FROM student s
-- INNER JOIN: each student has a faculty advisor
INNER JOIN faculty f
    ON s.F_id = f.F_id;

----4. Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'.
SELECT 
    e.exam_code AS Class_ID,
    c.c_Name AS Course_Title,
    e.room
FROM exam e
-- INNER JOIN: exam belongs to a department offering courses
INNER JOIN course c
    ON e.D_id = c.D_id
WHERE e.room LIKE 'A%' OR e.room LIKE 'B%';

----5. Display full data about courses whose titles start with "I" (e.g., "Introduction to...").
SELECT *
FROM course
WHERE c_Name LIKE 'I%';


-----6. Display names of students in program ID 3 whose GPA is between 2.5 and 3.5.

SELECT 
    s.FName,
    s.LName
FROM student s
-- INNER JOIN: student enrolled in a course
INNER JOIN student_course sc
    ON s.s_id = sc.s_id
WHERE sc.c_id = 3;

---7. Retrieve student names in the Engineering program who earned grades ? 90 in the "Database" course.

SELECT 
    s.FName,
    s.LName
FROM student s
-- INNER JOIN: student-course relationship
INNER JOIN student_course sc
    ON s.s_id = sc.s_id
INNER JOIN course c
    ON sc.c_id = c.c_id
WHERE s.D_id = 1
  AND c.c_Name LIKE '%Database%';

----8. Find names of students who are advised by "Dr. Ahmed Hassan".
SELECT 
    s.FName,
    s.LName
FROM student s
INNER JOIN faculty f
    ON s.F_id = f.F_id
WHERE f.F_Name = 'Ahmed Ali';

----9. Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title.

SELECT 
    s.FName,
    s.LName,
    c.c_Name
FROM student s
INNER JOIN student_course sc
    ON s.s_id = sc.s_id
INNER JOIN course c
    ON sc.c_id = c.c_id
ORDER BY c.c_Name;

----10. For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name
--teachingthe class.

SELECT 
    e.exam_code,
    c.c_Name,
    d.D_Name,
    f.F_Name
FROM exam e

INNER JOIN department d
    ON e.D_id = d.D_id
INNER JOIN faculty f
    ON d.D_id = f.D_id
INNER JOIN course c
    ON d.D_id = c.D_id
WHERE e.room = 'Main';
------11. Display all faculty members who manage any department.

SELECT DISTINCT
    f.F_Name
FROM faculty f
-- INNER JOIN: faculty linked to department
INNER JOIN department d
    ON f.D_id = d.D_id;

----12. Display all students and their advisors' names, even if some students don’t have advisors yet.
SELECT 
    s.FName,
    s.LName,
    f.F_Name AS Advisor_Name
FROM student s
-- LEFT JOIN: include students even without advisors
LEFT JOIN faculty f
    ON s.F_id = f.F_id;
