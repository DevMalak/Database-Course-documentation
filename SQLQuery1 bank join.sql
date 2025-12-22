use banksystem;
-----Bank Database – JOIN Queries------


------1. Display branch ID, name, and the name of the employee who manages it------

SELECT b.branch_id, b.address, e.name AS manager_name
FROM Branch b
INNER JOIN Employee e
ON b.branch_id = e.branch_id
WHERE e.position = 'Manager';

------2. Display branch names and the accounts opened under each-------

SELECT b.address AS branch_name,
       a.account_num,
       a.account_type,
       a.balance
FROM Branch b
INNER JOIN Employee e ON b.branch_id = e.branch_id
INNER JOIN Emp_Cust ec ON e.emp_id = ec.emp_id
INNER JOIN Account a ON ec.customer_id = a.customer_id;

INSERT INTO Emp_Cust (customer_id, emp_id, action_type)
VALUES (201, 101, 'Account Opening');

------3. Display full customer details along with their loans--------
SELECT c.*, l.loan_id, l.type, l.amount, l.issue_date
FROM Customer c
INNER JOIN Loans l ON c.customer_id = l.customer_id;

-------4. Display loan records where the loan office is in 'Alexandria' or 'Giza'------
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    position VARCHAR(50),
    branch_id INT,  -- This should exist
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employee';

ALTER TABLE Employee
ADD bbranch_id INT;

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Branch2 FOREIGN KEY (bbranch_id) REFERENCES Branch(branch_id);

ALTER TABLE Loans
ADD branch_id INT;

ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Branch FOREIGN KEY (branch_id) REFERENCES Branch(branch_id);

SELECT l.*
FROM Loans l
JOIN Branch b
    ON l.branch_id = b.branch_id
WHERE b.address IN ('Alexandria', 'Giza');

-------5. Display account data where the type starts with "S" (e.g., "Savings")-------

SELECT *
FROM Account
WHERE account_type LIKE 'S%';

------6. List customers with accounts having balances between 20,000 and 50,000------
SELECT DISTINCT c.customer_id, c.name
FROM Customer c
JOIN Account a
    ON c.customer_id = a.customer_id
WHERE a.balance BETWEEN 20000 AND 50000;

-------7. Retrieve customer names who borrowed more than 100,000 LE from 'Cairo Main Branch'------
SELECT c.name
FROM Customer c
JOIN Loans l ON c.customer_id = l.customer_id
JOIN Employee e ON l.emp_id = e.emp_id
JOIN Branch b ON e.branch_id = b.branch_id
WHERE l.amount > 100000
  AND b.address = 'Cairo';  -- use the branch’s address instead of name

  UPDATE Branch
SET name = 'Cairo Main Branch'  -- or 'Muscat', depending on branch
WHERE branch_id = 1;

SELECT * FROM Branch;

  
  SELECT c.name AS CustomerName
FROM Customer c
JOIN Loans l ON c.customer_id = l.customer_id
JOIN Employee e ON l.emp_id = e.emp_id
JOIN Branch b ON e.branch_id = b.branch_id
WHERE l.amount > 100000
  AND b.name = 'Cairo Main Branch';

------8. Find all customers assisted by employee "Amira Khaled"------
SELECT DISTINCT c.name
FROM Customer c
JOIN Emp_Cust ec ON c.customer_id = ec.customer_id
JOIN Employee e ON ec.emp_id = e.emp_id
WHERE e.name = 'Amira Khaled';

-----9. Display each customer’s name and the accounts they hold, sorted by account typ------
SELECT c.name AS CustomerName, a.account_num, a.account_type
FROM Customer c
JOIN Account a ON c.customer_id = a.customer_id
ORDER BY c.name, a.account_type;

------10. For each loan issued in Cairo, show loan ID, customer name, employee handling it, and branch name-----
SELECT 
    l.loan_id, 
    c.name AS CustomerName, 
    e.name AS EmployeeName, 
    b.name AS BranchName
FROM Loans l
JOIN Customer c ON l.customer_id = c.customer_id
JOIN Employee e ON l.emp_id = e.emp_id
JOIN Branch b ON e.branch_id = b.branch_id
WHERE b.name LIKE '%Cairo%';

-----11. Display all employees who manage any branch------
SELECT e.emp_id, e.name, e.position, e.branch_id
FROM Employee e
WHERE e.position = 'Manager';

----12. Display all customers and their transactions, even if some customers have no transactions yet------

SELECT 
    c.name AS CustomerName,
    a.account_num,
    t.transaction_id,
    t.amount,
    t.transaction_type,
    t.date AS TransactionDate
FROM Customer c
LEFT JOIN Account a ON c.customer_id = a.customer_id
LEFT JOIN Transactions t ON a.account_num = t.account_num
ORDER BY c.name, t.date;
