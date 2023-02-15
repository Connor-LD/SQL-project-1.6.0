Question 1: What issues will you address by cleaning the data?

Answer 1:
The data has multiple issues with its structure, NULL columns, NULL values that can be imbued, duplicate records, poor keying, incorrect pricing (/1,000,000). 




Qiuestion 2: Below, provide the SQL queries you used to clean your data.


-- products

-- [initial look at data 1092 records]
-- Select * FROM products

-- [check for primary key]
-- SELECT sku,COUNT(sku) 
-- 	FROM products
-- 	GROUP BY sku
-- 	HAVING COUNT(sku)>1
-- 	ORDER BY sku;
-- [RESULT: sku is unique and distinct, suitable primary key]

-- [assign primary key to sku]
-- ALTER TABLE products ADD PRIMARY KEY (sku);
-- [done]

-- [The products table seems to duplicate sales data that is more appropriately kept in the sales_report table (assume the data is actually duplicate)]
-- ALTER TABLE products
-- DROP COLUMN ordered_quantity,
-- DROP COLUMN stock_level,
-- DROP COLUMN restocking_lead_time,
-- DROP COLUMN sentiment_score,
-- DROP COLUMN sentiment_magnitude;

-- [Done: data appears clean]






-- sales_by_sku

-- [initial look at data 462 records]
-- Select Count(*) FROM sales_by_sku

-- [check primary key]
-- SELECT product_sku,COUNT(product_sku) 
-- 	FROM sales_by_sku
-- 	GROUP BY product_sku
-- 	HAVING COUNT(product_sku)>1
-- 	ORDER BY product_sku;
-- [RESULT: product_sku is unique and distinct,suitable as primary key]

