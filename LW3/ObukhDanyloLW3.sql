-- 1. Створення бази даних "STUDENTS": 

CREATE DATABASE STUDENTS;

-- Перейдіть до бази даних "STUDENTS":

USE STUDENTS;

-- 2. Створення таблиць:

--a. Створіть таблицю "PersonalInfo":

CREATE TABLE PersonalInfo (

StudentID INT PRIMARY KEY,

FirstName NVARCHAR(50),

LastName NVARCHAR(50),

DateOfBirth DATE

);

-- b. Створіть таблицю "AcademicInfo":

CREATE TABLE AcademicInfo (

RecordID INT PRIMARY KEY,

StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),

Faculty NVARCHAR(100),

Curator NVARCHAR(100),

EnrollmentYear INT

);

-- c. Створіть таблицю "ContactInfo":

CREATE TABLE ContactInfo (

ContactID INT PRIMARY KEY,

StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),

Email NVARCHAR(100),

PhoneNumber NVARCHAR(15)

);

-- 3. Операції зі структурою таблиці "ContactInfo":

-- a. Додайте стовбець "Address":

ALTER TABLE ContactInfo ADD Address NVARCHAR(200);

-- b. Видаліть стовбець "PhoneNumber":

ALTER TABLE ContactInfo DROP COLUMN PhoneNumber;

-- c. Змініть ім'я стовбця "Email" на "EmailAddress":

EXEC sp_rename 'ContactInfo.Email', 'EmailAddress', 'COLUMN';

-- 4. Змінення типу даних стовбця:

-- Змініть тип даних для стовбця "Faculty" у таблиці "AcademicInfo" на NVARCHAR(150):

ALTER TABLE AcademicInfo

ALTER COLUMN Faculty NVARCHAR(150);

-- 5. Додайте нову таблицю "Extracurricular":

CREATE TABLE Extracurricular (

ActivityID INT PRIMARY KEY,

StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),

ActivityName NVARCHAR(100),

JoinDate DATE

);

-- Після перевірки того, що таблиця була створена правильно, видаліть її:

DROP TABLE Extracurricular;

-- 6. Створення бази даних "TEACHER":

CREATE DATABASE TEACHER;

-- Переконайтеся, що база даних була створена (можна здійснити перегляд у SQL Server Management Studio або іншому клієнті).

-- Після перевірки видаліть базу даних:

DROP DATABASE TEACHER;

-- 7. Переключення на потрібну базу даних

USE STUDENTS;

-- Додати три рядки даних до таблиці "PersonalInfo"

INSERT INTO PersonalInfo (StudentID, FirstName, LastName, DateOfBirth)

VALUES

(1, 'Олександр', 'Петров', '2000-05-15'),

(2, 'Марія', 'Іваненко', '2001-03-22'),

(3, 'Василь', 'Коваленко', '1999-10-10');