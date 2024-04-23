CREATE DATABASE STUDENTS;
USE STUDENTS;

CREATE TABLE PersonalInfo (
StudentID INT PRIMARY KEY,
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
DateOfBirth DATE
);

CREATE TABLE AcademicInfo (
RecordID INT PRIMARY KEY,
StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
Faculty NVARCHAR(100),
Curator NVARCHAR(100),
EnrollmentYear INT
);

CREATE TABLE ContactInfo (
ContactID INT PRIMARY KEY,
StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
Email NVARCHAR(100),
PhoneNumber NVARCHAR(15)
);

ALTER TABLE ContactInfo ADD Address NVARCHAR(200);
ALTER TABLE ContactInfo DROP COLUMN PhoneNumber;
EXEC sp_rename 'ContactInfo.Email', 'EmailAddress', 'COLUMN';
ALTER TABLE AcademicInfo
ALTER COLUMN Faculty NVARCHAR(150);

CREATE TABLE Extracurricular (
ActivityID INT PRIMARY KEY,
StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
ActivityName NVARCHAR(100),
JoinDate DATE
);

DROP TABLE Extracurricular;

CREATE DATABASE TEACHER;

DROP DATABASE TEACHER;

USE STUDENTS;

INSERT INTO PersonalInfo (StudentID, FirstName, LastName, DateOfBirth)

VALUES
(1, 'Олександр', 'Петров', '2000-05-15'),
(2, 'Марія', 'Іваненко', '2001-03-22'),
(3, 'Василь', 'Коваленко', '1999-10-10');

SELECT*
FROM [dbo].[PersonalInfo]
