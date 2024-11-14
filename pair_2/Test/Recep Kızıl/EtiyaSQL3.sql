--1)Verilen Customers ve Orders tablolarını kullanarak, Customers tablosundaki müşterileri ve onların verdikleri siparişleri birleştirerek listeleyin. 
--Müşteri adı, sipariş ID'si ve sipariş tarihini gösterin.
SELECT C.CompanyName, O.OrderID, O.OrderDate FROM Customers C 
JOIN ORDERS O ON C.CustomerID = O.CustomerID

--2)Verilen Suppliers ve Products tablolarını kullanarak tüm tedarikçileri ve onların sağladıkları ürünleri listeleyin. 
--Eğer bir tedarikçinin ürünü yoksa, NULL olarak gösterilsin.

SELECT S.CompanyName, P.ProductID, P.ProductName from Suppliers S
LEFT JOIN Products P On S.SupplierID = P.SupplierID

--3)Verilen Employees ve Orders tablolarını kullanarak tüm siparişleri ve bu siparişleri işleyen çalışanları listeleyin. 
--Eğer bir sipariş bir çalışan tarafından işlenmediyse, çalışan bilgileri NULL olarak gösterilsin.

SELECT E.EmployeeID, CONCAT(E.firstname, ' ', E.lastname) AS FULLNAME, O.OrderID  FROM Employees E
LEFT JOIN ORDERS O ON E.EmployeeID = O.EmployeeID

--4)Verilen Customers ve Orders tablolarını kullanarak tüm müşterileri ve tüm siparişleri listeleyin. 
--Sipariş vermeyen müşteriler ve müşterisi olmayan siparişler için NULL döndürün.

birinci çözüm:
SELECT C.CustomerID, C.CompanyName, O.OrderID, O.OrderDate FROM Customers C
FULL OUTER JOIN Orders O ON C.CustomerID = O.CustomerID 

ikinci çözüm: 
SELECT C.CustomerID, C.CompanyName, O.OrderID, O.OrderDate 
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID

UNION

SELECT C.CustomerID, C.CompanyName, O.OrderID, O.OrderDate 
FROM Orders O
LEFT JOIN Customers C ON O.CustomerID = C.CustomerID

--5)Verilen Products ve Categories tablolarını kullanarak tüm ürünler ve tüm kategoriler için olası tüm kombinasyonları listeleyin. 
--Sonuç kümesindeki her satır bir ürün ve bir kategori kombinasyonunu göstermelidir.

SELECT P. productname, C.categoryname from Products P 
cross JOIN Categories C

--6)Verilen Orders, Customers, Employees tablolarını kullanarak bu tabloları birleştirin ve 2013 yılında verilen siparişleri listeleyin. 
--Müşteri adı, sipariş ID'si, sipariş tarihi ve ilgili çalışan adı gösterilsin.

SELECT O.OrderID, O.OrderDate, C.ContactName, CONCAT(E.firstname, ' ', E.lastname) AS EMPLOYEE  FROM ORDERS O
INNER JOIN CUSTOMERS C ON O.CustomerID = C.CustomerID
INNER JOIN Employees E on O.EmployeeID = E.EmployeeID
WHERE strftime('%Y', O.OrderDate) = '2013'

--7)Verilen Orders ve Customers tablolarını kullanarak müşterileri, verdikleri sipariş sayısına göre gruplandırın. 
--Sadece 5’ten fazla sipariş veren müşterileri listeleyin.

SELECT C.CustomerID, C.ContactName, COUNT(O.OrderID) AS ORDER_AMOUNT FROM Customers C
INNER JOIN Orders O On C.CustomerID = O.CustomerID 
GROUP BY C.CustomerID, C.ContactName
HAVING COUNT(O.OrderID) >5

--8)Verilen OrderDetails ve Products tablolarını kullanarak her ürün için kaç adet satıldığını ve toplam satış miktarını listeleyin. 
--Ürün adı, satılan toplam adet ve toplam kazancı (Quantity * UnitPrice) gösterin.

SELECT P.ProductName, SUM(OD.Quantity) AS TotalQuantity, SUM(OD.Quantity * OD.UnitPrice) AS TotalRevenue FROM Products P
INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName

--9)Verilen Customers ve Orders tablolarını kullanarak, müşteri adı "B" harfiyle başlayan müşterilerin siparişlerini listeleyin.
select C.CustomerID, C.ContactName, O.OrderID from Customers C
INNER JOIN Orders O On C.CustomerID = O.CustomerID
WHERE C.ContactName LIKE 'B%'

