--Tedarikçi ID'si 1 ile 5 arasındaki ürünler:
1. SELECT * 
   FROM Products 
   WHERE SupplierID BETWEEN 1 AND 5;

--Tedarikçi ID'si 1, 2, 3, 4 veya 5 olan ürünleri listeleyin.
2. SELECT * 
   FROM Products 
   WHERE SupplierID IN (1, 2, 4, 5);

--Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünler:
3. SELECT * 
   FROM Products 
   WHERE ProductName IN ('Chang', 'Aniseed Syrup');

--Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük ürünler:
4. SELECT * 
   FROM Products 
   WHERE SupplierID = 3 OR UnitPrice > 10;

--Ürün adı ve birim fiyatını içeren listeyi getirin.
5.SELECT ProductName || ' ' || UnitPrice 
  FROM Products;

--Ürün adlarını büyük harfe dönüştürdükten sonra 'c' harfi içeren ürünleri listeleyin. (örneğin: 'Chai', 'Chocolate', vs.)
6.SELECT ProductName
   FROM Products 
   WHERE UPPER(ProductName) LIKE '%C%';

--Ürün adı 'n' harfi ile başlayan ve içerisinde tek karakterli bir harf içeren ürünleri listeleyin. (örneğin: 'Naan', 'Nectar', vs.)
--: 'n' ile başlayan ve tek n karakterli bir kelime içeren ürünler
7.SELECT ProductName
  FROM Products
  WHERE ProductName LIKE 'n_';

--Stok miktarı 50'den fazla olan ürünler:
8.SELECT * 
 FROM Products 
 WHERE UnitsInStock > 50;

--En yüksek ve en düşük birim fiyatına sahip ürünleri listeleyin.
9. SELECT * 
   FROM Products 
   WHERE UnitPrice = (SELECT MAX(UnitPrice) AS MaxPrice FROM Products)
      OR UnitPrice = (SELECT MIN(UnitPrice) AS MinPrice FROM Products);

--Ürün adında 'Spice' kelimesi geçen ürünleri listeleyin.
10. SELECT * 
    FROM Products 
    WHERE ProductName LIKE '%Spice%';

------------------WORKSHOP2----------------------------------------------------------------------------------------------------------------------

--Her kategorideki (CategoryID) ürün sayısını gösteren bir sorgu yazın.
1. SELECT CategoryID, COUNT(*) AS ProductCount
   FROM Products
   GROUP BY CategoryID;

--Birim fiyatı en yüksek 5 ürünü listeleyin.
2. SELECT * 
   FROM Products
   ORDER BY UnitPrice DESC
   LIMIT 5;

--Her tedarikçinin sattığı ürünlerin ortalama fiyatını listeleyin.
3.SELECT SupplierID, AVG(UnitPrice) AS AveragePrice
  FROM Products
  GROUP BY SupplierID;

--"Products" tablosunda birim fiyatı 100'den büyük olan ürünlerin kategorilerini ve bu kategorilerdeki ortalama fiyatı listeleyin.
4. SELECT CategoryID, AVG(UnitPrice) AS AveragePrice
   FROM Products
   WHERE UnitPrice > 100
   GROUP BY CategoryID;

--"OrderDetails" tablosunda birim fiyat ve miktar çarpımıyla toplam satış değeri 1000'den fazla olan siparişleri listeleyin.
5. SELECT * 
   FROM [Order Details]
   WHERE (UnitPrice * Quantity) > 1000;

--En son sevk edilen 10 siparişi listeleyin.
6. SELECT * 
   FROM Orders
   WHERE ShippedDate IS NOT NULL
   ORDER BY ShippedDate DESC
   LIMIT 10;

--"Products" tablosundaki ürünlerin ortalama fiyatını hesaplayın.
7.SELECT AVG(UnitPrice) AS AveragePrice
  FROM Products;

--"Products" tablosunda fiyatı 50’den büyük olan ürünlerin toplam stok miktarını hesaplayın.
8.SELECT SUM(UnitsInStock) AS TotalStock
  FROM Products
  WHERE UnitPrice > 50;

--"Orders" tablosundaki en eski sipariş tarihini bulun.
9.SELECT MIN(OrderDate) AS OldestOrderDate
  FROM Orders;

