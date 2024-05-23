/*Завдання 1
Реалізуйте тригер для перевірки чисельності працівників на посаді.
Необхідно, щоб тригер блокував транзакцію (додавання нового працівника) у випадку, 
якщо найм працівника перевищить ліміт (не більше 8 працівників на кожній окремій посаді).
- Використовується таблиця dbo.salesreps
- Задійніть директиву INSTEAD OF INSERT*/

CREATE TRIGGER trg_LimitEmployeesPerPosition
ON [dbo].[SALESREPS]
INSTEAD OF INSERT
AS
BEGIN
DECLARE @newTitle VARCHAR(10);
 DECLARE @currentCount INT;

-- Отримання посади нового працівника
SELECT @newTitle = TITLE FROM inserted;

-- Підрахунок кількості працівників на цій посаді
SELECT @currentCount = COUNT(*) 
FROM [dbo].[SALESREPS]
WHERE TITLE = @newTitle;

-- Перевірка, чи кількість працівників перевищує або дорівнює ліміту
IF @currentCount >= 8
BEGIN
-- Блокування транзакції та виведення повідомлення
RAISERROR ('Кількість працівників на цій посаді перевищує ліміт у 8 осіб.', 16, 1);
ROLLBACK TRANSACTION;
END
END;

/*Завдання 2 
Тригер для автоматичного оновлення дати модифікації
Мета: автоматичне оновлення поля `LastModified` у таблиці `Products` при будь-яких змінах даних про продукти.
Умови завдання:
- до таблиці PRODUCTS додайте новий стовбець `LastModified` (тип даних – дата, може мати null значення)
- Створіть тригер, який реагує на зміни в таблиці `Products`, зокрема на операції UPDATE.
- Тригер має автоматично встановлювати поточну дату і час в поле `LastModified` для рядка, що зазнав змін.
- Використовуйте системну функцію `GETDATE()` для отримання поточної дати та часу.*/

ALTER TABLE PRODUCTS
ADD LastModified DATETIME NULL;

CREATE TRIGGER UpdateLastModified
ON [dbo].[PRODUCTS]
AFTER UPDATE
AS
BEGIN
-- Оновлення поля LastModified для змінених рядків
UPDATE [dbo].[PRODUCTS]
SET LastModified = GETDATE()
FROM [dbo].[PRODUCTS] p
INNER JOIN inserted i ON p.MFR_ID = i.MFR_ID AND p.PRODUCT_ID = i.PRODUCT_ID;
END;

/* Завдання 3
Тригер для перевірки унікальності електронної пошти
Запобігання дублюванню адрес електронної пошти в таблиці `Customers`.
Умови завдання:
- до таблиці CUSTOMERS додайте новий стовбець `Email` (може мати null значення)
- Створіть тригер, який перевіряє унікальність електронної пошти при додаванні нових або оновленні існуючих записів у таблиці `Customers`.
- Тригер повинен блокувати вставку або оновлення запису, якщо введена адреса електронної пошти вже існує в базі даних.
- Використовуйте директиву `INSTEAD OF INSERT, UPDATE` для перехоплення спроб вставки або оновлення.*/

CREATE TRIGGER trg_CheckUniqueEmail
ON [dbo].[CUSTOMERS]
INSTEAD OF INSERT
AS
BEGIN
-- Перевірка наявності дублікатів в нових або оновлених записах
IF EXISTS (
SELECT 1
FROM inserted i
jOIN [dbo].[CUSTOMERS] c ON i.Email = c.Email
WHERE i.Email IS NOT NULL AND c.CUST_NUM <> i.CUST_NUM
)
BEGIN
-- Блокування транзакції та виведення повідомлення про помилку
RAISERROR ('Адреса електронної пошти вже існує в базі даних.', 16, 1);
ROLLBACK TRANSACTION;
END
END;

