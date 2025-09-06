# Airbnb Database Schema

This directory contains the SQL DDL for the Airbnb clone project, based on the provided database specification.

## Files

- `schema.sql`: SQL statements to create all tables, primary/foreign keys, constraints, and indexes.

## Database Tables

### 1. User
Stores information about users of the platform.
- `user_id` (UUID, PK)
- `first_name`, `last_name`
- `email` (unique)
- `password_hash`
- `phone_number`
- `role` (guest, host, admin)
- `created_at`

### 2. Property
Stores properties listed by hosts.
- `property_id` (UUID, PK)
- `host_id` (FK → User.user_id)
- `name`, `description`, `location`
- `pricepernight`
- `created_at`, `updated_at`

### 3. Booking
Stores reservations made by users.
- `booking_id` (UUID, PK)
- `property_id` (FK → Property.property_id)
- `user_id` (FK → User.user_id)
- `start_date`, `end_date`
- `total_price`
- `status` (pending, confirmed, canceled)
- `created_at`

### 4. Payment
Tracks payments for bookings.
- `payment_id` (UUID, PK)
- `booking_id` (FK → Booking.booking_id)
- `amount`
- `payment_date`
- `payment_method` (credit_card, paypal, stripe)

### 5. Review
Stores feedback for properties.
- `review_id` (UUID, PK)
- `property_id` (FK → Property.property_id)
- `user_id` (FK → User.user_id)
- `rating` (1-5)
- `comment`
- `created_at`

### 6. Message
Stores messages between users.
- `message_id` (UUID, PK)
- `sender_id` (FK → User.user_id)
- `recipient_id` (FK → User.user_id)
- `message_body`
- `sent_at`

## Constraints & Indexing
- All tables enforce **primary keys** and **foreign keys** for integrity.
- **Unique** constraint on `User.email`.
- **Check constraints** for ENUM-like fields (`role`, `status`, `payment_method`) and rating.
- Indexes on commonly queried columns: `email`, `property_id`, `booking_id`, `sender_id`, `recipient_id`.

## Notes
- The schema uses UUIDs for primary keys to ensure uniqueness across distributed systems.
- The database is normalized to **3NF**, minimizing redundancy and maintaining data integrity.
