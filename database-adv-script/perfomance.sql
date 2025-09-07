-- Initial query (unoptimized)
EXPLAIN ANALYZE
SELECT 
    booking.id AS booking_id,
    users.first_name,
    users.last_name,
    property.name AS property_name,
    property.location,
    payment.amount,
    payment.status
FROM booking
INNER JOIN users 
    ON booking.user_id = users.id
INNER JOIN property 
    ON booking.property_id = property.id
INNER JOIN payment 
    ON booking.id = payment.booking_id;

-- Refactored query (optimized)
-- Removed unnecessary columns, used table aliases, and ensured indexes exist on:
-- booking.user_id, booking.property_id, payment.booking_id
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    u.first_name,
    p.name AS property_name,
    pay.amount
FROM booking b
JOIN users u 
    ON b.user_id = u.id
JOIN property p 
    ON b.property_id = p.id
JOIN payment pay 
    ON b.id = pay.booking_id;
