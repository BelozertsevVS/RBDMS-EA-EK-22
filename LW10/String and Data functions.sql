-- Строкові функції

-- Upper - переведення тексту у верхній регістр

SELECT p.DESCRIPTION,
       UPPER(p.DESCRIPTION) AS UpperDescr
  FROM [dbo].[PRODUCTS] p;

-- LOWER - переведення тексту унижній регістр

SELECT p.DESCRIPTION,
       LOWER(p.DESCRIPTION) AS LowerDescr
  FROM [dbo].[PRODUCTS] p;


-- LEN / DATALENGTH повертає довжину строкового значення у символах / у байтах

SELECT p.DESCRIPTION
      ,LEN(p.DESCRIPTION + ' ' + ' ' + ' ') AS DescrLEN
	  ,DATALENGTH (p.DESCRIPTION + ' ' + ' ' + ' ') AS DescrDATALENGTH
  FROM [dbo].[PRODUCTS] p;

-- CONCAT - зчеплення рядків
SELECT 'Dan' + ' ' + 'Brown'
      ,'Dan' + ' ' + NULL + 'Brown' 
	  ,CONCAT('Dan', ' ', 'Brown', NULL)

-- CONCAT_WS - зчеплення рядків з роздільниками

SELECT CONCAT_WS('  ',MFR_ID, PRODUCT_ID, [DESCRIPTION])
  FROM [dbo].[PRODUCTS] p


-- REPLACE - заміщення

SELECT *
      ,REPLACE(p.DESCRIPTION, '300', 'three hundreds' )
  FROM [dbo].[PRODUCTS] p;

--RIGHT - повертає вказану кількість символів з кінця рядка 
SELECT *
      ,RIGHT(p.PRODUCT_ID, 3)
	  ,DATALENGTH(RIGHT(p.PRODUCT_ID, 3))
  FROM [dbo].[PRODUCTS] p;

-- LEFT - повертає вказану кількість символів з початку рядка 

SELECT *
      ,LEFT(p.PRODUCT_ID, 2)
  FROM [dbo].[PRODUCTS] p;

-- SUBSTRING - використовується для отримання частини рядка
SELECT *
      ,SUBSTRING(p.DESCRIPTION, 4, 3)
  FROM [dbo].[PRODUCTS] p;

-- CHARINDEX 
SELECT *
      ,CHARINDEX('Widget', p.[DESCRIPTION])
  FROM [dbo].[PRODUCTS] p;

--------------------------------------
-- Data functions

SELECT GETDATE() AS [GETDATE]                      -- поточні дата та час. Повертає тип даних datetime 
      ,CURRENT_TIMESTAMP AS [CURRENT_TIMESTAMP]    -- ANSI/ISO аналог GETDATE поточні дата та час. Повертає тип даних datetime
	  ,GETUTCDATE() AS [GETUTCDATE]                -- поточна дата та час (UTC-0) datetime
	  ,SYSDATETIME() AS [SYSDATETIME]              -- поточна дата та чаc datetime2
	  ,SYSUTCDATETIME() AS [SYSUTCDATETIME]        -- поточна дата та чаc (UTC-0) datetime2
	  ,SYSDATETIMEOFFSET() AS [SYSDATETIMEOFFSET]  -- поточна дата та чаc з урахуванням часового поясу DATETIMEOFFSET





/*
YEAR()
MONTH()
DAY()
WEEK()
DATEDIFF()
DATEPART()
DATENAME()
*/

SELECT YEAR(GETDATE()) AS [YEAR]
      ,MONTH(GETDATE()) AS [MONTH]
	  ,DAY(GETDATE()) AS [DAY]