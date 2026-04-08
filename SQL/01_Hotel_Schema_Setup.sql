-- ============================================
-- HOTEL MANAGEMENT SYSTEM - Schema & Sample Data
-- ============================================

CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address TEXT
);

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- ============================================
-- SAMPLE DATA
-- ============================================

INSERT INTO users VALUES
('21wrcxuy-67erfn', 'John Doe',   '9700000001', 'john.doe@example.com',  '10, Street A, City X'),
('32xsdtyv-78fgop', 'Jane Smith', '9700000002', 'jane.smith@example.com','20, Street B, City Y'),
('43yteuzw-89ghpq', 'Bob Brown',  '9700000003', 'bob.brown@example.com', '30, Street C, City Z');

INSERT INTO items VALUES
('itm-a9e8-q8fu',  'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg',      89),
('itm-w978-23u4',  'Dal Fry',      75),
('itm-b123-cd45',  'Butter Naan',  30),
('itm-e567-fg89',  'Paneer Tikka', 150);

INSERT INTO bookings VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-10g4f-06ik', '2021-10-05 09:00:00', 'rm-cig0-bfskn', '32xsdtyv-78fgop'),
('bk-11h5g-17jl', '2021-10-15 10:00:00', 'rm-djh1-cgtkn', '43yteuzw-89ghpq'),
('bk-12i6h-28km', '2021-11-02 11:00:00', 'rm-eki2-dhuln', '21wrcxuy-67erfn'),
('bk-13j7i-39ln', '2021-11-18 12:00:00', 'rm-flj3-eivmn', '32xsdtyv-78fgop'),
('bk-14k8j-40mo', '2021-12-01 08:00:00', 'rm-gmk4-fjwno', '43yteuzw-89ghpq');

INSERT INTO booking_commercials VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu',  3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4','bk-10g4f-06ik', 'bl-34qhd-r7h8', '2021-10-05 12:05:37', 'itm-w978-23u4',  2),
('234ms-pzgo9-4rl5','bk-10g4f-06ik', 'bl-34qhd-r7h8', '2021-10-05 12:05:37', 'itm-b123-cd45',  3),
('334nt-qahi0-5sm6','bk-11h5g-17jl', 'bl-45rie-s8i9', '2021-10-15 13:00:00', 'itm-e567-fg89',  2),
('434ou-rbij1-6tn7','bk-11h5g-17jl', 'bl-45rie-s8i9', '2021-10-15 13:00:00', 'itm-a9e8-q8fu',  5),
('534pv-scjk2-7uo8','bk-12i6h-28km', 'bl-56sjf-t9j0', '2021-11-02 14:00:00', 'itm-a07vh-aer8', 4),
('634qw-tdkl3-8vp9','bk-12i6h-28km', 'bl-56sjf-t9j0', '2021-11-02 14:00:00', 'itm-w978-23u4',  3),
('734rx-uelm4-9wq0','bk-13j7i-39ln', 'bl-67tkg-u0k1', '2021-11-18 15:00:00', 'itm-b123-cd45',  6),
('834sy-vfmn5-0xr1','bk-13j7i-39ln', 'bl-67tkg-u0k1', '2021-11-18 15:00:00', 'itm-e567-fg89',  3),
('934tz-wgno6-1ys2','bk-14k8j-40mo', 'bl-78ulh-v1l2', '2021-12-01 16:00:00', 'itm-a9e8-q8fu',  10),
('034ua-xhop7-2zt3','bk-14k8j-40mo', 'bl-78ulh-v1l2', '2021-12-01 16:00:00', 'itm-e567-fg89',  2);
