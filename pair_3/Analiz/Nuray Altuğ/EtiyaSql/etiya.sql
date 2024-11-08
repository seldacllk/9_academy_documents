1. SELECT * 
   FROM Products 
   WHERE SupplierID BETWEEN 1 AND 5;
2. SELECT * 
   FROM Products 
   WHERE SupplierID IN (1, 2, 4, 5);
3. SELECT * 
   FROM Products 
   WHERE ProductName IN ('Chang', 'Aniseed Syrup');
4. SELECT * 
   FROM Products 
   WHERE SupplierID = 3 OR UnitPrice > 10;

5.SELECT ProductName, UnitPrice 
  FROM Products;

6.SELECT ProductName
   FROM Products 
   WHERE UPPER(ProductName) LIKE '%C%';

7.SELECT ProductName
  FROM Products
  WHERE ProductName LIKE 'n_';

8.SELECT * 
 FROM Products 
 WHERE UnitsInStock > 50;

9. SELECT * 
   FROM Products 
   WHERE UnitPrice = (SELECT MAX(UnitPrice) AS MaxPrice FROM Products)
      OR UnitPrice = (SELECT MIN(UnitPrice) AS MinPrice FROM Products);

10. SELECT * 
    FROM Products 
    WHERE ProductName LIKE '%Spice%';

------------------WORKSHOP2---------------------------------------------
1. SELECT CategoryID, COUNT(*) AS ProductCount
   FROM Products
   GROUP BY CategoryID;

2. SELECT * 
   FROM Products
   ORDER BY UnitPrice DESC
   LIMIT 5;

3.SELECT SupplierID, AVG(UnitPrice) AS AveragePrice
  FROM Products
  GROUP BY SupplierID;

4. SELECT CategoryID, AVG(UnitPrice) AS AveragePrice
   FROM Products
   WHERE UnitPrice > 100
   GROUP BY CategoryID;

5. SELECT * 
   FROM [Order Details]
   WHERE (UnitPrice * Quantity) > 1000;

6. SELECT * 
   FROM Orders
   WHERE ShippedDate IS NOT NULL
   ORDER BY ShippedDate DESC
   LIMIT 10;

7.SELECT AVG(UnitPrice) AS AveragePrice
  FROM Products;

8.SELECT SUM(UnitsInStock) AS TotalStock
  FROM Products
  WHERE UnitPrice > 50;

9.SELECT MIN(OrderDate) AS OldestOrderDate
  FROM Orders;

10. SELECT EmployeeID, 
       FirstName, 
       LastName, 
       HireDate,
       FLOOR((julianday('now') - julianday(HireDate)) / 365.25) AS YearsEmployed
   FROM Employees;


11. SELECT OrderID, 
    ROUND(SUM(UnitPrice * Quantity), 0) AS RoundedTotalPrice
    FROM [Order Details]
    GROUP BY OrderID;

12. SELECT COUNT(*) AS NumberOfProductsInStock
    FROM Products
    WHERE UnitsInStock > 0;

13.SELECT MIN(UnitPrice) AS LowestPrice, 
   MAX(UnitPrice) AS HighestPrice
   FROM Products;

14. SELECT strftime('%Y', OrderDate) AS OrderYear, 
       COUNT(*) AS NumberOfOrders
    FROM Orders
    GROUP BY strftime('%Y', OrderDate)
    ORDER BY OrderYear;

15. SELECT FirstName || ' ' || LastName AS FullName
    FROM Employees;

16. SELECT City, LENGTH(City) AS CityLength
    FROM Customers;

17. SELECT ProductID, 
       ProductName, 
       ROUND(UnitPrice, 2) AS RoundedPrice
    FROM Products;

18. SELECT COUNT(*) AS TotalOrders
    FROM Orders;

19. SELECT CategoryID, 
       AVG(UnitPrice) AS AveragePrice
    FROM Products
    GROUP BY CategoryID;

20. SELECT 
    (COUNT(CASE WHEN ShippedDate IS NULL THEN 1 END) * 100.0 / COUNT(*)) AS PercentageUnshipped
    FROM Orders;

21.SELECT ProductName, 
       UnitPrice AS OriginalPrice, 
       ROUND(UnitPrice * 1.10, 2) AS PriceIncreased
   FROM Products
   ORDER BY UnitPrice DESC
   LIMIT 1;

22. SELECT ProductName, 
    substr(ProductName, 1, 3) AS FirstThreeChars
    FROM Products;

23.SELECT strftime('%Y', OrderDate) AS OrderYear, 
       strftime('%m', OrderDate) AS OrderMonth, 
       COUNT(*) AS NumberOfOrders
   FROM Orders
   GROUP BY strftime('%Y', OrderDate), strftime('%m', OrderDate)
   ORDER BY OrderYear, OrderMonth;

24. SELECT OrderID, 
       ROUND(SUM(UnitPrice * Quantity), 2) AS TotalOrderValue
    FROM [Order Details]
    GROUP BY OrderID;

25. SELECT ROUND(SUM(UnitPrice), 2) AS TotalStockValue
    FROM Products
    WHERE UnitsInStock = 0;


------------------------WORKSHOP3-------------------------------------------------

