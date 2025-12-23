create database college2;
use college2


CREATE TABLE department (
    D_id INT PRIMARY KEY IDENTITY(1,1),
    D_Name NVARCHAR(20) NOT NULL
);


CREATE TABLE faculty (
    F_id INT PRIMARY KEY IDENTITY(1,1),
    F_Name NVARCHAR(20) NOT NULL,
    mobile_numb NVARCHAR(20) NOT NULL,
    salary DECIMAL(8,2) NOT NULL,
    D_id INT NOT NULL,
    FOREIGN KEY (D_id) REFERENCES department(D_id)
);


CREATE TABLE hostel (
    h_id INT PRIMARY KEY IDENTITY(1,1),
    h_Name NVARCHAR(20) NOT NULL,
    city NVARCHAR(20) NOT NULL,
    h_state NVARCHAR(20) NOT NULL,
    pin_code NVARCHAR(20) NOT NULL,
    no_of_seats INT NOT NULL
);


CREATE TABLE student (
    s_id INT PRIMARY KEY IDENTITY(1,1),
    FName NVARCHAR(20) NOT NULL,
    LName NVARCHAR(20) NOT NULL,
    phone_numb NVARCHAR(20) NOT NULL,
    DOB DATE NOT NULL,
    D_id INT NOT NULL,
    F_id INT NOT NULL,
    h_id INT NOT NULL,
    FOREIGN KEY (D_id) REFERENCES department(D_id),
    FOREIGN KEY (F_id) REFERENCES faculty(F_id),
    FOREIGN KEY (h_id) REFERENCES hostel(h_id)
);

CREATE TABLE course (
    c_id INT PRIMARY KEY IDENTITY(1,1),
    c_Name NVARCHAR(20) NOT NULL,
    duration INT NOT NULL,
    D_id INT NOT NULL,
    FOREIGN KEY (D_id) REFERENCES department(D_id)
);


CREATE TABLE subject (
    subj_id INT PRIMARY KEY IDENTITY(1,1),
    subj_Name NVARCHAR(20) NOT NULL,
    F_id INT NOT NULL,
    FOREIGN KEY (F_id) REFERENCES faculty(F_id)
);


CREATE TABLE exam (
    exam_code INT PRIMARY KEY IDENTITY(1,1),
    room VARCHAR(20) NOT NULL,
    exam_Date DATE NOT NULL,
    exam_time TIME NOT NULL,
    D_id INT NOT NULL,
    FOREIGN KEY (D_id) REFERENCES department(D_id)
);

CREATE TABLE student_exam (
    exam_code INT,
    s_id INT,
    PRIMARY KEY (exam_code, s_id),
    FOREIGN KEY (exam_code) REFERENCES exam(exam_code),
    FOREIGN KEY (s_id) REFERENCES student(s_id)
);

CREATE TABLE student_course (
    c_id INT,
    s_id INT,
    PRIMARY KEY (c_id, s_id),
    FOREIGN KEY (c_id) REFERENCES course(c_id),
    FOREIGN KEY (s_id) REFERENCES student(s_id)
);

CREATE TABLE student_subject (
    subj_id INT,
    s_id INT,
    PRIMARY KEY (subj_id, s_id),
    FOREIGN KEY (subj_id) REFERENCES subject(subj_id),
    FOREIGN KEY (s_id) REFERENCES student(s_id)
);


INSERT INTO department (D_Name) VALUES
('Computer Engineering'),
('Info Tech'),
('Business Admin');
SELECT * FROM department;


INSERT INTO faculty (F_Name, mobile_numb, salary, D_id) VALUES
('Ahmed Ali', '0791111111', 3500.00, 1),
('Sara Hosain', '0792222222', 3200.00, 2),
('Mohammad Saleh', '0793333333', 5300.00, 3);
SELECT * FROM faculty;

INSERT INTO hostel (h_Name, city, h_state, pin_code, no_of_seats) VALUES
('Al Noor Hostel', 'Alrustaq', 'Alrustaq', '11118', 200),
('Al Amal Hostel', 'Salalah', 'Salalah', '21110', 150),
('Al HOOR Hostel', 'Sohar', 'Sohar', '13110', 180);
SELECT * FROM hostel;


