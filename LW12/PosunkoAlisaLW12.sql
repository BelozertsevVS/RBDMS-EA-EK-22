﻿/* Задача 1
Напишіть запит, який поверне список ідентифікаторів виробників (без дублікатів).
Враховуйте тільки замовлення, що були проведені у 2008 році.
- Використовується таблиця [dbo].[ORDERS]
- Залучіть функцію Year
- Результативний набір даних містить: Ідентифікатор виробника
- Відсортуйте результативний набір даних за Ідентифікатор виробника (за зростанням) */

SELECT DISTINCT [MFR]
FROM [dbo].[ORDERS]
WHERE YEAR([ORDER_DATE]) = 2008
ORDER BY [MFR] ASC;

/* Задача 2
Напишіть запит, який у розрізі кількості відпрацьованих років (математична різниця в роках) поверне кількість працівників.
- Використовується таблиця [dbo].[SALESREPS]
- Результативний набір даних містить: Кількість років, кількість працівників
- Відсортуйте результат за кількістю працівників за зменшенням */

SELECT
DATEDIFF(YEAR, [HIRE_DATE], GETDATE()) AS Кільк_років,
COUNT(*) AS Кільк_праців
FROM [dbo].[SALESREPS]
GROUP BY DATEDIFF(YEAR, [HIRE_DATE], GETDATE())
ORDER BY Кільк_праців DESC;

/* Задача 3
Напишіть запит, який поверне період (рік, місяць) найму з найбільшою кількістю працівників.
Враховуйте ймовірність того, що відразу кілька періодів можуть мати однакову кількість працівників.
- Використовується таблиця [dbo].[SALESREPS]
- Залучіть функції: Year, Month
- Результативний набір даних містить: Рік найму, місяць найму, кількість найнятих працівників */

SELECT 
YEAR([HIRE_DATE]) AS Рік_найму,
MONTH([HIRE_DATE]) AS Місяць_найму,
COUNT(*) AS Кільк_праців
FROM [dbo].[SALESREPS]
GROUP BY YEAR([HIRE_DATE]), MONTH([HIRE_DATE])
ORDER BY COUNT(*) DESC

/* Задача 4
Напишіть запит, який у розрізі дня тижня (у строковому представленні) поверне кількість унікальних замовлень, загальну суму продаж, загальну кількість проданих од. товару (за весь час).
Враховуйте тільки замовлення, що були проведені в зимові місяці.
- Використовується таблиця [dbo].[ORDERS]
- Результативний набір даних містить: Номер дня тижня, назву дня тижня,
загальну кількість проведених замовлень, загальну суму продаж, загальну кількість проданих од. товару.
- Відсортуйте результат за днем тижня (за зростанням).
(Культура нумерації днів тижня значення не має) */

SELECT 
DATEPART(WEEKDAY, [ORDER_DATE]) AS Номер_тижня,
DATENAME(WEEKDAY, [ORDER_DATE]) AS Назва_тижня,
COUNT(DISTINCT [ORDER_NUM]) AS Заг_кільк_замов,
SUM([AMOUNT]) AS Заг_сума_продаж,
SUM([QTY]) AS Заг_кільк_продан_товарів
FROM [dbo].[ORDERS]
WHERE MONTH([ORDER_DATE]) IN (12, 1, 2)
GROUP BY DATEPART(WEEKDAY, [ORDER_DATE]), DATENAME(WEEKDAY, [ORDER_DATE])
ORDER BY Номер_тижня ASC;
