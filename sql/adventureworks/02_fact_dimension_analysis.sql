USE AdventureWorksDW2025;
GO

-- ============================================================
-- AdventureWorksDW2025
-- 02 - Fact and Dimension Analysis
-- ============================================================

-- Goal:
-- Understand the grain of FactInternetSales and its
-- relationships with the main dimensions.

-- Inspect sample rows
SELECT TOP (20)
    SalesOrderNumber,
    SalesOrderLineNumber,
    ProductKey,
    CustomerKey,
    OrderQuantity,
    UnitPrice,
    SalesAmount
FROM dbo.FactInternetSales
ORDER BY
    SalesOrderNumber,
    SalesOrderLineNumber;


-- Check orders with multiple lines
SELECT
    SalesOrderNumber,
    COUNT(*) AS NumberOfRows
FROM dbo.FactInternetSales
GROUP BY
    SalesOrderNumber
HAVING COUNT(*) > 1
ORDER BY
    NumberOfRows DESC;


-- Validate logical uniqueness of the grain
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS NumberOfRows
FROM dbo.FactInternetSales
GROUP BY
    SalesOrderNumber,
    SalesOrderLineNumber
HAVING COUNT(*) > 1;

-- Findings:
--
-- Grain:
-- One row represents one product line within an Internet
-- sales order.
--
-- OrderQuantity indicates the number of units sold on
-- that order line.
--
-- Logical identifier:
-- SalesOrderNumber + SalesOrderLineNumber

-- ============================================================
-- Fact joined with main dimensions
-- ============================================================

SELECT TOP (20)
    fis.SalesOrderNumber,
    fis.SalesOrderLineNumber,

    d.FullDateAlternateKey AS OrderDate,

    p.EnglishProductName AS Product,

    c.FirstName,
    c.LastName,

    st.SalesTerritoryCountry,
    st.SalesTerritoryRegion,

    fis.OrderQuantity,
    fis.UnitPrice,
    fis.SalesAmount

FROM dbo.FactInternetSales AS fis

INNER JOIN dbo.DimDate AS d
    ON fis.OrderDateKey = d.DateKey

INNER JOIN dbo.DimProduct AS p
    ON fis.ProductKey = p.ProductKey

INNER JOIN dbo.DimCustomer AS c
    ON fis.CustomerKey = c.CustomerKey

INNER JOIN dbo.DimSalesTerritory AS st
    ON fis.SalesTerritoryKey = st.SalesTerritoryKey

ORDER BY
    fis.SalesOrderNumber,
    fis.SalesOrderLineNumber;



    -- ============================================================
-- Product hierarchy
-- ============================================================

SELECT TOP (20)
    p.ProductKey,
    p.EnglishProductName AS Product,
    ps.EnglishProductSubcategoryName AS ProductSubcategory,
    pc.EnglishProductCategoryName AS ProductCategory

FROM dbo.DimProduct AS p

LEFT JOIN dbo.DimProductSubcategory AS ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

LEFT JOIN dbo.DimProductCategory AS pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey

ORDER BY
    p.ProductKey;


-- ============================================================
-- Surrogate keys vs business keys
-- ============================================================

SELECT TOP (20)
    ProductKey,
    ProductAlternateKey,
    EnglishProductName
FROM dbo.DimProduct
ORDER BY ProductKey;


SELECT TOP (20)
    CustomerKey,
    CustomerAlternateKey,
    FirstName,
    LastName
FROM dbo.DimCustomer
ORDER BY CustomerKey;

-- ============================================================
-- Inspect historical versions of a product
-- ============================================================

SELECT
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    Color,
    StandardCost,
    ListPrice,
    StartDate,
    EndDate,
    Status
FROM dbo.DimProduct
WHERE ProductAlternateKey = 'CA-1098'
ORDER BY
    StartDate;