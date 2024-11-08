--1-Verilen Customers ve Orders tablolarını kullanarak, Customers tablosundaki müşterileri ve onların verdikleri siparişleri birleştirerek listeleyin. Müşteri adı, sipariş ID'si ve sipariş tarihini gösterin.
SELECT 
    Customers.ContactName AS "Müşteri Adı", 
    Orders.OrderID AS "Sipariş ID'si", 
    Orders.OrderDate AS "Sipariş Tarihi"
FROM 
    Customers
JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY 
    Customers.ContactName, Orders.OrderDate;


--2-Verilen Suppliers ve Products tablolarını kullanarak tüm tedarikçileri ve onların sağladıkları ürünleri listeleyin. Eğer bir tedarikçinin ürünü yoksa, NULL olarak gösterilsin.
SELECT 
    Suppliers.CompanyName AS "Tedarikçi", 
    Products.ProductName AS "Ürün"
FROM 
    Suppliers
LEFT JOIN 
    Products ON Suppliers.SupplierID = Products.SupplierID
ORDER BY 
    Suppliers.CompanyName;


--3-Verilen Employees ve Orders tablolarını kullanarak tüm siparişleri ve bu siparişleri işleyen çalışanları listeleyin. Eğer bir sipariş bir çalışan tarafından işlenmediyse, çalışan bilgileri NULL olarak gösterilsin.
SELECT 
    Orders.OrderID AS "Sipariş ID'si", 
    CONCAT(Employees.FirstName, ' ', Employees.LastName) AS "Çalışan Adı", 
    Orders.OrderDate AS "Sipariş Tarihi"
FROM 
    Orders
RIGHT JOIN 
    Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY 
    Orders.OrderDate;


--4-Verilen Customers ve Orders tablolarını kullanarak tüm müşterileri ve tüm siparişleri listeleyin. Sipariş vermeyen müşteriler ve müşterisi olmayan siparişler için NULL döndürün.
SELECT 
    Customers.ContactName AS "Müşteri Adı", 
    Orders.OrderID AS "Sipariş ID'si", 
    Orders.OrderDate AS "Sipariş Tarihi"
FROM 
    Customers
FULL OUTER JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY 
    Customers.ContactName, Orders.OrderDate;


--5-Verilen Products ve Categories tablolarını kullanarak tüm ürünler ve tüm kategoriler için olası tüm kombinasyonları listeleyin. Sonuç kümesindeki her satır bir ürün ve bir kategori kombinasyonunu göstermelidir.
SELECT 
    Products.ProductName AS "Ürün", 
    Categories.CategoryName AS "Kategori"
FROM 
    Products
CROSS JOIN 
    Categories
ORDER BY 
    Products.ProductName, Categories.CategoryName;


--6-Verilen Orders, Customers, Employees tablolarını kullanarak bu tabloları birleştirin ve 1998 yılında verilen siparişleri listeleyin. Müşteri adı, sipariş ID'si, sipariş tarihi ve ilgili çalışan adı gösterilsin.
SELECT 
    Customers.ContactName AS "Müşteri Adı", 
    Orders.OrderID AS "Sipariş ID'si", 
    Orders.OrderDate AS "Sipariş Tarihi", 
    CONCAT(Employees.FirstName, ' ', Employees.LastName) AS "Çalışan Adı"
FROM 
    Orders
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID
JOIN 
    Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE 
	Orders.OrderDate BETWEEN '1998-01-01' AND '1998-12-31'
ORDER BY 
    Orders.OrderDate;


--7-Verilen Orders ve Customers tablolarını kullanarak müşterileri, verdikleri sipariş sayısına göre gruplandırın. Sadece 5’ten fazla sipariş veren müşterileri listeleyin.
SELECT 
    Customers.ContactName AS "Müşteri Adı", 
    SUM(`Order Details`.Quantity) AS "Toplam Ürün Miktarı"
FROM 
    Customers
JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
JOIN 
    `Order Details` ON Orders.OrderID = `Order Details`.OrderID
GROUP BY 
    Customers.ContactName
