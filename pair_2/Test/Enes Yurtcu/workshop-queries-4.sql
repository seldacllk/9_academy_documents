--1. En Pahalı Ürünü Getirin
SELECT *
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products);

--2. En Son Verilen Siparişi Bulun
SELECT *
FROM Orders
ORDER BY OrderDate DESC
LIMIT 1;

--3. Fiyatı Ortalama Fiyattan Yüksek Olan Ürünleri Getirin
SELECT *
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

--4. Belirli Kategorilerdeki Ürünleri Listeleyin
SELECT *
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName IN ('Beverages', 'Confections');

--5. En Yüksek Fiyatlı Ürünlere Sahip Kategorileri Listeleyin
SELECT C.CategoryName, P.ProductName, MAX(P.UnitPrice) as MaxPrice
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName, P.ProductName
ORDER BY MaxPrice DESC;

--6. Bir Ülkedeki Müşterilerin Verdiği Siparişleri Listeleyin
SELECT O.OrderID, O.CustomerID, C.CompanyName, O.OrderDate
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany'
ORDER BY O.OrderDate DESC;

--7. Her Kategori İçin Ortalama Fiyatın Üzerinde Olan Ürünleri Listeleyin
SELECT P.ProductID, P.ProductName, P.UnitPrice, C.CategoryName
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE P.UnitPrice > (
    SELECT AVG(UnitPrice)
    FROM Products
    WHERE CategoryID = P.CategoryID
)
ORDER BY C.CategoryName, P.UnitPrice DESC;

--8. Her Müşterinin En Son Verdiği Siparişi Listeleyin
SELECT O.CustomerID, C.CompanyName, MAX(O.OrderDate) as LatestOrderDate
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY O.CustomerID, C.CompanyName
ORDER BY LatestOrderDate DESC;

--9. (Düzenlendi) Her Çalışanın Kendi Departmanındaki Ortalama Sipariş Sayısının Üzerinde Sipariş Alıp Almadığını Bulun
SELECT E.EmployeeID, E.FirstName, E.LastName,
       COUNT(O.OrderID) AS TotalOrders,
       (SELECT AVG(OrderCount) FROM 
           (SELECT EmployeeID, COUNT(OrderID) AS OrderCount
            FROM Orders
            GROUP BY EmployeeID) AS DeptOrders
        WHERE DeptOrders.EmployeeID IN 
              (SELECT EmployeeID FROM Employees WHERE ReportsTo = E.ReportsTo)
       ) AS AvgDeptOrders,
       CASE 
           WHEN COUNT(O.OrderID) > (SELECT AVG(OrderCount) FROM 
               (SELECT EmployeeID, COUNT(OrderID) AS OrderCount
                FROM Orders
                GROUP BY EmployeeID) AS DeptOrders
            WHERE DeptOrders.EmployeeID IN 
                  (SELECT EmployeeID FROM Employees WHERE ReportsTo = E.ReportsTo)
           ) THEN 'Above Average'
           ELSE 'Below Average'
       END AS OrderPerformance
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE E.ReportsTo IS NOT NULL
GROUP BY E.EmployeeID, E.FirstName, E.LastName, E.ReportsTo
ORDER BY E.ReportsTo, OrderPerformance;

--10. En Az 10 Ürün Satın Alınan Siparişleri Listeleyin
SELECT OrderID, SUM(Quantity) AS TotalProducts
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) >= 10;

--11. Her Kategoride En Pahalı Olan Ürünlerin Ortalama Fiyatını Bulun
SELECT C.CategoryName, AVG(MaxPrice) as AverageMaxPrice
FROM (
    SELECT CategoryID, MAX(UnitPrice) as MaxPrice
    FROM Products
    GROUP BY CategoryID
) AS MaxPrices
JOIN Categories C ON MaxPrices.CategoryID = C.CategoryID
GROUP BY C.CategoryName;

--12. Müşterilerin Verdiği Toplam Sipariş Sayısına Göre Sıralama Yapın
SELECT C.CustomerID, C.CompanyName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY TotalOrders DESC;

--13. En Fazla Sipariş Vermiş 5 Müşteriyi ve Son Sipariş Tarihlerini Listeleyin
SELECT C.CustomerID, C.CompanyName, COUNT(O.OrderID) AS TotalOrders, MAX(O.OrderDate) AS LastOrderDate
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY TotalOrders DESC
LIMIT 5;

--14. Toplam Ürün Sayısı 1.250.000'ten Fazla Olan Kategorileri Listeleyin
SELECT C.CategoryName, SUM(OD.Quantity) AS TotalQuantity
FROM Categories C
JOIN Products P ON C.CategoryID = P.CategoryID
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryName
HAVING SUM(OD.Quantity) > 1250000;

--15. En Fazla 100 Farklı Ürün Sipariş Eden Müşterileri Listeleyin
SELECT 
    c.CustomerID,
    c.CompanyName,
    COUNT(DISTINCT od.ProductID) AS UniqueProductsOrdered
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    'Order Details' od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID, c.CompanyName
HAVING 
    COUNT(DISTINCT od.ProductID) <= 100
ORDER BY 
    UniqueProductsOrdered;

