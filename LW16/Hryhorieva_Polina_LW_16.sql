USE WebStor;
/*
Завдання 1
За допомогою циклу згенеруйте вказану кількість (@number) квадратних чисел.
Використовуйте оператор print для виведення кожного окремого квадратного числа.
*/
DECLARE @number INT = 1;
WHILE @number <= 15
BEGIN
     DECLARE @sq INT;
	 SET @sq = @number*@number;
     PRINT @sq;
     SET @number = @number + 1; 
END;
/*
Завдання 2
За допомогою циклу згенеруйте вказану кількість (@number) парних чисел.
Використовуйте оператор print для виведення кожного окремого парного числа.
*/
DECLARE @number INT = 2;
WHILE @number <= 16
BEGIN
     DECLARE @ev INT;
	 SET @ev = @number + 2;
	 PRINT @ev;
	 SET @number = @number + 2;
END;
/*
Завдання 3
За допомогою циклу згенеруйте вказану кількість (@number) чисел Фібоначчі.
Використовуйте оператор print для виведення кожного окремого числа Фібоначчі.
*/
DECLARE @a INT = 0;
DECLARE @b INT = 1;
DECLARE @i INT = 0;
DECLARE @c INT;
DECLARE @number INT;
SET @number = 15;
PRINT @a;
PRINT @b;
WHILE @i < @number
BEGIN
    SET @c = @a + @b;
    PRINT @c;
    SET @a = @b;
    SET @b = @c;
    SET @i = @i + 1;
END;
/*
Завдання 4
Створіть тимчасову локальну таблицю #local_temp_dates. За допомогою циклу внесіть 
вказану кількість дат (@iterations), починаючи з вказаної дати (@start_date).
Тобто, іншими словами, необхідно згенерувати вказану кількість дат за допомогою 
циклу і внести дати у тимчасову локальну таблицю.
@start_date - сама перша дата. За допомогою оператора print, виведіть номер кожної 
окремої ітерації циклу (повторення).
- Використовуйте змінні @iterations, @start_date, @I
- Використовуйте оператор IF у комбінації з функцією OBJECT_ID для видалення 
тимчасової локальної таблиці #local_temp_dates у випадку, якщо вона існує.
- Використовуйте цикл while.
*/
-- Видалення таблиці, якщо вона існує
IF OBJECT_ID('tempdb..#local_temp_dates') IS NOT NULL
    DROP TABLE #local_temp_dates;
-- Ввід змінних
DECLARE @start_date DATE = '2024-04-01';
DECLARE @iterations INT = 10; 
DECLARE @i INT = 1; 
-- Створення тимчасової локальної таблиці
CREATE TABLE #local_temp_dates
(Dates DATE);
-- Цикл для внесення дат
WHILE @i <= @iterations
BEGIN
    INSERT INTO #local_temp_dates (Dates)
    VALUES (@start_date);
    PRINT @start_date;
    SET @start_date = DATEADD(DAY, 1, @start_date); -- Збільшення дати на 1 день
    SET @i = @i + 1;
END;
-- Виведення результатів
SELECT * FROM #local_temp_dates;