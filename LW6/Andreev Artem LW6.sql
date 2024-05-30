-- Завдання 1.1: Створення бази даних та таблиць
CREATE DATABASE UniversityDB;
GO
USE UniversityDB;
GO
-- Створення таблиці Departments без обмежень
CREATE TABLE Departments (
DepartmentID INT NOT NULL,
DepartmentName VARCHAR(100)
);
GO
-- Створення таблиці Professors без обмежень
CREATE TABLE Professors (
ProfessorID INT NOT NULL,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Age TINYINT,
DepartmentID INT,
Email VARCHAR(100)
);
GO
-- Завдання 1.2: Додавання обмежень до існуючих таблиць

-- Додавання PRIMARY KEY до Departments та Professors
ALTER TABLE Departments ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);
ALTER TABLE Professors ADD CONSTRAINT PK_Professor PRIMARY KEY (ProfessorID);

-- Додавання UNIQUE обмеження на Email в Professors
ALTER TABLE Professors ADD CONSTRAINT UQ_Professor_Email UNIQUE (Email);

-- Додавання FOREIGN KEY обмеження до Professors для зв'язку з Departments
ALTER TABLE Professors ADD CONSTRAINT FK_Professor_Department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

-- Додавання CHECK обмеження на Age в Professors
ALTER TABLE Professors ADD CONSTRAINT CK_Age CHECK (Age >= 20);

-- Додавання NOT NULL обмежень на FirstName і LastName в Professors
ALTER TABLE Professors ALTER COLUMN FirstName VARCHAR(50) NOT NULL;
ALTER TABLE Professors ALTER COLUMN LastName VARCHAR(50) NOT NULL;

-- Додавання DEFAULT значення для DepartmentName в Departments
ALTER TABLE Departments ADD CONSTRAINT DF_DepartmentName DEFAULT 'General' FOR DepartmentName;

-- Завдання 1.3: Введення та тестування даних
-- Введення даних до Departments
INSERT INTO Departments (DepartmentID) VALUES (1); -- Використовується значення за замовчуванням 'General'

-- Введення даних до Professors з прив'язкою до Departments через DepartmentID
INSERT INTO Professors (ProfessorID, FirstName, LastName, Age, DepartmentID, Email)
VALUES (1, 'John', 'Smith', 57, 1, 'john.smith@university.com');
-- Спроба вставити запис до Professors з існуючим Email, щоб перевірити UNIQUE обмеження
-- Це має викликати помилку
INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email)
VALUES (2, 'Jane', 'Doe', 1, 35, 'john.smith@university.com');

-- Спроба вставити запис до Professors з віком менше 20, щоб перевірити CHECK обмеження
-- Це має викликати помилку
INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email)
VALUES (3, 'Bob', 'Doe', 1, 17, 'bob@university.com');

-- Завдання 1.4: Очищення
-- Переключити контекст на іншу базу даних
USE master;
GO
-- Заборонити нові підключення і відключити поточні підключення
ALTER DATABASE UniversityDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
-- Видалення таблиць Professors та Departments
DROP TABLE Professors;
DROP TABLE Departments;
-- Видалення бази даних UniversityDB
DROP DATABASE UniversityDB;

-- Блок 2: Створення таблиць з обмеженнями
-- Завдання 2.1: Створення бази даних і таблиць
CREATE DATABASE CompanyDB;
GO

USE CompanyDB;
GO

-- Створення таблиці Employees з обмеженнями
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Position VARCHAR(50) DEFAULT 'Junior Developer'
);
GO

-- Створення таблиці Departments з обмеженнями
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL CHECK (DepartmentName <> ''),
    Budget DECIMAL(10, 2) CHECK (Budget > 0),
    DefaultRoomNumber INT DEFAULT 101
);
GO

-- Створення таблиці Assignments з FOREIGN KEY
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    DepartmentID INT NOT NULL,
    AssignmentDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

-- Завдання 2.2: Введення та тестування даних

-- Введення даних до Departments та Employees, потім створення призначень в Assignments
INSERT INTO Departments (DepartmentID, DepartmentName, Budget) VALUES (1, 'Human Resources', 50000);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email) VALUES (1, 'John', 'Smith', 'john.smith@company.com');
INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID) VALUES (1, 1, 1);

-- Спроба вставити запис до Assignments з неіснуючим EmployeeID або DepartmentID, щоб перевірити FOREIGN KEY обмеження
-- Це має викликати помилку
INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID) VALUES (2, 999, 1);

-- Завдання 2.3: Очищення
-- Переключити контекст на іншу базу даних
USE master;
GO
-- Заборонити нові підключення і відключити поточні підключення
ALTER DATABASE CompanyDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
-- Видалення таблиць Assignments, Employees та Departments
DROP TABLE Assignments;
DROP TABLE Employees;
DROP TABLE Departments;

-- Видалення бази даних CompanyDB
DROP DATABASE CompanyDB;

