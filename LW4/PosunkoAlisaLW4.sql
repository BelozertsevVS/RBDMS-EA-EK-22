-- Створення бази University
CREATE DATABASE University;
-- Перехід до бази даних
USE University;

-- Створення таблиці "Students"
CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
EnrollmentDate DATE
);

-- Створення таблиці "Courses"
CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
CourseName NVARCHAR(50),
CourseDescription TEXT,
Credits INT
);

-- Заповнення даними таблиці "Students"
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES
(1, 'Олександр', 'Петров', '2022-08-20'),
(2, 'Марія', 'Іваненко', '2023-08-22'),
(3, 'Василь', 'Коваленко', '2017-09-10');

-- Заповнення даними таблиці "Courses"
INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'Історія','Метою дисципліни “Історія” є формування історичної свідомості студентів)','20'),
(2, 'Українська мова','Метою навчання рідної мови полягає у формуванні національно свідомої, духовно багатої мовної особистості','30'),
(3, 'Фізична культура','Метою дизципліни «Фізична культура» є гармонійний фізичний розвиток особистості учня, підвищення функціональних можливостей організму','50');

-- Перевірка даних
SELECT * 
FROM Students;
SELECT * 
FROM Courses;

-- Додавання стовпців
ALTER TABLE Students ADD Email NVARCHAR(50);
ALTER TABLE Courses ADD Departmen NVARCHAR(50);

-- Перевірка даних
SELECT * 
FROM Students;
SELECT * 
FROM Courses;

-- Видалення бази даних
DROP DATABASE University;