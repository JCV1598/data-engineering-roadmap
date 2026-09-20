USE AdventureWorksDW2025;
GO

-- ============================================================
-- AdventureWorksDW2025
-- 03 - Sales Analysis
-- ============================================================

-- Goal:
-- Answer business questions using FactInternetSales
-- and its related dimensions.

-- Sales by year and territory

-- ============================================================
-- Sales by year and territory
-- ============================================================

SELECT
    d.CalendarYear,
    st.SalesTerritoryCountry,
    st.SalesTerritoryRegion,

    SUM(fis.OrderQuantity) AS UnitsSold,
    SUM(fis.SalesAmount) AS TotalSales

FROM dbo.FactInternetSales AS fis

INNER JOIN dbo.DimDate AS d
    ON fis.OrderDateKey = d.DateKey

INNER JOIN dbo.DimSalesTerritory AS st
    ON fis.SalesTerritoryKey = st.SalesTerritoryKey

GROUP BY
    d.CalendarYear,
    st.SalesTerritoryCountry,
    st.SalesTerritoryRegion

ORDER BY
    d.CalendarYear,
    TotalSales DESC;

-- ============================================================
-- Sales by year and product category
-- ============================================================

SELECT
    d.CalendarYear,
    pc.EnglishProductCategoryName AS ProductCategory,

    SUM(fis.OrderQuantity) AS UnitsSold,
    SUM(fis.SalesAmount) AS TotalSales

FROM dbo.FactInternetSales AS fis

INNER JOIN dbo.DimDate AS d
    ON fis.OrderDateKey = d.DateKey

INNER JOIN dbo.DimProduct AS p
    ON fis.ProductKey = p.ProductKey

LEFT JOIN dbo.DimProductSubcategory AS ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

LEFT JOIN dbo.DimProductCategory AS pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey

GROUP BY
    d.CalendarYear,
    pc.EnglishProductCategoryName

ORDER BY
    d.CalendarYear,
    TotalSales DESC;

--Ventas de Bikes en 2013
SELECT 
		pc.EnglishProductCategoryName AS ProductCategory,
		SUM(fis.OrderQuantity) AS UnitsSold,
		SUM(fis.SalesAmount) AS TotalSales
FROM FactInternetSales AS fis
INNER JOIN DimDate AS d
	ON d.DateKey = fis.OrderDateKey

INNER JOIN DimProduct AS p
	ON fis.ProductKey=p.ProductKey

INNER JOIN DimProductSubcategory AS ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

INNER JOIN DimProductCategory AS pc
	ON ps.ProductCategoryKey = pc.ProductCategoryKey

WHERE 
	d.CalendarYear = 2013 
	AND pc.EnglishProductCategoryName = 'Bikes'
GROUP BY
		pc.EnglishProductCategoryName;


--Venta de Bikes por Subcategory
SELECT 
		ps.EnglishProductSubcategoryName AS ProductSubcategory,
		SUM(fis.OrderQuantity) AS UnitsSold,
		SUM(fis.SalesAmount) AS TotalSales
FROM dbo.FactInternetSales AS fis
INNER JOIN dbo.DimDate AS d
	ON d.DateKey = fis.OrderDateKey

INNER JOIN dbo.DimProduct AS p
	ON fis.ProductKey=p.ProductKey

INNER JOIN dbo.DimProductSubcategory AS ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

INNER JOIN dbo.DimProductCategory AS pc
	ON ps.ProductCategoryKey = pc.ProductCategoryKey

WHERE 
	d.CalendarYear = 2013 
	AND pc.EnglishProductCategoryName = 'Bikes'
GROUP BY
		ps.EnglishProductSubcategoryName
ORDER BY
		TotalSales