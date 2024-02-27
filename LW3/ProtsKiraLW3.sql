/* Створюємо базу даних під назвою "STUDENTS" */

CREATE DATABASE STUDENTS

/* Переходимо у створену базу даних */

USE STUDENTS

/* Створюємо таблицю "PersonalInfo" у створеній базі даних */

CREATE TABLE PersonalInfo (
StudentID INT PRIMARY KEY,
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
DateOfBirth DATE
);

/* Створюємо другу таблицю "AcademicInfo" */

CREATE TABLE AcademicInfo (
RecordID INT PRIMARY KEY,
StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
Faculty NVARCHAR(100),
Curator NVARCHAR(100),
EnrollmentYear INT
);

/* Створюємо третю таблицю "ContactInfo" */

CREATE TABLE ContactInfo (
ContactID INT PRIMARY KEY,
StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
Email NVARCHAR(100),
PhoneNumber NVARCHAR(15)
);

/* Додаємо стовбець "Address" до таблиці ContactInfo */

ALTER TABLE ContactInfo ADD Address NVARCHAR(200);

/* Видаляємо стовбець "PhoneNumber" з таблиці ContactInfo */

ALTER TABLE ContactInfo DROP COLUMN PhoneNumber;

/* Змінимо ім'я стовбця "Email" на "EmailAddress":*/

EXEC sp_rename 'ContactInfo.Email', 'EmailAddress', 'COLUMN';

/* Змінимо тип даних для стовбця "Faculty" у таблиці "AcademicInfo" на NVARCHAR(150) */

ALTER TABLE AcademicInfo
ALTER COLUMN Faculty NVARCHAR(150);

/* Додамо нову таблицю "Extracurricular" */

CREATE TABLE Extracurricular (
ActivityID INT PRIMARY KEY,
StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
ActivityName NVARCHAR(100),
JoinDate DATE
);

/* Після перевірки того, що таблиця була створена правильно, видаляємо її */

DROP TABLE Extracurricular;

/* Створюємо базу даних "TEACHER" */

CREATE DATABASE TEACHER;

/* Переконалися, що база даних була створена. Після перевірки видаляємо базу даних */

DROP DATABASE TEACHER;

/* Переключаємось на потрібну базу даних */

USE STUDENTS;

/* Додаємо три рядки даних до таблиці "PersonalInfo" */

INSERT INTO PersonalInfo (StudentID, FirstName, LastName, DateOfBirth)
VALUES
(1, 'Олександр', 'Петров', '2000-05-15'),
(2, 'Марія', 'Іваненко', '2001-03-22'),
(3, 'Василь', 'Коваленко', '1999-10-10');

/* Додатково перевіримо, чи додались дані до таблиці PersonalInfo */
SELECT TOP (1000) [StudentID]
      ,[FirstName]
      ,[LastName]
      ,[DateOfBirth]
  FROM [STUDENTS].[dbo].[PersonalInfo]