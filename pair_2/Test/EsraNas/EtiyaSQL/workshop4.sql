-- 1. En Pahalı Ürünü Getirin
SELECT productid, productname, unitprice FROM Products ORDER BY unitprice DESC LIMIT 1

-- 2. En Son Verilen Siparişi Bulun
SELECT orderid,customerid, orderdate FROM Orders ORDER BY orderdate DESC LIMIT 1;

-- 3. Fiyatı Ortalama Fiyattan Yüksek Olan Ürünleri Getirin
SELECT productid, productname, unitprice FROM Products WHERE unitprice > (SELECT AVG(unitprice) FROM Products)

-- 4.Belirli Kategorilerdeki Ürünleri Listeleyin
SELECT productid, productname, unitprice, Products.CategoryID AS Category FROM Products 
JOIN Categories ON Products.CategoryID=Categories.CategoryID
WHERE Categories.CategoryID IN (5,7);

--5. En Yüksek Fiyatlı Ürünlere Sahip Kategorileri Listeleyin
SELECT productid, productname, MAX(unitprice) AS price, Products.categoryid, Categories.categoryname AS CategoryName
FROM Products JOIN Categories on Products.CategoryID= Categories.CategoryID
GROUP BY Categories.CategoryName
ORDER BY unitprice DESC;

--6.Bir Ülkedeki Müşterilerin Verdiği Siparişleri Listeleyin
SELECT C.customerid, C.companyname, C.country, O.OrderID, O.OrderDate
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID WHERE C.Country = 'Brazil'

-- 7. Her Kategori İçin Ortalama Fiyatın Üzerinde Olan Ürünleri Listeleyin
SELECT p.productId, p.productName, p.unitprice, c.categoryName From Products p
JOIN Categories c on p.CategoryID=c.CategoryID
WHERE p.UnitPrice> (SELECT avg(p2.UnitPrice) FROM Products p2 WHERE p2.CategoryID=p.CategoryID)
ORDER by p.CategoryID desc                         

--8. Her Müşterinin En Son Verdiği Siparişi Listeleyin
SELECT c.CustomerID, c.CompanyName , o.OrderDate  from Orders o
JOIN Customers c on c.CustomerID=o.CustomerID
WHERE o.OrderDate = (SELECT max(o2.orderdate) FROM Orders o2
                     WHERE o2.CustomerID=o.CustomerID)
order BY o.orderdate DESC

--9. Her Çalışanın Kendi Departmanındaki Ortalama Maaşın Üzerinde Maaş Alıp Almadığını Bulun 

--10. En Az 10 Ürün Satın Alınan Siparişleri Listeleyin 
SELECT Products.ProductName,orderid, SUM(quantity) AS total_products
FROM 'Order Details' AS od JOIN Products ON Products.ProductID = od.productId
GROUP BY orderid
HAVING total_products >= 10 ORDER BY total_products DESC

--12. Müşterilerin Verdiği Toplam Sipariş Sayısına Göre Sıralama Yapın
SELECT c.customerid, COUNT(orderid) AS total_orders FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID ORDER BY total_orders DESC

--13. En Fazla Sipariş Vermiş 5 Müşteriyi ve Son Sipariş Tarihlerini Listeleyin
SELECT c.CompanyName ,COUNT(o.OrderID) as total_orders, max(o.OrderDate) as last_order FROM Customers c
JOIN Orders o on c.CustomerID=o.CustomerID
GROUP BY c.CustomerID,c.CompanyName
ORDER by total_orders DESC
LIMIT 5

--14. Toplam Ürün Sayısı 15'ten Fazla Olan Kategorileri Listeleyin 
SELECT categoryname, COUNT(p.ProductID) as 'total number of products' FROM Categories c
JOIN Products p ON p.CategoryID = c.CategoryId
GROUP BY c.categoryID, c.categoryname
HAVING 'total number of products' > 15

--15. En Fazla 5 Farklı Ürün Sipariş Eden Müşterileri Listeleyin
SELECT customerid, COUNT(orderid) AS total_orders FROM Orders
GROUP BY customerid ORDER BY total_orders DESC LIMIT 5

--16. 3'den Fazla Ürün Sağlayan Tedarikçileri Listeleyin
SELECT supplierid, COUNT(productid) AS number_of_products FROM Products
GROUP BY supplierid HAVING number_of_products >3

--17. Her Müşteri İçin En Pahalı Ürünü Bulun
SELECT c.CustomerID,  MAX(od.UnitPrice) AS "Price" FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN 'Order Details' od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName

--18. 10.000'den Fazla Sipariş Değeri Olan Çalışanları Listeleyin
SELECT e.EmployeeID, e.FirstName||' '|| e.LastName AS FullName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as "Total"
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN 'Order Details' od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING "Total" > 10000

--19. Kategorisine Göre En Çok Sipariş Edilen Ürünü Bulun 
WITH RankedProducts AS (
    SELECT c.categoryid, p.productid, p.productname,COUNT(od.orderid) AS order_count,
        ROW_NUMBER() OVER (PARTITION BY c.categoryid ORDER BY COUNT(od.orderid) DESC) AS rank
    FROM orders o JOIN 'Order Details' od ON o.orderid = od.orderid
    JOIN products p ON od.productid = p.productid
    JOIN categories c ON p.categoryid = c.categoryid
    GROUP BY c.categoryid, p.productid, p.productname
)
SELECT categoryid, productid, productname,order_count
FROM RankedProducts
WHERE rank = 1;

--20. Müşterilerin En Son Sipariş Verdiği Ürün ve Tarihlerini Listeleyin 
SELECT o.customerid, od.productid, p.productname, MAX(o.orderdate) AS last_order_date
FROM orders o
JOIN 'Order Details' od ON o.orderid = od.orderid
JOIN products p ON od.productid = p.productid
GROUP BY o.customerid, od.productid, p.productname
HAVING o.orderdate = MAX(o.orderdate);

--21. Her Çalışanın Teslim Ettiği En Pahalı Siparişi ve Tarihini Listeleyin
WITH OrderSummary AS (
    SELECT o.EmployeeID, o.OrderID, o.OrderDate,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalOrderValue,
        ROW_NUMBER() OVER (PARTITION BY o.EmployeeID ORDER BY SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) DESC) AS rn
    FROM Orders o
    JOIN 'Order Details' od ON o.OrderID = od.OrderID
    GROUP BY o.EmployeeID, o.OrderID, o.OrderDate
)
SELECT os.EmployeeID, e.FirstName, e.LastName, os.OrderID, os.OrderDate, os.TotalOrderValue
FROM OrderSummary os
JOIN Employees e ON os.EmployeeID = e.EmployeeID
WHERE os.rn = 1
ORDER BY os.EmployeeID;

--22. En Fazla Sipariş Verilen Ürünü ve Bilgilerini Listeleyin
SELECT p.productid, p.productname, COUNT(od.orderid) AS total_orders
FROM 'Order Details' od
JOIN products p ON od.productid = p.productid
JOIN orders o ON od.orderid = o.orderid
GROUP BY p.productid, p.productname
ORDER BY total_orders DESC LIMIT 1;


