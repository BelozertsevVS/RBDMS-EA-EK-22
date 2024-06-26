﻿/*Задача 1
Напишіть запит, який поверне список унікальних ідентифікаторів виробників.
Враховуйте тільки замовлення з парною сумою замовлення і непарною кількістю замовлених одиниць товару.
- Використовується таблиця [dbo].[ORDERS]
- Результативний набір даних містить: ідентифікатор виробника
- Відсортувати рез. набір даних за ідентифікатором виробника*/

SELECT*FROM [dbo].[ORDERS]
SELECT DISTINCT [MFR] FROM [dbo].[ORDERS]
WHERE [AMOUNT] % 2 <> 0
AND  [QTY] % 2 ! = 0
GROUP BY [MFR]

/*Задача 2

Напишіть запит, який у розрізі ідентифікатора виробника товару поверне загальну вартість од. товару на складі та середню вартість од. товарів. 
Щоб розрахувати вартість товару на складі, необхідно помножити кількість од. товару на ціну за одиницю.
Округлити результати агрегування до 2 знаків після коми.
- Використовується таблиця [dbo].[PRODUCTS]
- Результуючий набір даних містить: ідентифікатор виробника, загальну суму, середню суму.
- Відсортувати результуючий набір даних за ідентифікатором виробника*/

SELECT*FROM [dbo].[PRODUCTS]

SELECT [MFR_ID],
SUM([QTY_ON_HAND]*[PRICE]) AS Загальна_сума,
ROUND(AVG([QTY_ON_HAND]*[PRICE]),2) AS Середня_сума
FROM PRODUCTS
GROUP BY [MFR_ID] ORDER BY [MFR_ID]

/*Задача 3
Напишіть запит, який поверне працівника з найбільшою мат. різницею між ціллю за продажами і сумою поточних продаж, 
у абсолютному вимірі, тобто необхідно взяти число за модулем. 
Округлити результати обчислення до двох знаків після коми. 
Розрахувати кількість років працівника на момент найму.
Враховуйте ймовірність того, що відразу кілька працівників можуть мати одну і ту ж різницю.
- Використовується таблиця [dbo].[SALESREPS]*/

SELECT*FROM SALESREPS
SELECT TOP 1
ABS(ROUND(([QUOTA]-[SALES]),2)) AS Математична_різниця,
[AGE] - DATEDIFF(YEAR, [HIRE_DATE], GETDATE()) AS Кількість_років_праці
FROM SALESREPS
ORDER BY Математична_різниця DESC

