USE WebStor;
--Запит, який поверне список працівників старше 45 років
SELECT EMPL_NUM, NAME, AGE, TITLE 
FROM [dbo].[SALESREPS]
WHERE AGE > 45
ORDER BY AGE DESC;
/*
Запит, який поверне список унікальних комбінацій значень ідентифікатора виробника (MFR) 
та ідентифікатора товару (PRODUCT). Враховується тільки замовлення за 2008 рік.
*/
SELECT DISTINCT MFR, PRODUCT
FROM [dbo].[ORDERS]
WHERE ORDER_DATE BETWEEN '20080101' AND '20081231';
/*
Запит, який поверне ідентифікатор працівника ([REP]) з найбільшою кількістю проведених замовлень.
Враховується можливість того, що одразу кілька працівників можуть мати однакову кількість проведених замовлень.
Враховується тільки замовлення за 2008 рік.
*/          
SELECT TOP 1 WITH TIES 
       [REP]
	  ,[QTY]
      ,COUNT (*) AS OrderCount
FROM [dbo].[ORDERS]
WHERE ORDER_DATE BETWEEN '20080101' AND '20081231'
GROUP BY [REP], [QTY]
ORDER BY [QTY] DESC;
