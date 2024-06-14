/*Завдання 1
За допомогою циклу згенеруйте вказану кількість (@number) квадратних чисел.
Використовуйте оператор print для виведення кожного окремого квадратного числа.*/
DECLARE @number1 INT = 5;
DECLARE @i1 INT = 1;

PRINT 'Завдання 1: Генерація квадратних чисел';
WHILE @i1 <= @number1
BEGIN
    PRINT POWER(@i1, 2);
    SET @i1 = @i1 + 1;
END
PRINT '';

/*Завдання 2
За допомогою циклу згенеруйте вказану кількість (@number) парних чисел.
Використовуйте оператор print для виведення кожного окремого парного числа.*/
DECLARE @number2 INT = 5;
DECLARE @i2 INT = 2;

PRINT 'Завдання 2: Генерація парних чисел';
WHILE @i2 <= @number2 * 2
BEGIN
    PRINT @i2;
    SET @i2 = @i2 + 2;
END
PRINT '';

/*Завдання 3
За допомогою циклу згенеруйте вказану кількість (@number) чисел Фібоначчі.
Використовуйте оператор print для виведення кожного окремого числа Фібоначчі*/
DECLARE @number3 INT = 10;
DECLARE @i3 INT = 1;
DECLARE @a INT = 0, @b INT = 1, @fib INT;

PRINT 'Завдання 3: Генерація чисел Фібоначчі';
WHILE @i3 <= @number3
BEGIN
    IF @i3 <= 2
        SET @fib = @i3 - 1;
    ELSE
    BEGIN
        SET @fib = @a + @b;
        SET @a = @b;
        SET @b = @fib;
    END
    
    PRINT @fib;
    SET @i3 = @i3 + 1;
END
PRINT '';

/*Завдання 4
Створіть тимчасову локальну таблицю #local_temp_dates. За допомогою циклу внесіть вказану кількість дат (@iterations), починаючи з вказаної дати (@start_date).
Тобто, іншими словами, необхідно згенерувати вказану кількість дат за допомогою циклу і внести дати у тимчасову локальну таблицю.
@start_date - сама перша дата. За допомогою оператора print, виведіть номер кожної окремої ітерації циклу (повторення).
- Використовуйте змінні @iterations, @start_date, @I
- Використовуйте оператор IF у комбінації з функцією OBJECT_ID для видалення тимчасової локальної таблиці #local_temp_dates у випадку, якщо вона існує.
- Використовуйте цикл while.*/


DECLARE @id INT = 10; 
DECLARE @start_date DATE = '2024-05-01'; 
DECLARE @I INT = 1; 

IF OBJECT_ID('tempdb..#local_temp_dates') IS NOT NULL
DROP TABLE #local_temp_dates;

CREATE TABLE #local_temp_dates (
ID INT IDENTITY(1,1),
Дата DATE
);

WHILE @I <= @id
BEGIN
INSERT INTO #local_temp_dates (Дата)
VALUES (DATEADD(DAY, @I - 1, @start_date)); 

PRINT 'Ітерація ' + CAST(@I AS NVARCHAR(10)); 
SET @I = @I + 1; 
END;

SELECT * FROM #local_temp_dates;
