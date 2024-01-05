-- Crear la base de datos Northwind
-- Realizar las sentencias de SQL para resolver cada uno de los ejercicios que se encuentran a continuacion



-- 1. Obtener el monto total pagado por cada orden de compra hecha solo en julio de 1996. Redondear el monto total a 2 decimales y mostrar primero los registros con mayor monto.

SELECT ROUND(ExtendedPrice, 2) AS TotalPagado FROM
Orders AS o, [Order Details Extended] AS ode
WHERE o.ShippedDate BETWEEN '1996-07-01' AND '1996-07-31'
ORDER BY ExtendedPrice DESC;

-- 2. Mostrar el nombre de todos los proveedores, así como el precio máximo y mínimo de los productos que suministra.

SELECT ContactName , MAX(UnitPrice) AS MaxPrice, MIN(UnitPrice) AS MinPrice
FROM Suppliers AS s, Products AS p
WHERE s.SupplierID = p.SupplierID
GROUP BY ContactName;

-- 3. Obtener el stock total de los productos por cada categoría. Mostrar el nombre de la categoría y el stock por categoría. Solamente las categorías 2, 5 y 8.

SELECT CategoryName , SUM(UnitPrice) AS Stock
FROM Categories AS c, Products AS p
WHERE c.CategoryID = p.CategoryID AND (c.CategoryID = 2 OR
c.CategoryID = 5 OR c.CategoryID = 8)
GROUP BY CategoryName;

-- 4. Mostrar el número de órdenes realizadas de cada uno de los clientes por año.

SELECT c.CustomerID , COUNT(OrderID) AS NumOrders
FROM Customers AS c, Orders AS o
WHERE c.CustomerID = o.CustomerID
GROUP BY c.CustomerID;

-- 5. Crea una vista que muestre el nombre del país y el total de clientes que existen en cada uno. Incluye el código para crear la vista y una consulta hacia la vista.

CREATE VIEW ClientsPerCountry AS
(SELECT Country , COUNT(OrderID) AS NumOrders
FROM Customers AS c, Orders AS o
WHERE c.CustomerID = o.CustomerID
GROUP BY Country);

-- 6. Crea una vista que muestre los datos de cada cliente, así como el número de órdenes realizadas cada año. Incluye el código para crear la vista y una consulta hacia la vista.

CREATE VIEW ClientOrders AS
(SELECT CustomerID , CompanyName , ContactName ,
ContactTitle , Address , City , Region , PostalCode ,
Country , Phone , Fax
FROM Customers);
