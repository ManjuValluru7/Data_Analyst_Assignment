-- ============================================
-- CLINIC MANAGEMENT SYSTEM - Queries (Part B)
-- ============================================

-- Q1: Revenue from each sales channel in a given year
-- Replace 2021 with desired year

SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- ============================================

-- Q2: Top 10 most valuable customers for a given year
-- Logic: Sum total amount spent per customer, rank and limit to 10

SELECT
    c.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY c.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;

-- ============================================

-- Q3: Month-wise revenue, expense, profit, and status for a given year
-- Logic: Aggregate revenue and expenses separately by month, then join and calculate profit

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY DATE_FORMAT(datetime, '%Y-%m')
),
monthly_expense AS (
    SELECT
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY DATE_FORMAT(datetime, '%Y-%m')
)
SELECT
    COALESCE(r.month, e.month)                     AS month,
    COALESCE(r.total_revenue, 0)                   AS revenue,
    COALESCE(e.total_expense, 0)                   AS expense,
    COALESCE(r.total_revenue, 0) - COALESCE(e.total_expense, 0) AS profit,
    CASE
        WHEN COALESCE(r.total_revenue, 0) - COALESCE(e.total_expense, 0) > 0
        THEN 'Profitable'
        ELSE 'Not-Profitable'
    END AS status
FROM monthly_revenue r
LEFT JOIN monthly_expense e ON r.month = e.month
ORDER BY month;

-- ============================================

-- Q4: For each city, find the most profitable clinic for a given month
-- Logic: Calculate profit per clinic per month, rank within city, return rank = 1

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        DATE_FORMAT(cs.datetime, '%Y-%m') AS month,
        SUM(cs.amount) AS revenue
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY cl.cid, cl.clinic_name, cl.city, DATE_FORMAT(cs.datetime, '%Y-%m')
),
expense_summary AS (
    SELECT
        cid,
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, DATE_FORMAT(datetime, '%Y-%m')
),
profit_summary AS (
    SELECT
        cp.cid,
        cp.clinic_name,
        cp.city,
        cp.month,
        cp.revenue - COALESCE(es.total_expense, 0) AS profit
    FROM clinic_profit cp
    LEFT JOIN expense_summary es ON cp.cid = es.cid AND cp.month = es.month
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY city, month ORDER BY profit DESC) AS rnk
    FROM profit_summary
)
SELECT city, month, clinic_name, profit AS highest_profit
FROM ranked
WHERE rnk = 1
ORDER BY city, month;

-- ============================================

-- Q5: For each state, find the second least profitable clinic for a given month
-- Logic: Same as Q4 but rank ASC and return rank = 2

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.state,
        DATE_FORMAT(cs.datetime, '%Y-%m') AS month,
        SUM(cs.amount) AS revenue
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY cl.cid, cl.clinic_name, cl.state, DATE_FORMAT(cs.datetime, '%Y-%m')
),
expense_summary AS (
    SELECT
        cid,
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, DATE_FORMAT(datetime, '%Y-%m')
),
profit_summary AS (
    SELECT
        cp.cid,
        cp.clinic_name,
        cp.state,
        cp.month,
        cp.revenue - COALESCE(es.total_expense, 0) AS profit
    FROM clinic_profit cp
    LEFT JOIN expense_summary es ON cp.cid = es.cid AND cp.month = es.month
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY state, month ORDER BY profit ASC) AS rnk
    FROM profit_summary
)
SELECT state, month, clinic_name, profit AS second_least_profit
FROM ranked
WHERE rnk = 2
ORDER BY state, month;