--"Employees" tablosundaki çalışanların kaç yıl önce işe başladıklarını gösteren bir sorgu yazın.
10. SELECT EmployeeID, 
       FirstName, 
       LastName, 
       HireDate,
       FLOOR((julianday('now') - julianday(HireDate)) / 365.25) AS YearsEmployed
   FROM Employees;

--"OrderDetails" tablosundaki her bir sipariş için, birim fiyatın toplamını yuvarlayarak (ROUND) hesaplayın.
11. SELECT OrderID, 
    ROUND(SUM(UnitPrice * Quantity), 0) AS RoundedTotalPrice
    FROM [Order Details]
    GROUP BY OrderID;

--"Products" tablosunda stoktaki (UnitsInStock) ürün sayısını gösteren bir COUNT sorgusu yazın.
12. SELECT COUNT(*) AS NumberOfProductsInStock
    FROM Products
    WHERE UnitsInStock > 0;

--"Products" tablosundaki en düşük ve en yüksek fiyatları hesaplayın.
13.SELECT MIN(UnitPrice) AS LowestPrice, 
   MAX(UnitPrice) AS HighestPrice
   FROM Products;

--"Orders" tablosunda her yıl kaç sipariş alındığını listeleyin (YEAR() fonksiyonunu kullanarak).
14. SELECT strftime('%Y', OrderDate) AS OrderYear, 
       COUNT(*) AS NumberOfOrders
    FROM Orders
    GROUP BY strftime('%Y', OrderDate)
    ORDER BY OrderYear;

--"Employees" tablosundaki çalışanların tam adını (FirstName + LastName) birleştirerek gösterin.
15. SELECT FirstName || ' ' || LastName AS FullName
    FROM Employees;

--"Customers" tablosundaki şehir adlarının uzunluğunu (LENGTH) hesaplayın.
16. SELECT City, LENGTH(City) AS CityLength
    FROM Customers;

--"Products" tablosundaki her ürünün fiyatını iki ondalık basamağa yuvarlayarak gösterin.
17. SELECT ProductID, 
       ProductName, 
       ROUND(UnitPrice, 2) AS RoundedPrice
    FROM Products;

--"Orders" tablosundaki tüm siparişlerin toplam sayısını bulun.
18. SELECT COUNT(*) AS TotalOrders
    FROM Orders;

--"Products" tablosunda her kategorideki (CategoryID) ürünlerin ortalama fiyatını (AVG) hesaplayın.
19. SELECT CategoryID, 
       AVG(UnitPrice) AS AveragePrice
    FROM Products
    GROUP BY CategoryID;

--"Orders" tablosunda sevk tarihi (ShippedDate) boş olan siparişlerin yüzdesini (COUNT ve toplam sipariş sayısını kullanarak) hesaplayın.
20. SELECT 
    (COUNT(CASE WHEN ShippedDate IS NULL THEN 1 END) * 100.0 / COUNT(*)) AS PercentageUnshipped
    FROM Orders;

--"Products" tablosundaki en pahalı ürünün fiyatını bulun ve bir fonksiyon kullanarak fiyatı 10% artırın.
21.SELECT ProductName, 
       UnitPrice AS OriginalPrice, 
       ROUND(UnitPrice * 1.10, 2) AS PriceIncreased
   FROM Products
   ORDER BY UnitPrice DESC
   LIMIT 1;

--"Products" tablosundaki ürün adlarının ilk 3 karakterini gösterin (SUBSTRING).
22. SELECT ProductName, 
    substr(ProductName, 1, 3) AS FirstThreeChars
    FROM Products;

--"Orders" tablosunda verilen siparişlerin yıl ve ay bazında kaç sipariş alındığını hesaplayın (YEAR ve MONTH fonksiyonları).
23.SELECT strftime('%Y', OrderDate) AS OrderYear, 
       strftime('%m', OrderDate) AS OrderMonth, 
       COUNT(*) AS NumberOfOrders
   FROM Orders
   GROUP BY strftime('%Y', OrderDate), strftime('%m', OrderDate)
   ORDER BY OrderYear, OrderMonth;

