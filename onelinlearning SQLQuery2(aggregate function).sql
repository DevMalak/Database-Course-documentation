create database onlinelearning;
use onlinelearning;

CREATE TABLE Instructors (
InstructorID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
);

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
);

CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
Title VARCHAR(100),
InstructorID INT,
CategoryID INT,
Price DECIMAL(6,2),
PublishDate DATE,
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
);

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT,

CourseID INT,
EnrollDate DATE,
CompletionPercent INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Instructors VALUES
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'),
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21');

select*from Instructors;

INSERT INTO Categories VALUES
(1, 'Web Development'),
(2, 'Data Science'),
(3, 'Business');

select*from Categories;

INSERT INTO Courses VALUES
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'),
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'),
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'),
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01');

select*from Courses;

INSERT INTO Students VALUES
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'),
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'),
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10');

select*from Students;


INSERT INTO Enrollments VALUES
(1, 201, 101, '2023-04-10', 100, 5),
(2, 202, 102, '2023-04-15', 80, 4),
(3, 203, 101, '2023-04-20', 90, 4),
(4, 201, 102, '2023-04-22', 50, 3),
(5, 202, 103, '2023-04-25', 70, 4),
(6, 203, 104, '2023-04-28', 30, 2),
(7, 201, 104, '2023-05-01', 60, 3);
select*from Enrollments;

-----Part 1: Warm-Up

-----1. Display all courses with prices.

select Title,price 
from Courses;

----2. Display all students with join dates.

select FullName,JoinDate
from Students;

---3. Show all enrollments with completion percent and rating.

select EnrollmentID, StudentID, CourseID, CompletionPercent, Rating
from Enrollments;

----4. Count instructors who joined in 2023.

SELECT COUNT(InstructorID) AS Instructors2023 -- (count)Use it when  want to know how many rows or how many items meet a condition.
FROM Instructors
WHERE YEAR(JoinDate) = 2023;

----5. Count students who joined in April 2023.

select COUNT(StudentID) AS StudentsApril2023
from Students
where YEAR(JoinDate) = 2023
  AND MONTH(JoinDate) = 4;

 ---- Part 2: Beginner Aggregation 

----1. Count total number of students. 

select COUNT(StudentID) AS TotalStudents
from Students;


-----2. Count total number of enrollments. 


select COUNT(EnrollmentID) AS TotalEnrollments
from Enrollments;

----3. Find average rating per course. 
select CourseID, AVG(Rating) AS AvgRating
from Enrollments
GROUP BY CourseID;-------------------------Finds the average rating per course.
-- Example: Course 101 has an average rating of 4.

----4. Count courses per instructor. 

select InstructorID, COUNT(CourseID) AS CoursesCount
from Courses
GROUP BY InstructorID;

-----5. Count courses per category. 

select CategoryID, COUNT(CourseID) AS CoursesCount
from Courses
GROUP BY CategoryID;

----6. Count students enrolled in each course. 

select CourseID, COUNT(StudentID) AS StudentCount
from Enrollments
GROUP BY CourseID;


----7. Find average course price per category. 

select CategoryID, AVG(Price) AS AvgPrice
from Courses
GROUP BY CategoryID;

---8. Find maximum course price.

select MAX(Price) AS MaxPrice
from Courses;------------------------- This query finds the highest course price.

----9. Find min, max, and average rating per course. 

select CourseID,
       MIN(Rating) AS MinRating,
       MAX(Rating) AS MaxRating,
       AVG(Rating) AS AvgRating
from Enrollments
GROUP BY CourseID;

----10.Count how many students gave rating = 5. 

select COUNT(EnrollmentID) AS FiveStarRatings
from Enrollments
where Rating = 5;---------------- Uses COUNT to calculate how many enrollments have a rating equal to 5.


Part 3: Extended Beginner Practice 

----11.Count enrollments per month.

select MONTH(EnrollDate) AS EnrollMonth,
       COUNT(EnrollmentID) AS TotalEnrollments
from Enrollments
GROUP BY MONTH(EnrollDate);

---12.Find average course price overall. 

select AVG(Price) AS AvgCoursePrice
from Courses;

---13.Count students per join month. 

select MONTH(JoinDate) AS JoinMonth,
       COUNT(StudentID) AS StudentCount
from Students
GROUP BY MONTH(JoinDate);

---14.Count ratings per value (1–5). 

select Rating, COUNT(EnrollmentID) AS RatingCount
from Enrollments
GROUP BY Rating;

15.Find courses that never received rating = 5. 

select CourseID
from Enrollments
GROUP BY CourseID
HAVING MAX(Rating) < 5;

---16.Count courses priced above 30. 

select COUNT(CourseID) AS ExpensiveCourses
from Courses
WHERE Price > 30;

---17.Find average completion percentage. 

select AVG(CompletionPercent) AS AvgCompletion
from Enrollments;

---18.Find course with lowest average rating. 

select CourseID, AVG(Rating) AS AvgRating
from Enrollments
GROUP BY CourseID
ORDER BY AvgRating ASC;

---Part 4: JOIN + Aggregation 

---1. Course title + instructor name + enrollments. 

-- INNER JOIN: shows only courses that have instructors and enrollments
select c.Title,
       i.FullName AS InstructorName,
       COUNT(e.EnrollmentID) AS TotalEnrollments
from Courses c
inner JOIN Instructors i
    ON c.InstructorID = i.InstructorID
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.Title, i.FullName;

---2. Category name + total courses + average price. 

-- INNER JOIN: includes only categories that have courses
select cat.CategoryName,
       COUNT(c.CourseID) AS TotalCourses,
       AVG(c.Price) AS AvgPrice
