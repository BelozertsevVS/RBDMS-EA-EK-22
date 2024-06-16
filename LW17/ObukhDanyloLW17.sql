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
На завершальному етапі процедура виводить повідомлення про статус операції*/

CREATE PROCEDURE TEST
@CUSTOMER INT,
@EMPLOYEE INT,
@MANUFACTURED CHAR(15),
@PRODUCT CHAR(15),
@QUANTITY INT AS 
BEGIN
DECLARE @PRICE DECIMAL(10, 2)
DECLARE @ORDER_SUM DECIMAL(10, 2)
DECLARE @CREDIT_LIMIT DECIMAL(10, 2)
DECLARE @CURRENT_SALES DECIMAL(10, 2)
   
SELECT @PRICE = [PRICE] 
FROM  [dbo].[PRODUCTS]
WHERE [PRODUCT_ID] = @PRODUCT

/* ЕТАП 1 */

IF @QUANTITY <= (SELECT [QTY_ON_HAND] 
FROM [dbo].[PRODUCTS] 
WHERE [PRODUCT_ID] = @PRODUCT) 
BEGIN 

/* ЕТАП 2 */

SET @ORDER_SUM = @PRICE * @QUANTITY        
SELECT @CREDIT_LIMIT = [CREDIT_LIMIT]
FROM [dbo].[CUSTOMERS]
WHERE [CUST_NUM] = @CUSTOMER        
SELECT @CURRENT_SALES = [SALES]
FROM [dbo].[SALESREPS]
WHERE [EMPL_NUM] =@EMPLOYEE

/* ЕТАП 3 */

IF @CREDIT_LIMIT >= @ORDER_SUM
BEGIN

/* ЕТАП 4 */

BEGIN TRANSACTION;
UPDATE [dbo].[PRODUCTS]
SET    [QTY_ON_HAND] = [QTY_ON_HAND] - @QUANTITY
WHERE  [PRODUCT_ID] = @PRODUCT
UPDATE [dbo].[CUSTOMERS]
SET    [CREDIT_LIMIT] = [CREDIT_LIMIT] - @ORDER_SUM
WHERE  [CUST_NUM] = @CUSTOMER            
INSERT INTO [dbo].[ORDERS] ([CUST], [REP], [MFR], [PRODUCT], [QTY], [AMOUNT])
VALUES 
(@CUSTOMER,@EMPLOYEE, @MANUFACTURED, @PRODUCT, @QUANTITY, @ORDER_SUM)

/* ЕТАП 5 */   

UPDATE [dbo].[SALESREPS]
SET [SALES] = [SALES] + @ORDER_SUM
WHERE [EMPL_NUM] = @EMPLOYEE            
COMMIT TRANSACTION;

/* ЗАВЕРШЕННЯ */

PRINT 'Операція успішна.'
END
ELSE 
BEGIN ROLLBACK TRANSACTION;
PRINT 'Кредитний ліміт перевищено.'
END
END
ELSE
BEGIN PRINT 'Недостатньо товару на складі.'
END
END;