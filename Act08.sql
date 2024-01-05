-- Crear la base de datos Northwind
-- Realizar las sentencias de SQL para resolver cada uno de los ejercicios que se encuentran a continuacion



-- 1. Crear una función que retorne el monto total de una orden de compra determinada.

-- Function
CREATE FUNCTION dbo.OBTAINTOTALORDER
( @OrdenAiDi INT )

RETURNS MONEY
AS
BEGIN

DECLARE @OrdenTotal MONEY;

SELECT @OrdenTotal = SUM( (UnitPrice) * (Quantity) * (1-Discount) )
FROM [Order Details] AS od
INNER JOIN Orders AS o ON od.OrderID = o.OrderID
WHERE o.OrderID = @OrdenAiDi
GROUP BY o.OrderID;
RETURN @OrdenTotal;

END;

-- Query 
SELECT OrderID , dbo.OBTAINTOTALORDER(OrderId) AS TotalOrden FROM Orders WHERE OrderID=10248;

-- 2. Crear una función que devuelva el número de días que transcurren entre la fecha de orden y la fecha de embarque para una orden de compra determinada.

-- Function
CREATE FUNCTION dbo.DAYDIFFERENCE(@OrderID INT)

RETURNS INT
AS
BEGIN

DECLARE @OrderDate DATETIME, @ShippedDate DATETIME, @Days INT

SELECT @OrderDate = OrderDate, @ShippedDate = ShippedDate
FROM Orders
WHERE OrderID = @OrderID
SET @Days = DATEDIFF(DAY, @OrderDate, @ShippedDate)
RETURN @Days;

END;

-- Query
SELECT OrderID, dbo.DAYDIFFERENCE(OrderID) AS DaysBetweenOrderAndShippedDate FROM Orders
WHERE OrderID=10248;

-- 3. Crear un procedimiento almacenado para agregar un nuevo cliente.

-- Procedure
CREATE PROC ADDCUSTOMER
@CustomerID nchar(5),
@CompanyName nvarchar(40) = NULL,
@ContactName nvarchar(30) = NULL,
@ContactTitle nvarchar(30) = NULL,
@Address nvarchar(60) = NULL,
@City nvarchar(15) = NULL,
@Region nvarchar(15) = NULL,
@PostalCode nvarchar(10) = NULL,
@Country nvarchar(15) = NULL,
@Phone nvarchar(24) = NULL,
@Fax nvarchar(24) = NULL
AS
BEGIN

INSERT INTO Customers (
CustomerID,
CompanyName,
ContactName,
ContactTitle,
Address,
City,
Region,
PostalCode,
Country,
Phone,
Fax
) VALUES (
@CustomerID,
@CompanyName,
@ContactName,
@ContactTitle,
@Address,
@City,
@Region,
@PostalCode,
@Country,
@Phone,
@Fax
);

END;

-- Query
EXEC ADDCUSTOMER 'ZONIK', 'Zonikal Electrics', 'John Smith', 'Vicepresident', 'Daisy 292', 'Ljubljana', NULL,
'22122', 'Slovenia', '0000 000 000', NULL;

-- 4. Crear un procedimiento almacenado para incrementar el precio de los productos que pertenezcan a determinada categoría (solo actualizar los productos que no estén descontinuados). Mandar como parámetro el porcentaje de incremento del precio
-- **Por ejemplo aumentar un 15% los precios de los productos cuya categoría es (3)Confections

-- Procedure
CREATE PROCEDURE INCPRICEPERCATEGORY
@CategoryID INT,
@IncPercentage INT

AS
BEGIN

UPDATE Products
SET UnitPrice = UnitPrice * (1 + (@IncPercentage / 100))
WHERE CategoryID = @CategoryID AND Discontinued = 0;

END;

-- Query
EXEC INCPRICEPERCATEGORY 3, 15;
