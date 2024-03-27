--Створюємо базу даних STUDENTS
CREATE DATABASE STUDENTS;
USE STUDENTS;
--Створюємо таблиці
CREATE TABLE PersonalInfo 
(StudentID INT PRIMARY KEY,

FirstName NVARCHAR(50),

LastName NVARCHAR(50),

DateOfBirth DATE);
CREATE TABLE AcademicInfo 

(RecordID INT PRIMARY KEY,

StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),

Faculty NVARCHAR(100),

Curator NVARCHAR(100),

EnrollmentYear INT);
CREATE TABLE ContactInfo 

(ContactID INT PRIMARY KEY,

StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),

Email NVARCHAR(100),

PhoneNumber NVARCHAR(15));
--Додаємо стовбець "Address"
ALTER TABLE ContactInfo ADD Address NVARCHAR(200);
--Видаляємо стовбець "PhoneNumber"
ALTER TABLE ContactInfo DROP COLUMN PhoneNumber;
--Зміняємо ім'я стовбця "Email" на "EmailAddress":
EXEC sp_rename 'ContactInfo.Email', 'EmailAddress', 'COLUMN';

--Змінюємо тип даних для стовбця "Faculty" у таблиці "AcademicInfo" на NVARCHAR(150):
ALTER TABLE AcademicInfo
ALTER COLUMN Faculty NVARCHAR(150);

--Додаємо нову таблицю "Extracurricular"
CREATE TABLE Extracurricular 

(ActivityID INT PRIMARY KEY,

StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),

ActivityName NVARCHAR(100),

JoinDate DATE);
--Видаляємо таблицю "Extracurricular"
DROP TABLE Extracurricular;
--Створюємо базу даних "TEACHER"
CREATE DATABASE TEACHER;
--Після перевірки видаляємо базу даних:
DROP DATABASE TEACHER;
USE STUDENTS;
--Додаємо три рядки даних до таблиці "PersonalInfo"
INSERT INTO PersonalInfo (StudentID, FirstName, LastName, DateOfBirth)

VALUES
(1, 'Олександр', 'Петров', '2000-05-15'),

(2, 'Марія', 'Іваненко', '2001-03-22'),

(3, 'Василь', 'Коваленко', '1999-10-10');
--Робимо перевірку таблиці
SELECT *
FROM [dbo].[PersonalInfo];