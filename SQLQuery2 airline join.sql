use  airline1;


----1. Display each flight leg's ID, schedule, and the name of the airplane assigned to it.

SELECT li.leg_instance_id, li.depart_time AS schedule, a.type_name AS airplane_name
FROM LegInstance li
JOIN Airplane a ON li.airplane_id = a.airplane_id;

------2. Display all flight numbers and the names of the departure and arrival airports.

SELECT fl.flight_leg_code,
       dep.name AS departure_airport
FROM FlightLeg fl
inner JOIN Airport dep ON fl.air_code = dep.air_code;

----3. Display all reservation data with the name and phone of the customer who made each booking. 

SELECT reservation_id,
       seat_number,
       customer_name,
       customer_phone,
       leg_instance_id
FROM Reservation;

----4. Display IDs and locations of flights departing from 'CAI' or 'DXB'

SELECT li.leg_instance_id, li.depart_time, fl.air_code
FROM LegInstance li
JOIN FlightLeg fl ON li.leg_no = fl.leg_no
WHERE fl.air_code IN ('CAI', 'DXB');


----5. Display full data of flights whose names start with 'A'. 
SELECT *
FROM Flight
WHERE airline LIKE 'A%';

----6. List customers who have bookings with total payment between 3000 and 5000. 

SELECT r.customer_name,
       r.customer_phone,
       (f.amount * r.seat_number) AS total_payment
FROM Reservation r
JOIN LegInstance li ON r.leg_instance_id = li.leg_instance_id
JOIN Fare f ON li.leg_no = f.flight_leg_code
WHERE (f.amount * r.seat_number) BETWEEN 3000 AND 5000;


----7. Retrieve all passengers on 'Flight 110' who booked more than 2 seats. 

SELECT r.customer_name,
       SUM(r.seat_number) AS seats_booked
FROM Reservation r
JOIN LegInstance li ON r.leg_instance_id = li.leg_instance_id
JOIN Flight f ON li.leg_no = f.flight_leg_code
WHERE f.flight_leg_code = 1   -- Flight 110
GROUP BY r.customer_name
HAVING SUM(r.seat_number) > 2;

----8. Find names of passengers whose booking was handled by agent "Youssef Hamed".

------there is no table with agent name

----9. Display each passenger’s name and the flights they booked, ordered by flight date. 
SELECT r.customer_name,
       f.airline AS flight_airline,
       li.depart_time AS flight_date
FROM Reservation r
JOIN LegInstance li ON r.leg_instance_id = li.leg_instance_id
JOIN Flight f ON li.leg_no = f.flight_leg_code
ORDER BY li.depart_time;

---10. For each flight departing from 'Cairo', display the flight number, departure time, and airline name. 

SELECT f.flight_leg_code AS flight_number,
       li.depart_time,
       f.airline
FROM FlightLeg fl
inner JOIN LegInstance li ON li.leg_no = fl.leg_no
inner JOIN Flight f ON fl.flight_leg_code = f.flight_leg_code
WHERE fl.air_code = 'CAI';

----11. Display all staff members who are assigned as supervisors for flights. 
--In the current database schema, there is no table for staff members and no link between staff and flights. 


---12. Display all bookings and their related passengers, even if some bookings are unpaid 

SELECT r.reservation_id,
       r.customer_name,
       r.customer_phone,
       f.amount AS fare_amount,
       li.depart_time
FROM Reservation r
LEFT JOIN LegInstance li ON r.leg_instance_id = li.leg_instance_id
LEFT JOIN Fare f ON li.leg_no = f.flight_leg_code
ORDER BY r.reservation_id;







2. Display all flight numbers and the names of the departure and arrival airports. 

3. Display all reservation data with the name and phone of the customer who made each booking. 

4. Display IDs and locations of flights departing from 'CAI' or 'DXB'. 

5. Display full data of flights whose names start with 'A'. 

6. List customers who have bookings with total payment between 3000 and 5000. 

  

7. Retrieve all passengers on 'Flight 110' who booked more than 2 seats. 

8. Find names of passengers whose booking was handled by agent "Youssef Hamed". 

9. Display each passenger’s name and the flights they booked, ordered by flight date. 

10. For each flight departing from 'Cairo', display the flight number, departure time, and airline name. 

11. Display all staff members who are assigned as supervisors for flights. 

12. Display all bookings and their related passengers, even if some bookings are unpaid. 