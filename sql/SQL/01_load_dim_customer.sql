USE Northwind_DW;
GO

INSERT INTO dbo.dim_customer
(
    customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    region,
    postal_code,
    country,
    phone,
    fax
)
SELECT
    CustomerID,
    CompanyName,
    ContactName,
    ContactTitle,
    Address,
    City,
    Region,
    PostalCode,
    Country,
    Phone,
    Fax
FROM NORTHWND.dbo.Customers;
GO


SELECT *
FROM dbo.dim_customer;

