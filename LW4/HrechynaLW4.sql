CREATE DATABASE University
USE University

CREATE TABLE Students(
StudentID INT PRIMARY KEY,
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
EnrollmentDate DATE,
 );

CREATE TABLE Courses(
CourseID INT PRIMARY KEY,
CourseName NVARCHAR(50),
CourseDescription TEXT,
Credits INT
);

INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES
(1, 'Олександр', 'Петров', '2000-05-15'),
(2, 'Марія', 'Іваненко', '2001-03-22'),
(3, 'Василь', 'Коваленко', '1999-10-10');

INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'Німецька мова', 'Вивчення німецької мови', '5'),
(2, 'Англійська мова', 'Вивчення англійської мови', '7'),
(3, 'Французька мова', 'Вивчення французької мови', '4');

SELECT*
FROM Students;

SELECT*
FROM Courses;

ALTER TABLE Students ADD Email NVARCHAR(50);
ALTER TABLE Courses ADD Department NVARCHAR(50);

SELECT*
FROM Students;

SELECT*
FROM Courses;

DROP DATABASE University;