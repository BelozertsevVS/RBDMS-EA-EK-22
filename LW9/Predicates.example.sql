-- https://learn.microsoft.com/en-us/sql/t-sql/language-elements/comparison-operators-transact-sql?view=sql-server-ver16
/*
=
>
<
>=
<=
<>
!=
!<
!>
*/



-- =

SELECT *
FROM [dbo].[OFFICES];


SELECT *
  FROM [WebStor].[dbo].[OFFICES] AS o
  WHERE o.MGR = 108 --'Eastern';
  

-- > Більше ніж
SELECT *
FROM [dbo].[OFFICES] AS O
WHERE O.[TARGET] > 500000
;

-- < Менше ніж
SELECT *
FROM [dbo].[OFFICES] AS O
WHERE O.[TARGET] < 500000
;

-->= Більше або дорівнює
SELECT *
FROM [dbo].[OFFICES] AS O
WHERE O.[TARGET] >= 350000
;


--<= Менше або дорівнює
SELECT *
FROM [dbo].[OFFICES] AS O
WHERE O.[TARGET] <= 350000
;

--<> Не дорівнює
SELECT *
FROM [dbo].[OFFICES] AS O
WHERE O.REGION <> 'Eastern'
;

--!= Не дорівнює
SELECT *
FROM [dbo].[OFFICES] AS O
WHERE O.REGION != 'Eastern'
;


-- !< Не менше ніж
SELECT *
FROM [dbo].[OFFICES] AS O
WHERE O.[TARGET] !< 500000
;

-- !> Не більше ніж
SELECT *
FROM [dbo].[OFFICES] AS O
WHERE O.[TARGET] !> 500000
;


-- https://learn.microsoft.com/en-us/sql/t-sql/queries/predicates?view=sql-server-ver16

/*
IS NULL / IS NOT NULL
BETWEEN / NOT BETWEEN
IN / NOT IN
LIKE / NOT LIKE
*/

-- IS NULL / IS NOT NULL

SELECT *
  FROM [dbo].[SALESREPS] s
 ;

SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.MANAGER IS NULL
;

SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.MANAGER IS NOT NULL
;

-- BETWEEN / NOT BETWEEN

SELECT *
  FROM [dbo].[SALESREPS] s
;

SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.HIRE_DATE BETWEEN '20060101' AND '20061231'
;

SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE YEAR(s.HIRE_DATE) = 2006
;

SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.HIRE_DATE NOT BETWEEN '20060101' AND '20061231'
;


SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.EMPL_NUM BETWEEN 101 AND 104
;


-- IN / NOT IN

SELECT *
  FROM [dbo].[SALESREPS] s
;

SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.REP_OFFICE IN (12, 21) 
;


SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.TITLE IN ('Sales Mgr', 'VP Sales') 
;


SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.REP_OFFICE NOT IN (12, 21) 
;


-- LIKE / NOT LIKE
/*
%   -будь яка кількість будь яких символів
_   -будь який один символ 
[]  -діапазон символів або набір символів
[^] -заперечення діапазону або набору символів
*/


SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.TITLE LIKE 'Sales Rep'
;

SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.TITLE IN ('Sales Rep') 
;


SELECT *
  FROM [dbo].[SALESREPS] s
 WHERE s.TITLE = 'Sales Rep'
;





-- %
SELECT *
  FROM [dbo].[PRODUCTS] p
;


SELECT *
  FROM [dbo].[PRODUCTS] p
 WHERE p.[DESCRIPTION] NOT LIKE '%Widget%'
;


-- _

SELECT *
  FROM [dbo].[PRODUCTS] p
;

SELECT *
  FROM [dbo].[PRODUCTS] p
 WHERE p.PRODUCT_ID LIKE '2A44_'
;


-- []
SELECT *
  FROM [dbo].[PRODUCTS] p
 WHERE p.DESCRIPTION LIKE '%[A-z]%' 
;



/*
NOT
OR
AND
*/

SELECT *
  FROM [dbo].[ORDERS] o
 WHERE o.ORDER_DATE BETWEEN '20070101' AND '20071231'
    AND o.PRODUCT LIKE '2A44_'
    AND o.AMOUNT >=20000
;