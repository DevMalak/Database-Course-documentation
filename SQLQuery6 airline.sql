--- Create and use the database
IF DB_ID('airline1') IS NOT NULL
    DROP DATABASE airline1;

CREATE DATABASE airline1;

USE airline1;
 ---Drop tables if they already exist (in reverse dependency order)
IF OBJECT_ID('Reservation', 'U') IS NOT NULL DROP TABLE Reservation;
IF OBJECT_ID('LegInstance', 'U') IS NOT NULL DROP TABLE LegInstance;
IF OBJECT_ID('Fare', 'U') IS NOT NULL DROP TABLE Fare;
IF OBJECT_ID('FlightLeg', 'U') IS NOT NULL DROP TABLE FlightLeg;
IF OBJECT_ID('Flight', 'U') IS NOT NULL DROP TABLE Flight;
IF OBJECT_ID('Airplane', 'U') IS NOT NULL DROP TABLE Airplane;
IF OBJECT_ID('AirplaneType', 'U') IS NOT NULL DROP TABLE AirplaneType;
IF OBJECT_ID('Airport', 'U') IS NOT NULL DROP TABLE Airport;

---- AirplaneType table
CREATE TABLE AirplaneType (
    type_name VARCHAR(50) PRIMARY KEY, 
    max_seat INT NOT NULL,
    company VARCHAR(50)
);

-- 2. Airplane table
CREATE TABLE Airplane (
    airplane_id INT IDENTITY(1,1) PRIMARY KEY, 
    total_seat INT NOT NULL,
    type_name VARCHAR(50),
    FOREIGN KEY (type_name) REFERENCES AirplaneType(type_name)
);

-- 3. Airport table
CREATE TABLE Airport (
    air_code CHAR(5) PRIMARY KEY,
    name VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50)
);

-- 4. Flight table
CREATE TABLE Flight (
    flight_leg_code INT IDENTITY(1,1) PRIMARY KEY,  
    restriction VARCHAR(100),
    airline VARCHAR(50),
    weekdays VARCHAR(50)
);

-- 5. FlightLeg table
CREATE TABLE FlightLeg (
    leg_no INT IDENTITY(1,1) PRIMARY KEY,  
    arrival_time DATETIME,
    depart_time DATETIME,
    air_code CHAR(5),
    flight_leg_code INT,
    FOREIGN KEY (air_code) REFERENCES Airport(air_code),
    FOREIGN KEY (flight_leg_code) REFERENCES Flight(flight_leg_code)
);

-- 6. Fare table
CREATE TABLE Fare (
    code VARCHAR(10) PRIMARY KEY,
    amount DECIMAL(10,2),
    flight_leg_code INT,
    FOREIGN KEY (flight_leg_code) REFERENCES Flight(flight_leg_code)
);

-- 7. LegInstance table
CREATE TABLE LegInstance (
    leg_instance_id INT IDENTITY(1,1) PRIMARY KEY,  
    arrival_time DATETIME,
    depart_time DATETIME,
    number_of_seat INT,
    airplane_id INT,
    leg_no INT,
    FOREIGN KEY (airplane_id) REFERENCES Airplane(airplane_id),
    FOREIGN KEY (leg_no) REFERENCES FlightLeg(leg_no)
);

-- 8. Reservation table
CREATE TABLE Reservation (
    reservation_id INT IDENTITY(1,1) PRIMARY KEY,  
    seat_number INT,
    customer_phone VARCHAR(20),
    customer_name VARCHAR(50),
    leg_instance_id INT,
    FOREIGN KEY (leg_instance_id) REFERENCES LegInstance(leg_instance_id)
);
INSERT INTO AirplaneType (type_name, max_seat, company) VALUES
('Boeing737', 180, 'Boeing'),
('AirbusA320', 150, 'Airbus');
SELECT * FROM AirplaneType;
--  Airplane
INSERT INTO Airplane (total_seat, type_name) VALUES
(180, 'Boeing737'),
(150, 'AirbusA320');
SELECT * FROM Airplane;
--  Airport
INSERT INTO Airport (air_code, name, state, city) VALUES
('MCT', 'Muscat International Airport', 'Muscat', 'Muscat'),
('SLL', 'Salalah Airport', 'Dhofar', 'Salalah'),
('MNH', 'Masirah Airport', 'Sharqiya', 'Masirah');
SELECT * FROM Airport;