--"OrderDetails" tablosunda toplam sipariş değerini (UnitPrice * Quantity) hesaplayıp, bu değeri iki ondalık basamağa yuvarlayarak gösterin.
24. SELECT OrderID, 
       ROUND(SUM(UnitPrice * Quantity), 2) AS TotalOrderValue
    FROM [Order Details]
    GROUP BY OrderID;


--"Products" tablosunda stokta olmayan (UnitsInStock = 0) ürünlerin fiyatlarını toplam fiyat olarak hesaplayın.
25. SELECT ROUND(SUM(UnitPrice), 2) AS TotalStockValue
    FROM Products
    WHERE UnitsInStock = 0;


------------------------WORKSHOP3-------------------------------------------------
--Verilen Customers ve Orders tablolarını kullanarak, Customers tablosundaki müşterileri ve onların verdikleri siparişleri birleştirerek listeleyin. Müşteri adı, sipariş ID'si ve sipariş tarihini gösterin.
1. SELECT Customers.ContactName AS CustomerName, 
       Orders.OrderID, 
       Orders.OrderDate
   FROM Customers
   JOIN Orders 
   ON Customers.CustomerID = Orders.CustomerID;

--Verilen Suppliers ve Products tablolarını kullanarak tüm tedarikçileri ve onların sağladıkları ürünleri listeleyin. Eğer bir tedarikçinin ürünü yoksa, NULL olarak gösterilsin.
2.SELECT Suppliers.CompanyName, 
       Products.ProductName
  FROM Suppliers
  LEFT JOIN Products 
  ON Suppliers.SupplierID = Products.SupplierID;

--Verilen Employees ve Orders tablolarını kullanarak tüm siparişleri ve bu siparişleri işleyen çalışanları listeleyin. Eğer bir sipariş bir çalışan tarafından işlenmediyse, çalışan bilgileri NULL olarak gösterilsin.
3. SELECT Orders.OrderID, 
       Orders.OrderDate, 
       Employees.EmployeeID, 
       Employees.FirstName, 
       Employees.LastName
   FROM Orders
   LEFT JOIN Employees 
   ON Orders.EmployeeID = Employees.EmployeeID;

--Verilen Customers ve Orders tablolarını kullanarak tüm müşterileri ve tüm siparişleri listeleyin. Sipariş vermeyen müşteriler ve müşterisi olmayan siparişler için NULL döndürün.
4. SELECT Customers.CustomerID, 
       Customers.ContactName, 
       Orders.OrderID, 
       Orders.OrderDate
  FROM Customers
  FULL OUTER JOIN Orders 
  ON Customers.CustomerID = Orders.CustomerID;

--Verilen Products ve Categories tablolarını kullanarak tüm ürünler ve tüm kategoriler için olası tüm kombinasyonları listeleyin. Sonuç kümesindeki her satır bir ürün ve bir kategori kombinasyonunu göstermelidir.
5. SELECT Products.ProductName, 
       Categories.CategoryName
   FROM Products
   CROSS JOIN Categories;

--Verilen Orders, Customers, Employees tablolarını kullanarak bu tabloları birleştirin ve 1998 yılında verilen siparişleri listeleyin. Müşteri adı, sipariş ID'si, sipariş tarihi ve ilgili çalışan adı gösterilsin.
6.SELECT Customers.ContactName AS CustomerName, 
       Orders.OrderID, 
       Orders.OrderDate, 
       Employees.FirstName || ' ' || Employees.LastName AS EmployeeName
   FROM Orders
   JOIN Customers 
   ON Orders.CustomerID = Customers.CustomerID
   JOIN Employees 
   ON Orders.EmployeeID = Employees.EmployeeID
   WHERE strftime('%Y', Orders.OrderDate) = '2013';

--Verilen Orders ve Customers tablolarını kullanarak müşterileri, verdikleri sipariş sayısına göre gruplandırın. Sadece 5’ten fazla sipariş veren müşterileri listeleyin.
7. SELECT
   Customers.CustomerID,
   Customers.CustomerName,
   COUNT(Orders.OrderID) AS OrderCount
   FROM
   Customers
   JOIN Orders ON Customers.CustomerID = Orders.CustomerID
   GROUP BY
   Customers.CustomerID,
   Customers.CustomerName
   HAVING
   OrderCount > 5;

