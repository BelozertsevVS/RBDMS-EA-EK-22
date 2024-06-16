USE WebStor;
/*
�������� 1
������� ������������� �������� �������, ��� ������ ������������� �볺��� �� ������� �������� 
� ������� ������������� ���������� ���������� �볺���.
*/
CREATE FUNCTION Latest_Order_ID (@CustomerID INT)
RETURNS INT
AS
BEGIN
DECLARE @Latest_Order_ID INT;
SELECT @Latest_Order_ID = MAX(ORDER_NUM)
FROM ORDERS
WHERE CUST = @CustomerID;
RETURN @Latest_Order_ID;
END;
/*
�������� 2
������� ������������� inline �������, ��� ������ �� ���� ���������: ���� ������� ������ 
�� ���� ���� ������. ������� ������� ��� �������� � ��������� ��������� ������� 
�������� ������� ������ �� �����.
*/
CREATE FUNCTION data_of_the_product_with_the_highest_average_number (
@Start_Date DATETIME,
@Finish_Date DATETIME
)
RETURNS TABLE
AS
RETURN
(
SELECT TOP 1 PRODUCT, AVG(QTY) AS Avg_QTY
FROM ORDERS
WHERE ORDER_DATE BETWEEN @Start_Date AND @Finish_Date
GROUP BY PRODUCT
ORDER BY Avg_QTY DESC
);
/*
�������� 3
������� ������������� Multi-statement �������, ��� ������ �� ���� ���������: ���� ������� 
������ �� ���� ���� ������. ������� ������� ��� �������� � ��������� ��������� ������� 
�������� ������� ������, � ��������� ��������� ����� ������� � � ��������� ������� ���������� 
��������� �� �����.
*/
CREATE FUNCTION Avg_Function (
@Start_Date DATETIME,
@Finish_Date DATETIME
)
RETURNS TABLE
AS
RETURN
(
SELECT TOP 1 PRODUCT, 
AVG(QTY) AS Avg_QTY,
AVG(AMOUNT) AS Avg_AMOUNT,
MAX(ORDER_NUM) AS Max_ORDER_NUM
FROM ORDERS
WHERE ORDER_DATE BETWEEN @Start_Date AND @Finish_Date
GROUP BY PRODUCT
ORDER BY Avg_QTY, Avg_AMOUNT, Max_ORDER_NUM DESC
);
