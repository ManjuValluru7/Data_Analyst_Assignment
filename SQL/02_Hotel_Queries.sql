-- ============================================
-- HOTEL MANAGEMENT SYSTEM - Queries (Part A)
-- ============================================

-- Q1: For every user, get user_id and last booked room_no
-- Logic: For each user, find the booking with the maximum (latest) booking_date

SELECT
    u.user_id,
    b.room_no AS last_booked_room
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(b2.booking_date)
    FROM bookings b2
    WHERE b2.user_id = u.user_id
);

-- ============================================

-- Q2: Get booking_id and total billing amount for every booking in November 2021
-- Logic: Join bookings -> booking_commercials -> items, filter by Nov 2021, sum (quantity * rate)

SELECT
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(bc.bill_date, '%Y-%m') = '2021-11'
GROUP BY bc.booking_id;

-- ============================================

-- Q3: Get bill_id and bill amount of all bills in October 2021 with amount > 1000
-- Logic: Group by bill_id, filter month = Oct 2021, use HAVING to filter sum > 1000

SELECT
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(bc.bill_date, '%Y-%m') = '2021-10'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-- ============================================

-- Q4: Most ordered and least ordered item of each month in 2021
-- Logic: Aggregate quantity per month per item, then use RANK() to find top and bottom

WITH monthly_item_orders AS (
    SELECT
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS order_month,
        i.item_name,
        SUM(bc.item_quantity) AS total_quantity
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY DATE_FORMAT(bc.bill_date, '%Y-%m'), i.item_name
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY order_month ORDER BY total_quantity DESC) AS rank_desc,
        RANK() OVER (PARTITION BY order_month ORDER BY total_quantity ASC)  AS rank_asc
    FROM monthly_item_orders
)
SELECT
    order_month,
    MAX(CASE WHEN rank_desc = 1 THEN item_name END) AS most_ordered_item,
    MAX(CASE WHEN rank_asc  = 1 THEN item_name END) AS least_ordered_item
FROM ranked
GROUP BY order_month
ORDER BY order_month;

-- ============================================

-- Q5: Customers with the 2nd highest bill value of each month in 2021
-- Logic: Sum bills per customer per month, rank them, return rank = 2

WITH monthly_bills AS (
    SELECT
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS bill_month,
        b.user_id,
        u.name AS customer_name,
        SUM(bc.item_quantity * i.item_rate) AS total_bill
    FROM booking_commercials bc
    JOIN bookings b  ON bc.booking_id = b.booking_id
    JOIN users u     ON b.user_id = u.user_id
    JOIN items i     ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY DATE_FORMAT(bc.bill_date, '%Y-%m'), b.user_id, u.name
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY bill_month ORDER BY total_bill DESC) AS rnk
    FROM monthly_bills
)
SELECT
    bill_month,
    user_id,
    customer_name,
    total_bill AS second_highest_bill
FROM ranked
WHERE rnk = 2
ORDER BY bill_month;
