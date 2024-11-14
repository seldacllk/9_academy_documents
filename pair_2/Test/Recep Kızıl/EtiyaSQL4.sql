--1)En Pahalı Ürünü Getirin

SELECT ProductName, UnitPrice FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products)

--2)En Son Verilen Siparişi Bulun

SELECT OrderID, CustomerID, OrderDate FROM Orders
WHERE OrderDate = (SELECT MAX(OrderDate)FROM Orders)

--3)Fiyatı Ortalama Fiyattan Yüksek Olan Ürünleri Getirin

SELECT ProductName, UnitPrice FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

--4)Belirli Kategorilerdeki Ürünleri Listeleyin

SELECT ProductName, CategoryID, UnitPrice FROM Products
WHERE CategoryID IN (3, 4, 5)

--5)En Yüksek Fiyatlı Ürünlere Sahip Kategorileri Listeleyin

SELECT C.CategoryName, P.ProductName, P.UnitPrice FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE P.UnitPrice = (
    SELECT MAX(P2.UnitPrice)
    FROM Products P2
    WHERE P2.CategoryID = P.CategoryID
)

--6)Bir Ülkedeki Müşterilerin Verdiği Siparişleri Listeleyin

SELECT C.CustomerID, C.ContactName, C.Country, O.OrderID, O.OrderDate FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE C.Country = 'France'

--7)Her Kategori İçin Ortalama Fiyatın Üzerinde Olan Ürünleri Listeleyin

SELECT P.ProductName, P.CategoryID, P.UnitPrice FROM Products P
WHERE P.UnitPrice > (
    SELECT AVG(P2.UnitPrice)
    FROM Products P2
    WHERE P2.CategoryID = P.CategoryID)
    
--8)Her Müşterinin En Son Verdiği Siparişi Listeleyin

SELECT C.CustomerID, C.ContactName, O.OrderID, O.OrderDate FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE O.OrderDate = (
    SELECT MAX(O2.OrderDate)
    FROM Orders O2
    WHERE O2.CustomerID = O.CustomerID)
   
--9)En Çok Sipariş Alan Çalışanı Bulun

SELECT E.EmployeeID, E.FirstName, E.LastName, COUNT(O.OrderID) AS OrderCount FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY OrderCount DESC
LIMIT 1

--10)En Az 10 Ürün Satın Alınan Siparişleri Listeleyin

SELECT O.OrderID, SUM(OD.Quantity) AS TotalQuantity FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY O.OrderID
HAVING SUM(OD.Quantity) >= 10

--11)Her Kategoride En Pahalı Olan Ürünlerin Ortalama Fiyatını Bulun

SELECT AVG(HighestPrices.MaxPrice) AS AverageMaxPrice
FROM (
    SELECT CategoryID, MAX(UnitPrice) AS MaxPrice
    FROM Products
    GROUP BY CategoryID) AS HighestPrices

--12)Müşterilerin Verdiği Toplam Sipariş Sayısına Göre Sıralama Yapın

SELECT C.CustomerID, C.ContactName, COUNT(O.OrderID) AS TotalOrders FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.ContactName
ORDER BY TotalOrders DESC

--13)En Fazla Sipariş Vermiş 5 Müşteriyi ve Son Sipariş Tarihlerini Listeleyin

SELECT C.CustomerID, C.ContactName, OrderCounts.TotalOrders, OrderCounts.LastOrderDate FROM Customers C
JOIN (
    SELECT O.CustomerID, COUNT(O.OrderID) AS TotalOrders, MAX(O.OrderDate) AS LastOrderDate
    FROM Orders O
    GROUP BY O.CustomerID
) AS OrderCounts ON C.CustomerID = OrderCounts.CustomerID
ORDER BY OrderCounts.TotalOrders DESC
LIMIT 5

--14)Toplam Ürün Sayısı 15'ten Fazla Olan Kategorileri Listeleyin

SELECT C.CategoryID, C.CategoryName, COUNT(P.ProductID) AS TotalProducts FROM Categories C
JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryID, C.CategoryName
HAVING COUNT(P.ProductID) > 15

--15)En Fazla 5 Farklı Ürün Sipariş Eden Müşterileri Listeleyin

SELECT C.CustomerID, C.ContactName, COUNT(DISTINCT OD.ProductID) AS DistinctProducts FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.ContactName
HAVING COUNT(DISTINCT OD.ProductID) <= 5

--16)20'den Fazla Ürün Sağlayan Tedarikçileri Listeleyin

SELECT S.SupplierID, S.CompanyName, COUNT(P.ProductID) AS TotalProducts FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierID, S.CompanyName
HAVING COUNT(P.ProductID) > 20

--17)Her Müşteri İçin En Pahalı Ürünü Bulun

SELECT C.CustomerID, C.ContactName, MAX(OD.UnitPrice) AS MaxPrice FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.ContactName

--18)10.000'den Fazla Sipariş Değeri Olan Çalışanları Listeleyin

SELECT E.EmployeeID, E.FirstName, E.LastName, SUM(OD.UnitPrice * OD.Quantity) AS TotalOrderValue FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.FirstName, E.LastName
HAVING SUM(OD.Quantity * OD.UnitPrice) > 10000

--19)Kategorisine Göre En Çok Sipariş Edilen Ürünü Bulun

SELECT C.CategoryID, C.CategoryName, P.ProductID, P.ProductName, COUNT(OD.OrderID) AS OrderCount FROM Categories C
JOIN Products P ON C.CategoryID = P.CategoryID
LEFT JOIN "Order Details"  OD ON P.ProductID = OD.ProductID
LEFT JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY C.CategoryID, C.CategoryName, P.ProductID, P.ProductName
HAVING COUNT(OD.OrderID) = (
    SELECT MAX(OrderCount)
    FROM (
        SELECT COUNT(OD2.OrderID) AS OrderCount
        FROM Products P2
        LEFT JOIN "Order Details" OD2 ON P2.ProductID = OD2.ProductID
        WHERE P2.CategoryID = C.CategoryID
        GROUP BY P2.ProductID
    )
)

--20)Müşterilerin En Son Sipariş Verdiği Ürün ve Tarihlerini Listeleyin

SELECT C.CustomerID, C.ContactName, P.ProductID, P.ProductName, O.OrderDate FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE O.OrderDate = (
        SELECT MAX(OrderDate)
        FROM Orders
        WHERE CustomerID = C.CustomerID)
        
--21)Her Çalışanın Teslim Ettiği En Pahalı Siparişi ve Tarihini Listeleyin

SELECT E.EmployeeID, CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName, O.OrderID, O.OrderDate, SUM(OD.UnitPrice * OD.Quantity) AS TotalOrderValue FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.FirstName, E.LastName, O.OrderID, O.OrderDate
HAVING TotalOrderValue = (
        SELECT MAX(TotalValue)
        FROM (
            SELECT 
                SUM(OD2.UnitPrice * OD2.Quantity) AS TotalValue FROM Orders O2
            JOIN OrderDetails OD2 ON O2.OrderID = OD2.OrderID
            WHERE O2.EmployeeID = E.EmployeeID
            GROUP BY O2.OrderID))

--22)En Fazla Sipariş Verilen Ürünü ve Bilgilerini Listeleyin

SELECT P.ProductID, P.ProductName, COUNT(OD.OrderID) AS OrderCount FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY P.ProductID, P.ProductName
ORDER BY OrderCount DESC
LIMIT 1