from Categories cat
INNER JOIN Courses c
    ON cat.CategoryID = c.CategoryID
GROUP BY cat.CategoryName;

---3. Instructor name + average course rating. 

-- INNER JOIN: includes only instructors whose courses have enrollments

select i.FullName,
       AVG(e.Rating) AS AvgRating
from Instructors i
INNER JOIN Courses c
    ON i.InstructorID = c.InstructorID
INNER JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY i.FullName;

---4. Student name + total courses enrolled. 

-- INNER JOIN: includes only students who enrolled in at least one course
select s.FullName,
       COUNT(e.CourseID) AS CoursesEnrolled
from Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
GROUP BY s.FullName;

---5. Category name + total enrollments. 

-- INNER JOIN: includes only categories that have courses with enrollments
select cat.CategoryName,
       COUNT(e.EnrollmentID) AS TotalEnrollments
from Categories cat
inner JOIN Courses c
    ON cat.CategoryID = c.CategoryID
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY cat.CategoryName;


---6. Instructor name + total revenue. 

-- INNER JOIN: calculates revenue only for instructors with enrollments
select i.FullName,
SUM(c.Price) AS TotalRevenue
from Instructors i
inner JOIN Courses c
    ON i.InstructorID = c.InstructorID
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY i.FullName;

---7. Course title + % of students completed 100%. 

-- INNER JOIN: considers only courses that have enrollments
SELECT c.Title,
  AVG(CASE
    WHEN e.CompletionPercent = 100 THEN 1.0
    ELSE 0
    END) * 100 AS CompletionRate
from Courses c
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.Title;

----Part 5: HAVING Practice 

---Use HAVING only. 

----1. Courses with more than 2 enrollments. 

-- Finds courses that have more than 2 enrollments
select CourseID
from Enrollments
GROUP BY CourseID
HAVING COUNT(EnrollmentID) > 2; ------The result is empty because no course has more than two enrollments.


----2. Instructors with average rating above 4. 

select i.FullName
from Instructors i
inner JOIN Courses c ON i.InstructorID = c.InstructorID
inner JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName
HAVING AVG(e.Rating) > 4;         -----The result is empty because no course has average rating greater than 4.


----3. Courses with average completion below 60%. 

-- Finds courses where average completion percentage is below 60%

select CourseID
from Enrollments
GROUP BY CourseID
HAVING AVG(CompletionPercent) < 60;


----4. Categories with more than 1 course. 

-- Displays categories that offer more than one course

select CategoryID
from Courses
GROUP BY CategoryID
HAVING COUNT(CourseID) > 1;

----5. Students enrolled in at least 2 courses. 

                                                  -- Finds students who enrolled in two or more courses
select StudentID
from Enrollments
GROUP BY StudentID
HAVING COUNT(CourseID) >= 2;
   

   Part 6: Analytical Thinking
Answer using SQL + short explanation:
----1. Best performing course.

select c.Title, AVG(e.Rating) AS AvgRating
from Courses c
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY AvgRating DESC;

----2. Instructor to promote.

select i.FullName, AVG(e.Rating) AS AvgRating
from Instructors i
inner JOIN Courses c
    ON i.InstructorID = c.InstructorID
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY i.FullName
ORDER BY AvgRating DESC;

----3. Highest revenue category.

select cat.CategoryName, SUM(c.Price) AS TotalRevenue
from Categories cat
inner JOIN Courses c
    ON cat.CategoryID = c.CategoryID
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY cat.CategoryName
ORDER BY TotalRevenue DESC;

----4. Do expensive courses have better ratings?
select
    CASE
        WHEN c.Price > 30 THEN 'Expensive'
        ELSE 'Cheap'
    END AS PriceGroup,
    AVG(e.Rating) AS AvgRating
from Courses c
INNER JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    CASE
        WHEN c.Price > 30 THEN 'Expensive'
        ELSE 'Cheap'
    END;

------5. Do cheaper courses have higher completion?

select
    CASE
        WHEN c.Price <= 30 THEN 'Cheap'
        ELSE 'Expensive'
    END AS PriceGroup,
    AVG(e.CompletionPercent) AS AvgCompletion
from Courses c
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    CASE
        WHEN c.Price <= 30 THEN 'Cheap'
        ELSE 'Expensive'
    END;


----Final Challenge – Mini Analytics Report
---1. Top 3 courses by revenue.
select c.Title,
       SUM(c.Price) AS Revenue
from Courses c
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY Revenue DESC;

----2. Instructor with most enrollments.
select i.FullName,
       COUNT(e.EnrollmentID) AS TotalEnrollments
from Instructors i
inner JOIN Courses c
    ON i.InstructorID = c.InstructorID
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY i.FullName
ORDER BY TotalEnrollments DESC;

----3. Course with lowest completion rate.

select c.Title,
       AVG(e.CompletionPercent) AS AvgCompletion
from Courses c
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY AvgCompletion ASC;

----4. Category with highest average rating.

select cat.CategoryName,
       AVG(e.Rating) AS AvgRating
from Categories cat
inner JOIN Courses c
    ON cat.CategoryID = c.CategoryID
inner JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY cat.CategoryName
ORDER BY AvgRating DESC;

-----5. Student enrolled in most courses.
select s.FullName,
       COUNT(e.CourseID) AS CoursesCount
from Students s
inner JOIN Enrollments e
    ON s.StudentID = e.StudentID
GROUP BY s.FullName
ORDER BY CoursesCount DESC;

 

