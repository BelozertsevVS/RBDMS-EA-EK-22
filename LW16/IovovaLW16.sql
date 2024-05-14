USE WebStor;
/*
За допомогою циклу згенеруйте вказану кількість (@number) квадратних чисел.
Використовуйте оператор print для виведення кожного окремого квадратного числа.
*/
--Виконання завдання:
DECLARE @number INT;
DECLARE @i INT;
SET @number = 10; 
SET @i = 1;
WHILE @i <= @number
BEGIN
    DECLARE @square INT;
    SET @square = @i * @i;
    PRINT @square;
    SET @i = @i + 1;
END;
--Завдання виконано.

/*
За допомогою циклу згенеруйте вказану кількість (@number) парних чисел.
Використовуйте оператор print для виведення кожного окремого парного числа.
*/
--Виконання завдання:
DECLARE @Number INT = 10; 
DECLARE @Count INT = 0;
DECLARE @CurrentNumber INT = 0;

WHILE @Count < @Number
BEGIN
    IF @CurrentNumber % 2 = 0
    BEGIN
        PRINT @CurrentNumber;
        SET @Count = @Count + 1;
    END
    SET @CurrentNumber = @CurrentNumber + 1;
END;
--Завдання виконано.

/*
За допомогою циклу згенеруйте вказану кількість (@number) чисел Фібоначчі.
Використовуйте оператор print для виведення кожного окремого числа Фібоначчі.
*/
--Виконання завдання:
CREATE FUNCTION dbo.Fibonacci (@n INT)
RETURNS TABLE
AS
RETURN (
    WITH FibonacciSeries AS (
        SELECT 0 AS n, 0 AS Fib
        UNION ALL
        SELECT 1, 1
        UNION ALL
        SELECT n + 1, Fib + LEAD(Fib, 1, 0) OVER (ORDER BY n) 
        FROM FibonacciSeries
        WHERE n < @n - 1
    )
    SELECT Fib FROM FibonacciSeries
);
DECLARE @Number INT = 10;
SELECT Fib FROM dbo.Fibonacci(@Number);
--Завдання виконано.

/*
Створіть тимчасову локальну таблицю #local_temp_dates. За допомогою циклу внесіть вказану кількість дат (@iterations), починаючи з вказаної дати (@start_date).
Тобто, іншими словами, необхідно згенерувати вказану кількість дат за допомогою циклу і внести дати у тимчасову локальну таблицю.
@start_date - сама перша дата. За допомогою оператора print, виведіть номер кожної окремої ітерації циклу (повторення).
- Використовуйте змінні @iterations, @start_date, @I
- Використовуйте оператор IF у комбінації з функцією OBJECT_ID для видалення тимчасової  локальної таблиці #local_temp_dates у випадку, якщо вона існує.
- Використовуйте цикл while.
*/
--Виконання завдання:
-- Перевіряємо чи існує тимчасова таблиця #local_temp_dates, якщо так - видаляємо:
IF OBJECT_ID('tempdb..#local_temp_dates') IS NOT NULL
    DROP TABLE #local_temp_dates;
-- Задаємо змінні:
DECLARE @iterations INT = 10; -- Кількість ітерацій
DECLARE @start_date DATE = '2024-05-01'; -- Початкова дата
DECLARE @i INT = 1; -- Лічильник циклу
-- Створюємо тимчасову таблицю:
CREATE TABLE #local_temp_dates (
    IterationNumber INT,
    GeneratedDate DATE
);
-- Ініціалізуємо змінну перед використанням у циклі:
SET @i = 1; 
-- Цикл для внесення дат у тимчасову таблицю:
WHILE @i <= @iterations
BEGIN
    -- Використовуємо змінні напряму у складеній SQL-операції:
    INSERT INTO #local_temp_dates (IterationNumber, GeneratedDate)
    VALUES (@i, DATEADD(DAY, @i - 1, @start_date));
    -- Виводимо номер кожної окремої ітерації циклу:
    PRINT 'Iteration: ' + CAST(@i AS VARCHAR(10));
    -- Інкрементуємо лічильник циклу:
    SET @i = @i + 1;
END;
--Завдання виконано.
