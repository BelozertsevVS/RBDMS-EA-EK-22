/* Створюємо базу даних University */

CREATE DATABASE University

/* Використовуємо базу даних University */

USE University

/* Створюємо таблиці Students та Courses */

CREATE TABLE Students(
StudentID INT PRIMARY KEY,
FirstName NVARCHAR (50),
LastName NVARCHAR (50),
EnrollmentDate DATE
);

CREATE TABLE Courses(
CourseID INT PRIMARY KEY,
CourseName NVARCHAR (50),
CourseDescription NTEXT,
Credits INT
);

/* Вставляємо до таблиці Students та Courses відповідні значення */

INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)

VALUES

(1, 'Олександр', 'Петров', '2020-09-15'),

(2, 'Марія', 'Іваненко', '2021-09-22'),

(3, 'Василь', 'Коваленко', '2023-09-10');

INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)

VALUES

(1, 'Економетрика', 'Метою вивчення дисципліни "Економетрика" є формування у студентів глибокого розуміння методів та інструментів аналізу економічних явищ 
з використанням математичних та статистичних моделей...', 6),

(2, 'Інформаційні системи та технології в економіці', 
'Метою вивчення дисципліни "Інформаційні системи та технології в економіці" є формування у студентів комплексних знань щодо основних концепцій, 
методів та інструментів інформаційних систем і технологій в контексті сучасної економіки...', 3),

(3, 'Маркетинг', 
'Метою вивчення дисципліни «Маркетинг» є формування знань щодо базових категорій маркетингу,
методологічних аспектів організації маркетингової діяльності та її пріоритетів у сучасних умовах', 6);

/* Переглядаємо таблиці зі вставленими даними */

SELECT * FROM Students
SELECT * FROM Courses

/* Змінюємо таблиці, додаючи до них ще по одному стовпцю */

ALTER TABLE Students ADD Email NVARCHAR(20);
ALTER TABLE Courses ADD Department NVARCHAR(50);

/* Переглядаємо таблиці зі вставленими даними */

SELECT * FROM Students
SELECT * FROM Courses 

/* Видаляємо базу даних University */

DROP DATABASE University