--Verilen OrderDetails ve Products tablolarını kullanarak her ürün için kaç adet satıldığını ve toplam satış miktarını listeleyin. Ürün adı, satılan toplam adet ve toplam kazancı (Quantity * UnitPrice) gösterin.
8. SELECT
   p.ProductName,
   SUM(od.Quantity) AS TotalQuantitySold,
   SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
   FROM
   [Order Details] od
   JOIN Products p ON od.ProductID = p.ProductID
   GROUP BY
   p.ProductName;

--Verilen Customers ve Orders tablolarını kullanarak, müşteri adı "B" harfiyle başlayan müşterilerin siparişlerini listeleyin.
9.SELECT
  c.ContactName,
  o.OrderID,
  o.OrderDate
FROM
Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE
c.ContactName LIKE 'B%';

--Verilen Products ve Categories tablolarını kullanarak tüm kategorileri listeleyin ve ürünleri olmayan kategorileri bulun. Ürün adı NULL olan satırları gösterin.
10.SELECT
  c.CategoryID,
  c.CategoryName,
  p.ProductName
  FROM
  Categories c
  LEFT JOIN Products p ON c.CategoryID = p.CategoryID
  WHERE
  p.ProductName IS NULL;

--Verilen Employees tablosunu kullanarak her çalışanın yöneticisiyle birlikte bir liste oluşturun.
11. SELECT 
   e.EmployeeID AS EmployeeID,
   e.FirstName || ' ' || e.LastName AS EmployeeName,
   m.EmployeeID AS ManagerID,
   m.FirstName || ' ' || m.LastName AS ManagerName
   FROM 
   Employees e
   LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID;

--Verilen Products tablosunu kullanarak her kategorideki en pahalı ürünleri ve bu ürünlerin farklı fiyatlara sahip olup olmadığını sorgulayın.
12. WITH MaxPrices AS (
   SELECT 
      CategoryID,
      MAX(UnitPrice) AS MaxPrice
   FROM 
      Products
   GROUP BY 
      CategoryID
   )

   SELECT 
   p.CategoryID,
   p.ProductName,
   p.UnitPrice
   FROM 
   Products p
   JOIN MaxPrices mp ON p.CategoryID = mp.CategoryID AND p.UnitPrice = mp.MaxPrice
   ORDER BY 
   p.CategoryID, p.UnitPrice;

--Verilen Orders ve OrderDetails tablolarını kullanarak bu tabloları birleştirin ve her siparişin detaylarını sipariş ID'sine göre artan sırada listeleyin.
13. SELECT
   o.OrderID,
   o.CustomerID,
   o.OrderDate,
   od.ProductID,
   od.UnitPrice,
   od.Quantity,
   (od.UnitPrice * od.Quantity) AS TotalPrice
   FROM
   Orders o
   JOIN [Order Details] od ON o.OrderID = od.OrderID
   ORDER BY
   o.OrderID ASC;

--Verilen Employees ve Orders tablolarını kullanarak her çalışanın kaç tane sipariş işlediğini listeleyin. Sipariş işlemeyen çalışanlar da gösterilsin.
14. SELECT
   e.EmployeeID,
   e.FirstName,
   e.LastName,
   COUNT(o.OrderID) AS NumberOfOrders
   FROM
   Employees e
   LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
   GROUP BY
   e.EmployeeID, e.FirstName, e.LastName
   ORDER BY
   e.EmployeeID;

--Verilen Products tablosunu kullanarak bir kategorideki ürünleri kendi arasında fiyatlarına göre karşılaştırın ve fiyatı düşük olan ürünleri listeleyin.
15. SELECT
   p1.ProductID AS LowerPricedProductID,
   p1.ProductName AS LowerPricedProductName,
   p1.UnitPrice AS LowerPrice
   FROM
   Products p1
   JOIN Products p2 ON p1.CategoryID = p2.CategoryID
                  AND p1.UnitPrice < p2.UnitPrice
   ORDER BY
   p1.CategoryID, p1.UnitPrice;

