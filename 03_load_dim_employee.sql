USE Northwind_DW;
GO

INSERT INTO dbo.dim_employee
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
    extension
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
    Extension
FROM NORTHWND.dbo.Employees;
GO


SELECT *
FROM dbo.dim_employee;