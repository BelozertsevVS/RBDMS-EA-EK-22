/*Завдання 1
Реалізуйте тригер для перевірки чисельності працівників на посаді.
Необхідно, щоб тригер блокував транзакцію (додавання нового працівника) у випадку, 
якщо найм працівника перевищить ліміт (не більше 8 працівників на кожній окремій посаді).
- Використовується таблиця dbo.salesreps
- Задійніть директиву INSTEAD OF INSERT*/

CREATE TRIGGER Check_Empl_Count
ON [dbo].[SALESREPS]
INSTEAD OF INSERT
AS
BEGIN

    DECLARE @ExceedingTitle NVARCHAR(20);

    SELECT @ExceedingTitle = i.[TITLE]
    FROM INSERTED i
    GROUP BY i.[TITLE]
    HAVING (SELECT COUNT(*)
            FROM [dbo].[SALESREPS] s
            WHERE s.[TITLE] = i.[TITLE]) + COUNT(*) > 8;

    IF @ExceedingTitle IS NOT NULL
    BEGIN

        RAISERROR ('Неможливо додати нового працівника. Ліміт працівників на посаді перевищено.', 16, 1, @ExceedingTitle);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO [dbo].[SALESREPS] ([TITLE],[EMPL_NUM],[NAME],[HIRE_DATE])
    SELECT [TITLE],[EMPL_NUM],[NAME],[HIRE_DATE]
    FROM INSERTED;
END;


/*Завдання 2
Тригер для автоматичного оновлення дати модифікації
Мета: автоматичне оновлення поля `LastModified` у таблиці `Products` при будь-яких змінах даних про продукти.
Умови завдання:
- до таблиці PRODUCTS додайте новий стовбець `LastModified` (тип даних – дата, може мати null значення)
- Створіть тригер, який реагує на зміни в таблиці `Products`, зокрема на операції UPDATE.
- Тригер має автоматично встановлювати поточну дату і час в поле `LastModified` для рядка, що зазнав змін.
- Використовуйте системну функцію `GETDATE()` для отримання поточної дати та часу*/

ALTER TABLE [dbo].[PRODUCTS]
ADD LastModified DATETIME NULL;

CREATE TRIGGER Update_Product_LastModified
ON [dbo].[PRODUCTS]
FOR UPDATE
AS
BEGIN
  UPDATE [dbo].[PRODUCTS] 
  SET LastModified = GETDATE()
  WHERE [PRODUCT_ID] IN 
  (SELECT [PRODUCT_ID]
   FROM DELETED);
END;

/*Завдання 3
Тригер для перевірки унікальності електронної пошти
Запобігання дублюванню адрес електронної пошти в таблиці `Customers`.
Умови завдання:
- до таблиці CUSTOMERS додайте новий стовбець `Email` (може мати null значення)
- Створіть тригер, який перевіряє унікальність електронної пошти при додаванні нових або оновленні існуючих записів у таблиці `Customers`.
- Тригер повинен блокувати вставку або оновлення запису, якщо введена адреса електронної пошти вже існує в базі даних.
- Використовуйте директиву `INSTEAD OF INSERT, UPDATE` для перехоплення спроб вставки або оновлення.*/

ALTER TABLE [dbo].[CUSTOMERS]
ADD [Email] VARCHAR(50) NULL;

CREATE TRIGGER Check_Cust_Email
ON [dbo].[CUSTOMERS]
AFTER INSERT, 
UPDATE
AS
BEGIN
 IF EXISTS (SELECT 1
            FROM INSERTED i
            JOIN [dbo].[CUSTOMERS] c 
			ON i.[Email] = c.[Email]
            WHERE c.[CUST_NUM] = i.[CUST_NUM])
 BEGIN
  RAISERROR ('Помилка: Адреса електронної пошти вже існує.', 16, 1);
  ROLLBACK TRANSACTION;
 END
END;
