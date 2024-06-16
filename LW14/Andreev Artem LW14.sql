/* Завдання 1
Напишіть запит, який поверне список унікальних ідентифікаторів виробників товару (MFR).
Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). 
Для цього необхідно використовувати оператор LIKE та підстановочні знаки (wildcards).
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS
- Застосуйте внутрішнє з'єднання (ANSI-92)
- Результуючий набір даних містить: Ідентифікатор виробника товару (без дублікатів)
*/

SELECT DISTINCT 
    O.[MFR]
FROM 
    [dbo].[CUSTOMERS] C
INNER JOIN 
    [dbo].[ORDERS] O 
    ON C.[CUST_NUM] = O.[CUST]
WHERE 
    YEAR(O.[ORDER_DATE]) = 2008
    AND C.[COMPANY] LIKE '%CORP%'
ORDER BY 
    O.[MFR];

/*Завдання 2 
Напишіть запит, який у розрізі ідентифікатора клієнта (CUST_NUM) та місяця проведення замовлення (ORDER_DATE) 
поверне кількість унікальних замовлень (для цього використовується GROUP BY). 
Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP. у назві (COMPANY). 
У випадку, якщо у клієнта не було жодного замовлення, залиште такого клієнта у результуючому наборі даних.
Відсортуйте результативний набір даних за кількістю проведених замовлень (за спаданням)
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS
- Застосуйте ліве зовнішнє з'єднання
- Результуючий набір даних містить: ідентифікатор клієнта, місяць проведення замовлення 
(для отримання місяця з дати замовлення використовуємо функцію MONTH), 
кількість унікальних замовлень (використовуємо COUNT)*/

SELECT 
    C.[CUST_NUM],
    MONTH(O.[ORDER_DATE]) AS ORDER_MONTH,
    COUNT(DISTINCT O.[ORDER_NUM]) AS UNIQUE_ORDERS
FROM 
    [dbo].[CUSTOMERS] C
LEFT JOIN 
    [dbo].[ORDERS] O 
    ON C.[CUST_NUM] = O.CUST
    WHERE YEAR(O.[ORDER_DATE]) = 2008
    AND C.[COMPANY] LIKE '%CORP%'
GROUP BY 
    C.[CUST_NUM], 
    MONTH(O.[ORDER_DATE])
ORDER BY 
    UNIQUE_ORDERS DESC;

	/*Завдання 3 
Напишіть запит, який поверне список (без дублікатів) придбаних товарів.
Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). 
У випадку, якщо у клієнта не було жодного замовлення, залиште такого клієнта у результуючому наборі даних.
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS, dbo.PRODUCTS
- Застосуйте ліве зовнішнє з'єднання
- Результуючий набір даних містить: Ідентифікатор клієнта, назва компанії (у верхньому регістрі. 
Для цього використовуємо рядкову функцію (String Function) UPPER), опис товару ([DESCRIPTION])
*/

SELECT DISTINCT 
    C.[CUST_NUM],
    UPPER(C.[COMPANY]) AS COMPANY,
    P.[DESCRIPTION]
FROM 
    [dbo].[CUSTOMERS] C
LEFT JOIN 
    [dbo].[ORDERS] O 
    ON C.[CUST_NUM] = O.[CUST]
LEFT JOIN 
    [dbo].[PRODUCTS] P 
    ON O.[PRODUCT] = P.[PRODUCT_ID]
WHERE 
    YEAR(O.[ORDER_DATE]) = 2008
    AND C.[COMPANY] LIKE '%CORP%'
ORDER BY 
    C.[CUST_NUM], 
    P.[DESCRIPTION];