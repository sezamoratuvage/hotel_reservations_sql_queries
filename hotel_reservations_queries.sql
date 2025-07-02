-- hotel_reservations_queries.sql
-- Hotel reservation analysis queries

-- 1. Top 100 records
SELECT TOP 100 * FROM hotel_reservations_sample;

-- 2. List reservations for rooms of type 'Suite'
SELECT * FROM hotel_reservations_sample
WHERE room_type = 'Suite';

-- 3. View check-in reservations made after 2023
SELECT * FROM hotel_reservations_sample
WHERE check_in >= '2023-01-01';

-- 4. Get total reservation count by room type
SELECT room_type, COUNT(*) AS ReservationCount
FROM hotel_reservations_sample
GROUP BY room_type
ORDER BY ReservationCount DESC;

-- 5. Reservation trends by month (for seasonal planning)
SELECT YEAR(check_in) AS Year, MONTH(check_in) AS Month, COUNT(*) AS Reservations
FROM hotel_reservations_sample
GROUP BY YEAR(check_in), MONTH(check_in)
ORDER BY Year, Month;

-- 6. Average stay duration (in days)
SELECT AVG(DATEDIFF(day, check_in, check_out)) AS AverageStayDays
FROM hotel_reservations_sample;

-- 7. Top revenue-generating customers
SELECT reservation_id, SUM(total_price) AS TotalSpent
FROM hotel_reservations_sample
GROUP BY reservation_id
ORDER BY TotalSpent DESC;

-- 8. Reservation distribution by price range
SELECT 
  CASE 
    WHEN total_price < 100 THEN 'Low Price'
    WHEN total_price BETWEEN 100 AND 300 THEN 'Mid Price'
    ELSE 'High Price'
  END AS PriceCategory,
  COUNT(*) AS ReservationCount
FROM hotel_reservations_sample
GROUP BY
  CASE 
    WHEN total_price < 100 THEN 'Low Price'
    WHEN total_price BETWEEN 100 AND 300 THEN 'Mid Price'
    ELSE 'High Price'
  END
ORDER BY ReservationCount DESC;

-- 9. Distribution of cancelled reservations by room type
SELECT room_type, COUNT(*) AS CancelledCount
FROM hotel_reservations_sample
WHERE status = 'Canceled'
GROUP BY room_type
ORDER BY CancelledCount DESC;

-- 10. Daily occupancy rate calculation
SELECT check_in, 
       COUNT(*) * 1.0 / 100 AS OccupancyRate
FROM hotel_reservations_sample
GROUP BY check_in
ORDER BY check_in;

-- 11. Number of reservations per guest (for loyalty analysis)
SELECT guest_name, COUNT(*) AS ReservationCount
FROM hotel_reservations_sample
GROUP BY guest_name
HAVING COUNT(*) > 1
ORDER BY ReservationCount DESC;