HAVING 
    SUM(`Order Details`.Quantity) > 5
ORDER BY 
    "Toplam Ürün Miktarı" DESC;


--8-Verilen OrderDetails ve Products tablolarını kullanarak her ürün için kaç adet satıldığını ve toplam satış miktarını listeleyin. Ürün adı, satılan toplam adet ve toplam kazancı (Quantity * UnitPrice) gösterin.
SELECT 
    Products.ProductName AS "Ürün Adı", 
    SUM(`Order Details`.Quantity) AS "Toplam Satılan Adet", 
    SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) AS "Toplam Kazanç"
FROM 
    `Order Details`
JOIN 
    Products ON  `Order Details`.ProductID = Products.ProductID
GROUP BY 
    Products.ProductName
ORDER BY 
    "Toplam Kazanç" DESC;


--9-Verilen Customers ve Orders tablolarını kullanarak, müşteri adı "B" harfiyle başlayan müşterilerin siparişlerini listeleyin.
SELECT 
    Customers.ContactName AS "Müşteri Adı", 
    Orders.OrderID AS "Sipariş ID'si", 
    Orders.OrderDate AS "Sipariş Tarihi"
FROM 
    Customers
JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
WHERE 
    Customers.ContactName LIKE 'B%'
ORDER BY 
    Orders.OrderDate;


--10-Verilen Products ve Categories tablolarını kullanarak tüm kategorileri listeleyin ve ürünleri olmayan kategorileri bulun. Ürün adı NULL olan satırları gösterin.
SELECT 
    Categories.CategoryName AS "Kategori Adı", 
    Products.ProductName AS "Ürün Adı"
FROM 
    Categories
LEFT JOIN 
    Products ON Categories.CategoryID = Products.CategoryID
WHERE 
    Products.ProductName IS NULL;


--11-Verilen Employees tablosunu kullanarak her çalışanın yöneticisiyle birlikte bir liste oluşturun.
SELECT 
    e1.FirstName || ' ' || e1.LastName AS "Çalışan", 
    e2.FirstName || ' ' || e2.LastName AS "Yöneticisi"
FROM 
    Employees e1
LEFT JOIN 
    Employees e2 ON e1.ReportsTo = e2.EmployeeID
ORDER BY 
    e1.LastName;


--12-Verilen Products tablosunu kullanarak her kategorideki en pahalı ürünleri ve bu ürünlerin farklı fiyatlara sahip olup olmadığını sorgulayın.
SELECT 
    Categories.CategoryName AS "Kategori Adı",
    Products.ProductName AS "Ürün Adı", 
    Products.UnitPrice AS "Fiyat",
    (SELECT COUNT(DISTINCT p2.UnitPrice)
     FROM Products p2
     WHERE p2.CategoryID = Products.CategoryID) AS "Farklı Fiyat Sayısı"
FROM 
    Products
JOIN 
    Categories ON Products.CategoryID = Categories.CategoryID
WHERE 
    Products.UnitPrice = (
        SELECT MAX(p2.UnitPrice)
        FROM Products p2
        WHERE p2.CategoryID = Products.CategoryID
    )
ORDER BY 
    Categories.CategoryName;


--13-Verilen Orders ve OrderDetails tablolarını kullanarak bu tabloları birleştirin ve her siparişin detaylarını sipariş ID'sine göre artan sırada listeleyin.
SELECT 
    Orders.OrderID, 
    Orders.OrderDate, 
    `Order Details`.ProductID, 
    `Order Details`.Quantity, 
    `Order Details`.UnitPrice, 
    `Order Details`.Discount
FROM 
    Orders
JOIN 
    `Order Details` ON Orders.OrderID = `Order Details`.OrderID
ORDER BY 
    Orders.OrderID ASC;


--14-Verilen Employees ve Orders tablolarını kullanarak her çalışanın kaç tane sipariş işlediğini listeleyin. Sipariş işlemeyen çalışanlar da gösterilsin.
SELECT 
    Employees.EmployeeID, 
    CONCAT(Employees.FirstName, ' ', Employees.LastName) AS "Çalışan Adı", 
    COUNT(Orders.OrderID) AS "İşlenen Sipariş Sayısı"
