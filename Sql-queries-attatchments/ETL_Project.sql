CREATE DATABASE Retail_DW;
USE Retail_DW;
CREATE SCHEMA stg ;

CREATE TABLE ETL_FullLoad_Config
(
    ConfigID          INT IDENTITY(1,1) PRIMARY KEY,
    SourceSchema      NVARCHAR(100),
    SourceTable       NVARCHAR(200),
    TargetSchema      NVARCHAR(100),
    TargetTable       NVARCHAR(200),
    IsActive          BIT DEFAULT 1,
    TruncateTarget    BIT DEFAULT 1,      
    LoadOrder         INT,                 
    Notes             NVARCHAR(500)
);




INSERT INTO dbo.ETL_FullLoad_Config 
(SourceSchema, SourceTable, TargetSchema, TargetTable, TruncateTarget, IsActive, LoadOrder, Notes)
VALUES
('dbo', 'DimAccount',            'stg', 'Account',            1, 1, 1,  'Dimension'),
('dbo', 'DimChannel',            'stg', 'Channel',            1, 1, 2,  'Dimension'),
('dbo', 'DimCurrency',           'stg', 'Currency',           1, 1, 3,  'Dimension'),
('dbo', 'DimCustomer',           'stg', 'Customer',           1, 1, 4,  'Dimension'),
('dbo', 'DimDate',               'stg', 'Date',               1, 1, 5,  'Dimension'),
('dbo', 'DimEmployee',           'stg', 'Employee',           1, 1, 6,  'Dimension'),
('dbo', 'DimEntity',             'stg', 'Entity',             1, 1, 7,  'Dimension'),
('dbo', 'DimGeography',          'stg', 'Geography',          1, 1, 8,  'Dimension'),
('dbo', 'DimMachine',            'stg', 'Machine',            1, 1, 9,  'Dimension'),
('dbo', 'DimOutage',             'stg', 'Outage',             1, 1, 10, 'Dimension'),
('dbo', 'DimProduct',            'stg', 'Product',            1, 1, 11, 'Dimension'),
('dbo', 'DimProductCategory',    'stg', 'ProductCategory',    1, 1, 12, 'Dimension'),
('dbo', 'DimProductSubcategory', 'stg', 'ProductSubcategory', 1, 1, 13, 'Dimension'),
('dbo', 'DimPromotion',          'stg', 'Promotion',          1, 1, 14, 'Dimension'),
('dbo', 'DimSalesTerritory',     'stg', 'SalesTerritory',     1, 1, 15, 'Dimension'),
('dbo', 'DimScenario',           'stg', 'Scenario',           1, 1, 16, 'Dimension'),
('dbo', 'DimStore',              'stg', 'Store',              1, 1, 17, 'Dimension'),
('dbo', 'FactExchangeRate',      'stg', 'ExchangeRate',       1, 1, 30, 'Fact'),
('dbo', 'FactInventory',         'stg', 'Inventory',          1, 1, 31, 'Fact'),
('dbo', 'FactITMachine',         'stg', 'ITMachine',          1, 1, 32, 'Fact'),
('dbo', 'FactITSLA',             'stg', 'ITSLA',              1, 1, 33, 'Fact'),
('dbo', 'FactOnlineSales',       'stg', 'OnlineSales',        1, 1, 34, 'Fact'),
('dbo', 'FactSales',             'stg', 'Sales',              1, 1, 35, 'Fact'),
('dbo', 'FactSalesQuota',        'stg', 'SalesQuota',         1, 1, 36, 'Fact'),
('dbo', 'FactStrategyPlan',      'stg', 'StrategyPlan',       1, 1, 37, 'Fact');



SELECT 
    SourceSchema,
    SourceTable,
    TargetSchema,
    TargetTable,
    TruncateTarget
FROM dbo.ETL_FullLoad_Config
WHERE IsActive = 1
ORDER BY LoadOrder;



SELECT * FROM dbo.ETL_FullLoad_Config EFLC

UPDATE dbo.ETL_FullLoad_Config SET IsActive=0 WHERE ConfigID  BETWEEN 3 AND 25




----------------------------------------------------------------------------
--Validation
SELECT TOP 5 * FROM stg.Sales;

