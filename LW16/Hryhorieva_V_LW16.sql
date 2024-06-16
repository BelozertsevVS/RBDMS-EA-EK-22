/*Завдання 1
За допомогою циклу згенеруйте вказану кількість (@number) квадратних чисел.
Використовуйте оператор print для виведення кожного окремого квадратного числа.*/

DECLARE @number INT=18
DECLARE @v INT=1
WHILE @v <= @number
BEGIN PRINT POWER (@v, 2);
SET @v=@v+1 END

/*Завдання 2
За допомогою циклу згенеруйте вказану кількість (@number) парних чисел.
Використовуйте оператор print для виведення кожного окремого парного числа.*/

DECLARE @number INT=18
DECLARE @v INT=1
WHILE @v <= @number
BEGIN IF @v % 2=0
BEGIN PRINT @v END;
SET @v=@v+1 END

/*Завдання 3
За допомогою циклу згенеруйте вказану кількість (@number) чисел Фібоначчі.
Використовуйте оператор print для виведення кожного окремого числа Фібоначчі*/

DECLARE @number INT = 18
DECLARE @v INT = 1
DECLARE @a INT = 0
DECLARE @b INT = 1
DECLARE @SUM INT 
WHILE @v <= @number
BEGIN PRINT @a
SET @SUM = @a + @b
SET @a = @b
SET @b = @SUM
SET @v = @v + 1
END

/*Завдання 4
Створіть тимчасову локальну таблицю #local_temp_dates. За допомогою циклу внесіть вказану кількість дат (@iterations), починаючи з вказаної дати (@start_date).
Тобто, іншими словами, необхідно згенерувати вказану кількість дат за допомогою циклу і внести дати у тимчасову локальну таблицю.
@start_date - сама перша дата. За допомогою оператора print, виведіть номер кожної окремої ітерації циклу (повторення).
- Використовуйте змінні @iterations, @start_date, @I
- Використовуйте оператор IF у комбінації з функцією OBJECT_ID для видалення тимчасової локальної таблиці #local_temp_dates у випадку, якщо вона існує.
- Використовуйте цикл while.*/

DECLARE @table INT;
SET @table = OBJECT_ID('tempbd..#local_temp_dates');

IF @table IS NOT NULL
DROP TABLE #local_temp_dates; 

CREATE TABLE #local_temp_dates ([iterations] INT, [start_date] DATE);

DECLARE @start_date DATE = '20240101';
DECLARE @iterations INT = 10;
DECLARE @I INT;

SET @I=1;
WHILE @I <= @iterations
BEGIN INSERT INTO #local_temp_dates ([iterations], [start_date])
VALUES (@I, @start_date);
SET @I=@I+1;
SET @start_date=DATEADD(DAY, 1, @start_date);
END 

SELECT*FROM #local_temp_dates
