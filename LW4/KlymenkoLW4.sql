--Створення бази данних University
CREATE DATABASE University;
--Використовуємо базу данних University
USE University;
--Створення таблиці Students
CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
EnrollmentDate DATE
);
--Створення таблиці Courses
CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
CourseName VARCHAR(50),
CourseDescription TEXT,
Credits INT
);
--Заповнюємо таблицю Students
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES 
(1, 'Едуард', 'Шкабара', '2002-27-05'),
(2, 'Марія', 'Шевченко', '2003-18-06'),
(3, 'Анатолій', 'Вітренко', '2004-10-07');
--Заповнюємо таблицю Courses
INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'ДМ-1', 'Опис, курс 1', '87'),
(2, 'СС', 'Опис, курс 2', '79'),
(3, 'АД', 'Опис, курс 3', '98');
--Вибір даних з таблиці Students та Courses
SELECT * FROM Students;
SELECT * FROM Courses;
--Додаємо колонку Email в таблицю Students
ALTER TABLE Students ADD Email VARCHAR(50);
--Додаємо колонку Department в таблицю Courses
ALTER TABLE Courses ADD Department VARCHAR(50);
--Вибір даних з таблиці Students та Courses
SELECT * FROM Students;
SELECT * FROM Courses;
--Видаляємо бази данних University
DROP DATABASE University;