/*
1. ��������� ���� ����� "University"
*/
CREATE DATABASE University;
GO

/*
������� �� ���� ����� "University"
*/
USE University;
GO
/*
2a. ��������� ������� "Students"
*/
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    EnrollmentDate DATE
);
GO
/*
2b. ��������� ������� "Courses"
*/
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(100),
    CourseDescription TEXT,
    Credits INT
);
GO
/*
3. ���������� ������� ������
*/

/* ������� ����� � ������� "Students" */
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES
(1, '���������', '������', '2023-09-01'),
(2, '����', '�����������', '2022-09-01'),
(3, '������', '����������', '2023-09-01');
GO
/* ������� ����� � ������� "Courses" */
INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, '����������', '���������� ����������', 5),
(2, 'Գ����', '���������� ������', 4),
(3, '�������������', '������ ������������� �� Java', 6);
GO
/*
4. ������ �����
*/
SELECT * FROM Students;
GO

SELECT * FROM Courses;
GO

/*
5a. ��������� ������� "Email" �� ������� "Students"
*/
ALTER TABLE Students ADD Email NVARCHAR(100);
GO

/*
5b. ��������� ������� "Department" �� ������� "Courses"
*/
ALTER TABLE Courses ADD Department NVARCHAR(100);
GO
/*
6. ������ ����� ���� ����������� �������
*/
SELECT * FROM Students;
GO

SELECT * FROM Courses;
GO
/*
7. ��������� ���� ����� "University"
*/
DROP DATABASE University;
GO
