/* for this query, since we are looking for inactive accounts
within the past one year, i had to use curdate() to get the current date*/
SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(sa.transaction_date) AS last_transaction_date,
    DATEDIFF(curdate(), MAX(sa.transaction_date)) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount sa ON sa.plan_id = p.id
WHERE p.status_id = 1  -- assuming status_id=1 means active plan
GROUP BY p.id, p.owner_id, type
HAVING (MAX(sa.transaction_date) IS NULL OR MAX(sa.transaction_date) < DATE_SUB(curdate(), INTERVAL 365 DAY))
ORDER BY inactivity_days DESC;
