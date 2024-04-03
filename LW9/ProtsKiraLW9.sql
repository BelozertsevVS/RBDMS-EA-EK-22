﻿/*
1.1. Напишіть запит, який поверне список офісів східного регіону з ціллю по продажах менше або рівної 350000.00.
- Використовується таблиця [dbo].[OFFICES]
- Результуючий набір даних містить: Ідентифікатор офісу, місто, ідентифікатор керівника офісу*/
USE WebStor;
SELECT * FROM [dbo].[OFFICES]

SELECT [OFFICE]
      ,[CITY]
	  ,[MGR]
FROM [dbo].[OFFICES]
WHERE [REGION] = 'Eastern'
  AND [TARGET] <= 350000.00  

/*
2.1 Hапишіть запит, що повертає список замовлень, які були проведені не в 2008 році.
Враховуйте тільки замовлення на товари з ідентифікатором товарів (PRODUCT), які містять «A» другим символом або «0» в будь-якому місці.
- Використовується таблиця [dbo].[ORDERS]
- Задійте предикат LIKE
- Задійте предикат NOT BETWEEN
- Результуючий набір даних містить усі стовпці
*/

SELECT * FROM [dbo].[ORDERS]
WHERE [ORDER_DATE] NOT BETWEEN '20080101' AND '20081231'
AND   ([PRODUCT] LIKE '_A%' 
OR     [PRODUCT] LIKE '%0%')

/*
2.2 Напишіть запит, що повертає загальну суму проведених замовлень по ідент. виробника товарів (MFR),
які були проведені не в 2008 році. Враховуйте тільки замовлення на товари з ідентифікатором товарів (PRODUCT), які містять
A другим символом або 0 в будь-якому місці.
- Використовується таблиця [dbo].[ORDERS]
- Задійте предикат LIKE
- Задійте предикат NOT BETWEEN
- Задійте агрегатну функцію SUM
- Результуючий набір даних містить: Ідент. виробника товарів, кіль-ть унікальних замовлень
- Відсортуйте результат за загальною сумою (за зростанням)
*/

SELECT [MFR]
      ,COUNT(DISTINCT [ORDER_NUM]) AS COUNT_UNIQUE_ORDERS
FROM [dbo].[ORDERS]
WHERE [ORDER_DATE] NOT BETWEEN '20080101' AND '20081231'
AND   ([PRODUCT] LIKE '_A%' 
OR     [PRODUCT] LIKE '%0%')
GROUP BY [MFR]
ORDER BY SUM([AMOUNT]) ASC;

/*
2.3 Напишіть запит, що повертає ідент. виробника з найбільшою загальною сумою проведених замовлень.
Враховуйте ймовірність того, що одразу кілька виробників можуть мати одну і ту ж загальну суму.
Враховуйте тільки замовлення, які були проведені не в 2008 році.
Враховуйте тільки замовлення на товари з ідентифікатором товарів (PRODUCT), які містять
A другим символом або 0 в будь-якому місці.
- Використовується таблиця [dbo].[ORDERS]
- Задійте предикат LIKE
- Задійте предикат NOT BETWEEN
- Задійте агрегатну функцію SUM
- Задійте фільтр TOP і оператор WITH TIES
- Результуючий набір даних містить: Ідент. виробника товарів, загальна сума
*/

SELECT TOP 1 
WITH TIES [MFR]
	      ,SUM([AMOUNT]) AS TOTAL_SUM
FROM [dbo].[ORDERS]
WHERE [ORDER_DATE] NOT BETWEEN '2008-01-01' AND '2008-12-31'
AND   ([PRODUCT] LIKE '_A%' 
OR     [PRODUCT] LIKE '%0%')
GROUP BY [MFR]
ORDER BY TOTAL_SUM DESC;


/*3
Напишіть запит, який поверне ідент. офісу з найбільшою кількістю працівників.
Враховуйте ймовірність того, що відразу кілька офісів можуть мати одну й ту саму кількість працівників.
Враховуйте лише працівників на посаді Sales Rep та у віці 29, 45, 48.
- Використовується таблиця [dbo].[SALESREPS]
- Задіяти предикат IN
- Задіяйте агрегатну функцію COUNT
- Задійте фільтр TOP та оператор WITH TIES
- Результуючий набір даних містить: Ідент. офісу, кількість працівників
*/

SELECT TOP 1 
WITH TIES [REP_OFFICE]
         ,COUNT (*) AS [EMPL_COUNT]
FROM [dbo].[SALESREPS]
WHERE [TITLE] IN ('Sales Rep')  
AND   [AGE]   IN (29, 45, 48) 
GROUP BY [REP_OFFICE]
ORDER BY [EMPL_COUNT] DESC;

