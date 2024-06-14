/* �������� 1
�������� �����, ���� ������� ������ ��������� �������������� ��������� ������ (MFR).
���������� ���� ����������, �� ���� �������� � 2008 ���� �볺����� � ������ CORP � ���� (COMPANY). 
��� ����� ��������� ��������������� �������� LIKE �� ����������� ����� (wildcards).
- ���������������� �������: dbo.CUSTOMERS, dbo.ORDERS
- ���������� ������� �'������� (ANSI-92)
- ������������ ���� ����� ������: ������������� ��������� ������ (��� ��������)
*/

SELECT DISTINCT 
    O.[MFR]
FROM 
    [dbo].[CUSTOMERS] C
INNER JOIN 
    [dbo].[ORDERS] O 
    ON C.[CUST_NUM] = O.[CUST]
WHERE 
    YEAR(O.[ORDER_DATE]) = 2008
    AND C.[COMPANY] LIKE '%CORP%'
ORDER BY 
    O.[MFR];

/*�������� 2 
�������� �����, ���� � ����� �������������� �볺��� (CUST_NUM) �� ����� ���������� ���������� (ORDER_DATE) 
������� ������� ��������� ��������� (��� ����� ��������������� GROUP BY). 
���������� ���� ����������, �� ���� �������� � 2008 ���� �볺����� � ������ CORP. � ���� (COMPANY). 
� �������, ���� � �볺��� �� ���� ������� ����������, ������� ������ �볺��� � ������������� ����� �����.
³��������� �������������� ���� ����� �� ������� ���������� ��������� (�� ���������)
- ���������������� �������: dbo.CUSTOMERS, dbo.ORDERS
- ���������� ��� ������ �'�������
- ������������ ���� ����� ������: ������������� �볺���, ����� ���������� ���������� 
(��� ��������� ����� � ���� ���������� ������������� ������� MONTH), 
������� ��������� ��������� (������������� COUNT)*/

SELECT 
    C.[CUST_NUM],
    MONTH(O.[ORDER_DATE]) AS ORDER_MONTH,
    COUNT(DISTINCT O.[ORDER_NUM]) AS UNIQUE_ORDERS
FROM 
    [dbo].[CUSTOMERS] C
LEFT JOIN 
    [dbo].[ORDERS] O 
    ON C.[CUST_NUM] = O.CUST
    WHERE YEAR(O.[ORDER_DATE]) = 2008
    AND C.[COMPANY] LIKE '%CORP%'
GROUP BY 
    C.[CUST_NUM], 
    MONTH(O.[ORDER_DATE])
ORDER BY 
    UNIQUE_ORDERS DESC;

	/*�������� 3 
�������� �����, ���� ������� ������ (��� ��������) ��������� ������.
���������� ���� ����������, �� ���� �������� � 2008 ���� �볺����� � ������ CORP � ���� (COMPANY). 
� �������, ���� � �볺��� �� ���� ������� ����������, ������� ������ �볺��� � ������������� ����� �����.
- ���������������� �������: dbo.CUSTOMERS, dbo.ORDERS, dbo.PRODUCTS
- ���������� ��� ������ �'�������
- ������������ ���� ����� ������: ������������� �볺���, ����� ������ (� ��������� ������. 
��� ����� ������������� ������� ������� (String Function) UPPER), ���� ������ ([DESCRIPTION])
*/

SELECT DISTINCT 
    C.[CUST_NUM],
    UPPER(C.[COMPANY]) AS COMPANY,
    P.[DESCRIPTION]
FROM 
    [dbo].[CUSTOMERS] C
LEFT JOIN 
    [dbo].[ORDERS] O 
    ON C.[CUST_NUM] = O.[CUST]
LEFT JOIN 
    [dbo].[PRODUCTS] P 
    ON O.[PRODUCT] = P.[PRODUCT_ID]
WHERE 
    YEAR(O.[ORDER_DATE]) = 2008
    AND C.[COMPANY] LIKE '%CORP%'
ORDER BY 
    C.[CUST_NUM], 
    P.[DESCRIPTION];