# Final-Project-Transforming-and-Analyzing-Data-with-SQL

## Project/Goals
The goal is to gain familiarity, understanding, and insight with the ecommerce dataset (5 tables) while demonstrating various SQL techniques and functions.
The data has poor documentation, quality and structure. So improving data quality with careful cleaning, restructuring, and exploratory data analysis will be a critical goal.
Similarly, accuracy of the analysis and actionable insights will be unlikely due to the data quality.  So additional, exploratory analysis should focus on narrowly defined questions that acknowledge this limitation and still provide insight.

## Process
### Step 1 - Load
Loading the ecommerce data into PgAdmin as csv

### Step 2 - Clean
Clean the data:
Making an effort to demonstrate the cleaning techniques covered in the course so far.  However, in many instances my choice was to preserve the data as a precaution because it's NULL columns, duplicate recrods, and missing data values may have been meaningful.
Techniques used:
-Visually inspect the data
-Check columns suitability as a primary key
-assign a primary key
-add an arbitrary, sequential primary key
-drop columns
-compare tables using joins
-deduplicate records
-adjust columns (prices divided by 1,000,000)
-recast type

### Step 3 - Starting Questions
-- **Question 1: Which cities and countries have the highest level of transaction revenues on the site?**
2 solutions: extensible CTE and efficient window function
-- **Question 2: What is the average number of products ordered from visitors in each city and country?**
Solution: simple select, rank, group by, order by
-- **Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**
Solution: similar to above, with Where claus
-- **Question 4: What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?**
Solution: Similar to above.
-- **Question 5: Can we summarize the impact of revenue generated from each city/country?**
Solution: Summary Stats

### Step 4 - Additional Questions, Exploring Data
-- **Question 1:  Imbuing sales_report table to find total sales and ranked sales by product
-- **Question 2:  Number of unique visitors vs number of unique visitors who made purchases
-- **Question 3:  Unique visits per month
-- **Question 4:  Find most fruitful referral sources

### Step 5 - QA
A large effort was made to ensure the best practices of quality assurance were adhered to throughout all transformations and analyses.  This includes, but is not limited to:
    -Thorough commenting, 
    -Consistent syntax & structure/indentation,
    -All variables are written in the same snake_case,
    -Data cleaned to better reflect 1st and 2nd normal form, where appropriate.


## Results
(fill in what you discovered this data could tell you and how you used the data to answer those questions)

## Challenges 
The largest challenge was the lack of thorough documentation, which in a business context may be provided by a data engineer. Being unable to understand the nature of the data tables lead to highly-conservative data cleaning decisions that subsequently detract from the significace of the analysis.  The second largest challenge was the data quality: being unable to effetively join all tables to create meaningful results and the high frequency of missing values (Null) further reduced the strength of any result found by the analysis.  This is reflected in the majority of ecommerce revenue coming from the city,country pair of  '(not set), United States', which is not informative. 

## Future Goals
Many next steps could be valuable. Chief among them is resolving the data quality, strucutre, and documentation that is preventing future analyses from being significant.  Next is to clarify a business problem that we are trying to solve; many mini-trends can be gleaned from this data but it is not valuable without an application.
Technically, more could be done to create composite keys between tables, using regression to try to predict which customers are likely to make a purchase and what they may also be interested in, as well as understanding why certain products are selling well while others are not. 
