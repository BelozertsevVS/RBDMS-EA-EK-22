/*
1. ��������� ���� ����� "STUDENTS"
*/
CREATE DATABASE STUDENTS;
GO

/*
������� �� ���� ����� "STUDENTS"
*/
USE STUDENTS;
GO
/*
2a. ��������� ������� "PersonalInfo"
*/
CREATE TABLE PersonalInfo (
    StudentID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE
);
GO
/*
2b. ��������� ������� "AcademicInfo"
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
2c. ��������� ������� "ContactInfo"
*/
CREATE TABLE ContactInfo (
ContactID INT PRIMARY KEY,
StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
Email NVARCHAR(100),
PhoneNumber NVARCHAR(15)
);
GO
/*
3a. ��������� ������� "Address" �� ������� "ContactInfo"
*/
ALTER TABLE ContactInfo ADD Address NVARCHAR(200);
GO
/*
3b. ��������� ������� "PhoneNumber" � ������� "ContactInfo"
*/
ALTER TABLE ContactInfo DROP COLUMN PhoneNumber;
GO
/*
3c. ���� ���� ������� "Email" �� "EmailAddress" � ������� "ContactInfo"
*/
EXEC sp_rename 'ContactInfo.Email', 'EmailAddress', 'COLUMN';
GO
/*
4. ���� ���� ����� ������� "Faculty" �� NVARCHAR(150) � ������� "AcademicInfo"
*/
ALTER TABLE AcademicInfo
ALTER COLUMN Faculty NVARCHAR(150);
GO
/*
5a. ��������� ������� "Extracurricular"
*/
CREATE TABLE Extracurricular (
    ActivityID INT PRIMARY KEY,
    StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
    ActivityName NVARCHAR(100),
    JoinDate DATE
);
GO
/*
5b. ��������� ������� "Extracurricular"
*/
DROP TABLE Extracurricular;
GO
/*
6a. ��������� ���� ����� "TEACHER"
*/
CREATE DATABASE TEACHER;
GO

/*
6b. ��������� ���� ����� "TEACHER"
*/
DROP DATABASE TEACHER;
GO

/*
7. ������������ �� ���� ����� "STUDENTS"
*/
USE STUDENTS;
GO
/*
��������� ����� ����� ����� �� ������� "PersonalInfo"
*/
INSERT INTO PersonalInfo (StudentID, FirstName, LastName, DateOfBirth)

VALUES
(1, '���������', '������', '2000-05-15'),
(2, '����', '��������', '2001-03-22'),
(3, '������', '���������', '1999-10-10');
