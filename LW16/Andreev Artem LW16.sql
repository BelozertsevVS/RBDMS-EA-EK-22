/*�������� 1
�� ��������� ����� ���������� ������� ������� (@number) ���������� �����.
�������������� �������� print ��� ��������� ������� �������� ����������� �����.*/
DECLARE @number1 INT = 5;
DECLARE @i1 INT = 1;

PRINT '�������� 1: ��������� ���������� �����';
WHILE @i1 <= @number1
BEGIN
    PRINT POWER(@i1, 2);
    SET @i1 = @i1 + 1;
END
PRINT '';

/*�������� 2
�� ��������� ����� ���������� ������� ������� (@number) ������ �����.
�������������� �������� print ��� ��������� ������� �������� ������� �����.*/
DECLARE @number2 INT = 5;
DECLARE @i2 INT = 2;

PRINT '�������� 2: ��������� ������ �����';
WHILE @i2 <= @number2 * 2
BEGIN
    PRINT @i2;
    SET @i2 = @i2 + 2;
END
PRINT '';

/*�������� 3
�� ��������� ����� ���������� ������� ������� (@number) ����� Գ�������.
�������������� �������� print ��� ��������� ������� �������� ����� Գ�������*/
DECLARE @number3 INT = 10;
DECLARE @i3 INT = 1;
DECLARE @a INT = 0, @b INT = 1, @fib INT;

PRINT '�������� 3: ��������� ����� Գ�������';
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

/*�������� 4
������� ��������� �������� ������� #local_temp_dates. �� ��������� ����� ������ ������� ������� ��� (@iterations), ��������� � ������� ���� (@start_date).
�����, ������ �������, ��������� ����������� ������� ������� ��� �� ��������� ����� � ������ ���� � ��������� �������� �������.
@start_date - ���� ����� ����. �� ��������� ��������� print, ������� ����� ����� ������ �������� ����� (����������).
- �������������� ���� @iterations, @start_date, @I
- �������������� �������� IF � ��������� � �������� OBJECT_ID ��� ��������� ��������� �������� ������� #local_temp_dates � �������, ���� ���� ����.
- �������������� ���� while.*/


DECLARE @id INT = 10; 
DECLARE @start_date DATE = '2024-05-01'; 
DECLARE @I INT = 1; 

IF OBJECT_ID('tempdb..#local_temp_dates') IS NOT NULL
DROP TABLE #local_temp_dates;

CREATE TABLE #local_temp_dates (
ID INT IDENTITY(1,1),
���� DATE
);

WHILE @I <= @id
BEGIN
INSERT INTO #local_temp_dates (����)
VALUES (DATEADD(DAY, @I - 1, @start_date)); 

PRINT '�������� ' + CAST(@I AS NVARCHAR(10)); 
SET @I = @I + 1; 
END;

SELECT * FROM #local_temp_dates;
