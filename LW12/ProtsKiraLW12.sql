/*Задача 1
Напишіть запит, який поверне список ідентифікаторів виробників (без дублікатів).
Враховуйте тільки замовлення, що були проведені у 2008 році.
- Використовується таблиця [dbo].[ORDERS]
- Залучіть функцію Year
- Результативний набір даних містить: Ідентифікатор виробника
- Відсортуйте результативний набір даних за Ідентифікатор виробника (за зростанням)*/

SELECT * FROM [dbo].[ORDERS]

SELECT DISTINCT [MFR]
FROM [dbo].[ORDERS]
WHERE YEAR([ORDER_DATE]) = 2008
ORDER BY [MFR] ASC

/*Задача 2
Напишіть запит, який у розрізі кількості відпрацьованих років (математична різниця в роках) поверне кількість працівників.
- Використовується таблиця [dbo].[SALESREPS]
- Результативний набір даних містить: Кількість років, кількість працівників
- Відсортуйте результат за кількістю працівників за зменшенням*/

SELECT * FROM [dbo].[SALESREPS]

SELECT DATEDIFF(year, [HIRE_DATE], GETDATE()) AS [WORK_YEAR],
       COUNT(*) AS [NUM_EMPL]
FROM [dbo].[SALESREPS]
GROUP BY DATEDIFF(year, [HIRE_DATE], GETDATE())
ORDER BY [NUM_EMPL] DESC;

/*Задача 3
Напишіть запит, який поверне період (рік, місяць) найму з найбільшою кількістю працівників.
Враховуйте ймовірність того, що відразу кілька періодів можуть мати однакову кількість працівників.
- Використовується таблиця [dbo].[SALESREPS]
- Залучіть функції: Year, Month
- Результативний набір даних містить: Рік найму, місяць найму, кількість найнятих працівників*/

SELECT * FROM [dbo].[SALESREPS]

SELECT TOP 1 
WITH TIES
        YEAR([HIRE_DATE]) AS [HIRE_YEAR]
	   ,MONTH([HIRE_DATE]) AS [HIRE_MONTH]
	   ,COUNT(*) AS [NUM_EMPL]
FROM [dbo].[SALESREPS]
GROUP BY YEAR([HIRE_DATE]), MONTH([HIRE_DATE])
ORDER BY [NUM_EMPL] DESC;

/*Задача 4
Напишіть запит, який у розрізі дня тижня (у строковому представленні) поверне кількість унікальних замовлень, 
 загальну суму продаж, загальну кількість проданих од. товару (за весь час).
Враховуйте тільки замовлення, що були проведені в зимові місяці.
- Використовується таблиця [dbo].[ORDERS]
- Результативний набір даних містить: Номер дня тижня, назву дня тижня,
загальну кількість проведених замовлень, загальну суму продаж, загальну кількість проданих од. товару.
- Відсортуйте результат за днем тижня (за зростанням).
(Культура нумерації днів тижня значення не має)*/

SELECT * FROM [dbo].[ORDERS]

SELECT DATENAME(WEEKDAY,[ORDER_DATE]) AS [DAY_OF_WEEK]
      ,DATEPART(WEEKDAY,[ORDER_DATE]) AS [DATE_PART]
      ,COUNT(DISTINCT [PRODUCT]) AS [UN_PR]
	  ,SUM([AMOUNT]) AS [GEN_SUM_AMOUNT]
	  ,SUM([QTY]) AS [GEN_QTY_SUM]
FROM [dbo].[ORDERS]
WHERE MONTH([ORDER_DATE]) IN (12, 1, 2)
GROUP BY DATENAME(WEEKDAY,[ORDER_DATE]), DATEPART(WEEKDAY,[ORDER_DATE])
ORDER BY [DATE_PART] ASC