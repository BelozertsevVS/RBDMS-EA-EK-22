/* �������� 1
�������� �����, ���� ������� ������������� �볺��� (CUST_NUM) � ��������� ��������� ����� (CREDIT_LIMIT).
���������� ��������� ����, �� ������ ����� �볺��� ������ ���� ��������� ��������� ���.
- ��������������� ������� [dbo].[CUSTOMERS]
- �� �������������� �������� with ties
- �������������� ���� ����� ������: ������������� �볺���
*/
SELECT TOP 1 
    CUST_NUM
FROM 
    dbo.CUSTOMERS
WHERE 
    CREDIT_LIMIT = (SELECT MAX(CREDIT_LIMIT) FROM dbo.CUSTOMERS);

/* �������� 2
�������� �����, �� ������� ������ ��������� �볺��� � ��������� ��������� ����� (CREDIT_LIMIT).
���������� ��������� ����, �� ������ ����� �볺��� ������ ���� ��������� ��������� ���.
- ��������������� ������� [dbo].[CUSTOMERS], [dbo].[ORDERS]
- �� �������������� �������� with ties
- �������������� ���� ����� ������: ������������� �볺���
*/
SELECT TOP 1 
    C.[CUST_NUM]
FROM 
    [dbo].[ORDERS] O
JOIN (SELECT C.[CUST_NUM], C.[CREDIT_LIMIT]
      FROM [dbo].[CUSTOMERS] C
      WHERE C.[CREDIT_LIMIT] = (
      SELECT MAX([CREDIT_LIMIT])
      FROM [dbo].[CUSTOMERS])) C 
      ON O.CUST = C.CUST_NUM;

/* �������� 3
�������� �����, �� ������� �������� (�� ����� ���������� ORDER_DATE) ���������� ����� ������ ��������� �볺��� � ��������� ��������� ����� (CREDIT_LIMIT).
���������� ��������� ����, �� ������ ����� ��������� ������ ���� �������� ���� ����������.
���������� ��������� ����, �� ������ ����� �볺��� ������ ���� ��������� ��������� ���.
- ��������������� ������� [dbo].[CUSTOMERS], [dbo].[ORDERS]
- �� �������������� �������� with ties
- �������������� ���� ����� ������: ������������� �볺���
*/
SELECT TOP 1 C.CUST_NUM
FROM dbo.CUSTOMERS C
JOIN dbo.ORDERS O ON C.CUST_NUM = O.CUST
WHERE C.CREDIT_LIMIT = (
    SELECT MAX(CREDIT_LIMIT)
    FROM dbo.CUSTOMERS
);