-- ������ 1: �����, ���� ������� ��� �������� � ��������� �������� (�� ������� �������) �����.
-- ��������������� ������� [dbo].[PRODUCTS]
-- ���������� �������� ������� LEN
-- �������������� ���� ����� ������: �����. ���������, �����. ��������, ���� ��������, ������� �����

SELECT TOP 1 WITH TIES
    [MFR_ID],
    [PRODUCT_ID],
    [DESCRIPTION],
    LEN([DESCRIPTION]) AS "DescriptionLength"
FROM [dbo].[PRODUCTS]
ORDER BY
    LEN([DESCRIPTION]) DESC;

-- ������ 2: �����, �� ������� ��� ��������, ������������� ���� ������ ���� �����.
-- ��������������� ������� [dbo].[PRODUCTS]
-- ���������� �������� NOT LIKE
-- ���������� ������� �������: CONCAT_WS, UPPER, LEN, RTRIM
-- �������������� ���� ����� ������: ��������������� �����, ������� ���������������� �����
-- ³��������� �������������� ���� ����� �� �������� ���������������� ����� (�� ����������)

SELECT DISTINCT
    CONCAT_WS(' ', UPPER(RTRIM(MFR_ID)), UPPER(RTRIM(PRODUCT_ID)), UPPER(RTRIM([DESCRIPTION]))) AS ConcatenatedString,
    LEN(CONCAT_WS(' ', UPPER(RTRIM(MFR_ID)), UPPER(RTRIM(PRODUCT_ID)), UPPER(RTRIM([DESCRIPTION])))) AS ConcatenatedLength
FROM
    [dbo].[PRODUCTS]
WHERE 
    PRODUCT_ID NOT LIKE '%[^0-9]%'  
ORDER BY
    ConcatenatedLength DESC;


-- ������ 3: �����, ���� ������� ������ �볺��� � ��������� ��������� �����.
-- ��������������� ������� [dbo].[CUSTOMERS]
-- �������������� ���� ����� ������: �����. �볺���, ������������ �볺���, ��������� ���
-- ������������ �볺��� ��������� ���������� �� 2 ����� �� ������� ����� � 2 ����� � ���� �����, �� ���� ����� ������� �� ������ *

SELECT TOP 1 WITH TIES
    [CUST_NUM],
	SUBSTRING ([COMPANY], 1, 2) + '***' + RIGHT ([COMPANY], 2) AS Customer_Name,
    CREDIT_LIMIT
FROM
    [dbo].[CUSTOMERS]
ORDER BY
    [CREDIT_LIMIT];
