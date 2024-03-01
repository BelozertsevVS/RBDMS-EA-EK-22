   --Створюємо базу даних Students:
   CREATE DATABASE Students;
   --Переключимося на створену БД:
   USE STUDENTS;

   --Створимо таблицю PersonalInfo з наступними стовпцями, як айді, прізвище, ім'я та дата народження з певними характеристиками даних:
   CREATE TABLE PersonalInfo (
        StudentID INT PRIMARY KEY,
        FirstName NVARCHAR(50),
        LastName NVARCHAR(50),
        DateOfBirth DATE
    );
	--Створимо таблицю AcademicInfo з наступними стовпцями, як айді, айді студента, факультет, куратор та дата випуску з певними характеристиками даних:
      CREATE TABLE AcademicInfo (
        RecordID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
        Faculty NVARCHAR(100),
        Curator NVARCHAR(100),
        EnrollmentYear INT
    );
	--Створимо таблицю ContactInfo з наступними стовпцями, як айді, айді студента, емейл та номер телефону з певними характеристиками даних:
    CREATE TABLE ContactInfo (
        ContactID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
        Email NVARCHAR(100),
        PhoneNumber NVARCHAR(15)
    );

	--Додамо стовбець Address до таблиці ContactInfo:
        ALTER TABLE ContactInfo ADD Address NVARCHAR(200);
    --Видалимо стовбець PhoneNumber з тієї ж таблиці:
    ALTER TABLE ContactInfo DROP COLUMN PhoneNumber;
	--Змінимо ім'я стовбця Email на EmailAddress тієї ж таблиці:
      EXEC sp_rename 'ContactInfo.Email', 'EmailAddress', 'COLUMN';

	  --Змінимо тип даних для стовбця Faculty у таблиці AcademicInfo на NVARCHAR(150):
   ALTER TABLE AcademicInfo
   ALTER COLUMN Faculty NVARCHAR(150);

   --Додамо нову таблицю Extracurricular з стовпцями айді,айді студента, назва активності,дата приєднання з певними характеристиками:
        CREATE TABLE Extracurricular (
        ActivityID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
        ActivityName NVARCHAR(100),
        JoinDate DATE
    );
	--Таблиця була успішно створена, тепер видалимо її:
	DROP TABLE Extracurricular;

	--Створимо БД TEACHER:
       CREATE DATABASE TEACHER;
	   --БД була створена, тепер видалимо її:
	     DROP DATABASE TEACHER;
		 --БД була успішно видалена
		 
		 --Переключимося на БД Students:
		 USE STUDENTS;
		-- Додамо 3 рядки даних до таблиці PersonalInfo з наступними характеристиками:
INSERT INTO PersonalInfo (StudentID, FirstName, LastName, DateOfBirth)
VALUES 
    (1, 'Олександр', 'Петров', '2000-05-15'),
    (2, 'Марія', 'Іваненко', '2001-03-22'),
    (3, 'Василь', 'Коваленко', '1999-10-10');
	--Рядки були додані, перевіримо, чи все вийшло правильно:
	SELECT TOP (1000) [StudentID]
      ,[FirstName]
      ,[LastName]
      ,[DateOfBirth]
  FROM [Students].[dbo].[PersonalInfo]
  --Все вийшло, результати можна побачити нижче