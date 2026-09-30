/* ============================================================
   Project    : Northwind Data Warehouse
   File       : 00_create_database.sql
   Purpose    : Create the Data Warehouse database
   Author     : Mahsa Emamyari
   Date       : September 2026
   ============================================================ */

-- Drop database if it exists (for reusability)
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'Northwind_DW')
BEGIN
    ALTER DATABASE Northwind_DW SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Northwind_DW;
END
GO

-- Create the Data Warehouse database
CREATE DATABASE Northwind_DW;
GO

USE Northwind_DW;
GO

PRINT 'Database Northwind_DW created successfully.';
GO