INSERT INTO student (FName, LName, phone_numb, DOB, D_id, F_id, h_id) VALUES
('Omar', 'Jasim', '97783436', '2002-05-15', 1, 1, 1),
('Lina', 'Ahmad', '97043436', '2001-08-20', 2, 2, 2),
('Yousef', 'Khaled', '97789646', '2003-02-10', 3, 3, 3);
SELECT * FROM student;


INSERT INTO course (c_Name, duration, D_id) VALUES
('Database Systems', 4, 1),
('Network Security', 3, 2),
('Business Management', 4, 3);
SELECT * FROM course;


INSERT INTO subject (subj_Name, F_id) VALUES
('SQL Programming', 1),
('Cyber Security', 2),
('Marketing Basics', 3);
SELECT * FROM subject;


INSERT INTO exam (room, exam_Date, exam_time, D_id) VALUES
('Lab 1', '2025-01-10', '10:00', 1),
('Room 204', '2025-01-12', '12:00', 2),
('Hall A', '2025-01-15', '09:00', 3);
SELECT * FROM exam;
SELECT s_id, FName, LName FROM student;
SELECT exam_code, room FROM exam;

INSERT INTO student_exam (exam_code, s_id) VALUES
(1, 300047),
(2, 300048),
(3, 300049);

                                     
SELECT * FROM student_exam;

INSERT INTO student_course (c_id, s_id) VALUES
(1, 300047),
(2, 300048),
(3, 300049);


SELECT * FROM student_course;

INSERT INTO student_subject (subj_id, s_id) VALUES
(1, 300047),
(2, 300048),
(3, 300049);
  

SELECT * FROM student_subject;


    -- Q1: Display all student records
SELECT * FROM student;

-- Q2: Display each student's full name, enrollment date, and current status
SELECT
    FName + ' ' + LName AS full_name,
    enrollment_date,
    status
FROM student;

-- Q3: Display each course title and credits
SELECT c_Name AS title, duration AS credits
FROM course;

-- Q4: Display each student’s full name and GPA as GPA Score
SELECT
    FName + ' ' + LName AS full_name,
    gpa AS GPA_Score
FROM student;

-- Q5: List student IDs and names of students with GPA greater than 3.5
SELECT s_id, FName + ' ' + LName AS full_name
FROM student
WHERE gpa > 3.5;

-- Q6: List students who enrolled before 2022
SELECT *
FROM student
WHERE enrollment_date < '2022-01-01';

-- Q7: Display students with GPA between 3.0 and 3.5
SELECT *
FROM student
WHERE gpa BETWEEN 3.0 AND 3.5;

-- Q8: Display students ordered by GPA descending
SELECT *
FROM student
ORDER BY gpa DESC;

-- Q9: Display the maximum, minimum, and average GPA
SELECT MAX(gpa) AS max_gpa, MIN(gpa) AS min_gpa, AVG(gpa) AS avg_gpa
FROM student;

-- Q10: Display total number of students
SELECT COUNT(*) AS total_students
FROM student;

-- Q11: Display students whose first names end with 'a'
SELECT *
FROM student
WHERE FName LIKE '%a';

-- Q12: Display students with NULL advisor
SELECT *
FROM student
WHERE advisor IS NULL;

-- Q13: Display students enrolled in 2021
SELECT *
FROM student
WHERE YEAR(enrollment_date) = 2021;

-- Q14: Insert your data as a new student
SET IDENTITY_INSERT student ON;

INSERT INTO student (s_id, FName, LName, program_id, gpa)
VALUES (300045, 'Yahya', 'Alofi', 2, 3.6);

SET IDENTITY_INSERT student OFF;

-- Q15: Insert another student (friend) with GPA and advisor NULL
SET IDENTITY_INSERT student ON;

INSERT INTO student (s_id, FName, LName, program_id, gpa, advisor)
VALUES (300046, 'Friend', 'Name', 2, NULL, NULL);

SET IDENTITY_INSERT student OFF;

-- Q16: Increase your GPA by 0.2
UPDATE student
SET gpa = gpa + 0.2
WHERE s_id = 300045;

-- Q17: Set GPA to 2.0 for students with GPA below 2.0
UPDATE student
SET gpa = 2.0
WHERE gpa < 2.0;

-- Q18: Increase GPA by 0.1 for students enrolled before 2020
UPDATE student
SET gpa = gpa + 0.1
WHERE enrollment_date < '2020-01-01';

-- Q19: Delete students with status 'Inactive'
DELETE FROM student
WHERE status = 'Inactive';
