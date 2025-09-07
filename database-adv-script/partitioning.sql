CREATE TABLE booking_partitioned (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES property(id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id)
) PARTITION BY RANGE (start_date);

-- Partition for August 2025
CREATE TABLE booking_2025_08 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');

-- Partition for September 2025
CREATE TABLE booking_2025_09 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');

-- Insert sample data into partitions
INSERT INTO booking_partitioned (property_id, user_id, start_date, end_date, total_price, status)
VALUES
    (2, 3, '2025-08-02', '2025-08-06', 14500.00, 'confirmed'),
    (5, 2, '2025-08-12', '2025-08-14',  7800.00, 'pending'),
    (1, 4, '2025-08-25', '2025-08-29', 19800.00, 'cancelled'),
    (3, 1, '2025-09-04', '2025-09-07',  9200.00, 'confirmed'),
    (4, 5, '2025-09-15', '2025-09-20', 21000.00, 'pending');
