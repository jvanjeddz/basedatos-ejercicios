-- Crear la base de datos Northwind
-- Realizar las sentencias de SQL para resolver cada uno de los ejercicios que se encuentran a continuacion



-- 1. Agregar un proveedor con los datos del alumno, dejando vacíos los campos de región, código postal y número de fax

INSERT INTO Suppliers (CompanyName, ContactName, ContactTitle, Address, City, Country, Phone,
HomePage)
VALUES ('Google', 'John Doe', 'Vice President', 'Av. Palo s/n. Alto',
'San Francisco', 'Mexico', '(999) 999-9999', 'Google #https://www.google.com/')

-- 2. Agregar tres productos asociados al proveedor creado en el punto anterior.

INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit,
UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
VALUES ('Monster Energy', 31, 1, '6 - 473 ml cans', 9, 360, 57, 5, 0);

INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit,
UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
VALUES ('Limonada', 31, 1, '6 - 600 ml bottles', 7, 30, 7, 6, 0);

INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit,
UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
VALUES ('Gomitas', 31, 4, '1 kg pkg', 4, 580, 87, 3, 0);

-- 3. Incrementar la existencia en un 15% de los productos que pertenecen a la categoría 'Beverages'.

UPDATE Products SET UnitsInStock = UnitsInStock * 1.15
WHERE CategoryID = 1

-- 4. Asignar la fecha de envío 01 de febrero de 2020 a todas las órdenes cuya fecha sea nula.

UPDATE Orders SET ShippedDate = '2023-02-01'
WHERE ShippedDate IS NULL

-- 5. Eliminar todos los productos descontinuados.

DELETE FROM Products WHERE Discontinued = 1;

-- 6. Obtener una lista, ordenada alfabéticamente, de los productos que tienen existencia y pertenecen a las categorías Beverages y Condiments. Mostrar la clave de producto, su nombre, la cantidad en existencia y el nombre de la compañía que lo provee.

SELECT ProductID , ProductName , UnitsInStock , CompanyName
FROM Products AS p, Suppliers AS s
WHERE p.SupplierID = s.SupplierID AND UnitsInStock > 0
AND (CategoryID = 1 OR CategoryID = 2)
ORDER BY ProductName ASC;

-- 7. Obtener una lista de todas las órdenes que se enviaron a México. Mostrar la clave de la orden, el nombre de la compañía del cliente, la ciudad de envío y la fecha de envío. Ordenar la información, de forma ascendente, por fecha de envío.

SELECT OrderID , CompanyName , ShipCity , ShippedDate
FROM Orders AS o, Customers AS c
WHERE o.CustomerID = c.CustomerID AND ShipCountry = 'Mexico'
ORDER BY ShippedDate ASC;

-- 8. Obtener una lista, ordenada alfabéticamente por categoría, de todos los productos con un precio unitario menor a 30 dólares. Mostrar la clave de producto, su nombre, el precio unitario, el nombre de la compañía que lo provee y el nombre de la categoría a la que pertenece

SELECT ProductID , ProductName , UnitPrice , CompanyName ,CategoryName
FROM Products AS p, Categories AS c, Suppliers AS s
WHERE p.CategoryID = c.CategoryID AND p.SupplierID = s.SupplierID AND UnitPrice < 30
ORDER BY CategoryName ASC