CREATE TABLE [dbo].[Invalid_Sales]
(
[SalesKey] [int] NULL,
[DateKey] [datetime] NULL,
[channelKey] [int] NULL,
[StoreKey] [int] NULL,
[ProductKey] [int] NULL,
[PromotionKey] [int] NULL,
[CurrencyKey] [int] NULL,
[UnitCost] [money] NULL,
[UnitPrice] [money] NULL,
[SalesQuantity] [int] NULL,
[ReturnQuantity] [int] NULL,
[ReturnAmount] [money] NULL,
[DiscountQuantity] [int] NULL,
[DiscountAmount] [money] NULL,
[TotalCost] [money] NULL,
[SalesAmount] [money] NULL,
[ETLLoadID] [int] NULL,
[LoadDate] [datetime] NULL,
[UpdateDate] [datetime] NULL,
[Error_Date] [datetime] NULL,
[Error_Type] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PackageName] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Valid_Sales]
(
[SalesKey] [int] NULL,
[DateKey] [datetime] NULL,
[channelKey] [int] NULL,
[StoreKey] [int] NULL,
[ProductKey] [int] NULL,
[PromotionKey] [int] NULL,
[CurrencyKey] [int] NULL,
[UnitCost] [money] NULL,
[UnitPrice] [money] NULL,
[SalesQuantity] [int] NULL,
[ReturnQuantity] [int] NULL,
[ReturnAmount] [money] NULL,
[DiscountQuantity] [int] NULL,
[DiscountAmount] [money] NULL,
[TotalCost] [money] NULL,
[SalesAmount] [money] NULL,
[ETLLoadID] [int] NULL,
[LoadDate] [datetime] NULL,
[UpdateDate] [datetime] NULL
) ON [PRIMARY]
GO



CREATE TABLE [dbo].[Error_Sales]
(
[SalesKey] [int] NULL,
[DateKey] [datetime] NULL,
[channelKey] [int] NULL,
[StoreKey] [int] NULL,
[ProductKey] [int] NULL,
[PromotionKey] [int] NULL,
[CurrencyKey] [int] NULL,
[UnitCost] [money] NULL,
[UnitPrice] [money] NULL,
[SalesQuantity] [int] NULL,
[ReturnQuantity] [int] NULL,
[ReturnAmount] [money] NULL,
[DiscountQuantity] [int] NULL,
[DiscountAmount] [money] NULL,
[TotalCost] [money] NULL,
[SalesAmount] [money] NULL,
[ETLLoadID] [int] NULL,
[LoadDate] [datetime] NULL,
[UpdateDate] [datetime] NULL,
[ErrorCode] [int] NULL,
[ErrorColumn] [int] NULL
) ON [PRIMARY]
GO

SELECT COUNT(*) FROM stg.Sales S
SELECT COUNT(*) FROM dbo.Valid_Sales VS
SELECT COUNT(*) FROM dbo.ValidationErrors_Sales VES
SELECT COUNT(*) FROM dbo.Error_Sales ES


TRUNCATE TABLE dbo.Error_Sales;
TRUNCATE TABLE dbo.Valid_Sales;
TRUNCATE TABLE dbo.ValidationErrors_Sales;
------------------------------------------------------------------------------
SELECT TOP 10* FROM stg.Customer C

CREATE TABLE [Valid_Customers] (
    [CustomerKey] int,
    [GeographyKey] int,
    [CustomerLabel] nvarchar(100),
    [Title] nvarchar(8),
    [FirstName] nvarchar(50),
    [MiddleName] nvarchar(50),
    [LastName] nvarchar(50),
    [NameStyle] bit,
    [BirthDate] date,
    [MaritalStatus] nvarchar(1),
    [Suffix] nvarchar(10),
    [Gender] nvarchar(1),
    [EmailAddress] nvarchar(50),
    [YearlyIncome] money,
    [TotalChildren] tinyint,
    [NumberChildrenAtHome] tinyint,
    [Education] nvarchar(40),
    [Occupation] nvarchar(100),
    [HouseOwnerFlag] nvarchar(1),
    [NumberCarsOwned] tinyint,
    [AddressLine1] nvarchar(120),
    [AddressLine2] nvarchar(120),
    [Phone] nvarchar(20),
    [DateFirstPurchase] date,
    [CustomerType] nvarchar(15),
    [CompanyName] nvarchar(100),
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime
)




CREATE TABLE [Customer_Invalid] (
    [CustomerKey] int,
    [GeographyKey] int,
    [CustomerLabel] nvarchar(100),
    [Title] nvarchar(8),
    [FirstName] nvarchar(50),
    [MiddleName] nvarchar(50),
    [LastName] nvarchar(50),
    [NameStyle] bit,
    [BirthDate] date,
    [MaritalStatus] nvarchar(1),
    [Suffix] nvarchar(10),
    [Gender] nvarchar(1),
    [EmailAddress] nvarchar(50),
    [YearlyIncome] money,
    [TotalChildren] tinyint,
    [NumberChildrenAtHome] tinyint,
    [Education] nvarchar(40),
    [Occupation] nvarchar(100),
    [HouseOwnerFlag] nvarchar(1),
    [NumberCarsOwned] tinyint,
    [AddressLine1] nvarchar(120),
    [AddressLine2] nvarchar(120),
    [Phone] nvarchar(20),
    [DateFirstPurchase] date,
    [CustomerType] nvarchar(15),
    [CompanyName] nvarchar(100),
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [Error_Date] datetime,
    [Error_type] nvarchar(57)
)


