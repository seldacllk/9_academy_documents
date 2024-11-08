--SQL WORKSHOP 3
--1  Verilen Customers ve Orders tablolarını kullanarak, Customers tablosundaki müşterileri ve onların verdikleri siparişleri birleştirerek listeleyin. Müşteri adı, sipariş ID'si ve sipariş tarihini gösterin.
select CU.CompanyName,O.OrderID,O.OrderDate from ORDERS AS O JOIN Customers AS CU ON CU.CustomerID= O.CustomerID
--2  Verilen Suppliers ve Products tablolarını kullanarak tüm tedarikçileri ve onların sağladıkları ürünleri listeleyin. Eğer bir tedarikçinin ürünü yoksa, NULL olarak gösterilsin.
SELECT S.SupplierID,S.CompanyName,P.ProductID,P.ProductName 
FROM Suppliers AS S LEFT JOIN Products AS P ON P.SupplierID=S.SupplierID
--3  Verilen Employees ve Orders tablolarını kullanarak tüm siparişleri ve bu siparişleri işleyen çalışanları listeleyin. Eğer bir sipariş bir çalışan tarafından işlenmediyse, çalışan bilgileri NULL olarak gösterilsin.
SELECT E.EmployeeID,CONCAT(E.FirstName,E.LastName) AS 'FULL NAME',O.OrderID 
FROM Orders AS O LEFT JOIN Employees AS E ON E.EmployeeID=O.EmployeeID
--4  Verilen Customers ve Orders tablolarını kullanarak tüm müşterileri ve tüm siparişleri listeleyin. Sipariş vermeyen müşteriler ve müşterisi olmayan siparişler için NULL döndürün.
select O.OrderID,CU.CustomerID from Customers as CU FULL JOIN Orders AS O ON O.CustomerID=CU.CustomerID
--5  Verilen Products ve Categories tablolarını kullanarak tüm ürünler ve tüm kategoriler için olası tüm kombinasyonları listeleyin. Sonuç kümesindeki her satır bir ürün ve bir kategori kombinasyonunu göstermelidir.
SELECT CA.CategoryID,CA.CategoryName,P.ProductID,P.ProductName  FROM Categories AS CA CROSS JOIN Products AS P
--6  Verilen Orders, Customers, Employees tablolarını kullanarak bu tabloları birleştirin ve 1998 yılında verilen siparişleri listeleyin. Müşteri adı, sipariş ID'si, sipariş tarihi ve ilgili çalışan adı gösterilsin.
SELECT C.CompanyName,O.OrderID,O.OrderDate,E.EmployeeID,CONCAT(E.FirstName,E.LastName) AS 'FULL NAME' 
FROM Employees AS E JOIN Orders AS O ON E.EmployeeID=O.EmployeeID 
JOIN Customers AS C ON O.CustomerID=C.CustomerID
WHERE strftime('%Y', O.OrderDate) ='1998'
--7  Verilen Orders ve Customers tablolarını kullanarak müşterileri, verdikleri sipariş sayısına göre gruplandırın. Sadece 5’ten fazla sipariş veren müşterileri listeleyin.
SELECT CU.CustomerID,CU.CompanyName,count(o.OrderID) 'TOTTAL ORDERS'
FROM Orders AS O JOIN Customers AS CU ON CU.CustomerID=O.CustomerID
GROUP BY O.CustomerID
HAVING count(o.OrderID)>5
ORDER BY count(o.OrderID) ASC
--8  Verilen OrderDetails ve Products tablolarını kullanarak her ürün için kaç adet satıldığını ve toplam satış miktarını listeleyin. Ürün adı, satılan toplam adet ve toplam kazancı (Quantity * UnitPrice) gösterin.
SELECT P.ProductName,SUM(OD.Quantity) 'TOTAL QUANTITY',(OD.Quantity * OD.UnitPrice) 'TOTAL PRICE'
FROM OrderDetails AS OD JOIN Products AS P ON P.ProductID=OD.ProductID
GROUP BY OD.productid
ORDER BY COUNT(OD.ProductID) ASC
--9  Verilen Products ve Categories tablolarını kullanarak tüm kategorileri listeleyin ve ürünleri olmayan kategorileri bulun. Ürün adı NULL olan satırları gösterin.
SELECT O.OrderID,O.OrderDate,O.CustomerID,CU.CompanyName
FROM Orders AS O JOIN Customers AS CU ON CU.CustomerID=O.CustomerID
WHERE CU.CompanyName LIKE 'B%'
--10 Verilen Employees tablosunu kullanarak her çalışanın yöneticisiyle birlikte bir liste oluşturun.
SELECT P.CategoryID,CA.CategoryName,P.ProductID,P.ProductName 
FROM Categories AS CA LEFT JOIN Products AS P ON CA.CategoryID=P.CategoryID
where P.ProductName IS NULL
--11  Verilen Products tablosunu kullanarak her kategorideki en pahalı ürünleri ve bu ürünlerin farklı fiyatlara sahip olup olmadığını sorgulayın.
SELECT E1.EmployeeID,CONCAT(E1.FirstName,E1.LastName) AS 'EMPLOYEE',CONCAT(E2.FirstName,E2.LastName) AS 'MANAGER' 
FROM Employees  AS E1
LEFT JOIN Employees AS E2 ON E1.ReportsTo=E2.EmployeeID
--12  Verilen Orders ve OrderDetails tablolarını kullanarak bu tabloları birleştirin ve her siparişin detaylarını sipariş ID'sine göre artan sırada listeleyin.
SELECT CA.CategoryID,CA.CategoryName,P.ProductID,P.ProductName,MAX(P.UnitPrice) AS 'MOST EXPENSIVE'
FROM Products AS P JOIN Categories AS CA ON CA.CategoryID=P.CategoryID
GROUP BY CA.CategoryID
--13  Verilen Employees ve Orders tablolarını kullanarak her çalışanın kaç tane sipariş işlediğini listeleyin. Sipariş işlemeyen çalışanlar da gösterilsin.
select O.OrderID,O.OrderDate,OD.ProductID,OD.UnitPrice,OD.Quantity,OD.Discount
from Orders as O JOIN OrderDetails AS OD ON O.OrderID=OD.OrderID
ORDER BY O.OrderID
--14  Verilen Products tablosunu kullanarak bir kategorideki ürünleri kendi arasında fiyatlarına göre karşılaştırın ve fiyatı düşük olan ürünleri listeleyin.
SELECT E.EmployeeID,COUNT(O.EmployeeID) AS 'TOTAL ORDERS'
FROM Employees AS E LEFT JOIN Orders AS O ON E.EmployeeID=O.EmployeeID
GROUP BY E.EmployeeID
--15  Verilen Products ve Suppliers tablolarını kullanarak tedarikçiden alınan en pahalı ürünleri listeleyin.
SELECT CA.CategoryID,CA.CategoryName,P.ProductName,MIN(P.UnitPrice) ',CHEAPEST PRICE'
FROM Categories AS CA JOIN Products AS P ON CA.CategoryID=P.CategoryID
GROUP BY CA.CategoryID
--16  Verilen Employees ve Orders tablolarını kullanarak her çalışanın işlediği en son siparişi bulun.
SELECT S.SupplierID,S.CompanyName,P.ProductName,MAX(P.UnitPrice) 'MOST EXPENSIVE'
FROM Products AS P JOIN Suppliers AS S ON S.SupplierID=P.SupplierID
GROUP BY S.SupplierID
--17  Verilen Products tablosunu kullanarak ürünleri fiyatlarına göre gruplandırın ve fiyatı 20 birimden fazla olan ürünlerin sayısını listeleyin.
SELECT E.EmployeeID,CONCAT(E.FirstName,E.LastName) AS 'FULL NAME',O.OrderID,MAX(O.OrderDate) 'LATEST ORDER'
FROM Orders AS O JOIN Employees AS E ON O.EmployeeID=E.EmployeeID
GROUP BY E.EmployeeID
--18  Verilen Products tablosunu kullanarak ürünleri fiyatlarına göre gruplandırın ve fiyatı 20 birimden fazla olan ürünlerin sayısını listeleyin.
SELECT unitprice,COUNT(productid) FROM Products
WHERE unitprice>20
GROUP BY unitprice
--19  Verilen Orders ve Customers tablolarını kullanarak 1997 ile 1998 yılları arasında verilen siparişleri müşteri adıyla birlikte listeleyin.
SELECT O.OrderID,O.OrderDate,CU.CustomerID,CU.CompanyName
FROM ORDERS AS O JOIN Customers AS CU ON CU.CustomerID=O.CustomerID
WHERE strftime('%Y', O.OrderDate) BETWEEN '1997' AND '1999'
--20  Verilen Customers ve Orders tablolarını kullanarak hiç sipariş vermeyen müşterileri listeleyin.
SELECT CU.CustomerID,CU.CompanyName
FROM CUSTOMERS AS CU LEFT JOIN Orders AS O ON CU.CustomerID=O.CustomerID
WHERE O.OrderID IS NULL























