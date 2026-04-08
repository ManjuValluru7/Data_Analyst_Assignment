-- ============================================
-- CLINIC MANAGEMENT SYSTEM - Schema & Sample Data
-- ============================================

CREATE TABLE clinics (
    cid          VARCHAR(50) PRIMARY KEY,
    clinic_name  VARCHAR(100),
    city         VARCHAR(100),
    state        VARCHAR(100),
    country      VARCHAR(100)
);

CREATE TABLE customer (
    uid     VARCHAR(50) PRIMARY KEY,
    name    VARCHAR(100),
    mobile  VARCHAR(20)
);

CREATE TABLE clinic_sales (
    oid          VARCHAR(50) PRIMARY KEY,
    uid          VARCHAR(50),
    cid          VARCHAR(50),
    amount       DECIMAL(10,2),
    datetime     DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid         VARCHAR(50) PRIMARY KEY,
    cid         VARCHAR(50),
    description VARCHAR(200),
    amount      DECIMAL(10,2),
    datetime    DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- ============================================
-- SAMPLE DATA
-- ============================================

INSERT INTO clinics VALUES
('cnc-0100001', 'Wellness Clinic',  'Mumbai',    'Maharashtra', 'India'),
('cnc-0100002', 'Care Clinic',      'Pune',      'Maharashtra', 'India'),
('cnc-0100003', 'LifeLine Clinic',  'Bangalore', 'Karnataka',   'India'),
('cnc-0100004', 'Health Hub',       'Mysore',    'Karnataka',   'India');

INSERT INTO customer VALUES
('cst-0001', 'Alice', '9800000001'),
('cst-0002', 'Bob',   '9800000002'),
('cst-0003', 'Carol', '9800000003'),
('cst-0004', 'Dave',  '9800000004');

INSERT INTO clinic_sales VALUES
('ord-001', 'cst-0001', 'cnc-0100001', 24999, '2021-01-10 10:00:00', 'online'),
('ord-002', 'cst-0002', 'cnc-0100001', 15000, '2021-02-15 11:00:00', 'walk-in'),
('ord-003', 'cst-0001', 'cnc-0100002', 8000,  '2021-03-20 09:00:00', 'online'),
('ord-004', 'cst-0003', 'cnc-0100002', 20000, '2021-04-25 14:00:00', 'referral'),
('ord-005', 'cst-0004', 'cnc-0100003', 30000, '2021-05-05 15:00:00', 'walk-in'),
('ord-006', 'cst-0002', 'cnc-0100003', 12000, '2021-06-10 16:00:00', 'online'),
('ord-007', 'cst-0001', 'cnc-0100004', 5000,  '2021-07-15 10:00:00', 'referral'),
('ord-008', 'cst-0003', 'cnc-0100001', 18000, '2021-08-20 11:00:00', 'walk-in'),
('ord-009', 'cst-0004', 'cnc-0100002', 22000, '2021-09-25 12:00:00', 'online'),
('ord-010', 'cst-0001', 'cnc-0100003', 9000,  '2021-10-01 13:00:00', 'referral'),
('ord-011', 'cst-0002', 'cnc-0100004', 11000, '2021-11-05 14:00:00', 'walk-in'),
('ord-012', 'cst-0003', 'cnc-0100001', 17000, '2021-12-10 15:00:00', 'online');

INSERT INTO expenses VALUES
('exp-001', 'cnc-0100001', 'first-aid supplies', 557,  '2021-01-05 07:00:00'),
('exp-002', 'cnc-0100001', 'staff salary',       8000, '2021-02-01 08:00:00'),
('exp-003', 'cnc-0100002', 'medicines',          3000, '2021-03-10 09:00:00'),
('exp-004', 'cnc-0100002', 'utilities',          1500, '2021-04-15 10:00:00'),
('exp-005', 'cnc-0100003', 'equipment',          5000, '2021-05-20 11:00:00'),
('exp-006', 'cnc-0100003', 'staff salary',       9000, '2021-06-01 12:00:00'),
('exp-007', 'cnc-0100004', 'rent',               4000, '2021-07-01 07:00:00'),
('exp-008', 'cnc-0100001', 'medicines',          2000, '2021-08-10 08:00:00'),
('exp-009', 'cnc-0100002', 'staff salary',       7000, '2021-09-01 09:00:00'),
('exp-010', 'cnc-0100003', 'utilities',          1000, '2021-10-10 10:00:00'),
('exp-011', 'cnc-0100004', 'medicines',          2500, '2021-11-05 11:00:00'),
('exp-012', 'cnc-0100001', 'equipment',          6000, '2021-12-01 12:00:00');
