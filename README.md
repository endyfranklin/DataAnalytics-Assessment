# DataAnalytics-Assessment

## Question 1 Explanation
- The query finds customers who have both funded savings and investment plans.

- It counts how many savings and investment plans each customer has.

- It sums the total amount deposited across all their plans.

- It returns customers with at least one savings and one investment plan, sorted by total deposits descending.

## Question 2 Explanation
- The innermost subquery counts transactions per customer per month.

- The middle query calculates the average monthly transactions per customer and categorizes them.

- The outer query aggregates customers by frequency category and computes the average transactions per category.

- DATE_FORMAT(transaction_date, '%Y-%m') groups transactions by month.

- The query segments customers into "High Frequency" (≥10), "Medium Frequency" (3-9), and "Low Frequency" (≤2) transaction groups.

- It outputs the count of customers per category and the average transactions per month for that category.

- The ordering ensures "High Frequency" appears first, followed by "Medium" and then "Low."

## Question 3 Explanation
- Active plans: Filtered by p.status_id = 1.

- Plan type: Determined by is_regular_savings (Savings) or is_a_fund (Investment).

- Last transaction date: The most recent transaction date from savings_savingsaccount for each plan.

- Inactivity days: Difference in days between current date (2025-05-18) and last transaction date.

- Filter: Only plans with no transactions (MAX(sa.transaction_date) IS NULL) or last transaction older than 365 days.

- Ordering: By inactivity days descending (longest inactive first).

## Question 4 Explanation
- TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) calculates tenure in months.

- COUNT(sa.id) counts total transactions per customer.

- AVG(sa.amount) calculates average transaction amount per customer.

- The formula applies the CLV estimation as requested.

- NULLIF(..., 0) prevents division by zero if tenure is zero.

- Results are ordered from highest to lowest estimated CLV.

# Challenges Encountered
The major challenges I encourderd was understanding the columns definition. It would be nice if a data dictionary was given, specifying
each column definitions for each table. How I solved this, i made some assumption. for example calculating the total deposits i had to use
the amount column. Also, if another challenge i encountered was understanding the relationships since there was no ERD provided. However,
I had to make use of the brief and read the tables with due dilligence.
