﻿USE WebStor;

/*Завдання 1
Напишіть запит, який поверне список працівників старше 45 років.
- Використовується таблиця [dbo].[SALESREPS]
- Результуючий набір даних містить:
ідентифікатор працівника, ім'я працівника, вік, посаду
- Відсортуйте результуючий набір даних за віком (за спаданням)
*/

SELECT [EMPL_NUM]
      ,[NAME]
      ,[AGE]
      ,[TITLE]
FROM   [dbo].[SALESREPS]
WHERE  [AGE] > 45
ORDER BY [AGE] DESC
;

-- Завдання 1 - виконано



/* Завдання 2
Напишіть запит, який поверне список унікальних комбінацій значень 
ідентифікатора виробника (MFR) та ідентифікатора товару (PRODUCT). Враховуйте тільки
замовлення за 2008 рік.
- Використовується таблиця [dbo].[ORDERS]
- Задійте оператор DISTINCT
- Результуючий набір даних містить: ідентифікатор виробника, ідентифікатор товару
*/

SELECT DISTINCT [MFR]
               ,[PRODUCT]
FROM [dbo].[ORDERS]
WHERE           [ORDER_DATE] BETWEEN '20080101' AND '20081231'
;

-- Завдання 2 - виконано



/* Завдання 3
Напишіть запит, який поверне ідентифікатор працівника ([REP]) з найбільшою кількістю проведених замовлень.
Враховуйте можливість того, що одразу кілька працівників можуть мати однакову кількість проведених замовлень.
Враховуйте тільки замовлення за 2008 рік.
- Використовується таблиця [dbo].[ORDERS]
- Задійте агрегатну функцію COUNT
- Задійте оператор WITH TIES
- Результуючий набір даних містить: Ідентифікатор працівника,
кількість проведених замовлень
*/

SELECT TOP (1) WITH TIES [REP] AS [EmployeeID]
        ,COUNT(*) AS [OrderCount]
FROM     [dbo].[ORDERS]
WHERE    [ORDER_DATE] BETWEEN '20080101' AND '20081231'
GROUP BY [REP]
ORDER BY [OrderCount] DESC
;

-- Завдання 3 - виконано