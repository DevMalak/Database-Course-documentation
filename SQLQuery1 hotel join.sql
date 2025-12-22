USE HotelManagement;

------1. Display hotel ID, name, and the name of its manager.

SELECT 
    b.Branch_id,
    b.name AS Hotel_name,
    s.name AS Manager_name
FROM Branch b
LEFT JOIN Staff s
    ON b.Branch_id = s.Branch_id
WHERE s.job = 'Manager';

2. Display hotel names and the rooms available under them.

SELECT 
    b.name AS Hotel_name,
    r.Room_num,
    r.Room_type,
    r.Nightly_rate
FROM Branch b
JOIN Room r
    ON b.Branch_id = r.Branch_id
ORDER BY b.name, r.Room_num;

-----3. Display guest data along with the bookings they made.

SELECT 
    c.Customer_id,
    c.name AS Guest_name,
    c.phone,
    c.email,
    b.Booking_id,
    b.Check_in,
    b.Checkout,
    b.status,
    b.total_cost
FROM Customer c
LEFT JOIN Booking b
    ON c.Customer_id = b.Customer_id
ORDER BY c.Customer_id;

----4. Display bookings for hotels in 'Hurghada' or 'Sharm El Sheikh'.

SELECT 
    bo.Booking_id,
    c.name AS Guest_name,
    r.Room_num,
    r.Room_type,
    b.name AS Hotel_name,
    b.location
FROM Booking bo
-- Only include customers who have bookings ? INNER JOIN
INNER JOIN Customer c 
    ON bo.Customer_id = c.Customer_id

-- Only include bookings that have rooms ? INNER JOIN
INNER JOIN Booking_room br 
    ON bo.Booking_id = br.Booking_id

-- Only include rooms that are linked to bookings ? INNER JOIN
INNER JOIN Room r 
    ON br.Room_num = r.Room_num

-- Only include branches that have the rooms ? INNER JOIN
INNER JOIN Branch b 
    ON r.Branch_id = b.Branch_id

WHERE b.location IN ('Hurghada', 'Sharm El Sheikh');




5. Display all room records where room type starts with "S" (e.g., "Suite", "Single").

SELECT *
FROM Room
WHERE Room_type LIKE 'S%';

-----6. List guests who booked rooms priced between 1500 and 2500 LE.

SELECT DISTINCT 
    c.Customer_id,
    c.name AS Guest_name,
    c.phone,
    c.email
FROM Customer c
inner JOIN Booking b ON c.Customer_id = b.Customer_id
inner JOIN Booking_room br ON b.Booking_id = br.Booking_id
inner JOIN Room r ON br.Room_num = r.Room_num
WHERE r.Nightly_rate BETWEEN 1500 AND 2500;

7. Retrieve guest names who have bookings marked as 'Confirmed' in hotel "Hilton Downtown".

SELECT DISTINCT 
    c.name AS Guest_name
FROM Customer c
-- Only include customers who have bookings ? INNER JOIN
INNER JOIN Booking b ON c.Customer_id = b.Customer_id

-- Only include bookings linked to rooms ? INNER JOIN
INNER JOIN Booking_room br ON b.Booking_id = br.Booking_id

-- Only include rooms assigned to bookings ? INNER JOIN
INNER JOIN Room r ON br.Room_num = r.Room_num

-- Only include branches (hotels) for these rooms ? INNER JOIN
INNER JOIN Branch brh ON r.Branch_id = brh.Branch_id

-- Filter by booking status and hotel name
WHERE b.status = 'Confirmed'
  AND brh.name = 'Hilton Downtown';

8. Find guests whose bookings were handled by staff member "Mona Ali".

SELECT DISTINCT 
    c.name AS Guest_name,
    s.name AS Staff_name,
    sa.Action_type,
    sa.Action_date
FROM StaffAction sa
-- Include only staff linked to actions ? INNER JOIN
INNER JOIN Staff s ON sa.Staff_id = s.Staff_id

-- Include only bookings linked to actions ? INNER JOIN
INNER JOIN Booking b ON sa.Booking_id = b.Booking_id

-- Include only customers linked to bookings ? INNER JOIN
INNER JOIN Customer c ON b.Customer_id = c.Customer_id

-- Filter by staff name
WHERE s.name = 'Mona Ali';

----9. Display each guest’s name and the rooms they booked, ordered by room type.

SELECT 
    c.name AS Guest_name,
    r.Room_num,
    r.Room_type
FROM Customer c
-- Include only customers who have bookings ? INNER JOIN
INNER JOIN Booking b ON c.Customer_id = b.Customer_id

-- Include only bookings that have rooms ? INNER JOIN
INNER JOIN Booking_room br ON b.Booking_id = br.Booking_id

-- Include only rooms linked to the booking ? INNER JOIN
INNER JOIN Room r ON br.Room_num = r.Room_num

ORDER BY c.name, r.Room_type;

----10. For each hotel in 'Cairo', display hotel ID, name, manager name, and contact info.

SELECT 
    br.Branch_id,
    br.name AS Hotel_name,
    s.name AS Manager_name,
    s.salary,
    s.Staff_id
FROM Branch br
-- Include staff linked to the branch ? LEFT JOIN
LEFT JOIN Staff s 
    ON br.Branch_id = s.Branch_id AND s.job = 'Manager'
WHERE br.location = 'Cairo';

11. Display all staff members who hold 'Manager' positions.

SELECT *
FROM Staff
WHERE job = 'Manager';

-----12. Display all guests and their reviews, even if some guests haven't submitted any reviews.
CREATE TABLE Review (
    Review_id INT PRIMARY KEY,
    Customer_id INT,
    Booking_id INT,
    Review_text NVARCHAR(255),
    Rating INT,
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id),
    FOREIGN KEY (Booking_id) REFERENCES Booking(Booking_id)
);

SELECT 
    c.name AS Guest_name,
    r.Review_text,
    r.Rating
FROM Customer c
LEFT JOIN Review r ON c.Customer_id = r.Customer_id;



