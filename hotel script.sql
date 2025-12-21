
CREATE DATABASE HotelManagement;
USE HotelManagement;

-- Table: Branch
CREATE TABLE Branch (
    Branch_id INT PRIMARY KEY,
    name NVARCHAR(50),
    location NVARCHAR(100)
);

-- Insert sample data into Branch
INSERT INTO Branch (Branch_id, name, location)
VALUES
(1, 'Downtown Branch', '123 Main St'),
(2, 'Airport Branch', '456 Airport Rd');
select*from Branch;
-- Table: Room

CREATE TABLE Room (
    Room_num INT PRIMARY KEY,
    Room_type NVARCHAR(50),
    Nightly_rate DECIMAL(10,2),
    Branch_id INT,
    FOREIGN KEY (Branch_id) REFERENCES Branch(Branch_id)
);

-- Insert sample data into Room
INSERT INTO Room (Room_num, Room_type, Nightly_rate, Branch_id)
VALUES
(101, 'Single', 50.00, 1),
(102, 'Double', 80.00, 1),
(201, 'Suite', 150.00, 2);
select*from Room;

-- Table: Customer
CREATE TABLE Customer (
    Customer_id INT PRIMARY KEY,
    name NVARCHAR(50),
    phone NVARCHAR(20),
    email NVARCHAR(50)
);

-- Insert sample data into Customer
INSERT INTO Customer (Customer_id, name, phone, email)
VALUES
(1, 'Alice Smith', '555-1234', 'alice@example.com'),
(2, 'Bob Johnson', '555-5678', 'bob@example.com');
 select*from Customer;


-- Table: Booking

CREATE TABLE Booking (
    Booking_id INT PRIMARY KEY,
    Checkout DATE,
    Check_in DATE,
    Customer_id INT,
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

-- Insert sample data into Booking
INSERT INTO Booking (Booking_id, Checkout, Check_in, Customer_id)
VALUES
(1, '2025-12-25', '2025-12-20', 1),
(2, '2025-12-28', '2025-12-24', 2);
select*from Booking;

-- Table: Booking_room (many-to-many)

CREATE TABLE Booking_room (
    Booking_id INT,
    Room_num INT,
    PRIMARY KEY (Booking_id, Room_num),
    FOREIGN KEY (Booking_id) REFERENCES Booking(Booking_id),
    FOREIGN KEY (Room_num) REFERENCES Room(Room_num)
);

-- Insert sample data into Booking_room
INSERT INTO Booking_room (Booking_id, Room_num)
VALUES
(1, 101),
(2, 201);
select*from Booking_room;

-- Table: Staff

CREATE TABLE Staff (
    Staff_id INT PRIMARY KEY,
    name NVARCHAR(50),
    job NVARCHAR(50),
    salary DECIMAL(10,2),
    Branch_id INT,
    FOREIGN KEY (Branch_id) REFERENCES Branch(Branch_id)
);

-- Insert sample data into Staff
INSERT INTO Staff (Staff_id, name, job, salary, Branch_id)
VALUES
(1, 'John Doe', 'Receptionist', 3000.00, 1),
(2, 'Jane Roe', 'Housekeeping', 2800.00, 2);
select*from Staff;

-- Table: StaffAction

CREATE TABLE StaffAction (
    Action_id INT PRIMARY KEY,
    Action_type NVARCHAR(50),
    Action_date DATE,
    Staff_id INT,
    Booking_id INT,
    FOREIGN KEY (Staff_id) REFERENCES Staff(Staff_id),
    FOREIGN KEY (Booking_id) REFERENCES Booking(Booking_id)
);

-- Insert sample data into StaffAction
INSERT INTO StaffAction (Action_id, Action_type, Action_date, Staff_id, Booking_id)
VALUES
(1, 'Cleaned Room', '2025-12-21', 2, 1),
(2, 'Checked-in Customer', '2025-12-24', 1, 2);
 select*from StaffAction;

ALTER TABLE Booking
ADD status NVARCHAR(50) DEFAULT 'Pending',
    total_cost DECIMAL(10,2) DEFAULT 0;

-- 1. Display all guest (Customer) records

SELECT * FROM Customer

-- 2. Display guest name, contact number, and proof ID (using email as proof)

SELECT name, phone, email AS ProofID
FROM Customer;


-- 3. Display all bookings with booking date, status, and total cost

SELECT Booking_id, Check_in, Checkout, status, total_cost
FROM Booking;

-- 4. Display each room number and nightly rate

SELECT Room_num, Nightly_rate AS NightlyRate
FROM Room;

-- 5. List rooms priced above 1000 per night

SELECT Room_num, Nightly_rate
FROM Room
WHERE Nightly_rate > 1000;

-- 6. Display staff members working as 'Receptionist'

SELECT * 
FROM Staff
WHERE job = 'Receptionist';

-- 7. Display bookings made in 2024

SELECT * 
FROM Booking
WHERE YEAR(Check_in) = 2024;

-- 8. Display bookings ordered by total cost descending

SELECT * 
FROM Booking
ORDER BY total_cost DESC;

-- 9. Display maximum, minimum, and average room pric

SELECT 
    MAX(Nightly_rate) AS MaxPrice,
    MIN(Nightly_rate) AS MinPrice,
    AVG(Nightly_rate) AS AvgPrice
FROM Room;

-- 10. Display total number of rooms
SELECT COUNT(*) AS TotalRooms
FROM Room;


-- 11. Display guests whose names start with 'M'

SELECT * 
FROM Customer
WHERE name LIKE 'M%';

-- 12. Display rooms priced between 800 and 1500

SELECT * 
FROM Room
WHERE Nightly_rate BETWEEN 800 AND 1500;

-- 13. Insert yourself as a guest

INSERT INTO Customer (Customer_id, name, phone, email)
VALUES (9011, 'malak', '555-0000', 'mkmalaufi@gmail.com');

-- 14. Create a booking for room 205
-- 1. Insert the room first
INSERT INTO Room (Room_num, Room_type, Nightly_rate, Branch_id)
VALUES (205, 'Suite', 1200.00, 2);

-- 2. Verify room exists
SELECT * FROM Room;

-- 3. Insert booking for the new room
INSERT INTO Booking_room (Booking_id, Room_num)
VALUES (1001, 205);
select*from Booking_room ;
-- 15. Insert another guest with NULL contact and proof

INSERT INTO Customer (Customer_id, name, phone, email)
VALUES (9012, 'Guest Two', NULL, NULL);

-- 16. Update your booking status to 'Confirmed'

UPDATE Booking
SET status = 'Confirmed'
WHERE Booking_id = 1001;

-- 17. Increase room prices by 10% for luxury rooms

UPDATE Room
SET Nightly_rate = Nightly_rate * 1.10
WHERE Room_type = 'Suite';

-------------------------------------------
-- 18. Update booking status to 'Completed' where checkout date is before today
-------------------------------------------
UPDATE Booking
SET status = 'Completed'
WHERE Checkout < CAST(GETDATE() AS DATE);

-- 19. Delete bookings with status 'Cancelled'

DELETE FROM Booking
WHERE status = 'Cancelled';
