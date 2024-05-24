-- Задача 1: Запит, який поверне дані продукту з найбільшою довжиною (за кількістю символів) опису.
-- Використовується таблиця [dbo].[PRODUCTS]
-- Застосуйте строкову функцію LEN
-- Результируючий набір даних містить: Ідент. виробника, ідент. продукту, опис продукту, довжина опису

SELECT TOP 1 WITH TIES
    [MFR_ID],
    [PRODUCT_ID],
    [DESCRIPTION],
    LEN([DESCRIPTION]) AS "DescriptionLength"
FROM [dbo].[PRODUCTS]
ORDER BY
    LEN([DESCRIPTION]) DESC;

-- Задача 2: Запит, що повертає дані продуктів, ідентифікатор яких містить лише цифри.
-- Використовується таблиця [dbo].[PRODUCTS]
-- Застосуйте предикат NOT LIKE
-- Застосуйте строкові функції: CONCAT_WS, UPPER, LEN, RTRIM
-- Результируючий набір даних містить: сконкатенований рядок, довжина сконкатенованого рядка
-- Відсортуйте результируючий набір даних за довжиною сконкатенованого рядка (за зменшенням)

SELECT DISTINCT
    CONCAT_WS(' ', UPPER(RTRIM(MFR_ID)), UPPER(RTRIM(PRODUCT_ID)), UPPER(RTRIM([DESCRIPTION]))) AS ConcatenatedString,
    LEN(CONCAT_WS(' ', UPPER(RTRIM(MFR_ID)), UPPER(RTRIM(PRODUCT_ID)), UPPER(RTRIM([DESCRIPTION])))) AS ConcatenatedLength
FROM
    [dbo].[PRODUCTS]
WHERE 
    PRODUCT_ID NOT LIKE '%[^0-9]%'  
ORDER BY
    ConcatenatedLength DESC;


-- Задача 3: Запит, який поверне список клієнтів з найменшим кредитним лімітом.
-- Використовується таблиця [dbo].[CUSTOMERS]
-- Результируючий набір даних містить: ідент. клієнта, найменування клієнта, кредитний ліміт
-- Найменування клієнта необхідно відобразити як 2 букви на початку рядка і 2 букви в кінці рядка, всі інші букви замінити на символ *

SELECT TOP 1 WITH TIES
    [CUST_NUM],
	SUBSTRING ([COMPANY], 1, 2) + '***' + RIGHT ([COMPANY], 2) AS Customer_Name,
    CREDIT_LIMIT
FROM
    [dbo].[CUSTOMERS]
ORDER BY
    [CREDIT_LIMIT];
