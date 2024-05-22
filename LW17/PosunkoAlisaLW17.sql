/*Завдання 1
Створіть збережену процедуру.
Процедура приймає параметри:
- ідентифікатор клієнта.
- ідентифікатор співробітника.
- ідентифікатор виробника.
- ідентифікатор товару.
- кількість одиниць.
На першому етапі, процедура перевіряє наявність зазначеної кількості одиниць товару на складі.
Далі, на другому етапі, проводиться розрахунок суми замовлення (PRICE * @qty).
На третьому етапі, якщо сума кредитного ліміту компанії більша або дорівнює сумі замовлення - зменшується кількість одиниць товару на складі, 
сума замовлення вираховується з кредитного ліміту компанії та замовлення вноситься до таблиці замовлень.
На четвертому етапі сума поточних продажів службовця збільшується на суму замовлення.
На п'ятому етапі сума поточних продажів офісу даного співробітника збільшується на суму замовлення.
На завершальному етапі процедура виводить повідомлення про статус операції.*/

CREATE PROCEDURE ProcessOrder
@cust_num INT, -- Параметр, що вказує ідентифікатор клієнта
@empl_num INT, -- Параметр, що вказує ідентифікатор працівника
@mfr_id CHAR(3), -- Параметр, що вказує ідентифікатор виробника
@product_id CHAR(5), -- Параметр, що вказує ідентифікатор продукту
@qty INT -- Параметр, що вказує кількість продукту в замовленні
AS
BEGIN
-- Перевірка наявності товару на складі
DECLARE @available_qty INT; -- Змінна для зберігання доступної кількості товару
SELECT @available_qty = QTY_ON_HAND
FROM PRODUCTS
WHERE MFR_ID = @mfr_id AND PRODUCT_ID = @product_id;

IF @available_qty >= @qty -- Перевірка, чи є достатня кількість товару на складі
BEGIN
-- Розрахунок суми замовлення
DECLARE @order_amount MONEY; -- Змінна для зберігання суми замовлення
SELECT @order_amount = PRICE * @qty
FROM PRODUCTS
WHERE MFR_ID = @mfr_id AND PRODUCT_ID = @product_id;

-- Перевірка кредитного ліміту
DECLARE @credit_limit MONEY; -- Змінна для зберігання кредитного ліміту клієнта
SELECT @credit_limit = CREDIT_LIMIT
FROM CUSTOMERS
WHERE CUST_NUM = @cust_num;

IF @credit_limit >= @order_amount -- Перевірка, чи кредитний ліміт перевищує суму замовлення
BEGIN
-- Оновлення кількості товару на складі
UPDATE PRODUCTS
SET QTY_ON_HAND = QTY_ON_HAND - @qty
WHERE MFR_ID = @mfr_id AND PRODUCT_ID = @product_id;

-- Оновлення кредитного ліміту та додавання замовлення
UPDATE CUSTOMERS
SET CREDIT_LIMIT = CREDIT_LIMIT - @order_amount
WHERE CUST_NUM = @cust_num;

INSERT INTO ORDERS (ORDER_DATE, CUST, REP, MFR, PRODUCT, QTY, AMOUNT)
VALUES (GETDATE(), @cust_num, @empl_num, @mfr_id, @product_id, @qty, @order_amount);

-- Збільшення суми поточних продажів службовця
UPDATE SALESREPS
SET SALES = SALES + @order_amount
WHERE EMPL_NUM = @empl_num;

-- Збільшення суми поточних продажів офісу
DECLARE @rep_office INTEGER; -- Змінна для зберігання ідентифікатора офісу
SELECT @rep_office = REP_OFFICE
FROM SALESREPS
WHERE EMPL_NUM = @empl_num;

UPDATE OFFICES
SET SALES = SALES + @order_amount
WHERE OFFICE = @rep_office;

PRINT 'Операція успішно завершена: замовлення оформлено.';
END
ELSE
BEGIN
PRINT 'Помилка: сума замовлення перевищує кредитний ліміт компанії.';
END
END
ELSE
BEGIN
PRINT 'Помилка: недостатня кількість товару на складі.';
END
END;



DROP PROCEDURE IF EXISTS ProcessOrder;
