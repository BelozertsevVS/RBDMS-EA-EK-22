--Створюємо базу даних Університет:
CREATE DATABASE University;

--Створимо таблицю Студенти з наступними рядками:
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName NVARCHAR(20),
    LastName NVARCHAR(20),
    EnrollmentDate DATE
);
--Створимо таблицю Курси з наступними рядками:
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(50),
    CourseDescription TEXT,
    Credits INT
);

--Заповнимо таблиці записами (по 3 в кожну) з довільними даними:
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate)
VALUES
(1, 'Микола', 'Іванов', '2004-05-15'),
(2, 'Петро', 'Іваненко', '2005-03-22'),
(3, 'Ганна', 'Шевченко', '2004-10-10');
INSERT INTO Courses(CourseID, CourseName, CourseDescription, Credits)
VALUES
(1, 'ПУ', 'Опис курсу1,', 220),
(2, 'ПЕ', 'Опис курсу2', 200),
(3, 'ПА', 'Опис курсу3', 215);

--Виконаємо запит Select з наших таблиць:
 SELECT * FROM Students;
  SELECT * FROM Courses;

  --Модифікуємо таблиці додаванням стовпців до них:
  ALTER TABLE Students ADD Email NVARCHAR(100);
  ALTER TABLE Courses ADD Department NVARCHAR(100);

  --Знову зробимо запити до наших таблиць:
  SELECT * FROM Students;
  SELECT * FROM Courses;
 
  --Видалимо БД Університет:
 DROP DATABASE University;