CREATE TABLE [Customers_Errors] (
    [CustomerKey] int,
    [GeographyKey] int,
    [CustomerLabel] nvarchar(100),
    [Title] nvarchar(8),
    [FirstName] nvarchar(50),
    [MiddleName] nvarchar(50),
    [LastName] nvarchar(50),
    [NameStyle] bit,
    [BirthDate] date,
    [MaritalStatus] nvarchar(1),
    [Suffix] nvarchar(10),
    [Gender] nvarchar(1),
    [EmailAddress] nvarchar(50),
    [YearlyIncome] money,
    [TotalChildren] tinyint,
    [NumberChildrenAtHome] tinyint,
    [Education] nvarchar(40),
    [Occupation] nvarchar(100),
    [HouseOwnerFlag] nvarchar(1),
    [NumberCarsOwned] tinyint,
    [AddressLine1] nvarchar(120),
    [AddressLine2] nvarchar(120),
    [Phone] nvarchar(20),
    [DateFirstPurchase] date,
    [CustomerType] nvarchar(15),
    [CompanyName] nvarchar(100),
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [ErrorCode] int,
    [ErrorColumn] int
)

TRUNCATE TABLE dbo.Customer_Invalid;
TRUNCATE TABLE dbo.Customers_Errors;
TRUNCATE TABLE dbo.Valid_Customers;

SELECT * FROM dbo.Customer_Invalid CI
SELECT COUNT(*)FROM stg.Customer C;
SELECT COUNT(*)FROM dbo.Customer_Invalid CI;
SELECT COUNT(*)FROM dbo.Valid_Customers VC;
SELECT COUNT(*)FROM Customers_Errors;
--------------------------------------------------------------------------
SELECT TOP 10 * FROM stg.OnlineSales OS

CREATE TABLE [OnlineSales_Errors] (
    [OnlineSalesKey] int,
    [DateKey] datetime,
    [StoreKey] int,
    [ProductKey] int,
    [PromotionKey] int,
    [CurrencyKey] int,
    [CustomerKey] int,
    [SalesOrderNumber] nvarchar(20),
    [SalesOrderLineNumber] int,
    [SalesQuantity] int,
    [SalesAmount] money,
    [ReturnQuantity] int,
    [ReturnAmount] money,
    [DiscountQuantity] int,
    [DiscountAmount] money,
    [TotalCost] money,
    [UnitCost] money,
    [UnitPrice] money,
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [ErrorCode] int,
    [ErrorColumn] int
)



CREATE TABLE [OnlineSales_Valid] (
    [OnlineSalesKey] int,
    [DateKey] datetime,
    [StoreKey] int,
    [ProductKey] int,
    [PromotionKey] int,
    [CurrencyKey] int,
    [CustomerKey] int,
    [SalesOrderNumber] nvarchar(20),
    [SalesOrderLineNumber] int,
    [SalesQuantity] int,
    [SalesAmount] money,
    [ReturnQuantity] int,
    [ReturnAmount] money,
    [DiscountQuantity] int,
    [DiscountAmount] money,
    [TotalCost] money,
    [UnitCost] money,
    [UnitPrice] money,
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime
)



CREATE TABLE [OnlineSales_Invalid] (
    [OnlineSalesKey] int,
    [DateKey] datetime,
    [StoreKey] int,
    [ProductKey] int,
    [PromotionKey] int,
    [CurrencyKey] int,
    [CustomerKey] int,
    [SalesOrderNumber] nvarchar(20),
    [SalesOrderLineNumber] int,
    [SalesQuantity] int,
    [SalesAmount] money,
    [ReturnQuantity] int,
    [ReturnAmount] money,
    [DiscountQuantity] int,
    [DiscountAmount] money,
    [TotalCost] money,
    [UnitCost] money,
    [UnitPrice] money,
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [Error_Time] datetime,
    [Error_Type] nvarchar(17),
    [PackageName] nvarchar(26)
)
SELECT COUNT(*) FROM stg.OnlineSales OS
SELECT COUNT(*) FROM dbo.OnlineSales_Invalid OSI
SELECT COUNT(*) FROM dbo.OnlineSales_Valid OSV
SELECT COUNT(*) FROM dbo.OnlineSales_Errors OSE


TRUNCATE TABLE dbo.OnlineSales_Invalid;
TRUNCATE TABLE dbo.OnlineSales_Errors;
TRUNCATE TABLE dbo.OnlineSales_Valid;

----------------------------------------------------------------------------------------------
SELECT TOP 10* FROM stg.SalesQuota SQ
SELECT COUNT(*) FROM stg.SalesQuota SQ



