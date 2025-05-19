SELECT
    u.id AS customer_id,
    concat(u.first_name,' ', u.last_name) as name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months, -- calculates tenure in months from the current date
    COUNT(sa.id) AS total_transactions,
    ROUND(
        (COUNT(sa.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * AVG(sa.amount) * 0.001,
        2
    ) AS estimated_clv
FROM users_customuser u
LEFT JOIN savings_savingsaccount sa ON sa.owner_id = u.id
GROUP BY 1, 2, 3
ORDER BY estimated_clv DESC;