-- Flight
INSERT INTO Flight (restriction, airline, weekdays) VALUES
('No smoking', 'Oman Air', 'Mon-Fri'),
('Hand luggage only', 'Oman Air', 'Sat-Sun'),
('Pets allowed', 'Oman Air', 'Tue-Sun');
SELECT * FROM Flight;
-- FlightLeg
INSERT INTO FlightLeg (arrival_time, depart_time, air_code, flight_leg_code) VALUES
('2025-12-16 14:00', '2025-12-16 10:00', 'MCT', 1),
('2025-12-17 16:00', '2025-12-17 12:00', 'SLL', 2),
('2025-12-18 18:00', '2025-12-18 14:00', 'MNH', 3);

SELECT * FROM FlightLeg;
--  Fare
INSERT INTO Fare (code, amount, flight_leg_code) VALUES
('F001', 120.00, 1),
('F002', 150.00, 2),
('F003', 200.00, 3);

SELECT * FROM Fare;
--  LegInstance
INSERT INTO LegInstance (arrival_time, depart_time, number_of_seat, airplane_id, leg_no) VALUES
('2025-12-16 14:00', '2025-12-16 10:00', 180, 1, 1),
('2025-12-17 16:00', '2025-12-17 12:00', 150, 2, 2),
('2025-12-18 18:00', '2025-12-18 14:00', 180, 1, 3);
SELECT * FROM LegInstance;
-- Reservation
INSERT INTO Reservation (seat_number, customer_phone, customer_name, leg_instance_id) VALUES
(1, '968-99123456', 'Ahmed Al-Amri', 1),
(2, '968-99112233', 'Salma Al-Balushi', 1),
(3, '968-99234567', 'Hamad Al-Harthy', 2),
(4, '968-99345678', 'Aisha Al-Lawati', 2),
(5, '968-99456789', 'Sultan Al-Rashidi', 1),
(6, '968-99567890', 'Fatma Al-Mahrouqi', 3),
(7, '968-99678901', 'Khalid Al-Salmi', 3),
(8, '968-99789012', 'Laila Al-Hinai', 3);

SELECT * FROM Reservation;
--  Display all flight leg records-------
SELECT * FROM FlightLeg;

--  Display each flight leg ID, scheduled departure time, and arrival time
SELECT leg_no, depart_time, arrival_time
FROM FlightLeg;
--  Display each airplane’s ID, type, and seat capacity
SELECT a.airplane_id, at.type_name AS type, a.total_seat AS seat_capacity
FROM Airplane a
JOIN AirplaneType at ON a.type_name = at.type_name;
-- Display each flight leg’s ID and available seats as AvailableSeats
SELECT li.leg_instance_id AS FlightLegID, li.number_of_seat AS AvailableSeats
FROM LegInstance li;
--  List flight leg IDs with available seats greater than 100
SELECT leg_instance_id
FROM LegInstance
WHERE number_of_seat > 100;
--  List airplane IDs with seat capacity above 300
SELECT airplane_id
FROM Airplane
WHERE total_seat > 300;
--  Display airport codes and names where city = 'Cairo'
SELECT air_code, name
FROM Airport
WHERE city = 'Cairo';
--  Display flight legs scheduled on 2025-06-10
SELECT *
FROM FlightLeg
WHERE CAST(depart_time AS DATE) = '2025-06-10';
-- Display flight legs ordered by departure time
SELECT *
FROM FlightLeg
ORDER BY depart_time;

-- Display the maximum, minimum, and average available seats
SELECT MAX(number_of_seat) AS MaxSeats,
       MIN(number_of_seat) AS MinSeats,
       AVG(number_of_seat * 1.0) AS AvgSeats
FROM LegInstance;
-- Display total number of flight legs
SELECT COUNT(*) AS TotalFlightLegs
FROM FlightLeg;


-- 1️⃣2️⃣ Display airplanes whose type contains 'Boeing'
SELECT a.airplane_id, at.type_name
FROM Airplane a
JOIN AirplaneType at ON a.type_name = at.type_name
WHERE at.type_name LIKE '%Boeing%';
GO


