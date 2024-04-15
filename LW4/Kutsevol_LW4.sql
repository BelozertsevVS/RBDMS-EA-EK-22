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
(1, 'Іван', 'Нестеренко', '2004-07-01'),
(2, 'Софія', 'Криворот', '2005-11-02'),
(3, 'Юрій', 'Немченко', '2006-04-03');
--Заповнюємо таблицю Courses
INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'КС-1', 'Опис, курс№1', '90'),
(2, 'ПП', 'Опис, курс№2', '70'),
(3, 'ПУ', 'Опис, курс№3', '100');
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