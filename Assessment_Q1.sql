SELECT
    u.id AS owner_id,
    concat(u.first_name,' ', u.last_name) as name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 AND p.amount > 0 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 AND p.amount > 0 THEN p.id END) AS investment_count,
    round(IFNULL(SUM(p.amount)/100.0, 0),2) AS total_deposits
FROM users_customuser u
JOIN plans_plan p ON u.id = p.owner_id
LEFT JOIN savings_savingsaccount sa ON sa.plan_id = u.id
WHERE p.amount > 0
GROUP BY u.id, u.first_name, u.last_name
HAVING 
    savings_count > 0
    AND investment_count > 0
ORDER BY total_deposits DESC;