--Verilen Products ve Suppliers tablolarını kullanarak tedarikçiden alınan en pahalı ürünleri listeleyin.
16. SELECT
   s.SupplierID,
   s.CompanyName AS SupplierName,
   p.ProductID,
   p.ProductName,
   p.UnitPrice
   FROM
   Suppliers s
   JOIN Products p ON s.SupplierID = p.SupplierID
   WHERE
   p.UnitPrice = (
      SELECT
         MAX(p2.UnitPrice)
      FROM
         Products p2
      WHERE
         p2.SupplierID = s.SupplierID
   )
   ORDER BY
   s.SupplierID;

--Verilen Employees ve Orders tablolarını kullanarak her çalışanın işlediği en son siparişi bulun.
17. SELECT
   e.EmployeeID,
   e.FirstName,
   e.LastName,
   o.OrderID,
   o.OrderDate
   FROM
   Employees e
   LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
   WHERE
   o.OrderDate = (
      SELECT
         MAX(o2.OrderDate)
      FROM
         Orders o2
      WHERE
         o2.EmployeeID = e.EmployeeID
   );

--Verilen Products tablosunu kullanarak ürünleri fiyatlarına göre gruplandırın ve fiyatı 20 birimden fazla olan ürünlerin sayısını listeleyin.
18. SELECT
   COUNT(*) AS NumberOfProducts
   FROM
   Products
   WHERE
   UnitPrice > 20;

--Verilen Orders ve Customers tablolarını kullanarak 1997 ile 1998 yılları arasında verilen siparişleri müşteri adıyla birlikte listeleyin.
19. SELECT
   c.ContactName,
   o.OrderID,
   o.OrderDate
   FROM
   Orders o
   JOIN Customers c ON o.CustomerID = c.CustomerID
   WHERE
   o.OrderDate BETWEEN '2013-01-01' AND '2018-12-31';

--Verilen Customers ve Orders tablolarını kullanarak hiç sipariş vermeyen müşterileri listeleyin.
20. SELECT
   c.CustomerID,
   c.ContactName
   FROM
   Customers c
   LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
   WHERE
   o.OrderID IS NULL;


----------------------------WORKSHOP4---------------------------------------------------------------
-- En Pahalı Ürünü Getirin
1.SELECT 
  ProductName, 
  UnitPrice 
FROM 
  Products 
ORDER BY 
  UnitPrice DESC 
LIMIT 1;

--En Son Verilen Siparişi Bulun
2. SELECT 
  OrderID, 
  CustomerID, 
  OrderDate 
FROM 
  Orders 
ORDER BY 
  OrderDate DESC 
LIMIT 1;

--Fiyatı Ortalama Fiyattan Yüksek Olan Ürünleri Getirin
3. SELECT 
  ProductName, 
  UnitPrice 
FROM 
  Products 
WHERE 
  UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

--4. Belirli Kategorilerdeki Ürünleri Listeleyin
4. SELECT 
  ProductName, 
  CategoryID, 
  UnitPrice 
FROM 
  Products 
WHERE 
  CategoryID IN (1, 2, 3); 

--En Yüksek Fiyatlı Ürünlere Sahip Kategorileri Listeleyin
5. SELECT 
  CategoryID, 
  MAX(UnitPrice) AS MaxPrice 
FROM 
  Products 
GROUP BY 
  CategoryID 
ORDER BY 
  MaxPrice DESC;


--6. Bir Ülkedeki Müşterilerin Verdiği Siparişleri Listeleyin
6.  SELECT c.CustomerID, c.ContactName, o.OrderID, c.Country
   FROM Customers c
   JOIN Orders o ON c.CustomerID = o.CustomerID
   WHERE c.Country = 'Germany';


--7. Her Kategori İçin Ortalama Fiyatın Üzerinde Olan Ürünleri Listeleyin
7.  SELECT 
     ProductName, 
     CategoryID, 
     UnitPrice 
   FROM 
     Products p1 
   WHERE 
     UnitPrice > (
       SELECT 
         AVG(UnitPrice) 
       FROM 
         Products p2 
       WHERE 
         p2.CategoryID = p1.CategoryID
     );

