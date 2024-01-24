--1).
SELECT ProductID,ProductName,UnitPrice from Products WHERE UnitPrice < 20
--2).
SELECT ProductID,ProductName,UnitPrice from Products WHERE UnitPrice between 15 and 25
--3).
SELECT ProductID,ProductName,UnitPrice from Products WHERE UnitPrice > (SELECT avg(UnitPrice) from Products)
--4).
SELECT TOP 10  ProductID,ProductName,UnitPrice from Products ORDER BY UnitPrice DESC
--5).
SELECT * from Products WHERE UnitsInStock < UnitsOnOrder