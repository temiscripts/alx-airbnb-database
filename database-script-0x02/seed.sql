
-- Users (10)

INSERT INTO `user` (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(UUID(), 'John', 'Doe', 'john@example.com', 'hashed_pw1', '1234567890', 'guest'),
(UUID(), 'Jane', 'Smith', 'jane@example.com', 'hashed_pw2', '0987654321', 'host'),
(UUID(), 'Alice', 'Brown', 'alice@example.com', 'hashed_pw3', NULL, 'guest'),
(UUID(), 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw4', '5555555555', 'host'),
(UUID(), 'Carol', 'Davis', 'carol@example.com', 'hashed_pw5', '2223334444', 'guest'),
(UUID(), 'David', 'Wilson', 'david@example.com', 'hashed_pw6', NULL, 'guest'),
(UUID(), 'Eve', 'Miller', 'eve@example.com', 'hashed_pw7', '7778889999', 'host'),
(UUID(), 'Frank', 'Taylor', 'frank@example.com', 'hashed_pw8', NULL, 'guest'),
(UUID(), 'Grace', 'Anderson', 'grace@example.com', 'hashed_pw9', '4445556666', 'host'),
(UUID(), 'Hank', 'Thomas', 'hank@example.com', 'hashed_pw10', '1112223333', 'guest');

-- Properties (10)
INSERT INTO `property` (property_id, host_id, name, description, location, price_per_night)
VALUES
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Jane' LIMIT 1), 'Beach House', 'Ocean view villa with 3 bedrooms', 'Lagos', 200.00),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Bob' LIMIT 1), 'City Apartment', 'Modern apartment in city center', 'Abuja', 100.00),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Eve' LIMIT 1), 'Mountain Cabin', 'Cozy cabin with fireplace', 'Jos', 150.00),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Grace' LIMIT 1), 'Luxury Condo', 'High-end condo with pool', 'Lagos', 300.00),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Jane' LIMIT 1), 'Studio Flat', 'Small and modern studio', 'Abuja', 80.00),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Bob' LIMIT 1), 'Suburban House', 'Family home with garden', 'Ibadan', 120.00),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Eve' LIMIT 1), 'Lake House', 'Relaxing house near lake', 'Kano', 180.00),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Grace' LIMIT 1), 'Downtown Loft', 'Spacious loft in city center', 'Lagos', 220.00),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Jane' LIMIT 1), 'Penthouse Suite', 'Luxury penthouse with terrace', 'Abuja', 400.00),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Bob' LIMIT 1), 'Countryside Cottage', 'Quiet cottage in the countryside', 'Ekiti', 90.00);

-- Bookings (15)
INSERT INTO `booking` (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(UUID(), (SELECT property_id FROM `property` WHERE name='Beach House' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='John' LIMIT 1), '2025-09-10','2025-09-15', 1000.00, 'confirmed'),
(UUID(), (SELECT property_id FROM `property` WHERE name='City Apartment' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Alice' LIMIT 1), '2025-09-05','2025-09-08', 300.00, 'confirmed'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Mountain Cabin' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='David' LIMIT 1), '2025-10-01','2025-10-05', 600.00, 'confirmed'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Luxury Condo' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Carol' LIMIT 1), '2025-11-10','2025-11-15', 1500.00, 'confirmed'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Studio Flat' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Frank' LIMIT 1), '2025-12-01','2025-12-03', 160.00, 'pending'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Suburban House' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Hank' LIMIT 1), '2025-12-10','2025-12-15', 600.00, 'pending'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Lake House' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='John' LIMIT 1), '2025-08-01','2025-08-05', 720.00, 'canceled'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Downtown Loft' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Alice' LIMIT 1), '2025-07-01','2025-07-04', 660.00, 'canceled'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Penthouse Suite' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='David' LIMIT 1), '2025-09-20','2025-09-25', 2000.00, 'confirmed'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Countryside Cottage' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Carol' LIMIT 1), '2025-10-05','2025-10-08', 270.00, 'confirmed'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Beach House' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Frank' LIMIT 1), '2025-10-10','2025-10-15', 1000.00, 'pending'),
(UUID(), (SELECT property_id FROM `property` WHERE name='City Apartment' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Hank' LIMIT 1), '2025-11-01','2025-11-05', 500.00, 'confirmed'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Mountain Cabin' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='John' LIMIT 1), '2025-12-01','2025-12-04', 450.00, 'pending'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Luxury Condo' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Alice' LIMIT 1), '2025-12-10','2025-12-15', 1500.00, 'confirmed');

-- Payments (for confirmed bookings)
INSERT INTO `payment` (payment_id, booking_id, amount, payment_method)
VALUES
(UUID(), (SELECT booking_id FROM `booking` WHERE total_price=1000.00 AND status='confirmed' LIMIT 1), 1000.00, 'credit_card'),
(UUID(), (SELECT booking_id FROM `booking` WHERE total_price=300.00 AND status='confirmed' LIMIT 1), 300.00, 'paypal'),
(UUID(), (SELECT booking_id FROM `booking` WHERE total_price=600.00 AND status='confirmed' LIMIT 1), 600.00, 'stripe'),
(UUID(), (SELECT booking_id FROM `booking` WHERE total_price=1500.00 AND status='confirmed' LIMIT 1), 1500.00, 'credit_card'),
(UUID(), (SELECT booking_id FROM `booking` WHERE total_price=2000.00 AND status='confirmed' LIMIT 1), 2000.00, 'paypal');

-- Reviews
INSERT INTO `review` (review_id, property_id, user_id, rating, comment)
VALUES
(UUID(), (SELECT property_id FROM `property` WHERE name='Beach House' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='John' LIMIT 1), 5, 'Amazing stay! Highly recommend.'),
(UUID(), (SELECT property_id FROM `property` WHERE name='City Apartment' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Alice' LIMIT 1), 4, 'Comfortable and convenient.'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Mountain Cabin' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='David' LIMIT 1), 5, 'Cozy and beautiful location.'),
(UUID(), (SELECT property_id FROM `property` WHERE name='Luxury Condo' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Carol' LIMIT 1), 5, 'Luxury experience, very clean.');

-- Messages
INSERT INTO `message` (message_id, sender_id, receiver_id, message_body)
VALUES
(UUID(), (SELECT user_id FROM `user` WHERE first_name='John' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Jane' LIMIT 1), 'Hi, excited to stay at your property!'),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='Alice' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Bob' LIMIT 1), 'Hello, is the apartment available for my dates?'),
(UUID(), (SELECT user_id FROM `user` WHERE first_name='David' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Eve' LIMIT 1), 'Can I book the cabin for next month?'),

(UUID(), (SELECT user_id FROM `user` WHERE first_name='Carol' LIMIT 1), (SELECT user_id FROM `user` WHERE first_name='Grace' LIMIT 1), 'Is the condo still available?');