CREATE TABLE [SalesQuota_Invalid] (
    [SalesQuotaKey] int,
    [ChannelKey] int,
    [StoreKey] int,
    [ProductKey] int,
    [DateKey] datetime,
    [CurrencyKey] int,
    [ScenarioKey] int,
    [SalesQuantityQuota] money,
    [SalesAmountQuota] money,
    [GrossMarginQuota] money,
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [Error_Date] datetime,
    [Error_Type] nvarchar(17),
    [PackageName] nvarchar(25)
)

CREATE TABLE [SalesQuota_Invalid] (
    [SalesQuotaKey] int,
    [ChannelKey] int,
    [StoreKey] int,
    [ProductKey] int,
    [DateKey] datetime,
    [CurrencyKey] int,
    [ScenarioKey] int,
    [SalesQuantityQuota] money,
    [SalesAmountQuota] money,
    [GrossMarginQuota] money,
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [Error_Date] datetime,
    [Error_Type] nvarchar(17)
)



CREATE TABLE [SalesQuota_Errors] (
    [SalesQuotaKey] int,
    [ChannelKey] int,
    [StoreKey] int,
    [ProductKey] int,
    [DateKey] datetime,
    [CurrencyKey] int,
    [ScenarioKey] int,
    [SalesQuantityQuota] money,
    [SalesAmountQuota] money,
    [GrossMarginQuota] money,
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [ErrorCode] int,
    [ErrorColumn] int
)
SELECT COUNT(*) FROM stg.SalesQuota SQ
SELECT COUNT(*) FROM dbo.SalesQuota_Valid SQV
SELECT COUNT(*) FROM dbo.SalesQuota_Invalid SQI
SELECT COUNT(*) FROM dbo.SalesQuota_Errors SQE

TRUNCATE TABLE dbo.SalesQuota_Errors;
TRUNCATE TABLE dbo.SalesQuota_Invalid;
TRUNCATE TABLE dbo.SalesQuota_Valid;
----------------------------------------------------------------------------------------------
---Logging


 CREATE TABLE dbo.ETL_ExecutionLog
(
    LogID              INT IDENTITY(1,1) PRIMARY KEY,
    PackageName        NVARCHAR(200),
    ExecutionDate      DATE,
    StartTime          DATETIME,
    EndTime            DATETIME,
    Duration           INT,          
    TotalRecords       INT,
    SuccessfulRecords  INT,
    FailedRecords      INT,
    Status              NVARCHAR(20)  
);

SELECT * FROM dbo.ETL_ExecutionLog EEL

 INSERT INTO dbo.ETL_ExecutionLog
(PackageName, ExecutionDate, StartTime, EndTime, Duration, TotalRecords, SuccessfulRecords, FailedRecords, Status)
VALUES (?, CAST(GETDATE() AS DATE), CONVERT(DATETIME, ?, 120), GETDATE(), DATEDIFF(SECOND, CONVERT(DATETIME, ?, 120), GETDATE()), ?, ?, ?, ?);





SELECT * FROM dbo.ETL_ExecutionLog ORDER BY LogID DESC;

---------------------------------------------------------------------------------------
----Transformation

CREATE SCHEMA dwh;

 
CREATE TABLE [dwh].[Sales] (
    [SalesKey] int,
    [DateKey] datetime,
    [channelKey] int,
    [StoreKey] int,
    [ProductKey] int,
    [PromotionKey] int,
    [CurrencyKey] int,
    [UnitCost] money,
    [UnitPrice] money,
    [SalesQuantity] int,
    [ReturnQuantity] int,
    [ReturnAmount] money,
    [DiscountQuantity] int,
    [DiscountAmount] money,
    [TotalCost] money,
    [SalesAmount] money,
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [NetSalesAmount] money,
    [GrossProfit] money,
    [ProfitMarginPercent] numeric(24,5),
    [NetQuantitySold] int,
    [TransactionSizeCategory] nvarchar(10),
    [AuditLoadDate] datetime,
    [AuditPackageName] nvarchar(100),
    [AuditBatchID] nvarchar(30),
    [AuditETLUser] nvarchar(100)
)

CREATE TABLE [dwh].[SalesQuota] (
    [SalesQuotaKey] int,
    [ChannelKey] int,
    [StoreKey] int,
    [ProductKey] int,
    [DateKey] datetime,
    [CurrencyKey] int,
    [ScenarioKey] int,
    [SalesQuantityQuota] money,
    [SalesAmountQuota] money,
    [GrossMarginQuota] money,
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [QuotaAchievementPercent] numeric(24,5),
    [QuotaPerformanceCategory] nvarchar(20),
    [AuditLoadDate] datetime,
    [AuditPackageName] nvarchar(100),
    [AuditBatchID] nvarchar(30),
    [AuditETLUser] nvarchar(100)
)

