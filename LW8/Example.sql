USE  [WebStor];



SELECT *
FROM CUSTOMERS;



SELECT 'Приклад тексту' AS [String];
SELECT 859              AS [Number];
SELECT 5250.00          AS [Financial];
SELECT SYSDATETIME()    AS [DataTime];


SELECT 'Приклад тексту' AS [String]
      ,859              AS [Number]
      ,5250.00          AS [Financial]
      ,SYSDATETIME()    AS [DataTime]
	  ,2*3              AS [Calculations]  
;

-- Компоненти конструкції SELECT
/*
1 SELECT    5 Визначає найменування стовбців для виводу даних       
2 FROM      1 Визначає найменування таблиць
3 WHERE     2 Здійснює пошук рядків за якимось критерієм
4 GROUP BY  3 Формує групи рядків
5 HAVING    4 Фільтрує групи рядків
6 ORDER BY  6 Здійснює сотртування результуючого набору даних 

*/



SELECT TOP (1)
       [NAME],
       [AGE]
  FROM [dbo].[SALESREPS]
 WHERE REP_OFFICE = 12
 ORDER BY [AGE] ASC
;


SELECT *
FROM [dbo].[SALESREPS];

SELECT TITLE
      ,COUNT(DISTINCT EMPL_NUM) AS [Qty]
	  ,SUM(SALES)               AS [TotalSales]
	  ,AVG(SALES)               AS [AVG]
	  ,MIN(SALES)               AS [MIN]
	  ,MAX(SALES)               AS [MAX]
  FROM [dbo].[SALESREPS]
  WHERE HIRE_DATE BETWEEN '20040101' AND  '20041231'
 GROUP BY TITLE 
 HAVING COUNT(DISTINCT EMPL_NUM) > 1
 ORDER BY Qty DESC 
;


-- Завдання 1
-- Отримати список замовлень за січень 2008 р.

SELECT *
FROM [dbo].[ORDERS];

SELECT *
FROM [dbo].[ORDERS]
WHERE ORDER_DATE BETWEEN '20080101' AND  '20080130';


-- Завдання 2
-- Знайти кількість співробітників

SELECT COUNT(DISTINCT EMPL_NUM) AS [Кількість співробітників]
FROM [dbo].[SALESREPS]


-- Завдання 3
-- Отримати загальну суму продажів у 2008 році
SELECT *
FROM [dbo].[ORDERS]
