1- SELECT c.ContactName, o.OrderID, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;
 
 2. SELECT s.ContactName, p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON s.SupplierID = p.SupplierID;
 
3.SELECT o.OrderID, o.OrderDate, e.FirstName,e.LastName
FROM Orders o
LEFT JOIN Employees e ON o.EmployeeID = e.EmployeeID;
 
4. SELECT c.ContactName, o.OrderID, o.OrderDate
FROM Customers c
FULL OUTER JOIN Orders o ON c.CustomerID = o.CustomerID;
 
 5.SELECT p.ProductName, c.CategoryName
FROM Products p
CROSS JOIN Categories c;
 
 6. SELECT c.ContactName, o.OrderID, o.OrderDate, e.FirstName,e.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE strftime('%Y', o.OrderDate) = '2015';
 
 7.SELECT c.ContactName, COUNT(o.OrderID) as OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
HAVING OrderCount > 5;
 
8. SELECT p.ProductName, SUM(od.Quantity) as TotalQuantity, SUM(od.Quantity * od.UnitPrice) as TotalRevenue
FROM "Order Details" od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName;
 
 9.SELECT c.ContactName, o.OrderID, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.ContactName LIKE 'B%';
 
 10. SELECT c.CategoryName, p.ProductName
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
WHERE p.ProductName IS NULL;
 
 11.SELECT e.FirstName,e.lastname as Employee, m.FirstName,m.LastName as Manager
FROM Employees e
LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID;
 
 12. SELECT p1.CategoryID, p1.ProductName, p1.UnitPrice
FROM Products p1
WHERE p1.UnitPrice = (SELECT MAX(p2.UnitPrice) FROM Products p2 WHERE p2.CategoryID = p1.CategoryID);
 
13- SELECT o.OrderID, od.ProductID, od.Quantity, od.UnitPrice
FROM Orders o
JOIN "Order Details" od ON o.OrderID = od.OrderID
ORDER BY o.OrderID;
 
 14.
SELECT e.FirstName,e.LastName, COUNT(o.OrderID) as OrderCount
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName;
 
15.  
SELECT p1.ProductName, p1.UnitPrice
FROM Products p1
WHERE p1.UnitPrice < (SELECT AVG(p2.UnitPrice) FROM Products p2 WHERE p2.CategoryID = p1.CategoryID);
 
 16.
SELECT s.CompanyName, p.ProductName, p.UnitPrice
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
WHERE p.UnitPrice = (SELECT MAX(p2.UnitPrice) FROM Products p2 WHERE p2.SupplierID = p.SupplierID);
 
 17.
SELECT e.FirstName,e.LastName, o.OrderID, o.OrderDate
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate = (SELECT MAX(o2.OrderDate) FROM Orders o2 WHERE o2.EmployeeID = e.EmployeeID);
 
18.
SELECT COUNT(*) as ProductCount
FROM Products
WHERE UnitPrice > 20;
 
19.
SELECT c.ContactName, o.OrderID, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate BETWEEN strftime('%Y', o.OrderDate) = '2013' tme('%Y', o.OrderDate) = '2020';
 
 20. SELECT c.ContactName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
 
 
 
 