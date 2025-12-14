create database company2;
use company2
create table employee(
SSN int primary key identity (1,1),
Bdate date,
gender bit default(0),
firstname varchar(20) not null,
lastname varchar(30) not null,
superid int,
foreign key(superid) references employee (SSN),
)
create table department(
Dnumber int primary key identity (1,1),
Dname varchar(30) not null,
hiredate date not null,
mgrssn int,
foreign key(mgrssn) references employee(SSN),
)
alter table employee
add Dnum int,
foreign key(Dnum) references department (Dnumber)
create table Departmentlocation(
locations varchar(50) not null,
Dnum int,
primary key (locations,Dnum),
foreign key(Dnum) references Department (Dnumber)
)
create table project(
pnumber int primary key identity (1,1),
pname varchar(30) not null,
city varchar(30) not null,
location varchar(30)not null,
Dnum int,
foreign key(Dnum) references Department (Dnumber)
)
create table dependent(
Bdate date,
gender bit default(0),
Dname varchar(30) not null,
DSSN int,
primary key(Dname,DSSN),
foreign key(DSSN) references employee(SSN)
)
create table mywork(
pnum int,
workssn int,
workinghours decimal(4,1),
primary key(pnum,workssn),
foreign key (pnum) references project (pnumber),
foreign key (workssn) references employee (ssn)
);
INSERT INTO department(Dname, hiredate) VALUES
('HR', '2000-01-01'),
('Finance', '2002-03-15'),
('IT', '2005-07-10'),
('Marketing', '2008-05-20'),
('Operations', '2010-09-30');
select*from department;
INSERT INTO employee (Bdate, gender, firstname, lastname) VALUES
('1975-01-15', 1, 'Ahmed', 'Al-Sayed'),   -- Top manager
('1982-07-10', 0, 'Fatima', 'Al-Zahrani'),
('1990-03-22', 1, 'Omar', 'Al-Masri'),
('1995-12-05', 0, 'Sara', 'Khaled'),
('1998-08-15', 1, 'Youssef', 'Hassan');
select*from employee;
INSERT INTO Departmentlocation (locations, Dnum) VALUES
('Cairo', 1),
('Riyadh', 2),
('Dubai', 3),
('Jeddah', 4),
('Abu Dhabi', 5);
select*from Departmentlocation;
INSERT INTO project (pname, city, location, Dnum) VALUES
('Project Alpha', 'Cairo', 'Building A', 1),
('Project Beta', 'Riyadh', 'Building B', 2),
('Project Gamma', 'Dubai', 'Building C', 3),
('Project Delta', 'Jeddah', 'Building D', 4),
('Project Epsilon', 'Abu Dhabi', 'Building E', 5);
select*from project ;
INSERT INTO dependent (Bdate, gender, Dname, DSSN) VALUES
('2000-02-15', 0, 'Layla', 1),
('2005-06-10', 1, 'Omar', 2),
('2010-09-20', 0, 'Mariam', 3),
('2012-11-30', 1, 'Ali', 4),
('2015-01-05', 0, 'Noor', 5);
select*from dependent ;
INSERT INTO mywork (pnum, workssn, workinghours) VALUES
(1, 1, 40.0),
(2, 2, 35.5),
(3, 3, 45.0),
(4, 4, 38.0),
(5, 5, 42.5);
select*from mywork;