--10)Verilen Products ve Categories tablolarını kullanarak tüm kategorileri listeleyin ve ürünleri olmayan kategorileri bulun. 
--Ürün adı NULL olan satırları gösterin.
SELECT P.ProductID, C.CategoryName, P.ProductName FROM Categories C
LEFT JOIN Products P ON C.CategoryID = P.CategoryID
WHERE P.ProductID IS NULL

--11)Verilen Employees tablosunu kullanarak her çalışanın yöneticisiyle birlikte bir liste oluşturun.
SELECT CONCAT(E1.FirstName, ' ', E1.LastName) AS Employee, CONCAT(E2.FirstName, ' ', E2.LastName) as Manager FROM Employees E1
left JOIN Employees E2 ON E1.ReportsTo = E2.EmployeeID

--12)Verilen Products tablosunu kullanarak her kategorideki en pahalı ürünleri ve bu ürünlerin farklı fiyatlara sahip olup olmadığını sorgulayın.
SELECT P1.CategoryID, P1.ProductName, P1.UnitPrice FROM Products P1
WHERE P1.UnitPrice = (SELECT MAX(P2.UnitPrice) FROM Products P2 WHERE P2.CategoryID = P1.CategoryID)

--13)Verilen Orders ve OrderDetails tablolarını kullanarak bu tabloları birleştirin ve her siparişin detaylarını sipariş ID'sine göre artan sırada listeleyin.
SELECT O.OrderID, O.CustomerID, O.OrderDate, O.ShippedDate, OD.Quantity FROM Orders O
LEFT JOIN OrderDetails OD ON O.OrderID = OD.OrderID 
ORDER BY O.OrderID DESC

--14)Verilen Employees ve Orders tablolarını kullanarak her çalışanın kaç tane sipariş işlediğini listeleyin. 
--Sipariş işlemeyen çalışanlar da gösterilsin.

SELECT E.EmployeeID, CONCAT(E.firstname, ' ', E.lastname)AS EMPLOYEE, COUNT(O.OrderID) AS TotalOrder FROM Employees E
LEFT JOIN  Orders O On E.EmployeeID = O.EmployeeID 
GROUP BY E.EmployeeID, E.FirstName, E.LastName

--15)Verilen Products tablosunu kullanarak bir kategorideki ürünleri kendi arasında fiyatlarına göre karşılaştırın ve fiyatı düşük olan ürünleri listeleyin.
SELECT P1.ProductID, P1.ProductName, P1.UnitPrice, P1.CategoryID
FROM Products P1
JOIN Products P2 ON P1.CategoryID = P2.CategoryID AND P1.UnitPrice < P2.UnitPrice
GROUP BY P1.ProductID, P1.ProductName, P1.UnitPrice, P1.CategoryID

--16)Verilen Products ve Suppliers tablolarını kullanarak tedarikçiden alınan en pahalı ürünleri listeleyin.
SELECT P.ProductID, P.ProductName, P.UnitPrice, S.CompanyName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID
JOIN (SELECT SupplierID, MAX(UnitPrice) AS MaxPrice FROM Products
    GROUP BY SupplierID) AS MaxProducts ON P.SupplierID = MaxProducts.SupplierID AND P.UnitPrice = MaxProducts.MaxPrice


--17) Verilen Employees ve Orders tablolarını kullanarak her çalışanın işlediği en son siparişi bulun.
SELECT E.EmployeeID, E.FirstName, E.LastName, O.OrderID, O.OrderDate
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE O.OrderDate = (
    SELECT MAX(OrderDate)
    FROM Orders
    WHERE EmployeeID = E.EmployeeID
  
 --18)Verilen Products tablosunu kullanarak ürünleri fiyatlarına göre gruplandırın ve fiyatı 20 birimden fazla olan ürünlerin sayısını listeleyin.
SELECT COUNT(*) AS NumberOfProducts FROM Products
WHERE UnitPrice > 20
  
--19)Verilen Orders ve Customers tablolarını kullanarak 2012 ile 2013 yılları arasında verilen siparişleri müşteri adıyla birlikte listeleyin.
SELECT C.CustomerID, C.ContactName, O.OrderID, O.OrderDate FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
where strftime('%Y', O.OrderDate) IN ('2012','2013')
  
--20) Verilen Customers ve Orders tablolarını kullanarak hiç sipariş vermeyen müşterileri listeleyin.
SELECT C.ContactName FROM Customers C
LEFT JOIN Orders O On C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL
  

