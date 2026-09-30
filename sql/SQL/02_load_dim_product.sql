USE Northwind_DW;
GO

INSERT INTO dbo.dim_product
(
    product_id,
    product_name,
    supplier_id,
    supplier_name,
    category_id,
    category_name,
    quantity_per_unit,
    unit_price,
    units_in_stock,
    units_on_order,
    reorder_level,
    discontinued
)
SELECT
    p.ProductID,
    p.ProductName,
    p.SupplierID,
    s.CompanyName,
    p.CategoryID,
    c.CategoryName,
    p.QuantityPerUnit,
    p.UnitPrice,
    p.UnitsInStock,
    p.UnitsOnOrder,
    p.ReorderLevel,
    p.Discontinued
FROM NORTHWND.dbo.Products AS p
LEFT JOIN NORTHWND.dbo.Suppliers AS s
    ON p.SupplierID = s.SupplierID
LEFT JOIN NORTHWND.dbo.Categories AS c
    ON p.CategoryID = c.CategoryID;
GO

SELECT *
FROM dbo.dim_product;