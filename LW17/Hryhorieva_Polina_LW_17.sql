USE WebStor;
/*
Завдання 1
Створіть збережену процедуру.
Процедура приймає параметри:
- ідентифікатор клієнта.
- ідентифікатор співробітника.
- ідентифікатор виробника.
- ідентифікатор товару.
- кількість одиниць.
На першому етапі, процедура перевіряє наявність зазначеної кількості одиниць товару на складі.
Далі, на другому етапі, проводиться розрахунок суми замовлення (PRICE * @qty).
На третьому етапі, якщо сума кредитного ліміту компанії більша або дорівнює сумі замовлення - 
зменшується кількість одиниць товару на складі, сума замовлення вираховується з кредитного ліміту 
компанії та замовлення вноситься до таблиці замовлень.
На четвертому етапі сума поточних продажів службовця збільшується на суму замовлення.
На п'ятому етапі сума поточних продажів офісу даного співробітника збільшується на суму замовлення.
На завершальному етапі процедура виводить повідомлення про статус операції.
*/
CREATE PROCEDURE OrderProcessing
   @CustomerID INT,
   @EmployeeID INT,
   @ManufacturerID INT,
   @ProductID INT,
   @Qty INT
AS
BEGIN
    DECLARE @Price DECIMAL(18, 2);
    DECLARE @CreditLimit DECIMAL(18, 2);
    DECLARE @TotalOrderAmount DECIMAL(18, 2);
    -- Отримання ціни товару за допомогою @ProductId
    SELECT @Price = Price FROM Products WHERE PRODUCT_ID = @ProductId;
    -- Отримання кредитного ліміту компанії за допомогою @ClientId
    SELECT @CreditLimit = CREDIT_LIMIT FROM CUSTOMERS WHERE CUST_NUM = @CustomerID;
	--На першому етапі, процедура перевіряє наявність зазначеної кількості одиниць товару на складі.
	IF EXISTS (SELECT 1 FROM PRODUCTS WHERE PRODUCT_ID = @ProductID AND QTY_ON_HAND >= @Qty)
	   BEGIN
	   --Далі, на другому етапі, проводиться розрахунок суми замовлення (PRICE * @qty).
	   SET @TotalOrderAmount = @Price * @Qty;
	   --На третьому етапі, якщо сума кредитного ліміту компанії більша або дорівнює сумі замовлення 
       IF @CreditLimit >= @TotalOrderAmount
	   -- Зменшення кількості товару на складі
       UPDATE PRODUCTS SET QTY_ON_HAND = QTY_ON_HAND - @Qty WHERE PRODUCT_ID = @ProductID;
	   --Сума замовлення вираховується з кредитного ліміту компанії та замовлення вноситься до таблиці замовлень.
	   UPDATE CUSTOMERS SET CREDIT_LIMIT = CREDIT_LIMIT - @TotalOrderAmount WHERE CUST_NUM = @CustomerID;
	   INSERT INTO ORDERS (CUST, REP, MFR, PRODUCT, QTY)
	   VALUES ( @CustomerID, @EmployeeID, @ManufacturerID, @ProductID, @Qty)
	   --На четвертому етапі сума поточних продажів службовця збільшується на суму замовлення.
	   UPDATE SALESREPS SET SALES = SALES + @TotalOrderAmount WHERE EMPL_NUM = @EmployeeID
	   --На п'ятому етапі сума поточних продажів офісу даного співробітника збільшується на суму замовлення.
	   UPDATE OFFICES SET SALES = SALES + @TotalOrderAmount WHERE OFFICES = (SELECT EMPL_NUM = @EmployeeID FROM SALESREPS
	   WHERE EMPL_NUM = @EmployeeID)
	   --На завершальному етапі процедура виводить повідомлення про статус операції.
	   PRINT 'Замовлення успішно оброблено.'
	END
	ELSE
    BEGIN
        PRINT 'Недостатньо товару на складі або перевищено кредитний ліміт компанії.'
    END
END;
