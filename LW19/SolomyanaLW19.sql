Use WebStor;

/*Завдання 1
Реалізуйте тригер для перевірки чисельності працівників на посаді.
Необхідно, щоб тригер блокував транзакцію (додавання нового працівника) у випадку, якщо найм працівника перевищить ліміт (не більше 8 працівників на кожній окремій посаді).
- Використовується таблиця dbo.salesreps
- Задійніть директиву INSTEAD OF INSERT
*/

CREATE TRIGGER CheckEmployeeLimit
ON [dbo].[SALESREPS]
INSTEAD OF INSERT
AS
BEGIN
    -- Перевірка чисельності працівників на посаді
    IF EXISTS (
        SELECT i.TITLE
        FROM inserted i
        JOIN [dbo].[SALESREPS] s ON i.TITLE = s.TITLE
        GROUP BY i.TITLE
        HAVING COUNT(s.EMPL_NUM) + COUNT(i.EMPL_NUM) > 8
    )
    BEGIN
        RAISERROR ('Cannot add more than 8 employees to the same job title.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Вставка записів, якщо перевірка пройдена
        INSERT INTO [dbo].[SALESREPS] ([EMPL_NUM], [NAME], [TITLE], [SALES])
        SELECT [EMPL_NUM], [NAME], [TITLE], [SALES]
        FROM inserted;
    END
END;

SELECT * FROM [dbo].[SALESREPS];

/*Завдання 2
Тригер для автоматичного оновлення дати модифікації
Мета: автоматичне оновлення поля `LastModified` у таблиці `Products` при будь-яких змінах даних про продукти.
Умови завдання:
- до таблиці PRODUCTS додайте новий стовбець `LastModified` (тип даних – дата, може мати null значення)
- Створіть тригер, який реагує на зміни в таблиці `Products`, зокрема на операції UPDATE.
- Тригер має автоматично встановлювати поточну дату і час в поле `LastModified` для рядка, що зазнав змін.
- Використовуйте системну функцію `GETDATE()` для отримання поточної дати та часу.
*/

-- Додавання стовпця LastModified

ALTER TABLE [dbo].[PRODUCTS]
ADD LastModified DATETIME NULL;

CREATE TRIGGER UpdateLastModified
ON [dbo].[PRODUCTS]
AFTER UPDATE
AS
BEGIN
    -- Оновлення стовпця LastModified
    UPDATE [dbo].[PRODUCTS]
    SET LastModified = GETDATE()
    FROM inserted
    WHERE [dbo].[PRODUCTS].[PRODUCT_ID] = inserted.PRODUCT_ID;
END;



/*Завдання 3
Тригер для перевірки унікальності електронної пошти
Запобігання дублюванню адрес електронної пошти в таблиці `Customers`.
Умови завдання:
- до таблиці CUSTOMERS додайте новий стовбець `Email` (може мати null значення)
- Створіть тригер, який перевіряє унікальність електронної пошти при додаванні нових або оновленні існуючих записів у таблиці `Customers`.
- Тригер повинен блокувати вставку або оновлення запису, якщо введена адреса електронної пошти вже існує в базі даних.
- Використовуйте директиву `INSTEAD OF INSERT, UPDATE` для перехоплення спроб вставки або оновлення.
*/

-- Додавання стовпця Email

ALTER TABLE [dbo].[CUSTOMERS]
ADD Email VARCHAR(255) NULL;


CREATE TRIGGER CheckUniqueEmail
ON [dbo].[CUSTOMERS]
AFTER INSERT, UPDATE
AS
BEGIN
    -- Перевірка унікальності електронної пошти
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN [dbo].[CUSTOMERS] c ON i.Email = c.Email
        WHERE c.CUST_NUM <> i.CUST_NUM
    )
    BEGIN
        RAISERROR ('Email address must be unique.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;