-- =============================================
-- Northwind Data Warehouse - ETL Script
-- Source: NORTHWND
-- Target: Northwind_DW
-- =============================================


-- =============================================
-- ETL 1: Load dim_customer
-- =============================================

INSERT INTO Northwind_DW.dbo.dim_customer
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


-- =============================================
-- ETL 2: Load dim_date
-- =============================================

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
INSERT INTO Northwind_DW.dbo.dim_date
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


-- =============================================
-- ETL 3: Load dim_employee
-- =============================================

INSERT INTO Northwind_DW.dbo.dim_employee
(
    employee_id,
    last_name,
    first_name,
    title,
    title_of_courtesy,
    birth_date,
    hire_date,
    address,
    city,
    region,
    postal_code,
    country,
    home_phone,
    extension,
    photo,
    notes,
    reports_to,
    photo_path
)
SELECT
    EmployeeID,
    LastName,
    FirstName,
    Title,
    TitleOfCourtesy,
    BirthDate,
    HireDate,
    Address,
    City,
    Region,
    PostalCode,
    Country,
    HomePhone,
    Extension,
    Photo,
    Notes,
    ReportsTo,
    PhotoPath
FROM NORTHWND.dbo.Employees;


-- =============================================
-- ETL 4: Load dim_product
-- =============================================

INSERT INTO Northwind_DW.dbo.dim_product
(
    product_id,
    product_name,
    supplier_id,
    category_id,
    quantity_per_unit,
    unit_price,
    units_in_stock,
    units_on_order,
    reorder_level,
    discontinued
)
SELECT
    ProductID,
    ProductName,
    SupplierID,
    CategoryID,
    QuantityPerUnit,
    UnitPrice,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued
FROM NORTHWND.dbo.Products;


-- =============================================
-- ETL 5: Load dim_shipper
-- =============================================

INSERT INTO Northwind_DW.dbo.dim_shipper
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


-- =============================================
-- ETL 6: Load fact_sales
-- =============================================

INSERT INTO Northwind_DW.dbo.fact_sales
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
    CONVERT(INT, CONVERT(VARCHAR(8), o.OrderDate, 112)),
    od.UnitPrice,
    od.Quantity,
    od.Discount
FROM NORTHWND.dbo.Orders o
INNER JOIN NORTHWND.dbo.[Order Details] od
    ON o.OrderID = od.OrderID
INNER JOIN Northwind_DW.dbo.dim_customer c
    ON o.CustomerID = c.customer_id
INNER JOIN Northwind_DW.dbo.dim_product p
    ON od.ProductID = p.product_id
INNER JOIN Northwind_DW.dbo.dim_employee e
    ON o.EmployeeID = e.employee_id
INNER JOIN Northwind_DW.dbo.dim_shipper s
    ON o.ShipVia = s.shipper_id;