USE WebStor;
-- Çàäà÷à 1: Çàïèò, ÿêèé ïîâåðíå äàí³ ïðîäóêòó ç íàéá³ëüøîþ äîâæèíîþ (çà ê³ëüê³ñòþ ñèìâîë³â) îïèñó.
-- Âèêîðèñòîâóºòüñÿ òàáëèöÿ [dbo].[PRODUCTS]
-- Çàñòîñóéòå ñòðîêîâó ôóíêö³þ LEN
-- Ðåçóëüòèðóþ÷èé íàá³ð äàíèõ ì³ñòèòü: ²äåíò. âèðîáíèêà, ³äåíò. ïðîäóêòó, îïèñ ïðîäóêòó, äîâæèíà îïèñó

SELECT TOP 1 WITH TIES
    [MFR_ID],
    [PRODUCT_ID],
    [DESCRIPTION],
    LEN([DESCRIPTION]) AS "DescriptionLength"
FROM [dbo].[PRODUCTS]
ORDER BY
    LEN([DESCRIPTION]) DESC;

-- Çàäà÷à 2: Çàïèò, ùî ïîâåðòàº äàí³ ïðîäóêò³â, ³äåíòèô³êàòîð ÿêèõ ì³ñòèòü ëèøå öèôðè.
-- Âèêîðèñòîâóºòüñÿ òàáëèöÿ [dbo].[PRODUCTS]
-- Çàñòîñóéòå ïðåäèêàò NOT LIKE
-- Çàñòîñóéòå ñòðîêîâ³ ôóíêö³¿: CONCAT_WS, UPPER, LEN, RTRIM
-- Ðåçóëüòèðóþ÷èé íàá³ð äàíèõ ì³ñòèòü: ñêîíêàòåíîâàíèé ðÿäîê, äîâæèíà ñêîíêàòåíîâàíîãî ðÿäêà
-- Â³äñîðòóéòå ðåçóëüòèðóþ÷èé íàá³ð äàíèõ çà äîâæèíîþ ñêîíêàòåíîâàíîãî ðÿäêà (çà çìåíøåííÿì)

SELECT DISTINCT
    CONCAT_WS(' ', UPPER(RTRIM(MFR_ID)), UPPER(RTRIM(PRODUCT_ID)), UPPER(RTRIM([DESCRIPTION]))) AS ConcatenatedString,
    LEN(CONCAT_WS(' ', UPPER(RTRIM(MFR_ID)), UPPER(RTRIM(PRODUCT_ID)), UPPER(RTRIM([DESCRIPTION])))) AS ConcatenatedLength
FROM
    [dbo].[PRODUCTS]
WHERE 
    PRODUCT_ID NOT LIKE '%[^0-9]%'  
ORDER BY
    ConcatenatedLength DESC;


-- Çàäà÷à 3: Çàïèò, ÿêèé ïîâåðíå ñïèñîê êë³ºíò³â ç íàéìåíøèì êðåäèòíèì ë³ì³òîì.
-- Âèêîðèñòîâóºòüñÿ òàáëèöÿ [dbo].[CUSTOMERS]
-- Ðåçóëüòèðóþ÷èé íàá³ð äàíèõ ì³ñòèòü: ³äåíò. êë³ºíòà, íàéìåíóâàííÿ êë³ºíòà, êðåäèòíèé ë³ì³ò
-- Íàéìåíóâàííÿ êë³ºíòà íåîáõ³äíî â³äîáðàçèòè ÿê 2 áóêâè íà ïî÷àòêó ðÿäêà ³ 2 áóêâè â ê³íö³ ðÿäêà, âñ³ ³íø³ áóêâè çàì³íèòè íà ñèìâîë *

SELECT TOP 1 WITH TIES
    [CUST_NUM],
	SUBSTRING ([COMPANY], 1, 2) + '***' + RIGHT ([COMPANY], 2) AS Customer_Name,
    CREDIT_LIMIT
FROM
    [dbo].[CUSTOMERS]
ORDER BY
    [CREDIT_LIMIT];
