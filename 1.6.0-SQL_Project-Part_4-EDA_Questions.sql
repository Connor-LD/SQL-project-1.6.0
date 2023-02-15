-- In the **starting_with_data.md** file, write 3 - 5 new questions that you could answer with this database. 
-- Consider the data you have available to you.  You can use the data to:
--     - find all duplicate records  ##Done in Part 2: Data clean
--     - find the total number of unique visitors (`fullVisitorID`)  ## Trivial
--     - find the total number of unique visitors by referring sites
--     - find each unique product viewed by each visitor
--     - compute the percentage of visitors to the site that actually makes a purchase


-- **Question 1:  Imbuing sales_report table to find total sales and ranked sales by product
-- SQL Queries:
-- SELECT 'total sales',
-- 	SUM(sales_report.total_ordered * all_sessions.product_price) as total,
-- 	RANK() OVER (ORDER BY SUM(sales_report.total_ordered * all_sessions.product_price) DESC NULLS LAST) as rank
--  	FROM sales_report                
--         	INNER JOIN all_sessions 
-- 				On sales_report.product_sku=all_sessions.product_sku
-- UNION
-- SELECT sales_report.name,
-- 	SUM(sales_report.total_ordered * all_sessions.product_price) as total,
-- 	RANK() OVER (ORDER BY SUM(sales_report.total_ordered * all_sessions.product_price) DESC NULLS LAST) as rank
--  	FROM sales_report                
--         	INNER JOIN all_sessions 
-- 				On sales_report.product_sku=all_sessions.product_sku
-- 	GROUP BY sales_report.name
-- ORDER BY total DESC; 

-- Answer:
-- This query provides much more accurate reflection of total sales and sales by product name 





-- **Question 2: Number of unique visitors vs number of unique visitors who made purchases
-- SQL Queries:
-- SELECT 'number of unique visitors', COUNT(DISTINCT full_visitor_id) FROM all_sessions
-- UNION
-- SELECT 'number of unique visitors with purchase', COUNT(DISTINCT full_visitor_id) FROM all_sessions WHERE total_transaction_revenue IS NOT NULL

-- Answer:
-- 80 over 14223, unable to express as a percentage using psql, but it is 0.56%




-- **Question 3:  Get unique visits per month
-- SQL Queries:
-- Part 1: find date range
-- SELECT MIN(date),MAX(date) FROM all_sessions LIMIT 100;
-- Part 2:  find unique visitors by month
-- SELECT 	dategen.date,
-- 	(
-- 		SELECT COUNT(DISTINCT full_visitor_id) 
-- 		FROM all_sessions 
-- 		WHERE date > date - interval '1 month'
-- 			and date < dategen.date + interval '1 month'
-- 	) as visitor_count
-- 	FROM
-- 	(	-- generates a list of days in august
-- 		SELECT 	CAST(generate_series(timestamp '2016-08-01',
-- 			'2017-08-01','1 month') as date) as date
-- 	)  as dategen
-- ORDER BY dategen.date;
-- Answer:
-- Looks like web traffic is growing!




-- **Question 4:  Find most fruitful referral sources
-- SQL Queries:
-- SELECT channel_grouping,
-- 	COUNT(DISTINCT full_visitor_id) as unique_visitors,
-- 	RANK() OVER (ORDER BY COUNT(DISTINCT full_visitor_id) DESC NULLS LAST) as rank
-- 	FROM all_sessions
-- 	GROUP BY channel_grouping
-- ORDER BY rank, channel_grouping

-- Answer:
-- The majority of the ecommerce site's unique visitors come from 'Organic Search' (8207 of 14223, 5.77%)