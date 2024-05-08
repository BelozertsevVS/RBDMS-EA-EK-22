USE WebStor;

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
На третьому етапі, якщо сума кредитного ліміту компанії  більша або дорівнює сумі замовлення - зменшується кількість одиниць товару на складі, сума замовлення вираховується з кредитного ліміту компанії та замовлення вноситься до таблиці замовлень. 
На четвертому етапі сума поточних продажів службовця збільшується  на суму замовлення. 
На п'ятому етапі сума поточних продажів офісу даного співробітника збільшується на суму замовлення.
На завершальному етапі процедура виводить повідомлення про статус операції.
*/

CREATE PROCEDURE PlaceOrder

    @CustomerID INT,
    @EmployeeID INT,
    @ManufacturerID INT,
    @ProductID INT,
    @Qty1 INT
AS
BEGIN
    DECLARE @Price DECIMAL(10, 2)
    DECLARE @TotalAmount DECIMAL(10, 2)
    DECLARE @CreditLimit DECIMAL(10, 2)
    DECLARE @CurrentSales DECIMAL(10, 2)
    
    -- Отримання ціни товару
    SELECT @Price = [PRICE]
    FROM [dbo].[PRODUCTS]
    WHERE [PRODUCT_ID] = @ProductID
    
    -- ПЕРШИЙ ЕТАП: Перевірка наявності товару на складі
    IF (SELECT [QTY_ON_HAND] FROM [dbo].[PRODUCTS] WHERE [PRODUCT_ID] = @ProductID) >= @Qty1
    BEGIN
        
		
		-- ДРУГИЙ ЕТАП: Розрахунок суми замовлення
        SET @TotalAmount = @Price * @Qty1
        
        -- Отримання кредитного ліміту клієнта
        SELECT @CreditLimit = [CREDIT_LIMIT]
        FROM [dbo].[CUSTOMERS]
        WHERE [CUST_NUM] = @CustomerID
        
        -- Отримання поточних продажів службовця
        SELECT @CurrentSales = [SALES]
        FROM [dbo].[SALESREPS]
        WHERE [EMPL_NUM] = @EmployeeID
        
        -- ТРЕТІЙ ЕТАП: Перевірка наявності кредитного ліміту
        IF @CreditLimit >= @TotalAmount
        BEGIN
		
		
		-- ЧЕТВЕРТИЙ ЕТАП
            BEGIN TRANSACTION;
            -- Зменшення кількості товару на складі
            UPDATE [dbo].[PRODUCTS]
            SET [QTY_ON_HAND] = [QTY_ON_HAND] - @Qty1
            WHERE [PRODUCT_ID] = @ProductID
            
            -- Вирахування суми з кредитного ліміту
            UPDATE [dbo].[CUSTOMERS]
            SET [CREDIT_LIMIT] = [CREDIT_LIMIT] - @TotalAmount
            WHERE [CUST_NUM] = @CustomerID
            
            -- Внесення замовлення до таблиці замовлень
            INSERT INTO [dbo].[ORDERS] ([CUST], [REP], [MFR], [PRODUCT], [QTY], [AMOUNT])
            VALUES ( @CustomerID, @EmployeeID, @ManufacturerID, @ProductID, @Qty1, @TotalAmount)
            
            -- Оновлення поточних продажів службовця та офісу
            UPDATE [dbo].[SALESREPS]
            SET [SALES] = [SALES] + @TotalAmount
            WHERE [EMPL_NUM] = @EmployeeID
            
            COMMIT TRANSACTION;
           
		   -- П'ЯТИЙ ЕТАП
            PRINT 'Замовлення успішно оформлено.'
        END
        ELSE
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'Клієнт перевищив кредитний ліміт.'
        END
    END
    ELSE
    BEGIN
        PRINT 'На складі недостатньо товару.'
    END
END;


-- Завдання виконано