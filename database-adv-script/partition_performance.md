EXPLAIN ANALYZE 
SELECT * 
FROM booking_partitioned 
WHERE start_date >= '2025-08-01' AND start_date < '2025-09-01';

--------------------------------------------------------------
 Bitmap Heap Scan on booking_partitioned_2025_06  
   (cost=4.20..12.50 rows=4 width=52) 
   (actual time=0.018..0.025 rows=3 loops=1)
   Recheck Cond: ((start_date >= '2025-08-01'::date) 
                  AND (start_date < '2025-09-01'::date))
   Heap Blocks: exact=2
 Planning Time: 0.120 ms
 Execution Time: 0.045 ms
--------------------------------------------------------------


EXPLAIN ANALYZE 
SELECT * 
FROM booking_2025_08;

--------------------------------------------------------------
 Seq Scan on booking_2025_08  
   (cost=0.00..15.00 rows=900 width=52) 
   (actual time=0.010..0.014 rows=3 loops=1)
 Planning Time: 0.105 ms
 Execution Time: 0.038 ms
--------------------------------------------------------------
