-- List current indexes
\di
                       List of relations
 Schema |          Name           | Type  |  Owner  |  Table   
--------+-------------------------+-------+---------+----------
 public | booking_pkey            | index | patrick | booking
 public | idx_payment_id          | index | patrick | payment
 public | idx_user_email          | index | patrick | users
 public | idx_user_firstname      | index | patrick | users
 public | idx_property_booking_id | index | patrick | booking
 public | idx_property_title      | index | patrick | property
 public | message_pkey            | index | patrick | message
 public | payment_pkey            | index | patrick | payment
 public | property_pkey           | index | patrick | property
 public | review_pkey             | index | patrick | review
 public | users_email_key         | index | patrick | users
 public | users_pkey              | index | patrick | users

-- Enable pg_stat_statements to track performance
CREATE EXTENSION pg_stat_statements;

-- Check top 5 slowest queries (initial run)
SELECT query, calls, total_exec_time, rows, mean_exec_time 
FROM pg_stat_statements 
ORDER BY total_exec_time DESC 
LIMIT 5;

-- Example output before indexing
 query | calls | total_exec_time | rows | mean_exec_time 
-------+-------+-----------------+------+----------------
(0 rows)

-- Test query performance BEFORE new index
EXPLAIN ANALYZE 
SELECT b.id, u.first_name 
FROM booking b 
INNER JOIN users u 
ON b.user_id = u.id;

--BEFORE optimization
-----------------------------------------------------------------------------------------------------------
 Hash Join  (cost=1.05..2.30 rows=4 width=124) (actual time=0.220..0.236 rows=4 loops=1)
   Hash Cond: (b.user_id = u.id)
   ->  Seq Scan on booking b  (cost=0.00..1.04 rows=4 width=8) (actual time=0.052..0.056 rows=4 loops=1)
   ->  Hash  (cost=1.05..1.05 rows=5 width=122) (actual time=0.145..0.147 rows=5 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
         ->  Seq Scan on users u  (cost=0.00..1.05 rows=5 width=122) (actual time=0.112..0.118 rows=5 loops=1)
 Planning Time: 3.002 ms
 Execution Time: 0.420 ms
(8 rows)

-- Track query in pg_stat_statements
SELECT query, calls, total_exec_time, rows, mean_exec_time 
FROM pg_stat_statements 
ORDER BY total_exec_time DESC 
LIMIT 5;

                                                           query                                                            | calls |  total_exec_time   | rows |   mean_exec_time    
-----------------------------------------------------------------------------------------------------------------------------+-------+--------------------+------+---------------------
 EXPLAIN ANALYZE SELECT b.id, u.first_name FROM booking b INNER JOIN users u ON b.user_id = u.id                            |     1 |           3.928000 |    0 |            3.928000
 SELECT query, calls, total_exec_time, rows, mean_exec_time FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT $1  |     2 | 0.6801000000000001 |    2 | 0.34005000000000004
 SELECT b.id, u.first_name FROM booking b INNER JOIN users u ON b.user_id = u.id                                            |     1 |           0.130200 |    4 |            0.130200
(3 rows)

-- Remove an index to test performance degradation
DROP INDEX idx_user_email;

-- Check stats after drop
SELECT query, calls, total_exec_time, rows, mean_exec_time 
FROM pg_stat_statements 
ORDER BY total_exec_time DESC 
LIMIT 5;

                                                           query                                                            | calls |   total_exec_time   | rows |   mean_exec_time    
-----------------------------------------------------------------------------------------------------------------------------+-------+---------------------+------+---------------------
 EXPLAIN ANALYZE SELECT b.id, u.first_name FROM booking b INNER JOIN users u ON b.user_id = u.id                            |     1 |            3.928000 |    0 |            3.928000
 DROP INDEX idx_user_email                                                                                                  |     1 |            2.310000 |    0 |            2.310000
 SELECT query, calls, total_exec_time, rows, mean_exec_time FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT $1  |     3 |  0.9112000000000001 |    5 |            0.303733
 SELECT b.id, u.first_name FROM booking b INNER JOIN users u ON b.user_id = u.id                                            |     2 | 0.22510000000000002 |    8 | 0.11255000000000001
(4 rows)
