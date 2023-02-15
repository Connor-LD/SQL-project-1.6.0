-- CREATE TABLE sales_by_sku (
--   	product_sku VARCHAR(20) PRIMARY KEY,
-- 	total_ordered INT
-- )

-- \copy sales_by_sku(product_sku,total_ordered)
-- FROM '/Users/connorl/Downloads/LHL-Week1-SQL/1.6.0-SQL-Project/sales_by_sku.csv'
-- DELIMITER ','
-- CSV HEADER;

-- CREATE TABLE analytics (
-- 	visitNumber VARCHAR(255),
-- 	visitId VARCHAR(255),
-- 	visitStartTime VARCHAR(255),
-- 	date VARCHAR(255),
-- 	fullvisitorId VARCHAR(255),
-- 	userid VARCHAR(255),
-- 	channelGrouping VARCHAR(255),
-- 	socialEngagementType VARCHAR(255),
-- 	units_sold VARCHAR(255),
-- 	pageviews VARCHAR(255),
-- 	timeonsite VARCHAR(255),
-- 	bounces VARCHAR(255),
-- 	revenue VARCHAR(255),
-- 	unit_price VARCHAR(255)
-- )

-- CREATE TABLE all_sessions (
-- 	fullVisitorId VARCHAR(255),
-- 	channelGrouping VARCHAR(255),
-- 	time VARCHAR(255),
-- 	country VARCHAR(255),
-- 	city VARCHAR(255),
-- 	totalTransactionRevenue VARCHAR(255),
-- 	transactions VARCHAR(255),
-- 	timeOnSite VARCHAR(255),
-- 	pageviews VARCHAR(255),
-- 	sessionQualityDim VARCHAR(255),
-- 	date VARCHAR(255),
-- 	visitId VARCHAR(255),
-- 	type VARCHAR(255),
-- 	productRefundAmount VARCHAR(255),
-- 	productQuantity VARCHAR(255),
-- 	productPrice VARCHAR(255),
-- 	productRevenue VARCHAR(255),
-- 	productSKU VARCHAR(255),
-- 	v2ProductName VARCHAR(255),
-- 	v2ProductCategory VARCHAR(255),
-- 	productVariant VARCHAR(255),
-- 	currencyCode VARCHAR(255),
-- 	itemQuantity VARCHAR(255),
-- 	itemRevenue VARCHAR(255),
-- 	transactionRevenue VARCHAR(255),
-- 	transactionId VARCHAR(255),
-- 	pageTitle VARCHAR(255),
-- 	searchKeyword VARCHAR(255),
-- 	pagePathLevel1 VARCHAR(255),
-- 	eCommerceAction_type VARCHAR(255),
-- 	eCommerceAction_step VARCHAR(255),
-- 	eCommerceAction_option VARCHAR(255)
-- );

-- CREATE TABLE products (
-- 	sku VARCHAR(255),
-- 	name VARCHAR(255),
-- 	ordered_quantity INT,
-- 	stock_level INT,
-- 	restocking_lead_time INT,
-- 	sentiment_score decimal(2,1),
-- 	sentiment_magnitude decimal(2,1)
-- );

-- CREATE TABLE sales_report (
-- 	product_sku VARCHAR(255),
-- 	total_ordered INT,
-- 	name VARCHAR(255),
-- 	stock_level INT,
-- 	restocking_lead_time INT,
-- 	sentiment_score decimal(2,1),
-- 	sentiment_magnitude decimal (2,1),
-- 	ratio decimal (22,21)
-- )

CREATE TABLE all_sessions (
  	full_visitor_id VARCHAR(255),
	channel_grouping VARCHAR(255),
	time INT,
	country VARCHAR(255),
	city VARCHAR(255),
	total_transaction_revenue BIGINT,
	transactions INT,
	time_on_site INT,
	page_views INT,
	session_quality_dim INT,
	date VARCHAR(10),
	visit_id VARCHAR(20),
	type VARCHAR(10),
	product_refund_amount VARCHAR(100),
	product_quantity INT,
	product_price INT,
	product_revenue VARCHAR(100),
	product_sku VARCHAR(100),
	v2_product_name VARCHAR(255),
	v2_product_category VARCHAR(255),
	product_variant VARCHAR(100),
	currency_code VARCHAR(4),
	item_quantity VARCHAR(100),
	item_revenue VARCHAR(100),
	transaction_revenue INT,
	transaction_id VARCHAR(100),
	page_title VARCHAR(1024),
	search_keyword VARCHAR(100),
	page_path_level_1 VARCHAR(100),
	ecommerce_action_type INT,
	ecommerce_action_step INT,
	ecommerce_action_option VARCHAR(100)
);