--16.(Düzenlendi) 2'den Fazla Ürün Sağlayan Tedarikçileri Listeleyin
SELECT S.SupplierID, S.CompanyName, COUNT(P.ProductID) AS NumberOfProducts
FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierID, S.CompanyName
HAVING COUNT(P.ProductID) > 2;

--17. Her Müşteri İçin En Pahalı Ürünü Bulun
SELECT 
    c.CustomerID,
    c.CompanyName,
    p.ProductName,
    p.UnitPrice AS MaxPrice
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    'Order Details' od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE
    p.UnitPrice = (
        SELECT MAX(p2.UnitPrice)
        FROM Orders o2
        JOIN 'Order Details' od2 ON o2.OrderID = od2.OrderID
        JOIN Products p2 ON od2.ProductID = p2.ProductID
        WHERE o2.CustomerID = c.CustomerID
    )
GROUP BY 
    c.CustomerID, c.CompanyName, p.ProductName, p.UnitPrice
ORDER BY 
    c.CustomerID;


--18. 10.000'den Fazla Sipariş Değeri Olan Çalışanları Listeleyin
SELECT E.EmployeeID, E.FirstName, E.LastName, SUM(P.UnitPrice * OD.Quantity) AS TotalValue
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY E.EmployeeID, E.FirstName, E.LastName
HAVING SUM(P.UnitPrice * OD.Quantity) > 10000;

--19. Kategorisine Göre En Çok Sipariş Edilen Ürünü Bulun
WITH CategoryBestSellers AS (
    SELECT 
        C.CategoryID,
        C.CategoryName,
        P.ProductID,
        P.ProductName,
        SUM(OD.Quantity) AS TotalQuantity
    FROM 
        [Order Details] OD
    JOIN 
        Products P ON OD.ProductID = P.ProductID
    JOIN 
        Categories C ON P.CategoryID = C.CategoryID
    GROUP BY 
        C.CategoryID, C.CategoryName, P.ProductID, P.ProductName
)

SELECT
    CBS.CategoryName,
    CBS.ProductName,
    CBS.TotalQuantity
FROM 
    CategoryBestSellers CBS
WHERE 
    CBS.TotalQuantity = (
        SELECT MAX(TotalQuantity)
        FROM CategoryBestSellers
        WHERE CategoryID = CBS.CategoryID
    )
ORDER BY 
    CBS.CategoryID, CBS.TotalQuantity DESC;

--20. Müşterilerin En Son Sipariş Verdiği Ürün ve Tarihlerini Listeleyin
WITH LastOrders AS (
    SELECT 
        CustomerID, 
        MAX(OrderDate) AS LastOrderDate
    FROM 
        Orders
    GROUP BY 
        CustomerID
),
LastOrderDetails AS (
    SELECT 
        LO.CustomerID,
        LO.LastOrderDate,
        OD.ProductID,
        ROW_NUMBER() OVER (PARTITION BY LO.CustomerID ORDER BY OD.OrderID DESC) AS RowNum
    FROM 
        LastOrders LO
    JOIN 
        Orders O ON LO.CustomerID = O.CustomerID AND LO.LastOrderDate = O.OrderDate
    JOIN 
        [Order Details] OD ON O.OrderID = OD.OrderID
)

SELECT 
    LOD.CustomerID,
    LOD.LastOrderDate,
    P.ProductName
FROM 
    LastOrderDetails LOD
JOIN 
    Products P ON LOD.ProductID = P.ProductID
WHERE 
    LOD.RowNum = 1
ORDER BY 
    LOD.CustomerID;

--21. Her Çalışanın Teslim Ettiği En Pahalı Siparişi ve Tarihini Listeleyin
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    OrderID,
    OrderDate,
    MaxOrderAmount
FROM (
    SELECT 
        E.EmployeeID,
        E.FirstName,
        E.LastName,
        O.OrderID,
        O.OrderDate,
        OD.TotalAmount AS MaxOrderAmount,
        ROW_NUMBER() OVER (PARTITION BY E.EmployeeID ORDER BY OD.TotalAmount DESC) as rn
    FROM Employees E
    JOIN Orders O ON E.EmployeeID = O.EmployeeID
    JOIN (
        SELECT 
            OrderID,
            SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalAmount
        FROM [Order Details]
        GROUP BY OrderID
    ) OD ON O.OrderID = OD.OrderID
) T
WHERE rn = 1
ORDER BY EmployeeID;

--22. En Fazla Sipariş Verilen Ürünü ve Bilgilerini Listeleyin
SELECT 
    P.ProductID, 
    P.ProductName, 
    P.SupplierID, 
    P.CategoryID, 
    P.QuantityPerUnit, 
    P.UnitPrice, 
    P.UnitsInStock, 
    P.UnitsOnOrder, 
    P.ReorderLevel, 
    P.Discontinued, 
    SUM(OD.Quantity) AS TotalQuantityOrdered
FROM [Order Details] AS OD
JOIN Products AS P ON OD.ProductID = P.ProductID
GROUP BY 
    P.ProductID, 
    P.ProductName, 
    P.SupplierID, 
    P.CategoryID, 
    P.QuantityPerUnit, 
    P.UnitPrice, 
    P.UnitsInStock, 
    P.UnitsOnOrder, 
    P.ReorderLevel, 
    P.Discontinued
ORDER BY TotalQuantityOrdered DESC
LIMIT 1;