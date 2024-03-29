﻿USE WebStor;

/*
Напишемо запит, який поверне список офісів східного регіону з ціллю по продажах менше або рівної 350000.00.
Використаємо таблицю [dbo].[OFFICES];
Результуючий набір даних міститиме: Ідентифікатор офісу, місто, ідентифікатор керівника офісу.
*/

--Виконання завдання:
SELECT [OFFICE]
      ,[CITY]
	  ,[MGR]
FROM [dbo].[OFFICES]
WHERE 
    [REGION] = 'Eastern' 
    AND [SALES] <= 350000.00;
	--Значень менше 350000.00 в східному регіоні немає, тому таблиця є пустою.

/*
Напишемо запит, що повертає список замовлень, які були проведені не в 2008 році.
Врахуємо тільки замовлення на товари з ідентифікатором товарів (PRODUCT), які містять  «A» другим символом або «0» в будь-якому місці.
Використаємо таблицю [dbo].[ORDERS]; 
Задіємо предикат LIKE та NOT BETWEEN;
Результуючий набір даних міститиме усі стовпці.
*/

--Виконання завдання:
SELECT *
FROM [dbo].[ORDERS]
WHERE YEAR(ORDER_DATE) <> 2008
AND PRODUCT IN (
    SELECT [PRODUCT]
    FROM [dbo].[ORDERS]
    WHERE PRODUCT LIKE '_[A]%'
    OR PRODUCT LIKE '%0%'
)
;
--Завдання виконано, все працює.

/*
Напишемо запит, що повертає загальну суму проведених замовлень по ідент. виробника товарів (MFR), 
які були проведені не в 2008 році. Врахуємо тільки замовлення на товари з ідентифікатором товарів (PRODUCT), які містять 
A другим символом або 0 в будь-якому місці.
Використаємо таблицю [dbo].[ORDERS];
Задіємо предикат LIKE, NOT BETWEEN та агрегатну функцію SUM;
Результуючий набір даних міститиме: Ідент. виробника товарів, кіль-ть унікальних замовлень;
Відсортуємо результат за загальною сумою (за зростанням).
*/

--Виконання завдання:
SELECT MFR, COUNT(DISTINCT ORDER_NUM) AS TotalOrders, SUM(AMOUNT) AS TotalAmount
FROM [dbo].[ORDERS]
WHERE YEAR(ORDER_DATE) <> 2008
AND PRODUCT IN (
    SELECT PRODUCT
    FROM [dbo].[ORDERS]
    WHERE PRODUCT LIKE '_[A]%'
    OR PRODUCT LIKE '%0%'
)
GROUP BY MFR
ORDER BY TotalAmount ASC;
--Завдання виконано, все працює.

/*
Напишемо запит, що повертає ідент. виробника з найбільшою загальною сумою проведених замовлень. 
Враховуємо ймовірність того, що одразу кілька виробників можуть мати одну і ту ж загальну суму; тільки замовлення, які були проведені не в 2008 році;
тільки замовлення на товари з ідентифікатором товарів (PRODUCT), які містять A другим символом або 0 в будь-якому місці.
Використаємо таблицю [dbo].[ORDERS];
Задіємо предикат LIKE, NOT BETWEEN, агрегатну функцію SUM, фільтр TOP і оператор WITH TIES;
Результуючий набір даних міститиме: Ідент. виробника товарів, загальна сума.
*/

--Виконання завдання:
SELECT TOP 1 WITH TIES
    O.MFR,
    SUM(O.AMOUNT) AS TotalOrderAmount
FROM [dbo].[ORDERS] O
WHERE O.ORDER_DATE NOT BETWEEN '2008-01-01' AND '2008-12-31'
    AND O.PRODUCT LIKE '_A%' OR O.PRODUCT LIKE '%A%' OR O.PRODUCT LIKE '%0%'
GROUP BY O.MFR
ORDER BY TotalOrderAmount DESC;
--Все працює, завдання виконано.

/*
Напишемо запит, який поверне ідент. офісу з найбільшою кількістю працівників.
Врахуємо ймовірність того, що відразу кілька офісів можуть мати одну й ту саму кількість працівників, а також лише працівників на посаді Sales Rep та у віці 29, 45, 48.
Використаємо таблицю [dbo].[SALESREPS];
Задіємо предикат IN, агрегатну функцію COUNT, фільтр TOP та оператор WITH TIES;
Результуючий набір даних міститиме: Ідент. офісу, кількість працівників
*/

--Виконання завдання:
SELECT TOP 1 WITH TIES
    REP_OFFICE,
    COUNT(*) AS num_employees
FROM [dbo].[SALESREPS]
WHERE
    TITLE = 'Sales Rep'
    AND age IN (29, 45, 48)
GROUP BY
    REP_OFFICE
ORDER BY
    num_employees DESC;
--Завдання виконано, все працює.