--8. Her Müşterinin En Son Verdiği Siparişi Listeleyin
8.  SELECT 
     c.CustomerID, 
     c.CustomerName, 
     o.OrderID, 
     o.OrderDate 
   FROM 
     Customers c 
   JOIN 
     Orders o ON c.CustomerID = o.CustomerID 
   WHERE 
     o.OrderDate = (
       SELECT 
         MAX(o2.OrderDate) 
       FROM 
         Orders o2 
       WHERE 
         o2.CustomerID = c.CustomerID
     );

--9. Her Çalışanın Kendi Departmanındaki Ortalama Maaşın Üzerinde Maaş Alıp Almadığını Bulun
9. SELECT 
  e.EmployeeID, 
  e.EmployeeName, 
  e.DepartmentID, 
  e.Salary, 
  CASE 
    WHEN e.Salary > (
      SELECT 
        AVG(e2.Salary) 
      FROM 
        Employees e2 
      WHERE 
        e2.DepartmentID = e.DepartmentID
    ) 
    THEN 'Above Average' 
    ELSE 'Below Average' 
  END AS SalaryComparison 
FROM 
  Employees e;


--10. En Az 10 Ürün Satın Alınan Siparişleri Listeleyin
10. SELECT 
     o.OrderID, 
     SUM(od.Quantity) AS TotalQuantity 
   FROM 
     Orders o 
   JOIN 
     OrderDetails od ON o.OrderID = od.OrderID 
   GROUP BY 
     o.OrderID 
   HAVING 
     TotalQuantity >= 10;

--11. Her Kategoride En Pahalı Olan Ürünlerin Ortalama Fiyatını Bulun
11. SELECT 
     CategoryID, 
     AVG(UnitPrice) AS AvgMaxPrice 
   FROM 
     Products 
   WHERE 
     UnitPrice = (
       SELECT 
         MAX(UnitPrice) 
       FROM 
         Products AS p2 
       WHERE 
         p2.CategoryID = Products.CategoryID
     ) 
   GROUP BY 
     CategoryID;

--12. Müşterilerin Verdiği Toplam Sipariş Sayısına Göre Sıralama Yapın
12. SELECT 
     c.CustomerID, 
     c.CustomerName, 
     COUNT(o.OrderID) AS TotalOrders 
   FROM 
     Customers c 
   LEFT JOIN 
     Orders o ON c.CustomerID = o.CustomerID 
   GROUP BY 
     c.CustomerID, 
     c.CustomerName 
   ORDER BY 
     TotalOrders DESC;

--13. En Fazla Sipariş Vermiş 5 Müşteriyi ve Son Sipariş Tarihlerini Listeleyin
13.  WITH CustomerOrderCounts AS (
    SELECT c.CustomerID, c.CompanyName, COUNT(o.OrderID) AS TotalOrders, MAX(o.OrderDate) AS LastOrderDate
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CompanyName
)
   SELECT CustomerID, CompanyName, TotalOrders, LastOrderDate
   FROM CustomerOrderCounts
   ORDER BY TotalOrders DESC
   LIMIT 5;


--14. Toplam Ürün Sayısı 15'ten Fazla Olan Kategorileri Listeleyin
14. SELECT 
     CategoryID, 
     COUNT(*) AS TotalProducts 
   FROM 
     Products 
   GROUP BY 
     CategoryID 
   HAVING 
     TotalProducts > 15;

--15. En Fazla 5 Farklı Ürün Sipariş Eden Müşterileri Listeleyin
15. SELECT c.CustomerID, c.CompanyName, COUNT(DISTINCT od.ProductID) AS UniqueProducts
   FROM Customers c
   JOIN Orders o ON c.CustomerID = o.CustomerID
   JOIN "Order Details" od ON o.OrderID = od.OrderID
   GROUP BY c.CustomerID, c.CompanyName
   HAVING COUNT(DISTINCT od.ProductID) <= 2;

--16. 20'den Fazla Ürün Sağlayan Tedarikçileri Listeleyin
16.  SELECT 
     s.SupplierID, 
     s.SupplierName, 
     COUNT(p.ProductID) AS TotalProducts 
   FROM 
     Suppliers s 
   JOIN 
     Products p ON s.SupplierID = p.SupplierID 
   GROUP BY 
     s.SupplierID, 
     s.SupplierName 
   HAVING 
     TotalProducts > 20;