CREATE TABLE [dwh].[Customers] (
    [CustomerKey] int,
    [GeographyKey] int,
    [CustomerLabel] nvarchar(100),
    [Title] nvarchar(8),
    [FirstName] nvarchar(50),
    [MiddleName] nvarchar(50),
    [LastName] nvarchar(50),
    [NameStyle] bit,
    [BirthDate] date,
    [MaritalStatus] nvarchar(1),
    [Suffix] nvarchar(10),
    [Gender] nvarchar(1),
    [EmailAddress] nvarchar(50),
    [YearlyIncome] money,
    [TotalChildren] tinyint,
    [NumberChildrenAtHome] tinyint,
    [Education] nvarchar(40),
    [Occupation] nvarchar(100),
    [HouseOwnerFlag] nvarchar(1),
    [NumberCarsOwned] tinyint,
    [AddressLine1] nvarchar(120),
    [AddressLine2] nvarchar(120),
    [Phone] nvarchar(20),
    [DateFirstPurchase] date,
    [CustomerType] nvarchar(15),
    [CompanyName] nvarchar(100),
    [ETLLoadID] int,
    [LoadDate] datetime,
    [UpdateDate] datetime,
    [IncomeSegment] nvarchar(10),
    [FamilySizeCategory] nvarchar(15),
    [AuditLoadDate] datetime,
    [AuditPackageName] nvarchar(100),
    [AuditBatchID] nvarchar(30),
    [AuditETLUser] nvarchar(100)
)



SELECT TOP 20 SalesAmount, TransactionSizeCategory FROM dwh.Sales;
SELECT TOP 20 QuotaAchievementPercent, QuotaPerformanceCategory FROM dwh.SalesQuota;
SELECT TOP 20 YearlyIncome, IncomeSegment, TotalChildren, FamilySizeCategory FROM dwh.Customers;


SELECT TOP 20 FirstName, LastName, Phone, MiddleName FROM dwh.Customers;

--------------------------------------------------------------------------------------------------
--Incremental Load using Lookup
CREATE TABLE dbo.ETL_IncrementalControl
(
    ControlID       INT IDENTITY(1,1) PRIMARY KEY,
    TableName       NVARCHAR(200) NOT NULL,
    LastLoadDate    DATETIME NOT NULL
);

INSERT INTO dbo.ETL_IncrementalControl (TableName, LastLoadDate)
VALUES
('Sales', '1900-01-01'),
('SalesQuota', '1900-01-01'),
('Customer', '1900-01-01');

SELECT * FROM ETL_IncrementalControl

SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'Sales';


--UPDATE stg.Sales
--SET SalesQuantity = ?, SalesAmount = ?, UnitCost = ?, UnitPrice = ?, TotalCost = ?, ReturnQuantity = ?, ReturnAmount = ?, DiscountQuantity = ?, DiscountAmount = ?, UpdateDate = ?
--WHERE SalesKey = ?




SELECT * FROM ContosoRetailDW.dbo.FactSalesQuota WHERE UpdateDate > ?

--UPDATE stg.SalesQuota
--SET SalesQuantityQuota = ?, SalesAmountQuota = ?, GrossMarginQuota = ?, UpdateDate = ?
--WHERE SalesQuotaKey = ?



--SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'Customer';
--SELECT * FROM ContosoRetailDW.dbo.DimCustomer WHERE UpdateDate > ?


ALTER TABLE dbo.ETL_ValidationErrors ADD PackageName NVARCHAR(200) NULL;

SELECT * FROM ETL_ValidationErrors 



SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'SalesQuota';

SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'Customer';

SELECT * FROM dbo.ETL_ExecutionLog EEL

SELECT * FROM dbo.ETL_IncrementalControl EIC

