SELECT *
FROM Payments

--Total Amount Spent With Combined Payment Types

SELECT Payment_Type, CONCAT('$',ROUND(SUM(Amount_Spent),2)) AS Total_Amount_Spent
FROM Payments
GROUP BY Payment_Type

-- Total Spent Depending On Product

SELECT Description, CONCAT('$',ROUND(SUM(Amount_Spent),2)) AS Total_Amount_Spent
FROM Payments
GROUP BY Description

--Total Spent Depending on Category

SELECT Category, CONCAT('$',ROUND(SUM(Amount_Spent),2)) AS Total_Amount_Spent
FROM Payments
GROUP BY Category

--Total Spent In years

SELECT YEAR(date) AS Year, CONCAT('$',ROUND(SUM(Amount_spent),2)) AS Total_Spent
FROM Payments
GROUP BY YEAR(date)
ORDER BY Year

--Total Spent in months

SELECT YEAR(date) AS Year, MONTH(date) AS Month, CONCAT('$',ROUND(SUM(Amount_spent),2)) AS Total_Spent
FROM Payments
GROUP BY YEAR(date), MONTH(date)
ORDER BY 1,2

--Total Spent in days

SELECT YEAR(date) AS Year, MONTH(date) AS Month, DAY(date) AS Day, CONCAT('$',ROUND(SUM(Amount_spent),2)) AS Total_Spent
FROM Payments
GROUP BY YEAR(date), MONTH(date), DAY(date)
ORDER BY 1,2,3

--Money Gained

SELECT *
FROM Received_Money

--Total Money Recieved From Each Source

SELECT Description, CONCAT('$',SUM(Amount_Gained)) AS Total
FROM Received_Money
GROUP BY Description

--Total By Payment Type


SELECT Payment_Type, CONCAT('$',SUM(Amount_Gained)) AS Total
FROM Received_Money
GROUP BY Payment_Type

--Total By Year

SELECT YEAR(date) AS Year, SUM(Amount_Gained) AS Total
FROM Received_Money
GROUP BY YEAR(date)
ORDER BY YEAR(date)

--Total By Month

SELECT YEAR(date) AS Year, MONTH(date) AS Month, SUM(Amount_Gained) AS Total
FROM Received_Money
GROUP BY YEAR(date),MONTH(date)
ORDER BY 1,2

--Total By Day

SELECT YEAR(date) AS Year, MONTH(date) AS Month, DAY(date) AS Day, SUM(Amount_Gained) AS Total
FROM Received_Money
GROUP BY YEAR(date),MONTH(date), DAY(date)
ORDER BY 1,2,3

