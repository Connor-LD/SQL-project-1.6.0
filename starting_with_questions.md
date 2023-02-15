-- **Question 1: Which cities and countries have the highest level of transaction revenues on the site?**
-- SQL Queries:
-- Solution 1: effective CTE, easily extensible
-- SELECT city, country,
-- 	SUM(total_transaction_revenue) as total_revenue,
-- 	RANK() OVER (ORDER BY SUM(total_transaction_revenue) DESC NULLS LAST) as rank
-- 	FROM all_sessions
-- 	GROUP BY city, country
-- ORDER BY rank, city, country
-- LIMIT 1;

-- Solution 2: efficient windows, valid if two answers are tied for top ranking
-- SELECT city, country, total_rev FROM (
-- 	SELECT city, country, SUM(total_transaction_revenue) as total_rev, rank() over (ORDER BY SUM(total_transaction_revenue) DESC NULLS LAST) rank
--         	FROM all_sessions
-- 		GROUP BY city, country
-- 	) as ranked
-- 	WHERE rank = 1;

-- Answer:
-- The highest level of transaction revenues (assuming total_transaction_revenue = transaction revenues) is $6,092.56 from '(not set)' in the United States; the highest transaction revenue from a known city is $1,564.32 from San Francisco, United States.
-- QA Note: Accuracy of this result will be poor.  table: sales_report documents 454 sales, whereas all_sessions only documents 81. However, all_sessions is the only table that contains the city/country data and there is no known way to accurately join the two tables.
-- Solution Note:  This method was preferred because the top answer is not meaningful (i.e. not set). Rank included. for ease of use. Alternative, more efficient solution would be using window functions instead of CTE.





-- **Question 2: What is the average number of products ordered from visitors in each city and country?**
-- SQL Queries:
-- SELECT city, country,
-- 	ROUND(AVG(product_quantity),2),
-- 	RANK() OVER (ORDER BY AVG(product_quantity) DESC NULLS LAST) as rank
-- 	FROM all_sessions
-- 	GROUP BY city, country
-- ORDER BY rank, city, country;   

-- Answer:
-- Solution: Madrid, Spain has the highest average number of products per order out of all city,country pairs, with 10.
-- QA Note: Average number of products per visitor is not possible since we cannot identify individual visitors; average number of products per city, country has been used instead





-- **Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**
-- SQL Queries:
-- SELECT DISTINCT v_2_product_category, city, country,
-- 	SUM(total_transaction_revenue) as total_revenue
-- 	RANK() OVER (ORDER BY SUM(total_transaction_revenue) DESC NULLS LAST) as rank
-- 	FROM all_sessions
-- 	WHERE city != '(not set)' AND  v_2_product_category NOT IN ('(not set)','${escCatTitle}')
-- 	GROUP BY v_2_product_category, city, country
-- ORDER BY rank, v_2_product_category, city, country;

-- Answer:
-- Criticism: Question is unclear because there is no documentation for teh dataset nor expectation for what a valuable pattern would be. 
-- QA Note: We know that the all_sessions table only has 81 orders out of ~1000 found in other, unjoinable tables. Making our result significantly unreliable.
-- Solution: Nevertheless, by visual inspection, the above query demonstrates that the highest grossing product category for city,country tuples include 'Nest USA' 





-- **Question 4: What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?**
-- SQL Queries:
-- SELECT DISTINCT v_2_product_name, city, country,
-- 	SUM(total_transaction_revenue) as total_revenue,
-- 	RANK() OVER (ORDER BY SUM(total_transaction_revenue) DESC NULLS LAST) as rank
-- 	FROM all_sessions
-- 	GROUP BY v_2_product_name, city, country
-- ORDER BY rank, v_2_product_name, city, country;

-- Answer:
-- Solution: The highest grossing product by total revenue is 'Reusable Shopping Bag'





-- **Question 5: Can we summarize the impact of revenue generated from each city/country?**
-- SQL Queries:
-- Solution - Part 1: Summary stats by city, country
-- SELECT city, country,
-- 	SUM(total_transaction_revenue) as total_rev,
-- 	COUNT(total_transaction_revenue) as number_of_orders,
-- 	MIN(total_transaction_revenue) as min_revenue,
-- 	MAX(total_transaction_revenue) as max_revenue,
-- 	RANK() OVER (ORDER BY SUM(total_transaction_revenue) DESC NULLS LAST) as rank
-- 	FROM all_sessions
-- 	GROUP BY city, country
-- ORDER BY rank, city, country;
-- Solution - Part 2: Most have no sales
-- SELECT city, country,
-- 	COUNT(total_transaction_revenue) as number_of_orders
-- 	FROM all_sessions
-- 	WHERE total_transaction_revenue IS NULL
-- 	GROUP BY city, country
-- ORDER BY city, country;

-- Answer:
-- Solution: 415 of 436 city,country tuples have no sales. So most city,countries have no impact on revenue. 
-- Further, Part 1 highlights that the majority of sales are in the United States, which represent 10 of the top 11 city,country tuples.