---------------------------------------------------------------------------------
--Incremental Load using Merge
CREATE OR ALTER   PROCEDURE [dbo].[usp_MergeIncremental_Sales]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @LastLoad DATETIME = (
        SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'Sales'
    );

    IF NOT EXISTS (SELECT 1 FROM ContosoRetailDW.dbo.FactSales WHERE UpdateDate > @LastLoad)
    BEGIN
        SELECT 0 AS AffectedRows, 'No new data found' AS Message;
        RETURN;
    END

    SET IDENTITY_INSERT stg.Sales ON;

    BEGIN TRY
        DECLARE @MaxUpdateDate DATETIME = (
            SELECT MAX(UpdateDate) FROM ContosoRetailDW.dbo.FactSales WHERE UpdateDate > @LastLoad
        );
        DECLARE @RowsAffected INT;

        MERGE INTO stg.Sales AS Target
        USING (
            SELECT * FROM ContosoRetailDW.dbo.FactSales WHERE UpdateDate > @LastLoad
        ) AS Source
        ON Target.SalesKey = Source.SalesKey

        WHEN MATCHED AND Target.UpdateDate < Source.UpdateDate THEN
            UPDATE SET
                Target.SalesQuantity     = Source.SalesQuantity,
                Target.SalesAmount       = Source.SalesAmount,
                Target.UnitCost          = Source.UnitCost,
                Target.UnitPrice         = Source.UnitPrice,
                Target.TotalCost         = Source.TotalCost,
                Target.ReturnQuantity    = Source.ReturnQuantity,
                Target.ReturnAmount      = Source.ReturnAmount,
                Target.DiscountQuantity  = Source.DiscountQuantity,
                Target.DiscountAmount    = Source.DiscountAmount,
                Target.UpdateDate        = Source.UpdateDate

        WHEN NOT MATCHED BY TARGET THEN
            INSERT (SalesKey, DateKey, channelKey, StoreKey, ProductKey, PromotionKey, CurrencyKey,
                    UnitCost, UnitPrice, SalesQuantity, ReturnQuantity, ReturnAmount,
                    DiscountQuantity, DiscountAmount, TotalCost, SalesAmount,
                    ETLLoadID, LoadDate, UpdateDate)
            VALUES (Source.SalesKey, Source.DateKey, Source.channelKey, Source.StoreKey, Source.ProductKey,
                    Source.PromotionKey, Source.CurrencyKey, Source.UnitCost, Source.UnitPrice,
                    Source.SalesQuantity, Source.ReturnQuantity, Source.ReturnAmount,
                    Source.DiscountQuantity, Source.DiscountAmount, Source.TotalCost, Source.SalesAmount,
                    Source.ETLLoadID, Source.LoadDate, Source.UpdateDate);

        SET @RowsAffected = @@ROWCOUNT;

        SET IDENTITY_INSERT stg.Sales OFF;

        UPDATE dbo.ETL_IncrementalControl
        SET LastLoadDate = @MaxUpdateDate
        WHERE TableName = 'Sales';

        SELECT @RowsAffected AS AffectedRows, @MaxUpdateDate AS NewLastLoadDate;

    END TRY
    BEGIN CATCH
        SET IDENTITY_INSERT stg.Sales OFF;
        THROW;
    END CATCH
END

GO


CREATE OR ALTER   PROCEDURE [dbo].[usp_MergeIncremental_OnlineSales]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @LastLoad DATETIME = (
        SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'OnlineSales'
    );

    IF NOT EXISTS (SELECT 1 FROM ContosoRetailDW.dbo.FactOnlineSales WHERE UpdateDate > @LastLoad)
    BEGIN
        SELECT 0 AS AffectedRows, 'No new data found' AS Message;
        RETURN;
    END

    SET IDENTITY_INSERT stg.OnlineSales ON;

    BEGIN TRY
        DECLARE @MaxUpdateDate DATETIME = (
            SELECT MAX(UpdateDate) FROM ContosoRetailDW.dbo.FactOnlineSales WHERE UpdateDate > @LastLoad
        );
        DECLARE @RowsAffected INT;

        MERGE INTO stg.OnlineSales AS Target
        USING (
            SELECT * FROM ContosoRetailDW.dbo.FactOnlineSales WHERE UpdateDate > @LastLoad
        ) AS Source
        ON Target.OnlineSalesKey = Source.OnlineSalesKey

        WHEN MATCHED AND Target.UpdateDate < Source.UpdateDate THEN
            UPDATE SET
                Target.SalesQuantity     = Source.SalesQuantity,
                Target.SalesAmount       = Source.SalesAmount,
                Target.UnitCost          = Source.UnitCost,
                Target.UnitPrice         = Source.UnitPrice,
                Target.TotalCost         = Source.TotalCost,
                Target.ReturnQuantity    = Source.ReturnQuantity,
                Target.ReturnAmount      = Source.ReturnAmount,
                Target.DiscountQuantity  = Source.DiscountQuantity,
                Target.DiscountAmount    = Source.DiscountAmount,
                Target.UpdateDate        = Source.UpdateDate

        WHEN NOT MATCHED BY TARGET THEN
            INSERT (OnlineSalesKey, DateKey, StoreKey, ProductKey, PromotionKey, CurrencyKey, CustomerKey,
                    SalesOrderNumber, SalesOrderLineNumber, SalesQuantity, SalesAmount, ReturnQuantity,
                    ReturnAmount, DiscountQuantity, DiscountAmount, TotalCost, UnitCost, UnitPrice,
                    ETLLoadID, LoadDate, UpdateDate)
            VALUES (Source.OnlineSalesKey, Source.DateKey, Source.StoreKey, Source.ProductKey, Source.PromotionKey,
                    Source.CurrencyKey, Source.CustomerKey, Source.SalesOrderNumber, Source.SalesOrderLineNumber,
                    Source.SalesQuantity, Source.SalesAmount, Source.ReturnQuantity, Source.ReturnAmount,
                    Source.DiscountQuantity, Source.DiscountAmount, Source.TotalCost, Source.UnitCost,
                    Source.UnitPrice, Source.ETLLoadID, Source.LoadDate, Source.UpdateDate);

        SET @RowsAffected = @@ROWCOUNT;

        SET IDENTITY_INSERT stg.OnlineSales OFF;

        UPDATE dbo.ETL_IncrementalControl
        SET LastLoadDate = @MaxUpdateDate
        WHERE TableName = 'OnlineSales';

        SELECT @RowsAffected AS AffectedRows, @MaxUpdateDate AS NewLastLoadDate;

    END TRY
    BEGIN CATCH
        SET IDENTITY_INSERT stg.OnlineSales OFF;
        THROW;
    END CATCH
