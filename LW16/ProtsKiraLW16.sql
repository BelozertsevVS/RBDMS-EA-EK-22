/*Завдання 1
За допомогою циклу згенеруйте вказану кількість (@number) квадратних чисел.
Використовуйте оператор print для виведення кожного окремого квадратного числа.*/
GO
DECLARE @number INT = 10;
DECLARE @k INT = 1;
  WHILE @number >= @k
  BEGIN PRINT @k * @k;
	    SET @k = @k + 1;
  END

/*Завдання 2
За допомогою циклу згенеруйте вказану кількість (@number) парних чисел.
Використовуйте оператор print для виведення кожного окремого парного числа.*/
GO
DECLARE @number INT = 10;
DECLARE @k INT = 1;
 WHILE  @number >= @k
 BEGIN
    IF  @k % 2 = 0
    BEGIN PRINT @k;
	END
	    SET @k = @k + 1;
        END

/*Завдання 3
За допомогою циклу згенеруйте вказану кількість (@number) чисел Фібоначчі.
Використовуйте оператор print для виведення кожного окремого числа Фібоначчі.*/
GO
DECLARE @number INT = 22;
DECLARE @k INT = 1;
DECLARE @current_num INT = 0;
DECLARE @next_num INT = 1;
DECLARE @sum INT;
	WHILE @number >= @k
	BEGIN PRINT @current_num;
		SET @sum = @current_num + @next_num;
		SET @current_num = @next_num;
		SET @next_num = @sum;
		SET @k = @k + 1;
	END

/*Завдання 4
Створіть тимчасову локальну таблицю #local_temp_dates. За допомогою циклу внесіть вказану кількість дат (@iterations), починаючи з вказаної дати (@start_date).
Тобто, іншими словами, необхідно згенерувати вказану кількість дат за допомогою циклу і внести дати у тимчасову локальну таблицю.
@start_date - сама перша дата. За допомогою оператора print, виведіть номер кожної окремої ітерації циклу (повторення).
- Використовуйте змінні @iterations, @start_date, @I
- Використовуйте оператор IF у комбінації з функцією OBJECT_ID для видалення тимчасової локальної таблиці #local_temp_dates у випадку, якщо вона існує.
- Використовуйте цикл while.*/
IF OBJECT_ID('tempdb..#local_temp_dates') IS NOT NULL
BEGIN
  DROP TABLE #local_temp_dates;
  END;
DECLARE @iterations INT = 10; 
DECLARE @start_date DATE = '2024-01-01'; 
DECLARE @I INT; 
CREATE TABLE #local_temp_dates 
(iteration_number INT, 
 [date]           DATE);
SET @I = 1;
    WHILE @I <= @iterations
    BEGIN
	  INSERT INTO #local_temp_dates (iteration_number, date)
	  VALUES (@I, @start_date);
	  PRINT 'Ітерація: ' + CONVERT(VARCHAR(10), @I);
	  SET @start_date = DATEADD(DAY, 1, @start_date);
	  SET @I = @I + 1;
    END;
SELECT *
FROM #local_temp_dates;

DROP TABLE #local_temp_dates;
