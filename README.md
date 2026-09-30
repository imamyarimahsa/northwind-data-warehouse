# 🏢 Northwind Data Warehouse

> Design and Implementation of a Data Warehouse for the Northwind database using **Microsoft SQL Server** and **Star Schema** architecture.

---

## 📋 Project Overview

This project demonstrates the design and implementation of a **Data Warehouse** based on the operational **Northwind** database. Data is extracted, transformed, and loaded (ETL) from the source system into a Star Schema model optimized for Business Intelligence and analytical reporting.

### 🎯 Objectives

- Design a Star Schema data warehouse
- Implement ETL process using pure T-SQL scripts
- Apply Surrogate Keys for dimension tables
- Validate data integrity and consistency between source and DW
- Prepare data for BI tools (Power BI, SSRS, etc.)

---

## 🏗️ Architecture

**Star Schema** with the following components:

### 📐 Fact Table

| Table | Grain | Measures |
|-------|-------|----------|
| `fact_sales` | One product per order | `unit_price`, `quantity`, `discount` |

### 📊 Dimension Tables

| Table | Description |
|-------|-------------|
| `dim_customer` | Customer descriptive data |
| `dim_product` | Product, supplier, and category data |
| `dim_employee` | Employee data |
| `dim_shipper` | Shipping company data |
| `dim_date` | Date and time attributes |

---

## 🔄 Data Flow

```
NORTHWND (Source)
       ↓
     ETL
       ↓
Northwind_DW (Star Schema)
       ↓
   BI / Reporting
```

---

## 📁 Repository Structure

```
northwind-data-warehouse/
├── sql/                  SQL scripts (DDL + ETL)
├── docs/                 Project documentation
├── diagrams/             Star schema, DFD, architecture
└── README.md
```

---

## 🛠️ Technologies

- **Microsoft SQL Server 2022**
- **SQL Server Management Studio (SSMS)**
- **T-SQL** (Stored Procedures, CTEs, Window Functions)
- **Power BI** (for reporting layer)

---

## 🚀 How to Run

### Prerequisites

1. SQL Server 2019 or higher
2. SSMS installed
3. Northwind database restored (`NORTHWND`)

### Execution Order

Run scripts in this order:

```sql
-- 1. Create the data warehouse database
sql/00_create_database.sql

-- 2. Create dimension tables
sql/01_create_dimensions.sql

-- 3. Create fact table
sql/02_create_fact.sql

-- 4. Load dimensions
sql/03_load_dim_customer.sql
sql/04_load_dim_product.sql
sql/05_load_dim_employee.sql
sql/06_load_dim_shipper.sql
sql/07_load_dim_date.sql

-- 5. Load fact table
sql/08_load_fact_sales.sql

-- 6. Or run the master ETL script
sql/09_etl_master.sql
```

---

## ✅ Data Validation

| Table | Record Count |
|-------|--------------|
| `dim_customer` | 91 |
| `dim_date` | 672 |
| `dim_employee` | 9 |
| `dim_product` | 77 |
| `dim_shipper` | 3 |
| `fact_sales` | 2155 |

---

## 📚 Documentation

- 📄 Full Documentation (Word): `docs/Northwind_Data_Warehouse_Documentation.docx`
- 📊 Diagrams: `diagrams/`

---

## 📌 Naming Conventions

This project follows **snake_case** naming:

- **Tables:** `dim_*`, `fact_*`
- **Surrogate Keys:** `*_key` (e.g., `customer_key`)
- **Business Keys:** `*_id` (e.g., `customer_id`)

---

## 👩‍💻 Author

**Mahsa Emamyari**

Business Intelligence Course Project

Tehran Data Institute — September 2026

---

## 📜 License

This project is for educational purposes.
