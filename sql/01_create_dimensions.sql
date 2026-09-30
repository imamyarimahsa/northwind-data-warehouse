/* ============================================================
   Project    : Northwind Data Warehouse
   File       : 01_create_dimensions.sql
   Purpose    : Create all Dimension tables
   Author     : Mahsa Emamyari
   Date       : September 2026
   ============================================================ */

USE Northwind_DW;
GO

/* ------------------------------------------------------------
   Dimension: dim_customer
   ------------------------------------------------------------ */
IF OBJECT_ID('dbo.dim_customer', 'U') IS NOT NULL
    DROP TABLE dbo.dim_customer;
GO

CREATE TABLE dbo.dim_customer (
    customer_key    INT             IDENTITY(1,1) NOT NULL,
    customer_id     NCHAR(5)        NOT NULL,
    company_name    NVARCHAR(40)    NOT NULL,
    contact_name    NVARCHAR(30)    NULL,
    contact_title   NVARCHAR(30)    NULL,
    address         NVARCHAR(60)    NULL,
    city            NVARCHAR(15)    NULL,
    region          NVARCHAR(15)    NULL,
    postal_code     NVARCHAR(10)    NULL,
    country         NVARCHAR(15)    NULL,
    phone           NVARCHAR(24)    NULL,
    fax             NVARCHAR(24)    NULL,
    CONSTRAINT PK_dim_customer PRIMARY KEY (customer_key)
);
GO

/* ------------------------------------------------------------
   Dimension: dim_product
   ------------------------------------------------------------ */
IF OBJECT_ID('dbo.dim_product', 'U') IS NOT NULL
    DROP TABLE dbo.dim_product;
GO

CREATE TABLE dbo.dim_product (
    product_key         INT             IDENTITY(1,1) NOT NULL,
    product_id          INT             NOT NULL,
    product_name        NVARCHAR(40)    NOT NULL,
    supplier_id         INT             NULL,
    supplier_name       NVARCHAR(40)    NULL,
    category_id         INT             NULL,
    category_name       NVARCHAR(15)    NULL,
    quantity_per_unit   NVARCHAR(20)    NULL,
    unit_price          MONEY           NULL,
    units_in_stock      SMALLINT        NULL,
    units_on_order      SMALLINT        NULL,
    reorder_level       SMALLINT        NULL,
    discontinued        BIT             NOT NULL,
    CONSTRAINT PK_dim_product PRIMARY KEY (product_key)
);
GO

/* ------------------------------------------------------------
   Dimension: dim_employee
   ------------------------------------------------------------ */
IF OBJECT_ID('dbo.dim_employee', 'U') IS NOT NULL
    DROP TABLE dbo.dim_employee;
GO

CREATE TABLE dbo.dim_employee (
    employee_key        INT             IDENTITY(1,1) NOT NULL,
    employee_id         INT             NOT NULL,
    last_name           NVARCHAR(20)    NOT NULL,
    first_name          NVARCHAR(10)    NOT NULL,
    title               NVARCHAR(30)    NULL,
    title_of_courtesy   NVARCHAR(25)    NULL,
    birth_date          DATETIME        NULL,
    hire_date           DATETIME        NULL,
    address             NVARCHAR(60)    NULL,
    city                NVARCHAR(15)    NULL,
    region              NVARCHAR(15)    NULL,
    postal_code         NVARCHAR(10)    NULL,
    country             NVARCHAR(15)    NULL,
    home_phone          NVARCHAR(20)    NULL,
    extension           NVARCHAR(4)     NULL,
    CONSTRAINT PK_dim_employee PRIMARY KEY (employee_key)
);
GO

/* ------------------------------------------------------------
   Dimension: dim_shipper
   ------------------------------------------------------------ */
IF OBJECT_ID('dbo.dim_shipper', 'U') IS NOT NULL
    DROP TABLE dbo.dim_shipper;
GO

CREATE TABLE dbo.dim_shipper (
    shipper_key     INT             IDENTITY(1,1) NOT NULL,
    shipper_id      INT             NOT NULL,
    company_name    NVARCHAR(40)    NOT NULL,
    phone           NVARCHAR(24)    NULL,
    CONSTRAINT PK_dim_shipper PRIMARY KEY (shipper_key)
);
GO

/* ------------------------------------------------------------
   Dimension: dim_date
   ------------------------------------------------------------ */
IF OBJECT_ID('dbo.dim_date', 'U') IS NOT NULL
    DROP TABLE dbo.dim_date;
GO

CREATE TABLE dbo.dim_date (
    date_key        INT             NOT NULL,
    full_date       DATE            NOT NULL,
    year            INT             NOT NULL,
    quarter         INT             NOT NULL,
    month           INT             NOT NULL,
    month_name      NVARCHAR(20)    NOT NULL,
    day             INT             NOT NULL,
    day_of_week     INT             NOT NULL,
    day_name        NVARCHAR(20)    NOT NULL,
    CONSTRAINT PK_dim_date PRIMARY KEY (date_key)
);
GO

PRINT 'All dimension tables created successfully.';
GO
