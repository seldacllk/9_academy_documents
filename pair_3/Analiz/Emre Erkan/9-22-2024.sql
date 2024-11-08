 En Pahalı Ürünü Getirin
2. En Son Verilen Siparişi Bulun
3. Fiyatı Ortalama Fiyattan Yüksek Olan Ürünleri Getirin
4. Belirli Kategorilerdeki Ürünleri Listeleyin
5. En Yüksek Fiyatlı Ürünlere Sahip Kategorileri Listeleyin
6. Bir Ülkedeki Müşterilerin Verdiği Siparişleri Listeleyin
7. Her Kategori İçin Ortalama Fiyatın Üzerinde Olan Ürünleri Listeleyin
8. Her Müşterinin En Son Verdiği Siparişi Listeleyin
9. Her Çalışanın Kendi Departmanındaki Ortalama Maaşın Üzerinde Maaş Alıp Almadığını Bulun
10. En Az 10 Ürün Satın Alınan Siparişleri Listeleyin
11. Her Kategoride En Pahalı Olan Ürünlerin Ortalama Fiyatını Bulun
12. Müşterilerin Verdiği Toplam Sipariş Sayısına Göre Sıralama Yapın
13. En Fazla Sipariş Vermiş 5 Müşteriyi ve Son Sipariş Tarihlerini Listeleyin
14. Toplam Ürün Sayısı 15'ten Fazla Olan Kategorileri Listeleyin
15. En Fazla 5 Farklı Ürün Sipariş Eden Müşterileri Listeleyin
16. 20'den Fazla Ürün Sağlayan Tedarikçileri Listeleyin
17. Her Müşteri İçin En Pahalı Ürünü Bulun
18. 10.000'den Fazla Sipariş Değeri Olan Çalışanları Listeleyin
19. Kategorisine Göre En Çok Sipariş Edilen Ürünü Bulun
20. Müşterilerin En Son Sipariş Verdiği Ürün ve Tarihlerini Listeleyin
21. Her Çalışanın Teslim Ettiği En Pahalı Siparişi ve Tarihini Listeleyin
22. En Fazla Sipariş Verilen Ürünü ve Bilgilerini Listeleyin

--Q1
SELECT productid AS 'Product ID', productname as 'Name', unitprice as 'Price' FROM Products
order by unitprice DESC
LIMIT 1

--Q2
SELECT orderid as 'Order ID', orderdate as 'Date' FROM Orders
order by orderdate DESC
LIMIT 1

--Q3
SELECT productid as 'Product ID', productname as 'Name', unitprice as 'Price' FROM Products
WHERE unitprice > (SELECT avg(unitprice) FROM Products)
order by unitprice DESC

--Q4
SELECT p.productid as 'Product ID', p.productname AS 'Product Name', p.unitprice as 'Price', c.categoryid as 'Category ID',
categoryname as 'Category Name' FROM Products p
JOIN Categories c on p.CategoryID=c.CategoryID
WHERE c.CategoryID IN (1,3,5)

--Q5
SELECT p.ProductID as 'Product ID', p.ProductName as 'Product Name', max(p.UnitPrice) as "Price", c.CategoryID as 'Category ID',
c.CategoryName as 'Category Name' from Products p
JOIN Categories c on p.CategoryID=c.CategoryID
GROUP by c.CategoryName
order BY "Price" DESC

--Q6
SELECT cu.CustomerID as 'Customer ID', cu.CompanyName as 'Company Name' , cu.Country as 'Country' , o.OrderID as 'Order ID',
o.OrderDate as 'Order Date' FROM Customers cu
JOIN Orders o on cu.CustomerID=o.CustomerID
WHERE cu.Country = 'UK'

--Q7
SELECT p.ProductID as 'Product ID', p.ProductName as 'Name', p.UnitPrice as 'Price', c.CategoryName as 'Category' FROM Products p
JOIN Categories c on p.CategoryID=c.CategoryID
WHERE p.UnitPrice> (SELECT avg(p2.UnitPrice) FROM Products p2
                          WHERE p2.CategoryID=p.CategoryID)
ORDER by p.CategoryID desc                         