END

GO


CREATE OR ALTER   PROCEDURE [dbo].[usp_MergeIncremental_SalesQuota]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @LastLoad DATETIME = (
        SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'SalesQuota'
    );

    IF NOT EXISTS (SELECT 1 FROM ContosoRetailDW.dbo.FactSalesQuota WHERE UpdateDate > @LastLoad)
    BEGIN
        SELECT 0 AS AffectedRows, 'No new data found' AS Message;
        RETURN;
    END

    SET IDENTITY_INSERT stg.SalesQuota ON;

    BEGIN TRY
        DECLARE @MaxUpdateDate DATETIME = (
            SELECT MAX(UpdateDate) FROM ContosoRetailDW.dbo.FactSalesQuota WHERE UpdateDate > @LastLoad
        );
        DECLARE @RowsAffected INT;

        MERGE INTO stg.SalesQuota AS Target
        USING (
            SELECT * FROM ContosoRetailDW.dbo.FactSalesQuota WHERE UpdateDate > @LastLoad
        ) AS Source
        ON Target.SalesQuotaKey = Source.SalesQuotaKey

        WHEN MATCHED AND Target.UpdateDate < Source.UpdateDate THEN
            UPDATE SET
                Target.SalesQuantityQuota = Source.SalesQuantityQuota,
                Target.SalesAmountQuota   = Source.SalesAmountQuota,
                Target.GrossMarginQuota   = Source.GrossMarginQuota,
                Target.UpdateDate         = Source.UpdateDate

        WHEN NOT MATCHED BY TARGET THEN
            INSERT (SalesQuotaKey, ChannelKey, StoreKey, ProductKey, DateKey, CurrencyKey, ScenarioKey,
                    SalesQuantityQuota, SalesAmountQuota, GrossMarginQuota, ETLLoadID, LoadDate, UpdateDate)
            VALUES (Source.SalesQuotaKey, Source.ChannelKey, Source.StoreKey, Source.ProductKey, Source.DateKey,
                    Source.CurrencyKey, Source.ScenarioKey, Source.SalesQuantityQuota, Source.SalesAmountQuota,
                    Source.GrossMarginQuota, Source.ETLLoadID, Source.LoadDate, Source.UpdateDate);

        SET @RowsAffected = @@ROWCOUNT;

        SET IDENTITY_INSERT stg.SalesQuota OFF;

        UPDATE dbo.ETL_IncrementalControl
        SET LastLoadDate = @MaxUpdateDate
        WHERE TableName = 'SalesQuota';

        SELECT @RowsAffected AS AffectedRows, @MaxUpdateDate AS NewLastLoadDate;

    END TRY
    BEGIN CATCH
        SET IDENTITY_INSERT stg.SalesQuota OFF;
        THROW;
    END CATCH
END

GO