-- [this table looks like it is already contained within table.products. Let's check]
-- SELECT *
-- 	FROM sales_by_sku s
-- 	INNER JOIN products p
-- 		ON s.product_sku=p.sku
-- [tables are different, 8 new SKUs & total ordered is different deciding not to remove]

-- [Done: data appears clean]





-- sales_report

-- [initial look at data 454 records]
-- Select * FROM sales_report

-- [check primary key]
-- SELECT product_sku,COUNT(product_sku) 
-- 	FROM sales_report
-- 	GROUP BY product_sku
-- 	HAVING COUNT(product_sku)>1
-- 	ORDER BY product_sku;
-- [RESULT: product_sku is unique and distinct,suitable as primary key]

-- [assign primary key to sku]
-- ALTER TABLE sales_report ADD PRIMARY KEY (product_sku);
-- [done]

-- [this table looks similar to table: sales_by_sku. Let's check]
-- SELECT *
-- 	FROM sales_by_sku sbs
-- 	FULL OUTER JOIN sales_report sr
-- 		ON sbs.product_sku=sr.product_sku
-- 	WHERE sbs.product_sku IS NULL OR sr.product_sku IS NULL
-- [tables are different, 8 new SKUs, but with no additional information.]

-- [Options: depending on the business context I can:
-- 1. Union the two tables, inputting the missing data as NULL
-- 2. DROP the sales_by_sku
-- 3. DROP product_skus with 0 total orders, as these seem materially different from the other SKU codes
-- 4. DROP the total ordered from the sales_report to move towards 1st normal form]

-- [compare products and sales_report tables: sales_report is 638 records larger and contains all records from products]
-- SELECT *
-- 	FROM products p
-- 	FULL OUTER JOIN sales_report sr
-- 		ON p.sku=sr.product_sku
-- 	WHERE p.sku IS NULL OR sr.product_sku IS NULL

-- [Done: data appears clean]





-- analytics

-- [initial look at data, 4.3M records]
-- Select COUNT(*) FROM analytics
-- SELECT * FROM analytics LIMIT 100

-- [check for primary key]
-- SELECT visitid,COUNT(visitid) 
-- 	FROM analytics
-- 	GROUP BY visitid
-- 	HAVING COUNT(visitid)>1
-- 	ORDER BY visitid;
-- [RESULT: There doesn't appear to be a suitable primary key; many visitids are duplicate and later columns have different values for the same visitid.


-- [Next Step: Alter Table to include auto-generated primary key]
-- ALTER TABLE analytics ADD COLUMN ID SERIAL PRIMARY KEY;
-- [done]

-- [Review Columns]
-- [Visitstartime looks identical to visit id]
-- SELECT * FROM analytics WHERE visitid!=visitstarttime OR visitstarttime is NULL;
-- [columns not identical, 39k records are different; reluctant to remove]


-- [fix unit_price]
-- [rough work]SELECT CAST(unit_price as money) / 1000000.00 FROM analytics
-- ALTER TABLE analytics
-- ALTER COLUMN unit_price TYPE money USING CAST(unit_price as money) / 1000000.00
-- [done]
	

-- [fix date type]
-- ALTER TABLE analytics
-- ALTER COLUMN date TYPE date USING TO_DATE(date, 'YYYYMMDD')
-- [done]

-- [table appears to have multiple duplicate records, with matching values in each column aside from some unit_prices.]
-- [Deduplicate records, assuming that identical meanings ]
-- DELETE FROM analytics
-- WHERE fullvisitorid IN
--     (SELECT fullvisitorid
--     FROM 
--         (SELECT fullvisitorid,
--          ROW_NUMBER() OVER( PARTITION BY visitnumber,visitid,date,fullvisitorid,channelgrouping,socialengagementtype,pageviews,timeonsite,unit_price
--         ORDER BY  fullvisitorid) AS row_num
--         FROM analytics) t
--         WHERE t.row_num > 1);
-- [done]

-- [check for null columns, userid, units sold,bounces,revenue]
-- SELECT userid
-- 	FROM analytics
-- 	WHERE userid != NULL
	
-- SELECT units_sold
-- 	FROM analytics
-- 	WHERE units_sold != NULL

-- SELECT bounces
-- 	FROM analytics
-- 	WHERE bounces != NULL

-- SELECT revenue
-- 	FROM analytics
-- 	WHERE revenue != NULL

-- [all 4 columns (userid, units sold,bounces,revenue) are completely empty/NULL]
-- ALTER TABLE analytics
-- DROP COLUMN userid,
-- DROP COLUMN units_sold,
-- DROP COLUMN bounces,
-- DROP COLUMN revenue;





-- all sessions

-- [initial look at data 15,134 records]
-- SELECT * FROM all_sessions WHERE total_transaction_revenue IS NOT NULL
-- SELECT Count(*) FROM all_sessions

-- [recast data type for product_quantity to int and product_price, product_revenue, transaction_revenue,total_transaction_revenue to money]
-- ALTER TABLE all_sessions
-- ALTER COLUMN product_price TYPE money USING CAST(product_price as money) / 1000000.00,
-- ALTER COLUMN product_revenue TYPE money USING CAST(product_revenue as money) / 1000000.00,
-- ALTER COLUMN transaction_revenue TYPE money USING CAST(transaction_revenue as money) / 1000000.00,
-- ALTER COLUMN total_transaction_revenue TYPE money USING CAST(total_transaction_revenue as money) / 1000000.00
-- ALTER COLUMN product_quantity TYPE INT USING product_quantity::integer
-- [done]


-- [fix currency_code]
-- SELECT COUNT(currency_code)
-- 	FROM all_sessions 
-- 	WHERE currency_code != 'USD'
-- 		AND currency_code IS NOT NULL;
-- [Shows currency code is always USD or blank, can drop or imbue.  Since drop was used before, here is how to imbue]
-- ALTER TABLE all_sessions
-- ALTER COLUMN currency_code TYPE CHAR(3) USING COALESCE(currency_code,'USD')
-- [check]
-- SELECT COUNT(currency_code)
-- 	FROM all_sessions 
-- 	WHERE currency_code != 'USD'
-- 		AND currency_code IS NOT NULL;
-- [done, result = 0]


-- [check city, country not set - not available in demo set similarity]
-- SELECT country, COUNT(country)
-- 	FROM all_sessions
-- 	GROUP BY country
-- 	ORDER BY COUNT(country) DESC
-- 	[country only has 1 value for NULL, '(not set)']
-- SELECT TRIM(city), COUNT(TRIM(city))
-- 	FROM all_sessions
-- 	GROUP BY TRIM(city)
-- 	ORDER BY COUNT(TRIM(city)) DESC
-- [similarity between '(not set)' (354) and 'not available in demo dataset' (8302)]
-- [This accounts for 8656 of 15134 records, 57.2% of city data, which can be mostly but not accurately inferred as inside the USA based on the COUNT(country) query above, where 8727 records belong inside the USA.)]
-- [Fix city not set ambiguity; chosen to replace 'not available in demo dataset' with '(not set)' for similarity with country data values]
-- UPDATE 
--    all_sessions
-- SET 
--    city = REPLACE(city,'not available in demo dataset','(not set)')
-- WHERE 
--    city = 'not available in demo dataset'
-- [done]


-- [Decidided not to remove duplciate rows due to lack of documentation/context, but this could be how ]
-- DELETE FROM all_sessions
-- WHERE full_visitor_id IN
--     (SELECT full_visitor_id
--     FROM 
--         (SELECT full_visitor_id,
--          ROW_NUMBER() OVER( PARTITION BY channel_grouping,time,country,city,time_on_site,pageviews,date,visit_id,product_price,product_sku,page_title
--         ORDER BY  full_visitor_id) AS row_num
--         FROM all_sessions) t
--         WHERE t.row_num > 1);


-- [check for primary key]
-- SELECT full_visitor_id,COUNT(full_visitor_id) 
-- 	FROM all_sessions
-- 	GROUP BY full_visitor_id
-- 	HAVING COUNT(full_visitor_id)>1
-- 	ORDER BY full_visitor_id;
-- [RESULT: 794 duplicate records, not yet suitable as primary key]
-- SELECT *
-- 	FROM all_sessions
-- 	WHERE full_visitor_id = '0046188572569359609' OR full_visitor_id = '0070429642460956401';
-- [This shows that the same full_visitor_id # can contain different data, such as unit_price. Not suitable for primary key]
-- ALTER TABLE all_sessions ADD COLUMN session_id SERIAL PRIMARY KEY;
-- [done]