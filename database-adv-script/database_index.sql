-- Measure query performance BEFORE indexing
EXPLAIN ANALYZE
SELECT booking.id, users.first_name
FROM booking
INNER JOIN users
ON booking.user_id = users.id;

-- Create index on Users table for email (often used in WHERE clause)
CREATE INDEX idx_users_email ON users(email);

-- Create index on Bookings table for user_id (used in JOIN and filtering by user)
CREATE INDEX idx_bookings_user_id ON booking(user_id);

-- Create index on Bookings table for property_id (used in JOIN and filtering by property)
CREATE INDEX idx_bookings_property_id ON booking(property_id);

-- Create index on Properties table for location (if filtering by city/location)
CREATE INDEX idx_properties_location ON property(location);

-- Create index on Bookings table for start_date (if used for sorting or filtering by date)
CREATE INDEX idx_bookings_start_date ON booking(start_date);

-- Measure query performance AFTER indexing
EXPLAIN ANALYZE
SELECT booking.id, users.first_name
FROM booking
INNER JOIN users
ON booking.user_id = users.id;