--Q8
SELECT cu.CustomerID as 'Customer ID', cu.CompanyName as 'Company Name', o.OrderDate as 'Order Date'  from Orders o
JOIN Customers cu on cu.CustomerID=o.CustomerID
WHERE o.OrderDate = (SELECT max(o2.orderdate) FROM Orders o2
                     WHERE o2.CustomerID=o.CustomerID)
order BY o.orderdate DESC

--Q9


--Q10
SELECT o.OrderID as 'Order ID', o.CustomerID as 'Customer Name', o.OrderDate as 'Date', od.Quantity as 'Adet' FROM Orders o
JOIN OrderDetails od on Od.OrderID = o.OrderID
GROUP by o.OrderID, o.CustomerID, o.OrderDate
HAVING od.Quantity>=10
order by od.Quantity DESC

--Q11
WITH EnPahalıÜrünler as (
  SELECT p.CategoryID, max(p.UnitPrice) as "En Pahalı Fiyat" FROM Products p
  GROUP by p.CategoryID
  )
SELECT avg("En Pahalı Fiyat") as "Ortalama Fiyat" FROM EnPahalıÜrünler
  
--Q12
SELECT cu.CustomerID as 'Customer ID', cu.CompanyName as 'Company Name', COUNT(o.OrderID) as "Toplam Sipariş" from Customers cu
LEFT JOIN Orders o on cu.CustomerID=o.CustomerID
GROUP by cu.CustomerID, cu.CompanyName
ORDER BY "Toplam Sipariş" DESC

--Q13
SELECT cu.CompanyName as "Company Name",COUNT(o.OrderID) as "Total Orders", max(o.OrderDate) as "Last Order Date"  FROM Customers cu
JOIN Orders o on cu.CustomerID=o.CustomerID
GROUP BY cu.CustomerID,cu.CompanyName
ORDER by "Total Orders" DESC
LIMIT 5

--Q14
SELECT c.CategoryID as "Category ID", c.CategoryName as "Category Name", COUNT(p.ProductID) as "Total Product"  FROM Categories c
JOIN Products p on c.CategoryID=p.CategoryID
GROUP by c.categoryid, c.categoryname
HAVING "Total Product" > 15

--Q15
SELECT c.CustomerID as "Customer ID", c.CompanyName as "Name", COUNT(DISTINCT od.ProductID) AS "Product Count" FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(DISTINCT od.ProductID) <= 5

--Q16
SELECT s.ShipperID as "Shipper ID", s.CompanyName "Company Name", COUNT(p.ProductID) AS "Product Count" FROM Shippers s
JOIN Products p ON s.ShipperID = p.SupplierID
GROUP BY s.ShipperID, s.CompanyName
HAVING COUNT(p.ProductID) > 20

--Q17
SELECT c.CustomerID, c.CompanyName, MAX(od.UnitPrice) AS "Price" FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName

--Q18
SELECT e.EmployeeID, concat(e.FirstName, ' ', e.LastName) as "Name", SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as "Total"
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING "Total" > 10000

--Q19
SELECT p.CategoryID as "Category ID", p.ProductName as "Name", COUNT(od.Quantity) AS "Quantity" FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY p.CategoryID, p.ProductID, p.ProductName
ORDER BY p.CategoryID, "Quantity" DESC

--Q20
SELECT c.CustomerID as "ID", c.CompanyName as "Company Name" , p.ProductName as "Product Name", o.OrderDate as "Date" 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate = (
    SELECT MAX(o2.OrderDate)
    FROM Orders o2
    WHERE o2.CustomerID = c.CustomerID
)
ORDER BY c.CustomerID;

--Q21
WITH OrderSummary AS (
    SELECT o.EmployeeID, o.OrderID, o.OrderDate,
           SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalOrderValue,
           ROW_NUMBER() OVER (PARTITION BY o.EmployeeID ORDER BY SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) DESC) AS rn
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY o.EmployeeID, o.OrderID, o.OrderDate
)
SELECT e.EmployeeID, e.FirstName, e.LastName, os.OrderID, os.OrderDate, os.TotalOrderValue
FROM Employees e
JOIN OrderSummary os ON e.EmployeeID = os.EmployeeID
WHERE os.rn = 1
ORDER BY e.EmployeeID

--Q22
SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalQuantity, p.UnitPrice
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY p.ProductID, p.ProductName, p.UnitPrice
ORDER BY TotalQuantity DESC
LIMIT 1





                                                       
                                                
