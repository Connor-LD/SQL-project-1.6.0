Question 1: What are your risk areas? Identify and describe them.

Answer 1:
The ecommerce dataset arrived undocumented, unstructured, and with a multitude of data quality issues. 
The data structure of all (5) tables contained duplicative columns that could be dropped (first normal form). 
Due to the nature of this assignment, the analytics table was deduplicated to demonstrate an understanding of the technique.  Though this table was not used in subsequent analyses.  No other table rows were row reduced because it could not be confirmed that these rows were meaningless duplicates; versus meaningful duplicates. 
Many columns contained mostly or entirely Null values, which limited the range of possible analyses.
Furthermore, the tables were not structured in a way that allowed for meaningful primary keys, which limited the ability to analyze data across tables aside from a few minor examples.
Lastly, a quick analysis of the tables all_sessions, sales_by≠_sku, and sales_report show three distinct numbers of sales (81, 454, 462), which demonstrates the limited data quality of the ecommerce dataset.
If this dataset was presented in a busienss context I would argue to not proceed with any further analysis and seriously doubt the strength of any of its findings.   



Question 2: QA Process: Describe your QA process and include the SQL queries used to execute it.

Answer 2:
The QA process and subsequent queries are everpresent through the parts of this project (cleaning, intiial questions, EDA questions).
To inspect the QA process, please refer to those files.