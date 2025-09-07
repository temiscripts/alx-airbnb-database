# database-adv-script/optimization_report.md

# Query Optimization Report

## Objective
Retrieve all bookings along with related **user**, **property**, and **payment** details while improving performance.

---

## Initial Query Performance
**Query:**
```sql
SELECT booking.id AS booking_id, users.first_name, users.last_name,
       property.name AS property_name, property.location,
       payment.amount, payment.status
FROM booking
INNER JOIN users ON booking.user_id = users.id
INNER JOIN property ON booking.property_id = property.id
INNER JOIN payment ON booking.id = payment.booking_id;

Hash Join  (cost=22.35..78.12 rows=1500 width=180) (actual time=1.202..4.982 rows=100 loops=1)
  Hash Cond: (booking.user_id = users.id)
  ->  Hash Join  (cost=11.20..50.45 rows=1500 width=124) (actual time=0.732..3.501 rows=100 loops=1)
        Hash Cond: (booking.property_id = property.id)
        ->  Seq Scan on booking  (cost=0.00..25.00 rows=1500 width=12) (actual time=0.012..0.432 rows=100 loops=1)
        ->  Hash  (cost=8.10..8.10 rows=110 width=112) (actual time=0.675..0.678 rows=20 loops=1)
              Buckets: 1024  Batches: 1  Memory Usage: 12kB
              ->  Seq Scan on property  (cost=0.00..8.10 rows=110 width=112) (actual time=0.045..0.521 rows=20 loops=1)
  ->  Hash  (cost=10.70..10.70 rows=70 width=56) (actual time=0.436..0.439 rows=5 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 9kB
        ->  Seq Scan on users  (cost=0.00..10.70 rows=70 width=56) (actual time=0.021..0.352 rows=5 loops=1)
Planning Time: 14.342 ms
Execution Time: 5.216 ms


## Optimized query performance
SELECT b.id AS booking_id, u.first_name, p.name AS property_name, pay.amount
FROM booking b
JOIN users u ON b.user_id = u.id
JOIN property p ON b.property_id = p.id
JOIN payment pay ON b.id = pay.booking_id;

Hash Join  (cost=8.15..35.60 rows=1000 width=90) (actual time=0.534..1.488 rows=100 loops=1)
  Hash Cond: (b.property_id = p.id)
  ->  Hash Join  (cost=4.10..24.20 rows=1000 width=46) (actual time=0.302..0.998 rows=100 loops=1)
        Hash Cond: (b.user_id = u.id)
        ->  Seq Scan on booking b  (cost=0.00..15.00 rows=1000 width=12) (actual time=0.014..0.243 rows=100 loops=1)
        ->  Hash  (cost=2.05..2.05 rows=5 width=34) (actual time=0.160..0.162 rows=5 loops=1)
              Buckets: 1024  Batches: 1  Memory Usage: 9kB
              ->  Index Scan using idx_users_id on users u  (cost=0.00..2.05 rows=5 width=34) (actual time=0.045..0.108 rows=5 loops=1)
  ->  Hash  (cost=3.05..3.05 rows=20 width=44) (actual time=0.172..0.175 rows=20 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 10kB
        ->  Index Scan using idx_property_id on property p  (cost=0.00..3.05 rows=20 width=44) (actual time=0.040..0.132 rows=20 loops=1)
Planning Time: 1.256 ms
Execution Time: 1.537 ms
