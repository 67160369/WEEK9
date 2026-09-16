-- Bonus A2 (extended.db): AOV per month, plus the whole-period AOV and the
-- (different) unweighted average of the monthly AOVs.
-- AOV is non-additive: the correct whole-period value is
--   SUM(amount) / COUNT(DISTINCT order_id) over the whole period,
-- NOT the plain average of the monthly AOVs.
WITH m AS (
    SELECT month,
           SUM(amount)                                 AS revenue,
           COUNT(DISTINCT order_id)                    AS orders,
           SUM(amount) * 1.0 / COUNT(DISTINCT order_id) AS aov
    FROM sales
    GROUP BY month
)
SELECT period, revenue, orders, aov_month
FROM (
    SELECT month AS period, revenue, orders, ROUND(aov, 2) AS aov_month, 0 AS sort_key
    FROM m
    UNION ALL
    SELECT 'ALL (weighted, correct)',
           SUM(amount),
           COUNT(DISTINCT order_id),
           ROUND(SUM(amount) * 1.0 / COUNT(DISTINCT order_id), 2),
           1
    FROM sales
    UNION ALL
    SELECT 'AVG of monthly AOV (unweighted, wrong)',
           NULL,
           NULL,
           ROUND(AVG(aov), 2),
           2
    FROM m
)
ORDER BY sort_key, period;
