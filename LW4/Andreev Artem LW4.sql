/*
1. Створення бази даних "University"
*/
CREATE DATABASE University;
GO

/*
Перехід до бази даних "University"
*/
USE University;
GO
/*
2a. Створення таблиці "Students"
*/
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    EnrollmentDate DATE
);
GO
/*
2b. Створення таблиці "Courses"
*/
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(100),
    CourseDescription TEXT,
    Credits INT
);
GO
/*
3. Заповнення таблиць даними
*/

/* Вставка даних у таблицю "Students" */
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES
(1, 'Олександр', 'Новіков', '2023-09-01'),
(2, 'Марія', 'Приймаченко', '2022-09-01'),
(3, 'Василь', 'Вишинський', '2023-09-01');
GO
/* Вставка даних у таблицю "Courses" */
INSERT INTO Courses (CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'Математика', 'Теоретична математика', 5),
(2, 'Фізика', 'Теоретична фізика', 4),
(3, 'Програмування', 'Основи програмування на Java', 6);
GO
/*
4. Вибірка даних
*/
SELECT * FROM Students;
GO

SELECT * FROM Courses;
GO

/*
5a. Додавання стовпця "Email" до таблиці "Students"
*/
ALTER TABLE Students ADD Email NVARCHAR(100);
GO

/*
5b. Додавання стовпця "Department" до таблиці "Courses"
*/
ALTER TABLE Courses ADD Department NVARCHAR(100);
GO
/*
6. Вибірка даних після модифікації таблиць
*/
SELECT * FROM Students;
GO

SELECT * FROM Courses;
GO
/*
7. Видалення бази даних "University"
*/
DROP DATABASE University;
GO
