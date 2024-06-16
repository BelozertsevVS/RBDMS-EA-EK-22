﻿/*Завдання 1
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

CREATE PROCEDURE TEST_PROCEDURE
@CUST_ID INT,
@EMP_ID  INT,
@MF_ID   CHAR(10),
@PR_ID   CHAR(10),
@QTY     INT
AS 
BEGIN
   DECLARE @PRICE         DECIMAL(10, 2)
   DECLARE @ORDER_SUM     DECIMAL(10, 2)
   DECLARE @CREDIT_LIMIT  DECIMAL(10, 2)
   DECLARE @CURRENT_SALES DECIMAL(10, 2)
   
   SELECT @PRICE = [PRICE] 
   FROM  [dbo].[PRODUCTS]
   WHERE [PRODUCT_ID] = @PR_ID

-- 1 етап:
    IF @QTY <= (SELECT [QTY_ON_HAND] 
	            FROM [dbo].[PRODUCTS] 
		        WHERE [PRODUCT_ID] = @PR_ID) 
    BEGIN 
-- 2 етап: 
		SET @ORDER_SUM = @PRICE * @QTY
        
		SELECT @CREDIT_LIMIT = [CREDIT_LIMIT]
		FROM [dbo].[CUSTOMERS]
		WHERE [CUST_NUM] = @CUST_ID
        
		SELECT @CURRENT_SALES = [SALES]
		FROM [dbo].[SALESREPS]
		WHERE [EMPL_NUM] = @EMP_ID

-- 3 етап: 

    IF @CREDIT_LIMIT >= @ORDER_SUM
    BEGIN

-- 4 етап:
    BEGIN TRANSACTION;

    UPDATE [dbo].[PRODUCTS]
    SET    [QTY_ON_HAND] = [QTY_ON_HAND] - @QTY
    WHERE  [PRODUCT_ID] = @PR_ID

    UPDATE [dbo].[CUSTOMERS]
    SET    [CREDIT_LIMIT] = [CREDIT_LIMIT] - @ORDER_SUM
    WHERE  [CUST_NUM] = @CUST_ID
            
    INSERT INTO [dbo].[ORDERS] ([CUST], [REP], [MFR], [PRODUCT], [QTY], [AMOUNT])
    VALUES 
	(@CUST_ID, @EMP_ID, @MF_ID, @PR_ID, @QTY, @ORDER_SUM)

-- 5 етап    

    UPDATE [dbo].[SALESREPS]
    SET [SALES] = [SALES] + @ORDER_SUM
    WHERE [EMPL_NUM] = @EMP_ID
            
    COMMIT TRANSACTION;

-- завершальний етап:

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