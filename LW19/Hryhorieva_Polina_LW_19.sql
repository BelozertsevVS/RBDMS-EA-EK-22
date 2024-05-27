USE WebStor;
/*
Завдання 1
Реалізуйте тригер для перевірки чисельності працівників на посаді.
Необхідно, щоб тригер блокував транзакцію (додавання нового 
працівника) у випадку, якщо найм працівника перевищить ліміт (не 
більше 8 працівників на кожній окремій посаді).
- Використовується таблиця dbo.salesreps
- Задійніть директиву INSTEAD OF INSERT
*/
CREATE TRIGGER Number_of_Employees_Position
ON dbo.SALESREPS
INSTEAD OF INSERT
AS
BEGIN
  IF (SELECT COUNT(*) + (SELECT COUNT(*) FROM inserted) 
  FROM dbo.SALESREPS WHERE [TITLE] = (SELECT [TITLE] FROM inserted)) <= 8
  BEGIN
    INSERT INTO dbo.SALESREPS ([EMPL_NUM], [NAME], [AGE], [REP_OFFICE], [TITLE], 
    [HIRE_DATE], [MANAGER], [QUOTA], [SALES])
    SELECT [EMPL_NUM], [NAME], [AGE], [REP_OFFICE], [TITLE], [HIRE_DATE], 
    [MANAGER], [QUOTA], [SALES] FROM inserted;
  END
  ELSE
  BEGIN
    RAISERROR ('Cannot exceed the limit of 8 employees per title.', 16, 1);
    ROLLBACK TRANSACTION;
  END
END;
/*
Завдання 2
Тригер для автоматичного оновлення дати модифікації
Мета: автоматичне оновлення поля `LastModified` у таблиці `Products` 
при будь-яких змінах даних про продукти.
Умови завдання:
- до таблиці PRODUCTS додайте новий стовбець `LastModified` (тип 
даних – дата, може мати null значення)
- Створіть тригер, який реагує на зміни в таблиці `Products`, зокрема 
на операції UPDATE.
- Тригер має автоматично встановлювати поточну дату і час в поле 
`LastModified` для рядка, що зазнав змін.
- Використовуйте системну функцію `GETDATE()` для отримання поточної 
дати та часу.
*/
ALTER TABLE PRODUCTS
ADD LastModified DATETIME NULL;
CREATE TRIGGER Changes_in_the_table_PRODUCTS
ON PRODUCTS
AFTER UPDATE
AS
BEGIN
  UPDATE PRODUCTS
  SET LastModified = GETDATE()
  FROM PRODUCTS
  INNER JOIN inserted ON PRODUCTS.PRODUCT_ID = inserted.PRODUCT_ID;
END;
--Операцію зі змінення таблиці та вставлення в неї колонки необхідно 
--виконувати окремо ві операції зі створення тригеру
/*
Завдання 3
Тригер для перевірки унікальності електронної пошти
Запобігання дублюванню адрес електронної пошти в таблиці `Customers`.
Умови завдання:
- до таблиці CUSTOMERS додайте новий стовбець `Email` (може мати null 
значення)
- Створіть тригер, який перевіряє унікальність електронної пошти при 
додаванні нових або оновленні існуючих записів у таблиці `Customers`.
- Тригер повинен блокувати вставку або оновлення запису, якщо введена 
адреса електронної пошти вже існує в базі даних.
- Використовуйте директиву `INSTEAD OF INSERT, UPDATE` для перехоплення 
спроб вставки або оновлення.
*/
ALTER TABLE CUSTOMERS
ADD Email VARCHAR(255) NULL;
CREATE TRIGGER The_uniqueness_of_email
ON CUSTOMERS
AFTER INSERT, UPDATE
AS
BEGIN
  IF EXISTS (SELECT 1 
             FROM inserted i
             WHERE EXISTS (SELECT 1
                           FROM CUSTOMERS c
                           WHERE c.Email = i.Email
                           AND (i.Email IS NOT NULL AND i.Email != '')
                           AND (c.CUST_NUM != i.CUST_NUM OR i.CUST_NUM IS NULL)
						   )
			)
  BEGIN
    RAISERROR ('Така електронна адреса вже існує у базі даних', 16, 1);
    ROLLBACK TRANSACTION;
  END
  ELSE
  BEGIN
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
      INSERT INTO Customers (CUST_NUM, COMPANY, Email)
      SELECT CUST_NUM, COMPANY, Email FROM inserted;
    END
  END
END;
--Операцію зі змінення таблиці та вставлення в неї колонки необхідно 
--виконувати окремо ві операції зі створення тригеру