 -- Створюємо базу даних "STUDENTS"
 CREATE DATABASE STUDENTS;

 -- Переходимо до створеної бази даних
 USE STUDENTS;

 -- Створюємо таблицю "PersonalInfo" з персональними даними ( айді студента, імя, прізвище  та дата народження)
     CREATE TABLE PersonalInfo (
        StudentID INT PRIMARY KEY,
        FirstName NVARCHAR(50),
        LastName NVARCHAR(50),
        DateOfBirth DATE
    );
-- Створюємо 2 таблицю "AcademicInfo" з наступною інформацією (стовпцями): айді, айді студента, факультеь, куратор, дата вступу
      CREATE TABLE AcademicInfo (
        RecordID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
        Faculty NVARCHAR(100),
        Curator NVARCHAR(100),
        EnrollmentYear INT
    );
-- Остання таблиця з контактною інформацією. Стовпці: айді, айді студента, пошта, номер телефону
    CREATE TABLE ContactInfo (
        ContactID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
        Email NVARCHAR(100),
        PhoneNumber NVARCHAR(15)
    );
-- Додаєм стовпець "Address" в таблицю "ContactInfo"
ALTER TABLE ContactInfo ADD Address NVARCHAR(200);
-- Видаляємо стовпець "PhoneNumber" в таблиці "ContactInfo"
ALTER TABLE ContactInfo DROP COLUMN PhoneNumber;
-- Змінюємо ім'я стовбця "Email" на "EmailAddress" в таблиці "ContactInfo" (прим. EXEC: Це скорочення від "execute" і використовується для виклику (виконання) збереженої процедури. sp_rename: Це системна збережена процедура, яка дозволяє перейменовувати об'єкти бази даних, такі як таблиці, стовпці, індекси тощо.)
EXEC sp_rename 'ContactInfo.Email', 'EmailAddress', 'COLUMN';

-- Змінюємо тип даних для стовбця "Faculty" у таблиці "AcademicInfo" на NVARCHAR(150):
   ALTER TABLE AcademicInfo
   ALTER COLUMN Faculty NVARCHAR(150);

--Створюємо таблицю "Extracurricular"
CREATE TABLE Extracurricular (
        ActivityID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
        ActivityName NVARCHAR(100),
        JoinDate DATE
    );
-- Первірка наявності: оновлюємо object explorer.
-- Видалюємо таблицю "Extracurricular"
DROP TABLE Extracurricular;

-- Створюэмо бази даних "TEACHER"
CREATE DATABASE TEACHER;
-- Первірка наявності: оновлюємо object explorer.
-- Видаляємомо базу даних "TEACHER"
DROP DATABASE TEACHER;

-- Переключаємося на базу даних "STUDENTS"
USE STUDENTS;

-- Додаємо три рядки даних до таблиці "PersonalInfo"
INSERT INTO PersonalInfo (StudentID, FirstName, LastName, DateOfBirth)
VALUES 
    (1, 'Олександр', 'Петров', '2000-05-15'),
    (2, 'Марія', 'Іваненко', '2001-03-22'),
    (3, 'Василь', 'Коваленко', '1999-10-10');

-- Виконана ЛР №3
