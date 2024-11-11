--Q1) Verilen Customers ve Orders tablolarını kullanarak, Customers tablosundaki müşterileri ve onların verdikleri siparişleri birleştirerek listeleyin.
--Müşteri adı, sipariş ID'si ve sipariş tarihini gösterin. 

SELECT Customers.CustomerID, Orders.OrderID, Orders.OrderDate FROM Customers
LEFT JOIN Orders ON Orders.CustomerID = Customers.CustomerID order BY Customers.CustomerID

--Q2) Verilen Suppliers ve Products tablolarını kullanarak tüm tedarikçileri ve onların sağladıkları ürünleri listeleyin. 
--Eğer bir tedarikçinin ürünü yoksa, NULL olarak gösterilsin.
SELECT Suppliers.SupplierID, Products.ProductID FROM Suppliers
LEFT JOIN Products on Products.SupplierID=Suppliers.SupplierID 

--Q3) Verilen Employees ve Orders tablolarını kullanarak tüm siparişleri ve bu siparişleri işleyen çalışanları listeleyin. 
--Eğer bir sipariş bir çalışan tarafından işlenmediyse, çalışan bilgileri NULL olarak gösterilsin.
SELECT Orders.OrderID, Employees.EmployeeID, Employees.FirstName||' '|| Employees.LastName AS FullName FROM Orders
LEFT JOIN Employees ON Orders.EmployeeID= Employees.EmployeeID

--Q4)Verilen Customers ve Orders tablolarını kullanarak tüm müşterileri ve tüm siparişleri listeleyin. 
--Sipariş vermeyen müşteriler ve müşterisi olmayan siparişler için NULL döndürün.
SELECT Customers.CustomerID, Orders.OrderID FROM Customers join Orders on Customers.CustomerID = Orders.CustomerID

--Q5)Verilen Products ve Categories tablolarını kullanarak tüm ürünler ve tüm kategoriler için olası tüm kombinasyonları listeleyin. 
--Sonuç kümesindeki her satır bir ürün ve bir kategori kombinasyonunu göstermelidir.
SELECT Products.ProductID, Products.ProductName, Categories.CategoryName FROM Products
CROSS JOIN Categories 

--Q6)Verilen Orders, Customers, Employees tablolarını kullanarak bu tabloları birleştirin ve 2016 yılında verilen siparişleri listeleyin.
--Müşteri adı, sipariş ID'si, sipariş tarihi ve ilgili çalışan adı gösterilsin.
SELECT Customers.CompanyName, Orders.OrderID, Orders.OrderDate, Employees.FirstName||' '|| Employees.LastName AS EmployeeName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Orders.OrderDate LIKE '2016%'

--Q7)Verilen Orders ve Customers tablolarını kullanarak müşterileri, verdikleri sipariş sayısına göre gruplandırın. 
--Sadece 5’ten fazla sipariş veren müşterileri listeleyin.
SELECT Customers.CustomerID,  COUNT(Orders.OrderID) AS OrderCount FROM Customers 
JOIN Orders ON Customers.CustomerID=Orders.CustomerID GROUP BY Customers.customerid HAVING COUNT(Orders.OrderID) > 5

--Q8)Verilen OrderDetails ve Products tablolarını kullanarak her ürün için kaç adet satıldığını ve toplam satış miktarını listeleyin. 
--Ürün adı, satılan toplam adet ve toplam kazancı (Quantity * UnitPrice) gösterin.
SELECT Products.ProductID, SUM('Order Details'.Quantity) AS TotalQuantitySold, 
SUM('Order Details'.Quantity * 'Order Details'.UnitPrice) AS TotalRevenue
FROM 'Order Details' JOIN Products ON 'Order Details'.ProductID = Products.ProductID
GROUP BY Products.ProductName;

--Q9)Verilen Customers ve Orders tablolarını kullanarak, müşteri adı "B" harfiyle başlayan müşterilerin siparişlerini listeleyin. 
SELECT Customers.CompanyName, Orders.OrderID FROM Orders JOIN Customers ON Customers.CustomerID=Orders.CustomerID
WHERE Customers.CompanyName LIKE 'B%'

