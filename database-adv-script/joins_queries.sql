-- 1. INNER JOIN – Bookings with Users
SELECT 
    bookings.booking_id,
    bookings.property_id,
    bookings.booking_date,
    users.user_id,
    users.name AS user_name
FROM bookings
INNER JOIN users
    ON bookings.user_id = users.user_id;

-- 2. LEFT JOIN – Properties with Reviews
SELECT 
    p.property_id,
    p.title AS property_title,
    r.review_id,
    r.comment
FROM properties p
LEFT JOIN reviews r
    ON p.property_id = r.property_id
ORDER BY p.title ASC, r.review_id ASC;


-- 3. FULL OUTER JOIN – Users and Bookings
SELECT 
    users.user_id,
    users.name AS user_name,
    bookings.booking_id,
    bookings.booking_date
FROM users
FULL OUTER JOIN bookings
    ON users.user_id = bookings.user_id;
