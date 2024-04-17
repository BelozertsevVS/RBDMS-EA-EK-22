/*
Напишемо запит, який поверне список унікальних ідентифікаторів виробників товару (MFR).
Врахуємо лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). Для цього необхідно використовувати оператор LIKE та підстановочні знаки (wildcards).
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS;
- Застосуємо внутрішнє з'єднання (ANSI-92);
- Результуючий набір даних міститиме: Ідентифікатор виробника товару (без дублікатів).
*/
--Виконання завдання:
SELECT DISTINCT o.MFR
FROM [dbo].[CUSTOMERS] c
JOIN [dbo].[ORDERS] o ON c.CUST_NUM = o.CUST
WHERE YEAR(o.ORDER_DATE) = 2008 
AND c.COMPANY LIKE '%CORP%'
;
--Завдання виконано.

/*
Напишемо запит, який у розрізі ідентифікатора клієнта (CUST_NUM) та місяця проведення замовлення (ORDER_DATE) поверне кількість унікальних замовлень (для цього використовується GROUP BY). 
Врахуємо лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP. у назві (COMPANY). 
У випадку, якщо у клієнта не було жодного замовлення, залишимо такого клієнта у результуючому наборі даних.
Відсортуємо результативний набір даних за кількістю проведених замовлень (за спаданням)
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS;
- Застосуємо ліве зовнішнє з'єднання;
- Результуючий набір даних міститиме: ідентифікатор клієнта, місяць проведення замовлення (для отримання місяця з дати замовлення використовуємо функцію MONTH), кількість унікальних замовлень (використовуємо COUNT)
*/
--Виконання завдання:
SELECT 
    C.CUST_NUM AS Customer_ID,
    MONTH(O.ORDER_DATE) AS Order_Month,
    COUNT(DISTINCT O.ORDER_NUM) AS Unique_Orders_Count
FROM [dbo].[CUSTOMERS] C
LEFT JOIN [dbo].[ORDERS] O ON C.CUST_NUM = O.CUST
WHERE YEAR(O.ORDER_DATE) = 2008
    AND C.COMPANY LIKE '%CORP%'
GROUP BY C.CUST_NUM, 
    MONTH(O.ORDER_DATE)
ORDER BY Unique_Orders_Count DESC;
--Завдання виконано.

/*
Напишемо запит, який поверне список (без дублікатів) придбаних товарів. 
Врахуємо лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). 
У випадку, якщо у клієнта не було жодного замовлення, залишимо такого клієнта у результуючому наборі даних.
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS, dbo.PRODUCTS;
- Застосуємо ліве зовнішнє з'єднання;
- Результуючий набір даних міститиме: Ідентифікатор клієнта, назва компанії (у верхньому регістрі. Для цього використовуємо рядкову функцію (String Function) UPPER), опис товару ([DESCRIPTION])
*/
--Виконання завдання:
SELECT 
    c.CUST_NUM,
    UPPER(c.COMPANY) AS Company_Name,
    p.DESCRIPTION
FROM [dbo].[CUSTOMERS] c
LEFT JOIN 
    [dbo].[ORDERS] o ON c.CUST_NUM = o.CUST
LEFT JOIN 
    [dbo].[PRODUCTS] p ON o.PRODUCT = p.PRODUCT_ID
WHERE c.COMPANY LIKE '%CORP%'
    AND YEAR(o.ORDER_DATE) = 2008
GROUP BY 
    c.CUST_NUM, c.COMPANY, p.DESCRIPTION
ORDER BY 
    c.CUST_NUM, p.DESCRIPTION;
--Завдання виконано.