FROM 
    Employees
LEFT JOIN 
    Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY 
    Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY 
    "İşlenen Sipariş Sayısı" DESC;


--15-Verilen Products tablosunu kullanarak bir kategorideki ürünleri kendi arasında fiyatlarına göre karşılaştırın ve fiyatı düşük olan ürünleri listeleyin.
SELECT 
    p1.ProductName AS "Ürün Adı", 
    p1.UnitPrice AS "Fiyat", 
    p1.CategoryID AS "Kategori ID"
FROM 
    Products p1
JOIN 
    Products p2 ON p1.CategoryID = p2.CategoryID
               AND p1.UnitPrice < p2.UnitPrice
GROUP BY 
    p1.ProductName, p1.UnitPrice, p1.CategoryID
ORDER BY 
    p1.CategoryID, p1.UnitPrice;


--16-Verilen Products ve Suppliers tablolarını kullanarak tedarikçiden alınan en pahalı ürünleri listeleyin.
SELECT 
    Suppliers.CompanyName AS "Tedarikçi Adı", 
    Products.ProductName AS "Ürün Adı", 
    Products.UnitPrice AS "Fiyat"
FROM 
    Products
JOIN 
    Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE 
    Products.UnitPrice = (
        SELECT MAX(p2.UnitPrice)
        FROM Products p2
        WHERE p2.SupplierID = Products.SupplierID
    )
ORDER BY 
    Suppliers.CompanyName, Products.UnitPrice DESC;


--17-Verilen Employees ve Orders tablolarını kullanarak her çalışanın işlediği en son siparişi bulun.
SELECT 
    Employees.EmployeeID, 
    CONCAT(Employees.FirstName, ' ', Employees.LastName) AS "Çalışan Adı", 
    MAX(Orders.OrderDate) AS "En Son Sipariş Tarihi",
    Orders.OrderID AS "En Son Sipariş ID"
FROM 
    Employees
JOIN 
    Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY 
    Employees.EmployeeID, Employees.FirstName, Employees.LastName, Orders.OrderID
HAVING 
    Orders.OrderDate = (SELECT MAX(o2.OrderDate)
                        FROM Orders o2 
                        WHERE o2.EmployeeID = Employees.EmployeeID)
ORDER BY 
    Employees.EmployeeID;


--18-Verilen Products tablosunu kullanarak ürünleri fiyatlarına göre gruplandırın ve fiyatı 20 birimden fazla olan ürünlerin sayısını listeleyin.
SELECT 
    CASE 
        WHEN UnitPrice <= 10 THEN '0 - 10 Birim'
        WHEN UnitPrice > 10 AND UnitPrice <= 20 THEN '11 - 20 Birim'
        WHEN UnitPrice > 20 AND UnitPrice <= 30 THEN '21 - 30 Birim'
        ELSE '30 Birimden Fazla'
    END AS "Fiyat Grubu",
    COUNT(*) AS "Ürün Sayısı"
FROM 
    Products
GROUP BY 
    "Fiyat Grubu"
ORDER BY 
    "Fiyat Grubu";


--19-Verilen Orders ve Customers tablolarını kullanarak 1997 ile 1998 yılları arasında verilen siparişleri müşteri adıyla birlikte listeleyin.
SELECT 
    Customers.ContactName AS "Müşteri Adı", 
    Orders.OrderID AS "Sipariş ID'si", 
    Orders.OrderDate AS "Sipariş Tarihi"
FROM 
    Orders
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID
WHERE 
    Orders.OrderDate BETWEEN '1997-01-01' AND '1998-12-31'
ORDER BY 
    Orders.OrderDate;


--20-Verilen Customers ve Orders tablolarını kullanarak hiç sipariş vermeyen müşterileri listeleyin.-
SELECT 
    Customers.ContactName AS "Müşteri Adı", 
    Customers.CustomerID AS "Müşteri ID"
FROM 
    Customers
LEFT JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
WHERE 
    Orders.OrderID IS NULL;