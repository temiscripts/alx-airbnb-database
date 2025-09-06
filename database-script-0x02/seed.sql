-- alx-airbnb-database/database-script-0x02/seed.sql
-- Seed realistic sample data for Airbnb clone

-- ==========================
-- Users (10)
-- ==========================
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(gen_random_uuid(), 'John', 'Doe', 'john@example.com', 'hashed_pw1', '1234567890', 'guest'),
(gen_random_uuid(), 'Jane', 'Smith', 'jane@example.com', 'hashed_pw2', '0987654321', 'host'),
(gen_random_uuid(), 'Alice', 'Brown', 'alice@example.com', 'hashed_pw3', NULL, 'guest'),
(gen_random_uuid(), 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw4', '5555555555', 'host'),
(gen_random_uuid(), 'Carol', 'Davis', 'carol@example.com', 'hashed_pw5', '2223334444', 'guest'),
(gen_random_uuid(), 'David', 'Wilson', 'david@example.com', 'hashed_pw6', NULL, 'guest'),
(gen_random_uuid(), 'Eve', 'Miller', 'eve@example.com', 'hashed_pw7', '7778889999', 'host'),
(gen_random_uuid(), 'Frank', 'Taylor', 'frank@example.com', 'hashed_pw8', NULL, 'guest'),
(gen_random_uuid(), 'Grace', 'Anderson', 'grace@example.com', 'hashed_pw9', '4445556666', 'host'),
(gen_random_uuid(), 'Hank', 'Thomas', 'hank@example.com', 'hashed_pw10', '1112223333', 'guest');

-- ==========================
-- Properties (10)
-- ==========================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Jane'), 'Beach House', 'Ocean view villa with 3 bedrooms', 'Lagos', 200.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Bob'), 'City Apartment', 'Modern apartment in city center', 'Abuja', 100.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Eve'), 'Mountain Cabin', 'Cozy cabin with fireplace', 'Jos', 150.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Grace'), 'Luxury Condo', 'High-end condo with pool', 'Lagos', 300.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Jane'), 'Studio Flat', 'Small and modern studio', 'Abuja', 80.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Bob'), 'Suburban House', 'Family home with garden', 'Ibadan', 120.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Eve'), 'Lake House', 'Relaxing house near lake', 'Kano', 180.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Grace'), 'Downtown Loft', 'Spacious loft in city center', 'Lagos', 220.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Jane'), 'Penthouse Suite', 'Luxury penthouse with terrace', 'Abuja', 400.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Bob'), 'Countryside Cottage', 'Quiet cottage in the countryside', 'Ekiti', 90.00);

-- ==========================
-- Bookings (15)
-- ==========================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
-- confirmed bookings
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Beach House'), (SELECT user_id FROM "User" WHERE first_name='John'), '2025-09-10','2025-09-15', 1000.00, 'confirmed'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='City Apartment'), (SELECT user_id FROM "User" WHERE first_name='Alice'), '2025-09-05','2025-09-08', 300.00, 'confirmed'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Mountain Cabin'), (SELECT user_id FROM "User" WHERE first_name='David'), '2025-10-01','2025-10-05', 600.00, 'confirmed'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Luxury Condo'), (SELECT user_id FROM "User" WHERE first_name='Carol'), '2025-11-10','2025-11-15', 1500.00, 'confirmed'),
-- pending bookings
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Studio Flat'), (SELECT user_id FROM "User" WHERE first_name='Frank'), '2025-12-01','2025-12-03', 160.00, 'pending'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Suburban House'), (SELECT user_id FROM "User" WHERE first_name='Hank'), '2025-12-10','2025-12-15', 600.00, 'pending'),
-- canceled bookings
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Lake House'), (SELECT user_id FROM "User" WHERE first_name='John'), '2025-08-01','2025-08-05', 720.00, 'canceled'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Downtown Loft'), (SELECT user_id FROM "User" WHERE first_name='Alice'), '2025-07-01','2025-07-04', 660.00, 'canceled'),
-- additional bookings
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Penthouse Suite'), (SELECT user_id FROM "User" WHERE first_name='David'), '2025-09-20','2025-09-25', 2000.00, 'confirmed'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Countryside Cottage'), (SELECT user_id FROM "User" WHERE first_name='Carol'), '2025-10-05','2025-10-08', 270.00, 'confirmed'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Beach House'), (SELECT user_id FROM "User" WHERE first_name='Frank'), '2025-10-10','2025-10-15', 1000.00, 'pending'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='City Apartment'), (SELECT user_id FROM "User" WHERE first_name='Hank'), '2025-11-01','2025-11-05', 500.00, 'confirmed'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Mountain Cabin'), (SELECT user_id FROM "User" WHERE first_name='John'), '2025-12-01','2025-12-04', 450.00, 'pending'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Luxury Condo'), (SELECT user_id FROM "User" WHERE first_name='Alice'), '2025-12-10','2025-12-15', 1500.00, 'confirmed');

-- ==========================
-- Payments (for confirmed bookings)
-- ==========================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE total_price=1000.00 AND status='confirmed' LIMIT 1), 1000.00, 'credit_card'),
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE total_price=300.00 AND status='confirmed' LIMIT 1), 300.00, 'paypal'),
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE total_price=600.00 AND status='confirmed' LIMIT 1), 600.00, 'stripe'),
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE total_price=1500.00 AND status='confirmed' LIMIT 1), 1500.00, 'credit_card'),
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE total_price=2000.00 AND status='confirmed' LIMIT 1), 2000.00, 'paypal');

-- ==========================
-- Reviews
-- ==========================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Beach House'), (SELECT user_id FROM "User" WHERE first_name='John'), 5, 'Amazing stay! Highly recommend.'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='City Apartment'), (SELECT user_id FROM "User" WHERE first_name='Alice'), 4, 'Comfortable and convenient.'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Mountain Cabin'), (SELECT user_id FROM "User" WHERE first_name='David'), 5, 'Cozy and beautiful location.'),
(gen_random_uuid(), (SELECT property_id FROM Property WHERE name='Luxury Condo'), (SELECT user_id FROM "User" WHERE first_name='Carol'), 5, 'Luxury experience, very clean.');

-- ==========================
-- Messages
-- ==========================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='John'), (SELECT user_id FROM "User" WHERE first_name='Jane'), 'Hi, excited to stay at your property!'),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Alice'), (SELECT user_id FROM "User" WHERE first_name='Bob'), 'Hello, is the apartment available for my dates?'),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='David'), (SELECT user_id FROM "User" WHERE first_name='Eve'), 'Can I book the cabin for next month?'),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE first_name='Carol'), (SELECT user_id FROM "User" WHERE first_name='Grace'), 'Is the condo still available?');
