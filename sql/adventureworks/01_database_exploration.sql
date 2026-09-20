USE AdventureWorksDW2025;
GO

-- ============================================================
-- AdventureWorksDW2025
-- 01 - Database Exploration
-- ============================================================

-- Goal:
-- Understand the structure of the Data Warehouse before
-- writing analytical queries.

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
ORDER BY
    s.name,
    t.name;


-- ============================================================
-- Inspect table columns
-- ============================================================

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FactInternetSales'
ORDER BY ORDINAL_POSITION;