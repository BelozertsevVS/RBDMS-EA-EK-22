CREATE DATABASE UNIVERSITI 
USE UNIVERSITI 

/*Створюємо таблицю Students*/

CREATE TABLE Students
(StudentID INT PRIMARY KEY, 
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
EnrollmentDate DATE);

/*Створюємо таблицю Courses*/
CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
CourseName NVARCHAR(100),
CourseDescription TEXT,
Credits INT
);

/*Заповнюємо таблицю Students даними*/
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES
(1, 'Лідія', 'Дьоміна', '2023-08-30'),
(2, 'Ірина', 'Коваленко', '2023-08-31'),
(3, 'Владислав', 'Ткаченко', '2023-08-31');

/*Заповнюємо таблицю Courses даними*/
INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'Бізнес-стратегія і менеджмент', 'Метою вивчення дисципліни є...', '1'),
(2, 'Оптимізація управлінських рішень', 'Метою вивчення дисципліни є...', '3'),
(3, 'Економіко-математичні методи та моделі: економетрика', 'Метою вивчення дисципліни є...', '2');

/*Перевіряємо дані таблиці*/
SELECT * FROM Students
SELECT * FROM Courses

/*Змінюємо таблиці, додаємо ще по одному стовпцю*/
ALTER TABLE Students ADD Email NVARCHAR(20);
ALTER TABLE Courses ADD Department NVARCHAR(50);

/*Видаляємо базу даних UNIVERSITI*/
DROP DATABASE UNIVERSITI
