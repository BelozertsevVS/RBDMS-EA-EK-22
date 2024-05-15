/*Завдання 1
За допомогою циклу згенеруйте вказану кількість (@number) квадратних чисел.
Використовуйте оператор print для виведення кожного окремого квадратного числа.*/

DECLARE @number INT = 10
DECLARE @k INT = 1
WHILE @k <= @number
	BEGIN PRINT(@k * @k)
	        SET @k = @k + 1
    END;
GO

/*Завдання 2
За допомогою циклу згенеруйте вказану кількість (@number) парних чисел.
Використовуйте оператор print для виведення кожного окремого парного числа.*/

DECLARE @number INT = 10
DECLARE @k INT = 1
WHILE @k <= @number
	BEGIN
	 IF @k % 2 = 0
	 BEGIN PRINT @k
	 END;
	 SET @k = @k + 1
     END;
GO

/*Завдання 3
За допомогою циклу згенеруйте вказану кількість (@number) чисел Фібоначчі.
Використовуйте оператор print для виведення кожного окремого числа Фібоначчі.*/

DECLARE @number INT = 10
DECLARE @k INT = 1
DECLARE @x INT = 0
DECLARE @y INT = 1
DECLARE @SUM INT 
   WHILE @k <= @number
	BEGIN PRINT @x
	 SET @SUM = @x + @y
	 SET @x = @y
	 SET @y = @SUM
	 SET @k = @k + 1
	END;
GO

/*Завдання 4
Створіть тимчасову локальну таблицю #local_temp_dates. 
За допомогою циклу внесіть вказану кількість дат (@iterations), починаючи з вказаної дати (@start_date).
Тобто, іншими словами, необхідно згенерувати вказану кількість дат за допомогою циклу і внести дати у тимчасову локальну таблицю.
@start_date - сама перша дата. За допомогою оператора print, виведіть номер кожної окремої ітерації циклу (повторення).
- Використовуйте змінні @iterations, @start_date, @I
- Використовуйте оператор IF у комбінації з функцією OBJECT_ID для видалення тимчасової локальної таблиці #local_temp_dates 
у випадку, якщо вона існує.
- Використовуйте цикл while.*/

DECLARE @table_exists INT;
SET @table_exists = OBJECT_ID('tempdb..#local_temp_dates');

IF  @table_exists IS NOT NULL
 BEGIN DROP TABLE #local_temp_dates;
 END;

CREATE TABLE #local_temp_dates 
([iterations] INT,
       [start_date] DATE);

DECLARE @iterations INT = 10; 
DECLARE @start_date DATE = '20240101'; 
DECLARE @I INT;
	SET @I = 1;
	WHILE @I <= @iterations
	BEGIN
		PRINT 'Ітерація: ' + STR(@I);
		INSERT INTO #local_temp_dates ([iterations], [start_date])
		VALUES (@I, @start_date);
		SET @I = @I + 1;
		SET @start_date = DATEADD(DAY, 1, @start_date);
	END;

SELECT * FROM #local_temp_dates;
