--Створюю базу данних University
CREATE DATABASE University;
--Використовую базу данних University
USE University;
--Створюю таблицю Students
CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
EnrollmentDate DATE
);
--Створюю таблицю Courses
CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
CourseName VARCHAR(50),
CourseDescription TEXT,
Credits INT
);
--Заповнюю таблицю Students
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES 
(1, 'Петро', 'Пархоменко', '2003-10-08'),
(2, 'Марина', 'Лавриненко', '2001-09-29'),
(3, 'Владислав', 'Юрченко', '2000-02-23');
--Заповнюю таблицю Courses
INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'ІП-21', 'Опис для курсу 1', '25'),
(2, 'ВА-23', 'Опис для курсу 2', '100'),
(3, 'АЕ-22', 'Опис для курсу 3', '78');
--Вибір даних з таблиці Students та Courses
SELECT * FROM Students;
SELECT * FROM Courses;
--Додаю колонку Email в таблицю Students
ALTER TABLE Students ADD Email VARCHAR(50);
--Додаю колонку Department в таблицю Courses
ALTER TABLE Courses ADD Department VARCHAR(50);
--Вибір даних з таблиці Students та Courses
SELECT * FROM Students;
SELECT * FROM Courses;
--Видаляю базу даних University
DROP DATABASE University;