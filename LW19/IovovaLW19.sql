USE WebStor;
/*Завдання 1
Реалізуйте тригер для перевірки чисельності працівників на посаді.
Необхідно, щоб тригер блокував транзакцію (додавання нового працівника) у випадку, якщо найм працівника перевищить ліміт (не більше 8 працівників на кожній окремій посаді).
- Використовується таблиця dbo.salesreps
- Задійніть директиву INSTEAD OF INSERT
*/
--Виконання завдання:
CREATE TRIGGER trg_CheckEmployeeCount
ON [dbo].[SALESREPS]
INSTEAD OF INSERT
AS
BEGIN
    -- Перевірка кількості працівників на кожній посаді з нових даних
    DECLARE @title VARCHAR
    DECLARE @NewEmployeeCount INT

    -- Перебір всіх нових записів у вставці
    DECLARE insert_cursor CURSOR FOR
    SELECT DISTINCT title
    FROM inserted

    OPEN insert_cursor
    FETCH NEXT FROM insert_cursor INTO @title

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Підрахунок кількості працівників на посаді з урахуванням нових записів
        SELECT @NewEmployeeCount = (SELECT COUNT(*) 
                                    FROM [dbo].[SALESREPS] 
                                    WHERE TITLE = @title) + 
                                   (SELECT COUNT(*) 
                                    FROM inserted 
                                    WHERE TITLE = @title)

        -- Якщо кількість працівників на посаді перевищує 8, викликається помилка
        IF @NewEmployeeCount > 8
        BEGIN
            RAISERROR ('Cannot add more employees to this position. Limit of 8 employees exceeded.', 16, 1)
            ROLLBACK TRANSACTION
            RETURN
        END
        FETCH NEXT FROM insert_cursor INTO @title
    END
    CLOSE insert_cursor
    DEALLOCATE insert_cursor

    -- Якщо перевірка пройшла успішно, вставка відбувається
    INSERT INTO [dbo].[SALESREPS] ([EMPL_NUM],[NAME],[AGE],[REP_OFFICE],[TITLE],[HIRE_DATE],[MANAGER],[QUOTA],[SALES])
    SELECT [EMPL_NUM],[NAME],[AGE],[REP_OFFICE],[TITLE],[HIRE_DATE],[MANAGER],[QUOTA],[SALES]
    FROM inserted
END;
--Завдання виконано.

/*Завдання 2
Тригер для автоматичного оновлення дати модифікації
Мета: автоматичне оновлення поля `LastModified` у таблиці `Products` при будь-яких змінах даних про продукти.
Умови завдання:
- до таблиці PRODUCTS додайте новий стовбець `LastModified` (тип даних – дата, може мати null значення)
- Створіть тригер, який реагує на зміни в таблиці `Products`, зокрема на операції UPDATE.
- Тригер має автоматично встановлювати поточну дату і час в поле `LastModified` для рядка, що зазнав змін.
- Використовуйте системну функцію `GETDATE()` для отримання поточної дати та часу.
*/
--Виконання завдання:
/*Щоб реалізувати тригер для автоматичного оновлення дати модифікації в таблиці Products, потрібно виконати наступні кроки:
1.Додати новий стовпець LastModified в таблицю Products.
2.Створити тригер, який буде автоматично оновлювати значення стовпця LastModified при кожній операції UPDATE на таблиці Products.
*/
--1:
ALTER TABLE [dbo].[PRODUCTS]
ADD LastModified DATETIME NULL;
--2:
CREATE TRIGGER trg_UpdateLastModified
ON [dbo].[PRODUCTS]
AFTER UPDATE
AS
BEGIN
    -- Оновлення стовпця LastModified для змінених рядків
    UPDATE [dbo].[PRODUCTS]
    SET LastModified = GETDATE()
    FROM [dbo].[PRODUCTS]
    INNER JOIN inserted ON PRODUCTS.PRODUCT_ID = inserted.PRODUCT_ID;
END;
--Завдання виконано.

/*Завдання 3
Тригер для перевірки унікальності електронної пошти
Запобігання дублюванню адрес електронної пошти в таблиці `Customers`.
Умови завдання:
- до таблиці CUSTOMERS додайте новий стовбець `Email` (може мати null значення)
- Створіть тригер, який перевіряє унікальність електронної пошти при додаванні нових або оновленні існуючих записів у таблиці `Customers`.
- Тригер повинен блокувати вставку або оновлення запису, якщо введена адреса електронної пошти вже існує в базі даних.
- Використовуйте директиву `INSTEAD OF INSERT, UPDATE` для перехоплення спроб вставки або оновлення.
*/
--Виконання завдання:
/*
Щоб реалізувати тригер для перевірки унікальності електронної пошти в таблиці Customers, потрібно виконати наступні кроки:
1.Додати новий стовпець Email в таблицю Customers.
2.Створити тригер, який буде перевіряти унікальність електронної пошти при додаванні нових або оновленні існуючих записів.
*/
--1:
ALTER TABLE [dbo].[CUSTOMERS]
ADD EMAIL VARCHAR(50) NULL;
--2:
CREATE TRIGGER trg_CheckUniqueEmail
ON [dbo].[CUSTOMERS]
AFTER INSERT, UPDATE
AS
BEGIN
    -- Перевірка унікальності для вставки та оновлення
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN [dbo].[CUSTOMERS] c ON i.EMAIL = c.EMAIL AND i.CUST_NUM <> c.CUST_NUM
        WHERE i.EMAIL IS NOT NULL AND i.EMAIL <> ''
    )
    BEGIN
        RAISERROR ('Email address must be unique.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
    -- Виконання вставки, якщо запису не існує
    INSERT INTO [dbo].[CUSTOMERS] (CUST_NUM, COMPANY, EMAIL)
    SELECT i.CUST_NUM, i.COMPANY, i.EMAIL
    FROM inserted i
    LEFT JOIN [dbo].[CUSTOMERS] c ON i.CUST_NUM = c.CUST_NUM
    WHERE c.CUST_NUM IS NULL;
    -- Виконання оновлення, якщо запис існує
    UPDATE c
    SET c.COMPANY = i.COMPANY,
        c.EMAIL = i.EMAIL
    FROM [dbo].[CUSTOMERS] c
    JOIN inserted i ON c.CUST_NUM = i.CUST_NUM;
END;
--Завдання виконано.