CREATE OR ALTER   PROCEDURE [dbo].[usp_MergeIncremental_Customer]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @LastLoad DATETIME = (
        SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'Customer'
    );

    IF NOT EXISTS (SELECT 1 FROM ContosoRetailDW.dbo.DimCustomer WHERE UpdateDate > @LastLoad)
    BEGIN
        SELECT 0 AS AffectedRows, 'No new data found' AS Message;
        RETURN;
    END

    SET IDENTITY_INSERT stg.Customer ON;

    BEGIN TRY
        DECLARE @MaxUpdateDate DATETIME = (
            SELECT MAX(UpdateDate) FROM ContosoRetailDW.dbo.DimCustomer WHERE UpdateDate > @LastLoad
        );
        DECLARE @RowsAffected INT;

        MERGE INTO stg.Customer AS Target
        USING (
            SELECT * FROM ContosoRetailDW.dbo.DimCustomer WHERE UpdateDate > @LastLoad
        ) AS Source
        ON Target.CustomerKey = Source.CustomerKey

        WHEN MATCHED AND Target.UpdateDate < Source.UpdateDate THEN
            UPDATE SET
                Target.FirstName             = Source.FirstName,
                Target.LastName              = Source.LastName,
                Target.EmailAddress          = Source.EmailAddress,
                Target.Phone                 = Source.Phone,
                Target.YearlyIncome          = Source.YearlyIncome,
                Target.TotalChildren         = Source.TotalChildren,
                Target.NumberChildrenAtHome  = Source.NumberChildrenAtHome,
                Target.HouseOwnerFlag        = Source.HouseOwnerFlag,
                Target.NumberCarsOwned       = Source.NumberCarsOwned,
                Target.AddressLine1          = Source.AddressLine1,
                Target.UpdateDate            = Source.UpdateDate

        WHEN NOT MATCHED BY TARGET THEN
            INSERT (CustomerKey, GeographyKey, CustomerLabel, Title, FirstName, MiddleName, LastName, NameStyle,
                    BirthDate, MaritalStatus, Suffix, Gender, EmailAddress, YearlyIncome, TotalChildren,
                    NumberChildrenAtHome, Education, Occupation, HouseOwnerFlag, NumberCarsOwned,
                    AddressLine1, AddressLine2, Phone, DateFirstPurchase, CustomerType, CompanyName,
                    ETLLoadID, LoadDate, UpdateDate)
            VALUES (Source.CustomerKey, Source.GeographyKey, Source.CustomerLabel, Source.Title, Source.FirstName,
                    Source.MiddleName, Source.LastName, Source.NameStyle, Source.BirthDate, Source.MaritalStatus,
                    Source.Suffix, Source.Gender, Source.EmailAddress, Source.YearlyIncome, Source.TotalChildren,
                    Source.NumberChildrenAtHome, Source.Education, Source.Occupation, Source.HouseOwnerFlag,
                    Source.NumberCarsOwned, Source.AddressLine1, Source.AddressLine2, Source.Phone,
                    Source.DateFirstPurchase, Source.CustomerType, Source.CompanyName,
                    Source.ETLLoadID, Source.LoadDate, Source.UpdateDate);

        SET @RowsAffected = @@ROWCOUNT;

        SET IDENTITY_INSERT stg.Customer OFF;

        UPDATE dbo.ETL_IncrementalControl
        SET LastLoadDate = @MaxUpdateDate
        WHERE TableName = 'Customer';

        SELECT @RowsAffected AS AffectedRows, @MaxUpdateDate AS NewLastLoadDate;

    END TRY
    BEGIN CATCH
        SET IDENTITY_INSERT stg.Customer OFF;
        THROW;
    END CATCH
END

GO








SELECT COUNT(*) FROM ContosoRetailDW.dbo.FactSales FS WHERE FS.UpdateDate > '1900-01-01'
SELECT COUNT(*) FROM  stg.Sales SQ WHERE SQ.UpdateDate >'1900-01-01'

SELECT COUNT(*) FROM stg.SalesQuota SQ

SELECT  TOP 100 S.UpdateDate,S.LoadDate,* FROM stg.Sales S


SELECT COUNT(*) FROM ContosoRetailDW.dbo.FactSales FS JOIN stg.Sales SQ ON FS.SalesKey=SQ.SalesKey AND SQ.LoadDate = FS.LoadDate
AND sq.UpdateDate >'1900-01-01'



SELECT * FROM dbo.ETL_IncrementalControl EIC
SELECT * FROM dbo.ETL_ExecutionLog EEL ORDER BY EEL.LogID DESC

UPDATE dbo.ETL_IncrementalControl SET LastLoadDate='1900-01-01 00:00:00.000' WHERE ControlID=1


SET STATISTICS TIME ON
EXEC dbo.usp_MergeIncremental_Sales
SET STATISTICS TIME OFF


--SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'SalesQuota';

--SELECT * FROM ContosoRetailDW.dbo.FactSalesQuota WHERE UpdateDate > '2026-08-19 00:55:11.860'

--SELECT * FROM ContosoRetailDW.dbo.DimCustomer DC


SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'Customer';


SELECT LastLoadDate FROM dbo.ETL_IncrementalControl WHERE TableName = 'Customer';

SELECT * FROM ContosoRetailDW.dbo.DimCustomer
WHERE UpdateDate > '2026-08-19 00:55:12.083'

SELECT * FROM ContosoRetailDW.dbo.FactSales 
WHERE UpdateDate > '2026-08-19 00:41:56.130'

GO



SELECT * FROM dbo.ETL_IncrementalControl EIC




SET STATISTICS TIME ON
EXEC dbo.usp_MergeIncremental_Sales
SET STATISTICS TIME OFF


SELECT TOP 5 * FROM dbo.ETL_ExecutionLog ORDER BY LogID DESC;

SELECT * FROM dbo.ETL_FullLoad_Config EFLC
SELECT * FROM dbo.ETL_IncrementalControl EIC

