USE Northwind_DW;
GO

INSERT INTO dbo.dim_shipper
(
    shipper_id,
    company_name,
    phone
)
SELECT
    ShipperID,
    CompanyName,
    Phone
FROM NORTHWND.dbo.Shippers;
GO

SELECT *
FROM dbo.dim_shipper;
