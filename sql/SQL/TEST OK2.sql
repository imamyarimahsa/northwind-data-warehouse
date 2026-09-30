

---آیا Fact کلید Null دارد
USE Northwind_DW;
GO

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_key IS NULL THEN 1 ELSE 0 END) AS null_customer,
    SUM(CASE WHEN product_key IS NULL THEN 1 ELSE 0 END) AS null_product,
    SUM(CASE WHEN employee_key IS NULL THEN 1 ELSE 0 END) AS null_employee,
    SUM(CASE WHEN shipper_key IS NULL THEN 1 ELSE 0 END) AS null_shipper,
    SUM(CASE WHEN date_key IS NULL THEN 1 ELSE 0 END) AS null_date
FROM dbo.fact_sales;





---آیا تعداد Dimensionها درست است؟
SELECT 'dim_customer' AS table_name, COUNT(*) AS row_count
FROM dbo.dim_customer

UNION ALL

SELECT 'dim_product', COUNT(*)
FROM dbo.dim_product

UNION ALL

SELECT 'dim_employee', COUNT(*)
FROM dbo.dim_employee

UNION ALL

SELECT 'dim_shipper', COUNT(*)
FROM dbo.dim_shipper

UNION ALL

SELECT 'dim_date', COUNT(*)
FROM dbo.dim_date

UNION ALL

SELECT 'fact_sales', COUNT(*)
FROM dbo.fact_sales;