/*The innermost subquery counts transactions per customer per month.
The middle query calculates the average monthly transactions per customer and categorizes them.
The outer query aggregates customers by frequency category and computes the average transactions per category.*/
SELECT
    frequency_category,
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM (
    SELECT
        owner_id,
        AVG(transactions_count) AS avg_transactions_per_month,
        CASE
            WHEN AVG(transactions_count) >= 10 THEN 'High Frequency'
            WHEN AVG(transactions_count) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM (
        SELECT
            owner_id,
            DATE_FORMAT(transaction_date, '%Y-%m') AS 'year_month',
            COUNT(*) AS transactions_count
        FROM savings_savingsaccount
        GROUP BY 1, 2
    ) AS monthly_transactions
    GROUP BY owner_id
) AS customer_avg_transactions
GROUP BY frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
