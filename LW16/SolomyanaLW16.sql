/*Завдання 1
За допомогою циклу згенеруйте вказану кількість (@number) квадратних чисел.
Використовуйте оператор print для виведення кожного окремого квадратного числа.
*/
DECLARE @number INT = 5; -- Задайте кількість квадратних чисел
DECLARE @i INT = 1;

WHILE @i <= @number
BEGIN
    PRINT POWER(@i, 2);
    SET @i = @i + 1;
END


/*Завдання 2
За допомогою циклу згенеруйте вказану кількість (@number) парних чисел.
Використовуйте оператор print для виведення кожного окремого парного числа.
*/
DECLARE @number INT = 5; -- Задає кількість парних чисел
DECLARE @i INT = 1;

WHILE @i <= @number
BEGIN
    IF @i % 2 = 0 -- Перевіряє, чи є поточне значення @i парним
    BEGIN
        PRINT @i; -- Виводить поточне значення @i, якщо воно парне
    END
    SET @i = @i + 1;
END


/*Завдання 3
За допомогою циклу згенеруйте вказану кількість (@number) чисел Фібоначчі.
Використовуйте оператор print для виведення кожного окремого числа Фібоначчі.
*/

DECLARE @number INT = 5; -- Кількість чисел Фібоначчі
DECLARE @a INT = 0, @b INT = 1, @sum INT, @i INT = 1;

WHILE @i <= @number
BEGIN
    PRINT @a;
    SET @sum = @a + @b;
    SET @a = @b;
    SET @b = @sum;
    SET @i = @i + 1;
END

/*Завдання 4
Створіть тимчасову локальну таблицю #local_temp_dates. За допомогою циклу внесіть вказану кількість дат (@iterations), починаючи з вказаної дати (@start_date).
Тобто, іншими словами, необхідно згенерувати вказану кількість дат за допомогою циклу і внести дати у тимчасову локальну таблицю.
@start_date - сама перша дата. За допомогою оператора print, виведіть номер кожної окремої ітерації циклу (повторення).
- Використовуйте змінні @iterations, @start_date, @I
- Використовуйте оператор IF у комбінації з функцією OBJECT_ID для видалення тимчасової  локальної таблиці #local_temp_dates у випадку, якщо вона існує.
- Використовуйте цикл while.
*/
DECLARE @iterations INT = 5; -- Кількість дат
DECLARE @start_date DATE = '2024-01-01';
DECLARE @i INT = 1;

IF OBJECT_ID('tempdb..#local_temp_dates') IS NOT NULL
    DROP TABLE #local_temp_dates;

CREATE TABLE #local_temp_dates (GeneratedDate DATE);

WHILE @i <= @iterations
BEGIN
    INSERT INTO #local_temp_dates (GeneratedDate)
    VALUES (DATEADD(DAY, @i - 1, @start_date));

    PRINT 'Iteration ' + CAST(@i AS VARCHAR(10));
    SET @i = @i + 1;
END

SELECT * FROM #local_temp_dates;