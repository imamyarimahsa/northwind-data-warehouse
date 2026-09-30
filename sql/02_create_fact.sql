/* ============================================================
   Project    : Northwind Data Warehouse
   File       : 02_create_fact.sql
   Purpose    : Create the Fact table and foreign key relationships
   Author     : Mahsa Emamyari
   Date       : September 2026
   ============================================================ */

USE Northwind_DW;
GO

/* ------------------------------------------------------------
   Fact Table: fact_sales
   Grain: One product per order (row from Order Details)
   ------------------------------------------------------------ */
IF OBJECT_ID('dbo.fact_sales', 'U') IS NOT NULL
    DROP TABLE dbo.fact_sales;
GO

CREATE TABLE dbo.fact_sales (
    sales_key       INT         IDENTITY(1,1) NOT NULL,
    order_id        INT         NOT NULL,
    customer_key    INT         NOT NULL,
    product_key     INT         NOT NULL,
    employee_key    INT         NOT NULL,
    shipper_key     INT         NOT NULL,
    date_key        INT         NOT NULL,
    unit_price      MONEY       NOT NULL,
    quantity        SMALLINT    NOT NULL,
    discount        REAL        NOT NULL,
    CONSTRAINT PK_fact_sales PRIMARY KEY (sales_key)
);
GO

/* ------------------------------------------------------------
   Foreign Key Constraints
   ------------------------------------------------------------ */
ALTER TABLE dbo.fact_sales
    ADD CONSTRAINT FK_fact_sales_dim_customer
    FOREIGN KEY (customer_key) REFERENCES dbo.dim_customer(customer_key);
GO

ALTER TABLE dbo.fact_sales
    ADD CONSTRAINT FK_fact_sales_dim_product
    FOREIGN KEY (product_key) REFERENCES dbo.dim_product(product_key);
GO

ALTER TABLE dbo.fact_sales
    ADD CONSTRAINT FK_fact_sales_dim_employee
    FOREIGN KEY (employee_key) REFERENCES dbo.dim_employee(employee_key);
GO

ALTER TABLE dbo.fact_sales
    ADD CONSTRAINT FK_fact_sales_dim_shipper
    FOREIGN KEY (shipper_key) REFERENCES dbo.dim_shipper(shipper_key);
GO

ALTER TABLE dbo.fact_sales
    ADD CONSTRAINT FK_fact_sales_dim_date
    FOREIGN KEY (date_key) REFERENCES dbo.dim_date(date_key);
GO

/* ------------------------------------------------------------
   Indexes for performance
   ------------------------------------------------------------ */
CREATE INDEX IX_fact_sales_customer_key ON dbo.fact_sales(customer_key);
CREATE INDEX IX_fact_sales_product_key  ON dbo.fact_sales(product_key);
CREATE INDEX IX_fact_sales_employee_key ON dbo.fact_sales(employee_key);
CREATE INDEX IX_fact_sales_shipper_key  ON dbo.fact_sales(shipper_key);
CREATE INDEX IX_fact_sales_date_key     ON dbo.fact_sales(date_key);
GO

PRINT 'Fact table created successfully with all constraints and indexes.';
GO