--Q10)Verilen Products ve Categories tablolarını kullanarak tüm kategorileri listeleyin ve ürünleri olmayan kategorileri bulun.
--Ürün adı NULL olan satırları gösterin.
SELECT Products.ProductName, Categories.CategoryName
FROM Categories 
LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.ProductName IS NULL;

--Q11)Verilen Employees tablosunu kullanarak her çalışanın yöneticisiyle birlikte bir liste oluşturun.
SELECT e1.FirstName|| ' ' || e1.LastName AS "Employee",  e2.FirstName|| ' ' || e2.LastName AS "Manager"
from Employees e1 LEFT JOIN Employees e2 ON e1.ReportsTo=e2.EmployeeID
order BY e1.LastName

--Q12)Verilen Products tablosunu kullanarak her kategorideki en pahalı ürünleri 
--ve bu ürünlerin farklı fiyatlara sahip olup olmadığını sorgulayın.
SELECT CategoryID, 
       COUNT(DISTINCT UnitPrice) AS DistinctPriceCount
FROM Products
WHERE UnitPrice IN (
    SELECT MAX(UnitPrice)
    FROM Products
    GROUP BY CategoryID
)
GROUP BY CategoryID;

--Q13)Verilen Orders ve OrderDetails tablolarını kullanarak bu tabloları birleştirin 
-- ve her siparişin detaylarını sipariş ID'sine göre artan sırada listeleyin
SELECT o.OrderID, o.OrderDate, od.ProductID, od.UnitPrice, od.Quantity, od.Discount
FROM Orders o
JOIN 'Order Details' od ON o.OrderID = od.OrderID
ORDER BY o.OrderID ASC;

--Q14)Verilen Employees ve Orders tablolarını kullanarak her çalışanın kaç tane sipariş işlediğini listeleyin. 
-- Sipariş işlemeyen çalışanlar da gösterilsin.
SELECT e.EmployeeID, e.FirstName|| ' ' || e.LastName AS "EmployeeName", COUNT(o.OrderID) AS OrderCount
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID

--Q15)Verilen Products tablosunu kullanarak bir kategorideki ürünleri kendi arasında fiyatlarına 
--göre karşılaştırın ve fiyatı düşük olan ürünleri listeleyin.
SELECT p1.CategoryID, 
       p1.ProductID, 
       p1.ProductName, 
       p1.UnitPrice
FROM Products p1
LEFT JOIN Products p2 
ON p1.CategoryID = p2.CategoryID 
AND p1.UnitPrice > p2.UnitPrice
WHERE p2.ProductID IS NULL order by p1.categoryid

--Q16)Verilen Products ve Suppliers tablolarını kullanarak tedarikçiden alınan en pahalı ürünleri listeleyin.
SELECT s.SupplierID, 
       s.CompanyName, 
       p.ProductID, 
       p.ProductName, 
       p.UnitPrice
FROM Suppliers s JOIN Products p ON s.SupplierID = p.SupplierID
WHERE p.UnitPrice = (
    SELECT MAX(p2.UnitPrice)
    FROM Products p2
    WHERE p2.SupplierID = s.SupplierID
)

--Q17)Verilen Employees ve Orders tablolarını kullanarak her çalışanın işlediği en son siparişi bulun. 
SELECT e.EmployeeID, 
       e.FirstName|| ' ' || e.LastName AS "EmployeeName", 
       o.OrderID, 
       o.OrderDate
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate = (
    SELECT MAX(o2.OrderDate)
    FROM Orders o2
    WHERE o2.EmployeeID = e.EmployeeID
)

--Q18)Verilen Products tablosunu kullanarak ürünleri fiyatlarına göre gruplandırın ve
--fiyatı 20 birimden fazla olan ürünlerin sayısını listeleyin.
SELECT COUNT(*) AS ProductCount
FROM Products
WHERE UnitPrice > 20

--Q19)Verilen Orders ve Customers tablolarını kullanarak
--2012 ile 2023 yılları arasında verilen siparişleri müşteri adıyla birlikte listeleyin.
SELECT o.OrderID, 
       o.OrderDate, 
       c.CustomerID, 
       c.CompanyName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate BETWEEN '2012-01-01' AND '2023-12-31'

--Q20)Verilen Customers ve Orders tablolarını kullanarak hiç sipariş vermeyen müşterileri listeleyin. 
SELECT c.CustomerID, 
       c.CompanyName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL


