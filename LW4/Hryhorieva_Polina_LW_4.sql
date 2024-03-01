--Створення бази данних University
CREATE DATABASE University;
--Використовувати базу данних
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
--Заповнення таблиці Students
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES 
(1, 'Валерія', 'Андрухович', '2022-09-01'),
(2, 'Христина', 'Бойко', '2022-09-01'),
(3, 'Ілля', 'Гринькович', '2023-09-01');
--Заповнення таблиці Courses
INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'Філософія', 'Дисципліна вивчається один семестр і має на меті ознайомленння з історією формування філосовської думки та розширення світогляду.', '50'),
(2, 'Українська мова', 'Дисципліна вивчається один семестр і має на меті покращення навичків володіння рідною мовою.', '60'),
(3, 'Англійська мова', 'Дисципліна вивчається один семестр і має на меті покращення навичків володіння англійською мовою мовою.', '60');
--Вибір даних з таблиці Students
SELECT * FROM Students;
--Вибір даних з таблиці Courses
SELECT * FROM Courses;
--Додавання колонки Email в таблицю Students
ALTER TABLE Students ADD Email VARCHAR(50);
--Додавання колонки Department в таблицю Courses
ALTER TABLE Courses ADD Department VARCHAR(50);
--Вибір даних з таблиці Students
SELECT * FROM Students;
--Вибір даних з таблиці Courses
SELECT * FROM Courses;
--Видалення бази данних University
DROP DATABASE University;