--������ 1
--�������� �����, ���� ������� ������ �������������� ��������� (��� ��������).
--���������� ����� ����������, �� ���� �������� � 2008 ����.
--��������������� ������� [dbo].[ORDERS]
--�������� ������� Year
--�������������� ���� ����� ������: ������������� ���������
--³��������� �������������� ���� ����� �� ������������� ��������� (�� ����������)
-- ������ 1
SELECT DISTINCT [MFR]
FROM [dbo].[ORDERS]
WHERE YEAR([ORDER_DATE]) = 2008
ORDER BY [MFR];

-- ������ 2
--�������� �����, ���� � ����� ������� ������������� ���� (����������� ������ � �����) ������� ������� ����������.
--��������������� ������� [dbo].[SALESREPS]
--�������������� ���� ����� ������: ʳ������ ����, ������� ����������
--³��������� ��������� �� ������� ���������� �� ����������
SELECT 
DATEDIFF(YEAR, [HIRE_DATE], GETDATE()) AS YearsWorked,
COUNT(*) AS NumberOfEmployees
FROM [dbo].[SALESREPS]
GROUP BY DATEDIFF(YEAR, [HIRE_DATE], GETDATE())
ORDER BY NumberOfEmployees DESC;

-- ������ 3
--�������� �����, ���� ������� ����� (��, �����) ����� � ��������� ������� ����������.
--���������� ��������� ����, �� ������ ����� ������ ������ ���� �������� ������� ����������.
--��������������� ������� [dbo].[SALESREPS]
--�������� �������: Year, Month
--�������������� ���� ����� ������: г� �����, ����� �����, ������� �������� ���������� */
SELECT
YEAR([HIRE_DATE]) AS HireYear,
MONTH([HIRE_DATE]) AS HireMonth,
COUNT(*) AS NumberOfEmployees
FROM [dbo].[SALESREPS]
GROUP BY YEAR([HIRE_DATE]), MONTH([HIRE_DATE])
ORDER BY NumberOfEmployees DESC;
-- ������ 4
--�������� �����, ���� � ����� ��� ����� (� ���������� ������������) ������� ������� ��������� ���������, �������� ���� ������, �������� ������� �������� ��. ������ (�� ���� ���).
--���������� ����� ����������, �� ���� �������� � ����� �����.
--��������������� ������� [dbo].[ORDERS]
--�������������� ���� ����� ������: ����� ��� �����, ����� ��� �����, �������� ������� ���������� ���������, �������� ���� ������, �������� ������� �������� ��. ������.
--³��������� ��������� �� ���� ����� (�� ����������).
--(�������� ��������� ��� ����� �������� �� ��)
SELECT 
    DATEPART(WEEKDAY, [ORDER_DATE]) AS WeekNumber,
	DATENAME(WEEKDAY, [ORDER_DATE]) AS DayOfWeek,
    COUNT(DISTINCT [ORDER_NUM]) AS TotalOrders,
    SUM([AMOUNT]) AS TotalSalesAmount,
    SUM([QTY]) AS TotalQuantitySold
FROM 
    [dbo].[ORDERS]
WHERE 
    MONTH([ORDER_DATE]) IN (12, 1, 2) -- ����� �����: �������, ѳ����, �����
GROUP BY 
    DATENAME(WEEKDAY, [ORDER_DATE]), DATEPART(WEEKDAY, [ORDER_DATE])
ORDER BY WeekNumber;