--17. Her Müşteri İçin En Pahalı Ürünü Bulun
17.  WITH CustomerMaxPrice AS (
    SELECT o.CustomerID, od.ProductID, MAX(p.UnitPrice) AS MaxPrice
    FROM Orders o
    JOIN "Order Details" od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY o.CustomerID, od.ProductID
   )
   SELECT c.CustomerID, c.CompanyName, p.ProductName, cmp.MaxPrice
   FROM CustomerMaxPrice cmp
   JOIN Customers c ON cmp.CustomerID = c.CustomerID
   JOIN Products p ON cmp.ProductID = p.ProductID
   WHERE (cmp.CustomerID, cmp.MaxPrice) IN (
       SELECT CustomerID, MAX(MaxPrice)
       FROM CustomerMaxPrice
       GROUP BY CustomerID
   );


--18. 10.000'den Fazla Sipariş Değeri Olan Çalışanları Listeleyin
18.  SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(od.Quantity * p.UnitPrice) AS TotalOrderValue
   FROM Employees e
   JOIN Orders o ON e.EmployeeID = o.EmployeeID
   JOIN "Order Details" od ON o.OrderID = od.OrderID
   JOIN Products p ON od.ProductID = p.ProductID
   GROUP BY e.EmployeeID, e.FirstName, e.LastName
   HAVING SUM(od.Quantity * p.UnitPrice) > 10000;


--19. Kategorisine Göre En Çok Sipariş Edilen Ürünü Bulun
19. WITH ProductOrderCounts AS (
    SELECT p.ProductID, p.ProductName, p.CategoryID, SUM(od.Quantity) AS TotalOrdered
    FROM Products p
    JOIN "Order Details" od ON p.ProductID = od.ProductID
    JOIN Orders o ON od.OrderID = o.OrderID
    GROUP BY p.ProductID, p.ProductName, p.CategoryID
   )
   SELECT poc.CategoryID, p.ProductName, poc.TotalOrdered
   FROM ProductOrderCounts poc
   JOIN Products p ON poc.ProductID = p.ProductID
   WHERE (poc.CategoryID, poc.TotalOrdered) IN (
       SELECT CategoryID, MAX(TotalOrdered)
       FROM ProductOrderCounts
       GROUP BY CategoryID
   );

--20. Müşterilerin En Son Sipariş Verdiği Ürün ve Tarihlerini Listeleyin
20.  SELECT 
     c.CustomerID, 
     c.CustomerName, 
     p.ProductName, 
     o.OrderDate 
   FROM 
     Customers c 
   JOIN 
     Orders o ON c.CustomerID = o.CustomerID 
   JOIN 
     OrderDetails od ON o.OrderID = od.OrderID 
   JOIN 
     Products p ON od.ProductID = p.ProductID 
   WHERE 
     o.OrderDate = (
       SELECT 
         MAX(o2.OrderDate) 
       FROM 
         Orders o2 
       WHERE 
         o2.CustomerID = c.CustomerID
     );

--21. Her Çalışanın Teslim Ettiği En Pahalı Siparişi ve Tarihini Listeleyin
21. SELECT 
     e.EmployeeID, 
     e.FirstName, 
     e.LastName, 
     o.OrderID, 
     o.OrderDate, 
     MAX(od.UnitPrice * od.Quantity) AS MaxOrderValue
   FROM 
     Employees e
   JOIN 
     Orders o ON e.EmployeeID = o.EmployeeID 
   JOIN 
     "Order Details"s od ON o.OrderID = od.OrderID 
   GROUP BY 
     e.EmployeeID, 
     e.FirstName, 
     e.LastName, 
     o.OrderID, 
     o.OrderDate
   ORDER BY 
     e.EmployeeID, 
     MaxOrderValue DESC;

--22. En Fazla Sipariş Verilen Ürünü ve Bilgilerini Listeleyin
22.  SELECT p.ProductID, p.ProductName, p.CategoryID, SUM(od.Quantity) AS TotalOrdered
   FROM Products p
   JOIN "Order Details" od ON p.ProductID = od.ProductID
   JOIN Orders o ON od.OrderID = o.OrderID
   GROUP BY p.ProductID, p.ProductName, p.CategoryID
   ORDER BY TotalOrdered DESC
   LIMIT 1;






















