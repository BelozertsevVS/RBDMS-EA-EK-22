CREATE DATABASE UNIVERSITI 
USE UNIVERSITI 

/*��������� ������� Students*/

CREATE TABLE Students
(StudentID INT PRIMARY KEY, 
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
EnrollmentDate DATE);

/*��������� ������� Courses*/
CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
CourseName NVARCHAR(100),
CourseDescription TEXT,
Credits INT
);

/*���������� ������� Students ������*/
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES
(1, '˳��', '������', '2023-08-30'),
(2, '�����', '���������', '2023-08-31'),
(3, '���������', '��������', '2023-08-31');

/*���������� ������� Courses ������*/
INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, '������-�������� � ����������', '����� �������� ��������� �...', '1'),
(2, '���������� ������������ �����', '����� �������� ��������� �...', '3'),
(3, '��������-���������� ������ �� �����: ������������', '����� �������� ��������� �...', '2');

/*���������� ��� �������*/
SELECT * FROM Students
SELECT * FROM Courses

/*������� �������, ������ �� �� ������ �������*/
ALTER TABLE Students ADD Email NVARCHAR(20);
ALTER TABLE Courses ADD Department NVARCHAR(50);

/*��������� ���� ����� UNIVERSITI*/
DROP DATABASE UNIVERSITI
