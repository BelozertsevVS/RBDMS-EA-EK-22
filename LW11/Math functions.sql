-- Математичні функції

-- ABS
SELECT ABS(5 + 255);
SELECT ABS(-255);

-- CEILING
SELECT CEILING(122);

-- FLOOR
SELECT FLOOR(123.1);

-- PI
SELECT PI();

--POWER
SELECT POWER(2, 3);

-- ROUND (number, decimal_places, operation )
SELECT ROUND(123.5567, 2, 0);
SELECT ROUND(123.5567, 2, 1);

https://learn.microsoft.com/en-us/sql/t-sql/functions/mathematical-functions-transact-sql?view=sql-server-ver16

/*
Завдання 1
Написати запит, який поверне список замовлень з парними ідентифікаторами
- використати [dbo].[ORDERS]
- використати функцію FLOOR
*/

SELECT *
  FROM [dbo].[ORDERS]
 WHERE FLOOR(ORDER_NUM / 2.0) = (ORDER_NUM / 2.0)
;

/*
Завдання 2
Написати запит, який поверне список замовлень з не парними ідентифікаторами
- використати [dbo].[ORDERS]
- використати функцію CEILING
*/

SELECT *
  FROM [dbo].[ORDERS]
 WHERE CEILING(ORDER_NUM / 2.0) != (ORDER_NUM / 2.0)
;

/*

+
-
*
/
%

*/

-- +
SELECT 1 + 2 + 3;  -- = 6

SELECT '1' + 2;    -- = 3

SELECT 1 + '2';   -- = 3

SELECT '1' + '2';   -- '12'

SELECT 'Hello' + '!';   -- 'Hello!'


SELECT 1 + 2 + 3 + NULL;   --NULL

SELECT 'Hello' + NULL + '!';   --NULL


-- -
SELECT 3 - 2 - NULL;   --NULL


-- *
SELECT '3' * 2; 


-- /
SELECT 3/2;  --1

SELECT 3.0/2; --1.500000

SELECT 3/NULL; --NULL

SELECT 3/0;  --Incorrect syntax near '/'.

SELECT 3/NULLIF(0, 0); -- NULL


-- %


SELECT 17.56 % 2  
