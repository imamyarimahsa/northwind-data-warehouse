USE Northwind_DW;
GO

INSERT INTO dbo.fact_sales
(
    order_id,
    customer_key,
    product_key,
    employee_key,
    shipper_key,
    date_key,
    unit_price,
    quantity,
    discount
)
SELECT
    o.OrderID,
    c.customer_key,
    p.product_key,
    e.employee_key,
    s.shipper_key,
    YEAR(CAST(o.OrderDate AS DATE)) * 10000
        + MONTH(CAST(o.OrderDate AS DATE)) * 100
        + DAY(CAST(o.OrderDate AS DATE)) AS date_key,
    od.UnitPrice,
    od.Quantity,
    od.Discount
FROM NORTHWND.dbo.Orders AS o
INNER JOIN NORTHWND.dbo.[Order Details] AS od
    ON o.OrderID = od.OrderID
INNER JOIN dbo.dim_customer AS c
    ON o.CustomerID = c.customer_id
INNER JOIN dbo.dim_product AS p
    ON od.ProductID = p.product_id
INNER JOIN dbo.dim_employee AS e
    ON o.EmployeeID = e.employee_id
INNER JOIN dbo.dim_shipper AS s
    ON o.ShipVia = s.shipper_id
WHERE o.OrderDate IS NOT NULL;
GO

SELECT COUNT(*) AS fact_sales_count
FROM dbo.fact_sales;
GO

--------
----

		

SELECT TOP 20 *
FROM dbo.fact_sales
ORDER BY sales_key;
