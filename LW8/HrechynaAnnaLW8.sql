﻿USE WebStor;

--Напишемо запит, який поверне список працівників старше 45 років у порядку спадання

SELECT [EMPL_NUM]
       ,[NAME]
	   ,[AGE]
	   ,[TITLE]
FROM [dbo].[SALESREPS]
WHERE Age > 45
ORDER BY AGE DESC;

--Напишемо запит, який поверне список унікальних комбінацій значень ідентифікатора виробника (MFR) та ідентифікатора товару (PRODUCT). 
--Врахуємо тільки замовлення за 2008 рік.

SELECT DISTINCT
       [MFR]
      ,[PRODUCT]
FROM [dbo].[ORDERS]
WHERE ORDER_DATE BETWEEN '20080101' AND  '20081231'

/*Напишемо запит, який поверне ідентифікатор працівника ([REP]) з найбільшою кількістю проведених замовлень.
Врахуємо можливість того, що одразу кілька працівників можуть мати однакову кількість проведених замовлень.
Врахуємо тільки замовлення за 2008 рік.*/

SELECT TOP 1 
WITH TIES [REP],
    COUNT(*) AS ORDER_Count
FROM [dbo].[ORDERS]
WHERE [ORDER_DATE] BETWEEN '20080101' AND  '20081231'
GROUP BY [REP]
ORDER BY ORDER_Count DESC;