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
    properties.property_id,
    properties.title AS property_title,
    reviews.review_id,
    reviews.comment
FROM properties
LEFT JOIN reviews
    ON properties.property_id = reviews.property_id;


-- 3. FULL OUTER JOIN – Users and Bookings
SELECT 
    users.user_id,
    users.name AS user_name,
    bookings.booking_id,
    bookings.booking_date
FROM users
FULL OUTER JOIN bookings
    ON users.user_id = bookings.user_id;
