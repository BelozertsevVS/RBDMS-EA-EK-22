/* 1. Створити нову базу даних University */

CREATE DATABASE UNIVERSITY;

-- 2. Створення таблиць:

-- Таблиця Students: створіть таблицю для зберігання інформації про студентів. Таблиця повинна містити наступні стовпці:

-- StudentID (ідентифікатор студента, ціле число)

-- FirstName (ім'я студента, рядок)

-- LastName (прізвище студента, рядок)

-- EnrollmentDate (дата запису, дата)

USE UNIVERSITY;

CREATE TABLE Students 
(
StudentID INT PRIMARY KEY, 
FirstName NVARCHAR(100),
LastName NVARCHAR(100),
EnrollmentDate DATE
);

-- Таблиця Courses: створіть таблицю для зберігання інформації про курси. Таблиця повинна містити наступні стовпці:

-- CourseID (ідентифікатор курсу, ціле число)

-- CourseName (назва курсу, рядок)

-- CourseDescription (опис курсу, текст)

-- Credits (кредити, ціле число)

CREATE TABLE Courses
(
CourseID INT PRIMARY KEY,
CourseName NVARCHAR(100),
CourseDescription TEXT,
Credits INT
);

-- 3. Заповнення таблиць даними:

-- Вставте мінімум по 3 записи в кожну таблицю з довільними даними, що відображають студентів та курси.

INSERT INTO STUDENTS(StudentID, FirstName, LastName, EnrollmentDate)
VALUES 
(1, 'EGOR', 'KOVALENKO', '20240511'),
(2, 'IGOR', 'SHEVCHENKO', '20240510'),
(3, 'OLEG', 'IVANOV', '20240512');

INSERT INTO Courses(CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'PYTHON', 'DESCRIPTION1', 90),
(2, 'C++', 'DESCRIPTION2', 90),
(3, 'C#', 'DESCRIPTION3', 90);

-- 4. Вибірка даних:

-- Виконайте запити `SELECT * FROM Students;` та `SELECT * FROM Courses;` для перегляду даних, які ви вставили.

SELECT * FROM Students;
SELECT * FROM Courses;

-- 5. Модифікація таблиць:

-- Додайте за допомогою команди ALTER по одному новому стовпцю до кожної таблиці:

-- Для Students додайте стовпець Email (електронна адреса, рядок).

-- Для Courses додайте стовпець Department (кафедра, рядок).

ALTER TABLE STUDENTS 
ADD EMAIL NVARCHAR(100);
ALTER TABLE COURSES
ADD DEPARTMENT NVARCHAR(100);

-- 6. Вибірка даних:

-- Повторно виконайте запити `SELECT * FROM Students;` та `SELECT * FROM Courses;` для перегляду оновлених таблиць.

SELECT * FROM Students;
SELECT * FROM Courses;

-- 7. Видалити базу даних University */

DROP DATABASE UNIVERSITY;