1. SELECT Customers.ContactName AS CustomerName, 
       Orders.OrderID, 
       Orders.OrderDate
   FROM Customers
   JOIN Orders 
   ON Customers.CustomerID = Orders.CustomerID;

2.SELECT Suppliers.CompanyName, 
       Products.ProductName
  FROM Suppliers
  LEFT JOIN Products 
  ON Suppliers.SupplierID = Products.SupplierID;

3. SELECT Orders.OrderID, 
       Orders.OrderDate, 
       Employees.EmployeeID, 
       Employees.FirstName, 
       Employees.LastName
   FROM Orders
   LEFT JOIN Employees 
   ON Orders.EmployeeID = Employees.EmployeeID;

4. SELECT Customers.CustomerID, 
       Customers.ContactName, 
       Orders.OrderID, 
       Orders.OrderDate
  FROM Customers
  FULL OUTER JOIN Orders 
  ON Customers.CustomerID = Orders.CustomerID;

5. SELECT Products.ProductName, 
       Categories.CategoryName
   FROM Products
   CROSS JOIN Categories;

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

8. SELECT
   p.ProductName,
   SUM(od.Quantity) AS TotalQuantitySold,
   SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
   FROM
   [Order Details] od
   JOIN Products p ON od.ProductID = p.ProductID
   GROUP BY
   p.ProductName;

9.SELECT
  c.ContactName,
  o.OrderID,
  o.OrderDate
FROM
Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE
c.ContactName LIKE 'B%';

10.SELECT
  c.CategoryID,
  c.CategoryName,
  p.ProductName
  FROM
  Categories c
  LEFT JOIN Products p ON c.CategoryID = p.CategoryID
  WHERE
  p.ProductName IS NULL;

11. SELECT 
   e.EmployeeID AS EmployeeID,
   e.FirstName || ' ' || e.LastName AS EmployeeName,
   m.EmployeeID AS ManagerID,
   m.FirstName || ' ' || m.LastName AS ManagerName
   FROM 
   Employees e
   LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID;

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

18. SELECT
   COUNT(*) AS NumberOfProducts
   FROM
   Products
   WHERE
   UnitPrice > 20;

19. SELECT
   c.ContactName,
   o.OrderID,
   o.OrderDate
   FROM
   Orders o
   JOIN Customers c ON o.CustomerID = c.CustomerID
   WHERE
   o.OrderDate BETWEEN '2013-01-01' AND '2018-12-31';

20. SELECT
   c.CustomerID,
   c.ContactName
   FROM
   Customers c
   LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
   WHERE
   o.OrderID IS NULL;


----------------------------WORKSHOP4---------------------------------------------------------------

1.SELECT 
  ProductName, 
  UnitPrice 
FROM 
  Products 
ORDER BY 
  UnitPrice DESC 
LIMIT 1;

2. SELECT 
  OrderID, 
  CustomerID, 
  OrderDate 
FROM 
  Orders 
ORDER BY 
  OrderDate DESC 
LIMIT 1;

3. SELECT 
  ProductName, 
  UnitPrice 
FROM 
  Products 
WHERE 
  UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

4. SELECT 
  ProductName, 
  CategoryID, 
  UnitPrice 
FROM 
  Products 
WHERE 
  CategoryID IN (1, 2, 3); -- Kategori ID'lerini buraya yazabilirsiniz.

5. SELECT 
  CategoryID, 
  MAX(UnitPrice) AS MaxPrice 
FROM 
  Products 
GROUP BY 
  CategoryID 
ORDER BY 
  MaxPrice DESC;

6.  SELECT c.CustomerID, c.ContactName, o.OrderID, c.Country
   FROM Customers c
   JOIN Orders o ON c.CustomerID = o.CustomerID
   WHERE c.Country = 'Germany';

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

14. SELECT 
     CategoryID, 
     COUNT(*) AS TotalProducts 
   FROM 
     Products 
   GROUP BY 
     CategoryID 
   HAVING 
     TotalProducts > 15;

15. SELECT c.CustomerID, c.CompanyName, COUNT(DISTINCT od.ProductID) AS UniqueProducts
   FROM Customers c
   JOIN Orders o ON c.CustomerID = o.CustomerID
   JOIN "Order Details" od ON o.OrderID = od.OrderID
   GROUP BY c.CustomerID, c.CompanyName
   HAVING COUNT(DISTINCT od.ProductID) <= 2;

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

18.  SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(od.Quantity * p.UnitPrice) AS TotalOrderValue
   FROM Employees e
   JOIN Orders o ON e.EmployeeID = o.EmployeeID
   JOIN "Order Details" od ON o.OrderID = od.OrderID
   JOIN Products p ON od.ProductID = p.ProductID
   GROUP BY e.EmployeeID, e.FirstName, e.LastName
   HAVING SUM(od.Quantity * p.UnitPrice) > 10000;

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

22.  SELECT p.ProductID, p.ProductName, p.CategoryID, SUM(od.Quantity) AS TotalOrdered
   FROM Products p
   JOIN "Order Details" od ON p.ProductID = od.ProductID
   JOIN Orders o ON od.OrderID = o.OrderID
   GROUP BY p.ProductID, p.ProductName, p.CategoryID
   ORDER BY TotalOrdered DESC
   LIMIT 1;






















