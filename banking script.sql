create database banksystem;
use banksystem;
-- Branch table
CREATE TABLE Branch (
    branch_id INT PRIMARY KEY,
    address VARCHAR(100),
    phone_num VARCHAR(20)
);

-- Employee table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    position VARCHAR(50),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

-- Customer table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100),
    phone_num VARCHAR(20),
    date_of_birth DATE
);

-- Employee-Customer (handle / take relationship)
CREATE TABLE Emp_Cust (
    customer_id INT,
    emp_id INT,
    action_type VARCHAR(50),
    PRIMARY KEY (customer_id, emp_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

-- Loans table
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    type VARCHAR(30),
    amount DECIMAL(10,2),
    issue_date DATE,
    customer_id INT,
    emp_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

-- Account table
CREATE TABLE Account (
    account_num INT PRIMARY KEY,
    balance DECIMAL(10,2),
    account_type VARCHAR(20), -- saving / checking
    duration INT,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Transaction table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    date DATE,
    amount DECIMAL(10,2),
    transaction_type VARCHAR(20), -- deposit / withdrawal / transfer
    account_num INT,
    FOREIGN KEY (account_num) REFERENCES Account(account_num)
);
/* ===============================
   INSERT DATA USING SELECT
   =============================== */

-- Insert Branch
INSERT INTO Branch (branch_id, address, phone_num)
SELECT 1, 'Muscat', '24567890';

-- Insert Employees
INSERT INTO Employee (emp_id, name, position, branch_id)
SELECT 101, 'Ali', 'Manager', branch_id
FROM Branch
WHERE branch_id = 1;

INSERT INTO Employee (emp_id, name, position, branch_id)
SELECT 102, 'Sara', 'Clerk', branch_id
FROM Branch
WHERE branch_id = 1;

-- Insert Customers
INSERT INTO Customer (customer_id, name, address, phone_num, date_of_birth)
SELECT 201, 'Ahmed', 'Seeb', '91234567', '1998-05-12';

INSERT INTO Customer (customer_id, name, address, phone_num, date_of_birth)
SELECT 202, 'Fatma', 'Bawshar', '92345678', '2000-08-20';
select*from customer;
-- Insert Employee-Customer relationship
INSERT INTO Emp_Cust (customer_id, emp_id, action_type)
SELECT c.customer_id, e.emp_id, 'Account Opening'
FROM Customer c
JOIN Employee e ON e.emp_id = 102
WHERE c.customer_id = 202;
 select*from Emp_Cust;

-- Insert Loan
INSERT INTO Loans (loan_id, type, amount, issue_date, customer_id, emp_id)
SELECT 
    301,
    'Personal',
    5000,
    GETDATE(),
    c.customer_id,
    e.emp_id
FROM Customer c
JOIN Employee e ON e.emp_id = 101
WHERE c.customer_id = 201;
select*from Loans;
-- Insert Account
INSERT INTO Account (account_num, balance, account_type, duration, customer_id)
SELECT 
    401,
    2000,
    'Saving',
    12,
    customer_id
FROM Customer
WHERE customer_id = 201;
select*from Account;
SELECT customer_id
FROM Customer
WHERE customer_id = 201;

-- Insert Transactions
INSERT INTO Transactions (transaction_id, date, amount, transaction_type, account_num)
SELECT 
    501,
    GETDATE(),
    500,
    'Deposit',
    account_num
FROM Account
WHERE account_num = 401;
select*from Transactions;
USE banksystem;
GO

/* =====================================
   DQL Queries (Select / Retrieve Data)
   ===================================== */

-- 1. Display all customer records
SELECT * FROM Customer;

-- 2. Display customer name, phone, and date of birth
SELECT name, phone_num, date_of_birth
FROM Customer;

-- 3. Display each loan ID, amount, and type
SELECT loan_id, amount, type
FROM Loans;

-- 4. Display account number and annual interest (5% of balance) as AnnualInterest
SELECT account_num, balance * 0.05 AS AnnualInterest
FROM Account;

-- 5. List customers with loan amounts greater than 100000
SELECT c.customer_id, c.name, l.amount
FROM Customer c
JOIN Loans l ON c.customer_id = l.customer_id
WHERE l.amount > 100000;

-- 6. List accounts with balances above 20000
SELECT *
FROM Account
WHERE balance > 20000;

-- 7. Display accounts opened in 2023 (based on Accounts insert date or assume today)
-- Note: Your Account table has no open date, so we use duration or account_num as example
SELECT *
FROM Account
WHERE YEAR(GETDATE()) = 2023;

-- 8. Display accounts ordered by balance descending
SELECT *
FROM Account
ORDER BY balance DESC;

-- 9. Display the maximum, minimum, and average account balance
SELECT MAX(balance) AS MaxBalance,
       MIN(balance) AS MinBalance,
       AVG(balance) AS AvgBalance
FROM Account;

-- 10. Display total number of customers
SELECT COUNT(*) AS TotalCustomers
FROM Customer;

-- 11. Display customers with NULL phone numbers
SELECT *
FROM Customer
WHERE phone_num IS NULL;

-- 12. Display loans with duration greater than 10 years
-- Note: Your Loans table does not have duration column, using amount > 10000 as a placeholder
SELECT *
FROM Loans
WHERE amount > 10000;

/* =====================================
   DML Operations (Insert / Update / Delete)
   ===================================== */

-- 13. Insert yourself as a new customer and open an account with balance 10000
INSERT INTO Customer (customer_id, name, address, phone_num, date_of_birth)
VALUES (203, 'Yahya Alofi', 'Muscat', '91234567', '2002-01-01');

INSERT INTO Account (account_num, balance, account_type, duration, customer_id)
VALUES (402, 10000, 'Saving', 12, 203);

-- 14. Insert another customer with NULL phone and address
INSERT INTO Customer (customer_id, name, address, phone_num, date_of_birth)
VALUES (204, 'New Customer', NULL, NULL, '2000-05-05');

-- 15. Increase your account balance by 20%
UPDATE Account
SET balance = balance * 1.2
WHERE customer_id = 203;

-- 16. Increase balance by 5% for accounts with balance less than 5000
UPDATE Account
SET balance = balance * 1.05
WHERE balance < 5000;

-- 17. Update phone number to 'Not Provided' where phone is NULL
UPDATE Customer
SET phone_num = 'Not Provided'
WHERE phone_num IS NULL;

-- 18. Delete closed accounts
-- Note: Yo
ALTER TABLE Account
ADD status VARCHAR(20) DEFAULT 'Open';
UPDATE Account
SET status = 'Closed'
WHERE account_num = 403;  -- replace with the account number you want to close
DELETE FROM Account
WHERE status = 'Closed';
SELECT * FROM Account;



