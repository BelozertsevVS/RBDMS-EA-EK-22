--Створимо базу даних `UniversityDB`:
 CREATE DATABASE UniversityDB;
 USE UniversityDB;

 --Створимо таблицю `Departments` (без обмежень):
    CREATE TABLE Departments (
    DepartmentID INT NOT NULL,
    DepartmentName VARCHAR(100)
  );

  --Створіть таблицю `Professors` (без обмежень):
  CREATE TABLE Professors (
  ProfessorID INT NOT NULL,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Age TINYINT,
  DepartmentID INT,
  Email VARCHAR(100)
  );

  --Додамо PRIMARY KEY до `Departments` та `Professors`:
ALTER TABLE Departments ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);
ALTER TABLE Professors ADD CONSTRAINT PK_Professor PRIMARY KEY (ProfessorID);

--Додамо UNIQUE обмеження на `Email` в `Professors`:
ALTER TABLE Professors ADD CONSTRAINT UQ_Professor_Email UNIQUE (Email);

--Додамо FOREIGN KEY обмеження до `Professors`для поєднання `DepartmentID` з `Departments`:
ALTER TABLE Professors ADD CONSTRAINT FK_Professor_Department  FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

--Додамо CHECK обмеження на `Age` в ` Professors`, щоб значення віку не було менше 20:
ALTER TABLE Professors ADD CONSTRAINT CK_Age CHECK (Age > = 20);
  
--Додамо NOT NULL обмеження на `FirstName` і `LastName` в `Professors`:
ALTER TABLE Professors ALTER COLUMN FirstName VARCHAR(50) NOT NULL;
ALTER TABLE Professors ALTER COLUMN LastName VARCHAR(50) NOT NULL;

--Додамо DEFAULT значення для `DepartmentName` в `Departments`:
ALTER TABLE Departments ADD CONSTRAINT DF_DepartmentName DEFAULT 'General' FOR DepartmentName;

--Введемо дані до `Departments`:
INSERT INTO Departments (DepartmentID) VALUES (1); -- Застосується DEFAULT значення 'General'

--Введемо дані до `Professors`, включаючи їх прив'язку до відділів через `DepartmentID`:
  INSERT INTO Professors (ProfessorID, FirstName, LastName, Age, DepartmentID, Email) 
  VALUES (1, 'John', 'Smith', 57, 1, 'john.smith@university.com');

  --Спробуєм вставити запис до `Professors` з існуючим `Email`, щоб перевірити UNIQUE обмеження:
  INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email) 
  VALUES (2, 'Jane', 'Doe', 1, 35, 'john.smith@university.com'); -- Викликало помилку через UNIQUE обмеження

  --Спробуєм вставити запис до `Professors` з існуючим віком менше 20, щоб перевірити CHECK обмеження:
  INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email) 
  VALUES (3, 'Bob', 'Doe', 1, 17, 'bob@university.com'); -- Викликало помилку через CHECK обмеження

  --Видалимо таблиці `Professors` та `Departments`:
  DROP TABLE Professors;
  DROP TABLE Departments;
  
--Видалимо базу даних `UniversityDB`.
  DROP DATABASE UniversityDB;

  --Створимо базу даних `CompanyDB`:
  CREATE DATABASE CompanyDB;
  USE CompanyDB;

--Створимо таблицю `Employees` з PRIMARY KEY, NOT NULL, UNIQUE, і DEFAULT обмеженнями:
  CREATE TABLE Employees (
      EmployeeID INT PRIMARY KEY,
      FirstName VARCHAR(50) NOT NULL,
      LastName VARCHAR(50) NOT NULL,
      Email VARCHAR(100) UNIQUE,
      Position VARCHAR(50) DEFAULT 'Junior Developer'
  );

--Створимо таблицю `Departments` з PRIMARY KEY та CHECK обмеженнями:
  CREATE TABLE Departments (
      DepartmentID INT PRIMARY KEY,
      DepartmentName VARCHAR(100) NOT NULL CHECK (DepartmentName <> ''),
      Budget DECIMAL(10, 2) CHECK (Budget > 0),
      DefaultRoomNumber INT DEFAULT 101
  );

--Створимо таблицю `Assignments` з FOREIGN KEY, що вказує на `Employees` та `Departments`:
  CREATE TABLE Assignments (
      AssignmentID INT PRIMARY KEY,
      EmployeeID INT NOT NULL,
      DepartmentID INT NOT NULL,
      AssignmentDate DATE DEFAULT GETDATE(),
      FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
      FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
  );

--Введемо дані до `Departments` і `Employees`, потім створіть призначення у `Assignments`:
  INSERT INTO Departments (DepartmentID, DepartmentName, Budget) 
  VALUES (1, 'Human Resources', 50000);
  INSERT INTO Employees (EmployeeID, FirstName, LastName, Email) 
  VALUES (1, 'John', 'Smith', 'john.smith@company.com');
  INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID) 
  VALUES (1, 1, 1);
  
--Спробуєм вставити запис до `Assignments` з неіснуючим `EmployeeID` або `DepartmentID`, щоб перевірити FOREIGN KEY обмеження:
  INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID) 
  VALUES (2, 999, 1); -- Викликало помилку через FOREIGN KEY обмеження

--Видалимо таблиці `Assignments`, `Employees` та `Departments`:
  DROP TABLE Assignments;
  DROP TABLE Employees;
  DROP TABLE Departments;

--Видалимо БД `CompanyDB`:
    DROP DATABASE CompanyDB;
	--ЗАВДАННЯ ВИКОНАНО.