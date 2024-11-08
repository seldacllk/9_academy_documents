SELECT * FROM Products where 5>=supplierid>=1 ; --Tedarikçi ID'si 1 ile 5 arasındaki ürünler
SELECT * FROM Products  WHERE SupplierID IN (1, 2, 4, 5); --Tedarikçi ID'si 1, 2, 4 veya 5 olan ürünler
SELECT * FROM Products WHERE ProductName = 'Chang' OR ProductName = 'Aniseed Syrup';--Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünler
SELECT * FROM Products WHERE SupplierID = 3 OR UnitPrice > 10; --Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük ürünler
SELECT ProductName, UnitPrice FROM Products; --Ürün adı ve birim fiyatı ile birlikte getirme
SELECT * FROM Products WHERE UPPER(ProductName) LIKE '%C%'; -- Büyük harfe dönüştürerek 'c' harfi içeren ürünler
SELECT * FROM Products WHERE ProductName LIKE 'N%'; --'n' ile başlayan ve tek karakterli bir harf içeren ürünler
SELECT * FROM Products WHERE UnitsInStock > 50;--Stok miktarı 50'den fazla olan ürünler
SELECT * FROM Products WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products) OR UnitPrice = (SELECT MIN(UnitPrice) FROM Products);--Ürünlerin en yüksek ve en düşük birim fiyatları
SELECT * FROM Products WHERE ProductName LIKE '%Spice%'; --Ürün adında 'Spice' kelimesi geçen ürünler


SELECT * FROM Products;