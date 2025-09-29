-------------------------------------------------------------------------------
1.If we keep policy records in JSONB format, what are the trade-offs
 compared to using anormalised table schema?
-------------------------------------------------------------------------------
-JSONB offers flexibility and is good for variable or evolving data, but has slower queries, weaker data integrity, and more complex analytics.
-Normalized tables provide better performance, strong data integrity, and easier analytics, but are less flexible and require schema changes for new fields.
-JSONB is best for semi-structured or rapidly changing data; normalized tables are best for structured, relational data where performance and integrity matter.

-----------------------------------------------------------------------------------
2. What data quality checks are critical before exposing data to Actuaries
-----------------------------------------------------------------------------------
-Completeness, Ensure all required fields (e.g dates, amounts and IDs) are present and not null.
-Accuracy, Validate that values are correct and within expected ranges.
-Consistency, Check for consistent formats(e.g date/time, currency codes) and relationships (e.g start date before end date)
-Uniqueness, Ensure no duplicate records.
-Integrity, Verify referential Integrity (e.g foreign keys, valid references to lookup tables).
-Auditability, Ensure changes are tracked and data lineage is clear.
With these checks it helps ensure actuaries work with reliable, accurateand trustworthy data for their analysis.

-----------------------------------------------------------------------------------
3.Suppose policy events arrive late or back-dated. How would you make the pipeline
idempotent?
-----------------------------------------------------------------------------------
To make our pipeline Idempotent with late or back-dated events:
I will use unique keys to upsert(insert or update) records, not just append. This prevents duplicates and ensures latest data is always reflected even if events arrive out of order.

-----------------------------------------------------------------------------------
4. If data grows 100×, what would you change in the pipeline (infra, partitioning, modelling)?
-----------------------------------------------------------------------------------
- Upgrade Infrastructure( use scalable/cloud storage and compute).
- Partition data by date or key fields for faster queries
- Optimize data models(denormalize, use columnar formats like Parquert)
- Add Indexing and batch processing to handle larger volumes efficiently

-----------------------------------------------------------------------------------
5. How would you design a daily "active policies" history table (SCD2-style) from event data?
-----------------------------------------------------------------------------------
Create a table with policyID, effective and end dates, and status columns.For each event, insert a new row when a policy changes, closing the previous row with an end date. 
This keeps a full history of daily active policy SCD2.