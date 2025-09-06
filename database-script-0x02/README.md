# Airbnb Database Seed Data - Realistic Example

This directory contains SQL scripts to populate the Airbnb clone database with realistic sample data for testing and development.

## Files

- `seed.sql`: Inserts sample data for Users, Properties, Bookings, Payments, Reviews, and Messages.

## Features of Sample Data

- **Users:** 10 users, mix of guests and hosts.
- **Properties:** 10 properties hosted by multiple hosts.
- **Bookings:** 15 bookings with different statuses (confirmed, pending, canceled).
- **Payments:** Payments recorded for confirmed bookings using multiple methods.
- **Reviews:** Ratings and comments for some properties.
- **Messages:** Conversations between users.

## Notes

- UUIDs are generated with `gen_random_uuid()` (PostgreSQL). Use `UUID()` for MySQL.
- Dates, prices, and ratings simulate realistic usage scenarios.
- This dataset provides enough variety for testing queries, joins, and reporting.
