# Enterprise Retail Data Warehouse ETL

An end-to-end ETL solution built with **SQL Server Integration Services (SSIS)** that loads, validates, transforms, and incrementally updates a retail data warehouse — built as the final project for the Data Pill Data Engineering course.

## Overview

The project uses **ContosoRetailDW** (a SQL Server sample star-schema database) as the operational source system and builds a separate target database, **RetailDW**, through a layered ETL pipeline:

```
Source (ContosoRetailDW)
        │
        ▼
   Staging Layer (stg schema)      ← Full Load (dynamic, metadata-driven)
        │
        ▼
  Validation Layer (vld schema)    ← Conditional Split (Mandatory → Numeric → Business Rule)
        │
        ▼
 Transformation Layer (dwh schema) ← Financial Calculations, Data Standardization
        │
        ▼
   Incremental Load                ← Last Modified Date filter + PK Lookup
```

## Key Components

### 1. Full Load — Staging
- Loads ~25 source tables from ContosoRetailDW into the `stg` schema
- Dynamic / metadata-driven load rather than one Data Flow per table
- Custom audit/logging columns added (source's native `ETLLoadID`/`LoadDate`/`UpdateDate` are ignored)

### 2. Validation Layer
Applied to 4 core staging tables: `stg.Sales`, `stg.Customer`, `stg.OnlineSales`, `stg.SalesQuota`
- Data Flow + chained Conditional Split: **Mandatory checks → Numeric checks → Business Rule checks**
- NULL checks skipped on Key columns
- Invalid rows → `dbo.ETL_ValidationErrors` (via Union All of Derived Column error branches)
- Valid rows → corresponding `vld.<table>`
- Shared `Logging.dtsx` package (Execute Package Task, Project Deployment Model) called once after all 4 parallel Data Flow branches converge

### 3. Business Transformation Layer
Package: `Transformation.dtsx` → output schema: `dwh`

| Area | Applied To | Details |
|---|---|---|
| Financial Calculations | Sales, OnlineSales, SalesQuota | NetSalesAmount, GrossProfit, ProfitMarginPercent, NetQuantitySold, QuotaAchievementPercent |
| Data Standardization | Customer | Proper Case names, phone number cleanup, NULL handling via Derived Column expressions |

### 4. Incremental Load
Applies to: Sales, OnlineSales, SalesQuota, Customer
- Filters by `UpdateDate > last load` (Last Modified Date pattern)
- Primary Key Lookup to decide Insert vs. Update
- Tracked via `ETL_IncrementalControl` table

### 5. Automation & Bonus Features
- **SSIS Catalog (SSISDB)** deployment
- Two SQL Server Agent Jobs:
  - `Retail_DW_Full_Load_Job` — Full Load → Validation → Transformation (manual/on-demand)
  - `Retail_DW_Incremental_Load_Job` — Incremental Load (scheduled daily)
- `Logging.dtsx` invoked from inside each package (not a separate job step)
- Email notifications on job success/failure
- Configuration-table-driven SSIS Framework (`ETL_FullLoad_Config`, `ETL_IncrementalControl`)

## Project Structure

```
├── FullLoad.dtsx              # Metadata-driven full load to staging
├── Validation.dtsx            # Conditional Split validation (4 tables)
├── Transformation.dtsx        # Financial calcs + data standardization
├── IncrementalLoad.dtsx       # Incremental load with PK lookup
├── Logging.dtsx               # Shared logging package
├── SQL/
│   ├── ETL_ValidationErrors.sql
│   ├── ETL_IncrementalControl.sql
│   └── ETL_FullLoad_Config.sql
└── Documentation/
    └── Final_Report.pdf
```

## Tech Stack
- SQL Server / T-SQL
- SSIS (Project Deployment Model)
- SSISDB Catalog
- SQL Server Agent

## Author
**Yusuf Kamal**
