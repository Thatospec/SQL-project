create database looping;
go
use looping;
go

CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4,2),
    salary DECIMAL(10,2)   
);

GO

CREATE TABLE multiplicationTable(
num int,
symbol varchar(10),
multiplyer int,
result int
);
go

INSERT INTO salesman (salesman_id, name, city, commission, salary) VALUES
(5001, 'James Hoog', 'New York', 0.15, 50000.00),
(5002, 'Nail Knite', 'Paris', 0.13, 42000.00),
(5005, 'Pit Alex', 'London', 0.11, 39000.00),
(5006, 'Mc Lyon', 'Paris', 0.14, 45000.00),
(5007, 'Paul Adam', 'Rome', 0.13, 40000.00),
(5003, 'Lauson Hen', 'San Jose', 0.12, 38000.00);

go

CREATE PROCEDURE multiply @multiplyer INT
AS BEGIN
DECLARE @i INT = 0;
WHILE @i <= 9
BEGIN
PRINT CONCAT(@multiplyer, ' x ', @i, ' = ', @multiplyer * @i);
SET @i = @i + 1;
END
END;
GO

DECLARE @multiplyer INT = 5;
DECLARE @i INT = 1;
WHILE @i <= 10
BEGIN
INSERT INTO multiplicationTable (num, symbol, multiplyer, result)
VALUES (@multiplyer, 'x', @i, @multiplyer * @i);
SET @i = @i + 1;
END;

DECLARE @minID INT, @maxID INT, @currentID INT;
SELECT @minID = MIN(salesman_id), @maxID = MAX(salesman_id)
FROM salesman;
SET @currentID = @minID;
WHILE @currentID <= @maxID
BEGIN
UPDATE salesman
SET salary = salary * 1.10
WHERE salesman_id = @currentID;
SET @currentID = @currentID + 1;
END;

DECLARE @salesman_id INT, @current_commission DECIMAL(4,2);
DECLARE commission_cursor CURSOR FOR
SELECT salesman_id, commission
FROM salesman;
OPEN commission_cursor;
FETCH NEXT FROM commission_cursor INTO @salesman_id, @current_commission;
WHILE @@FETCH_STATUS = 0
BEGIN
IF @current_commission < 0.13
BEGIN
UPDATE salesman
SET commission = commission * 1.10
WHERE salesman_id = @salesman_id;
END
FETCH NEXT FROM commission_cursor INTO @salesman_id, @current_commission;
END
CLOSE commission_cursor;
DEALLOCATE commission_cursor;
