-- �������� 1.1: ��������� ���� ����� �� �������
CREATE DATABASE UniversityDB;
GO
USE UniversityDB;
GO
-- ��������� ������� Departments ��� ��������
CREATE TABLE Departments (
DepartmentID INT NOT NULL,
DepartmentName VARCHAR(100)
);
GO
-- ��������� ������� Professors ��� ��������
CREATE TABLE Professors (
ProfessorID INT NOT NULL,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Age TINYINT,
DepartmentID INT,
Email VARCHAR(100)
);
GO
-- �������� 1.2: ��������� �������� �� �������� �������

-- ��������� PRIMARY KEY �� Departments �� Professors
ALTER TABLE Departments ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);
ALTER TABLE Professors ADD CONSTRAINT PK_Professor PRIMARY KEY (ProfessorID);

-- ��������� UNIQUE ��������� �� Email � Professors
ALTER TABLE Professors ADD CONSTRAINT UQ_Professor_Email UNIQUE (Email);

-- ��������� FOREIGN KEY ��������� �� Professors ��� ��'���� � Departments
ALTER TABLE Professors ADD CONSTRAINT FK_Professor_Department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

-- ��������� CHECK ��������� �� Age � Professors
ALTER TABLE Professors ADD CONSTRAINT CK_Age CHECK (Age >= 20);

-- ��������� NOT NULL �������� �� FirstName � LastName � Professors
ALTER TABLE Professors ALTER COLUMN FirstName VARCHAR(50) NOT NULL;
ALTER TABLE Professors ALTER COLUMN LastName VARCHAR(50) NOT NULL;

-- ��������� DEFAULT �������� ��� DepartmentName � Departments
ALTER TABLE Departments ADD CONSTRAINT DF_DepartmentName DEFAULT 'General' FOR DepartmentName;

-- �������� 1.3: �������� �� ���������� �����
-- �������� ����� �� Departments
INSERT INTO Departments (DepartmentID) VALUES (1); -- ��������������� �������� �� ������������� 'General'

-- �������� ����� �� Professors � ����'����� �� Departments ����� DepartmentID
INSERT INTO Professors (ProfessorID, FirstName, LastName, Age, DepartmentID, Email)
VALUES (1, 'John', 'Smith', 57, 1, 'john.smith@university.com');
-- ������ �������� ����� �� Professors � �������� Email, ��� ��������� UNIQUE ���������
-- �� �� ��������� �������
INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email)
VALUES (2, 'Jane', 'Doe', 1, 35, 'john.smith@university.com');

-- ������ �������� ����� �� Professors � ���� ����� 20, ��� ��������� CHECK ���������
-- �� �� ��������� �������
INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email)
VALUES (3, 'Bob', 'Doe', 1, 17, 'bob@university.com');

-- �������� 1.4: ��������
-- ����������� �������� �� ���� ���� �����
USE master;
GO
-- ���������� ��� ���������� � ��������� ������ ����������
ALTER DATABASE UniversityDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
-- ��������� ������� Professors �� Departments
DROP TABLE Professors;
DROP TABLE Departments;
-- ��������� ���� ����� UniversityDB
DROP DATABASE UniversityDB;

-- ���� 2: ��������� ������� � �����������
-- �������� 2.1: ��������� ���� ����� � �������
CREATE DATABASE CompanyDB;
GO

USE CompanyDB;
GO

-- ��������� ������� Employees � �����������
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Position VARCHAR(50) DEFAULT 'Junior Developer'
);
GO

-- ��������� ������� Departments � �����������
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL CHECK (DepartmentName <> ''),
    Budget DECIMAL(10, 2) CHECK (Budget > 0),
    DefaultRoomNumber INT DEFAULT 101
);
GO

-- ��������� ������� Assignments � FOREIGN KEY
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    DepartmentID INT NOT NULL,
    AssignmentDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

-- �������� 2.2: �������� �� ���������� �����

-- �������� ����� �� Departments �� Employees, ���� ��������� ���������� � Assignments
INSERT INTO Departments (DepartmentID, DepartmentName, Budget) VALUES (1, 'Human Resources', 50000);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email) VALUES (1, 'John', 'Smith', 'john.smith@company.com');
INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID) VALUES (1, 1, 1);

-- ������ �������� ����� �� Assignments � ��������� EmployeeID ��� DepartmentID, ��� ��������� FOREIGN KEY ���������
-- �� �� ��������� �������
INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID) VALUES (2, 999, 1);

-- �������� 2.3: ��������
-- ����������� �������� �� ���� ���� �����
USE master;
GO
-- ���������� ��� ���������� � ��������� ������ ����������
ALTER DATABASE CompanyDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
-- ��������� ������� Assignments, Employees �� Departments
DROP TABLE Assignments;
DROP TABLE Employees;
DROP TABLE Departments;

-- ��������� ���� ����� CompanyDB
DROP DATABASE CompanyDB;

