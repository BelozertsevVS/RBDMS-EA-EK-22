-- ������� 1: ��������� �������������� �������

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    ProductName NVARCHAR(100),
    ProductCategory NVARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10),
    OrderDate DATE
);

-- �������� ����� � �������
INSERT INTO [dbo].[Orders] (OrderID, CustomerName, ProductName, ProductCategory, Quantity, UnitPrice, OrderDate)
VALUES
(1, '����', '�������', '����������', 1, 25000, '2024-04-09'),
(2, '����', '��������', '����������', 1, 15000, '2024-04-09'),
(3, '����', '�������', '����������', 1, 12000, '2024-04-08'),
(4, '�����', '�������', '����������', 1, 27000, '2024-04-08'),
(5, '�����', '�����-��������', '����������', 2, 7000, '2024-04-08'),
(6, '�����', '���������', '����������', 1, 2000, '2024-04-07'),
(7, '�����', '�������', '����������', 2, 3000, '2024-04-06'),
(8, '������', '��������', '����������', 1, 16000, '2024-04-05'),
(9, '�����', '��������', '����������', 1, 30000, '2024-04-05'),
(10, '������', '�����-��������', '����������', 1, 6000, '2024-04-05');

SELECT * FROM [dbo].[Orders];

-- ������������� ������� ������ ���������� �� ������� � ��������� �������, ��������� �� ��������� �����. ���������, ���� ������ ��������� �� ���������� �����, �� ��������� �� ��������� �� ������������. ��� ����, ���� ��������� ����� ������ �������������� ����� ����� ����������� ��������� ��� ���������.

-- ������� 2: ������ �����������

-- 1��: ��������� ������� ��� ���������� ������ �� ���������� �������

CREATE TABLE Orders2 (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE
);

CREATE TABLE CustomerInfo (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100)
);

CREATE TABLE ProductsInfo (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    ProductCategory NVARCHAR(50),
    UnitPrice DECIMAL(10, 2)
);

-- 2��: ����� �� �������� ��������� �����������

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders2(OrderID),
    FOREIGN KEY (ProductID) REFERENCES ProductsInfo(ProductID)
);

-- 3��: �������� ������������ �����������

CREATE TABLE Orders3 (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES CustomerInfo(CustomerID)
);

CREATE TABLE ProductsInfo2 (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    ProductCategory NVARCHAR(50),
    UnitPrice DECIMAL(10, 2)
);

CREATE TABLE OrderDetails2 (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders3(OrderID),
    FOREIGN KEY (ProductID) REFERENCES ProductsInfo2(ProductID)
);

SELECT * FROM OrderDetails2;

-- ������� ����� � ������� �������

INSERT INTO CustomerInfo (CustomerID, CustomerName)
VALUES
(1, '�������'),
(2, '������');

INSERT INTO ProductsInfo2 (ProductID, ProductName, ProductCategory, UnitPrice)
VALUES
(1, '�������', '����������', 18000.00),
(2, '�����-��������', '����������', 21000.00);

INSERT INTO Orders3 (OrderID, CustomerID, OrderDate)
VALUES
(1, 1, '2024-04-10'),
(2, 2, '2024-04-10');
INSERT INTO OrderDetails2 (OrderID, ProductID, Quantity)
VALUES
(1, 1, 1),
(2, 2, 1);
SELECT * FROM CustomerInfo;
SELECT * FROM ProductsInfo2;
SELECT * FROM Orders3;
SELECT * FROM OrderDetails2;

-- ���������� � �����

-- �������
INSERT INTO CustomerInfo (CustomerID, CustomerName)
VALUES
(10, '�����');

-- ���������
UPDATE CustomerInfo
SET CustomerName = '����� �������'
WHERE CustomerID = 10;

-- ��������� �����
DELETE FROM CustomerInfo
WHERE CustomerID = 10;

-- ������� ������ ��� �������� ���������
SELECT * FROM CustomerInfo;
SELECT * FROM ProductsInfo2;
SELECT * FROM Orders3;
SELECT * FROM OrderDetails2;

