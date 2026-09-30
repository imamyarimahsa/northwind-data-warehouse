USE Northwind_DW;
GO

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;

SELECT
    @StartDate = MIN(CAST(OrderDate AS DATE)),
    @EndDate = MAX(CAST(OrderDate AS DATE))
FROM NORTHWND.dbo.Orders
WHERE OrderDate IS NOT NULL;

;WITH DateList AS
(
    SELECT @StartDate AS full_date

    UNION ALL

    SELECT DATEADD(DAY, 1, full_date)
    FROM DateList
    WHERE full_date < @EndDate
)
INSERT INTO dbo.dim_date
(
    date_key,
    full_date,
    [year],
    [quarter],
    [month],
    month_name,
    [day],
    day_of_week,
    day_name
)
SELECT
    YEAR(full_date) * 10000
        + MONTH(full_date) * 100
        + DAY(full_date) AS date_key,

    full_date,

    YEAR(full_date),

    DATEPART(QUARTER, full_date),

    MONTH(full_date),

    DATENAME(MONTH, full_date),

    DAY(full_date),

    DATEPART(WEEKDAY, full_date),

    DATENAME(WEEKDAY, full_date)
FROM DateList
OPTION (MAXRECURSION 0);
GO

SELECT *
FROM dbo.dim_date
ORDER BY full_date;
