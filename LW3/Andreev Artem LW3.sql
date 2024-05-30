/*
1. Створення бази даних "STUDENTS"
*/
CREATE DATABASE STUDENTS;
GO

/*
Перехід до бази даних "STUDENTS"
*/
USE STUDENTS;
GO
/*
2a. Створення таблиці "PersonalInfo"
*/
CREATE TABLE PersonalInfo (
    StudentID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE
);
GO
/*
2b. Створення таблиці "AcademicInfo"
*/
CREATE TABLE AcademicInfo (
    RecordID INT PRIMARY KEY,
    StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
    Faculty NVARCHAR(100),
    Curator NVARCHAR(100),
    EnrollmentYear INT
);
GO
/*
2c. Створення таблиці "ContactInfo"
*/
CREATE TABLE ContactInfo (
ContactID INT PRIMARY KEY,
StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
Email NVARCHAR(100),
PhoneNumber NVARCHAR(15)
);
GO
/*
3a. Додавання стовпця "Address" до таблиці "ContactInfo"
*/
ALTER TABLE ContactInfo ADD Address NVARCHAR(200);
GO
/*
3b. Видалення стовпця "PhoneNumber" з таблиці "ContactInfo"
*/
ALTER TABLE ContactInfo DROP COLUMN PhoneNumber;
GO
/*
3c. Зміна імені стовпця "Email" на "EmailAddress" у таблиці "ContactInfo"
*/
EXEC sp_rename 'ContactInfo.Email', 'EmailAddress', 'COLUMN';
GO
/*
4. Зміна типу даних стовпця "Faculty" на NVARCHAR(150) у таблиці "AcademicInfo"
*/
ALTER TABLE AcademicInfo
ALTER COLUMN Faculty NVARCHAR(150);
GO
/*
5a. Створення таблиці "Extracurricular"
*/
CREATE TABLE Extracurricular (
    ActivityID INT PRIMARY KEY,
    StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
    ActivityName NVARCHAR(100),
    JoinDate DATE
);
GO
/*
5b. Видалення таблиці "Extracurricular"
*/
DROP TABLE Extracurricular;
GO
/*
6a. Створення бази даних "TEACHER"
*/
CREATE DATABASE TEACHER;
GO

/*
6b. Видалення бази даних "TEACHER"
*/
DROP DATABASE TEACHER;
GO

/*
7. Переключення на базу даних "STUDENTS"
*/
USE STUDENTS;
GO
/*
Додавання трьох рядків даних до таблиці "PersonalInfo"
*/
INSERT INTO PersonalInfo (StudentID, FirstName, LastName, DateOfBirth)

VALUES
(1, 'Олександр', 'Петров', '2000-05-15'),
(2, 'Марія', 'Іваненко', '2001-03-22'),
(3, 'Василь', 'Коваленко', '1999-10-10');
