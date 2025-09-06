# Database Normalization to 3NF

## 1. Introduction
This document explains the normalization steps applied to the `alx-airbnb-database` schema to ensure it meets **Third Normal Form (3NF)**.  
The schema is based on the ERD for our Airbnb clone (referenced in the project).

---

## 2. Original Schema (Before Normalization)
**Entities:**
- **Users:** Stores information about users (name, email, phone, etc.)
- **Listings:** Stores properties listed by users
- **Bookings:** Stores reservations made by users
- **Locations:** Stores city and country information
- **Reviews:** Stores feedback for listings

---

## 3. Normalization Steps

### **First Normal Form (1NF)**
- Ensured all fields contain atomic values.
- Added primary keys for all tables.
- Removed repeating groups.

### **Second Normal Form (2NF)**
- Removed partial dependencies:
  - `city` and `country` moved to `Locations` table, referenced by `Users` and `Listings`.
- All non-key attributes now depend on the full primary key.

### **Third Normal Form (3NF)**
- Removed transitive dependencies:
  - `country` no longer stored redundantly in `Users` or `Listings`.
  - `location_id` used as a foreign key instead.

---

## 4. Final Normalized Schema (3NF)

### Users
| user_id | first_name | last_name | email | phone_number | location_id |

### Listings
| listing_id | user_id | title | description | price | location_id |

### Bookings
| booking_id | user_id | listing_id | start_date | end_date | status |

### Locations
| location_id | city | country |

### Reviews
| review_id | user_id | listing_id | rating | comment | created_at |

---

## 5. Summary
- Redundancy removed by creating `Locations` table.
- Data integrity improved via foreign key relationships.
- Database now satisfies **3NF** principles.

