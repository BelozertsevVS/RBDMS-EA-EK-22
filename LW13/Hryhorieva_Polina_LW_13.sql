USE WebStor;
/*
Завдання 1: Аналіз продажів виробників
Мета: Використовуючи таблицю `[dbo].[ORDERS]`, створіть SQL-запит, який агрегує загальну 
суму продажів по кожному виробнику за 2008 рік. Використайте функцію `SUM` для підрахунку 
загальної суми та `GROUP BY` для групування результатів за виробниками.
- Створіть запит, який виводить ідентифікатор виробника (`MFR`) та загальну суму продажів 
(`TOTAL_SALES`) за 2008 рік.
- Використайте функцію `YEAR` для фільтрації дати замовлення.
- Відсортуйте результати за ідентифікатором виробника за зростанням.
*/
SELECT [MFR],
       SUM ([AMOUNT]) AS "TOTAL_SALES"
FROM [dbo].[ORDERS]
WHERE Year([ORDER_DATE]) = 2008
GROUP BY [MFR]
ORDER BY SUM ([AMOUNT]) ASC;
/*
Завдання 2: Статистика робочого стажу працівників
Мета: Застосуйте агрегатні функції на таблиці `[dbo].[SALESREPS]`, щоб визначити кількість 
працівників з різним стажем роботи.
- Створіть запит, який групує працівників (`EMP_NUM`) за кількістю повних років роботи 
(`YEARS_OF_SERVICE`) з використанням `DATEDIFF`.
- Використайте функцію `COUNT` для обчислення кількості працівників у кожній групі.
- Відсортуйте результати за кількістю працівників за спаданням.
*/
SELECT DATEDIFF (year, [HIRE_DATE], GETDATE()) AS "YEARS_OF_SERVICE",
       COUNT (*) AS "NUMBER_OF_EMPLOYEES"
FROM [dbo].[SALESREPS]
GROUP BY DATEDIFF (year, [HIRE_DATE], GETDATE())
ORDER BY "NUMBER_OF_EMPLOYEES" DESC;
/*
Завдання 3: Аналіз найму працівників за періодами
Мета: Вивчіть розподіл найму працівників по місяцях та роках, використовуючи таблицю 
`[dbo].[SALESREPS]` і функції `YEAR`, `MONTH`, `COUNT`, `GROUP BY`.
- Розробіть запит, який показує рік та місяць найму (`HIRE_YEAR`, `HIRE_MONTH`) разом з кількістю 
працівників, яких було найнято в кожен із цих періодів (`HIRED_COUNT`).
- Використайте `GROUP BY` для групування даних за роком та місяцем найму.
- Відсортуйте результати спочатку за роком, а потім за місяцем за зростанням.
*/
SELECT DATENAME (year, [HIRE_DATE]) AS "HIRE_YEAR",
	   DATENAME (month, [HIRE_DATE]) AS "HIRE_MONTH",
	   COUNT (*) AS "HIRED_COUNT"
FROM [dbo].[SALESREPS]
GROUP BY 
         DATENAME (year, [HIRE_DATE]),
	     DATENAME (month, [HIRE_DATE])
ORDER BY 
         DATENAME (year, [HIRE_DATE]),
	     DATENAME (month, [HIRE_DATE]) ASC;