/*Завдання 1
Напишіть запит, який поверне список ідентифікаторів виробників та ідентифікаторів товарів без дублікатів.
Для відсікання дублікатів необхідно задіяти функцію ранжування ROW_NUMBER.
- Використовується таблиця ORDERS
- Не використовуйте оператор DISTINCT
- Результуючий набір даних містить: ідентифікатори виробників та ідентифікатори товарів*/

SELECT [MFR],[PRODUCT]
FROM (SELECT [MFR], [PRODUCT],
           ROW_NUMBER() OVER (PARTITION BY [MFR], [PRODUCT] ORDER BY (SELECT NULL)) AS row_num
    FROM [dbo].[ORDERS]) AS ranked_orders
WHERE row_num = 1;

/*Завдання 2
Напишіть запит, що повертає список замовлень на товари, які продавалися більше одного разу (за кількістю замовлень на <MFR>, <PRODUCT>).
- Використовується таблиця ORDERS
- Задійте функції ранжування для визначення товарів, які продавалися більше одного разу*/

SELECT [MFR]
      ,[PRODUCT]
	  ,COUNT(*) AS [order_count]
	  ,RANK() OVER (ORDER BY COUNT(*) DESC) AS [rank]
FROM [dbo].[ORDERS]
GROUP BY [MFR], [PRODUCT]
HAVING COUNT(*) > 1;

/*Завдання 3
Напишіть запит, який для кожної окремої посади поверне найбільш досвідченого працівника (за кількістю відпрацьованих років).
Враховуйте ймовірність того, що одразу кілька працівників мають однаковий стаж.
Розрахуйте кількість відпрацьованих років за допомогою функції DATEDIFF.
Визначте найбільш досвідчених працівників для кожної окремої посади за допомогою функції ранжування DENSE_RANK.
- Використовується таблиця [dbo].[SALESREPS]*/
select * from [dbo].[SALESREPS]
WITH Ranked_Salesreps 
AS 
(SELECT  [TITLE]
        ,[EMPL_NUM]
        ,[NAME]
        ,DATEDIFF(YEAR, [HIRE_DATE], GETDATE()) AS Years_Of_Service
        ,DENSE_RANK() OVER (PARTITION BY [TITLE] ORDER BY DATEDIFF(YEAR, [HIRE_DATE], GETDATE()) DESC) AS [rank]
 FROM[dbo].[SALESREPS])
SELECT [TITLE]
      ,[EMPL_NUM]
      ,[NAME]
      ,Years_Of_Service
FROM
    Ranked_Salesreps
WHERE
    [rank] = 1;

