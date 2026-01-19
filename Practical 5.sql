create database procedurePrac;
go
use procedurePrac;
go


CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

go

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002,  65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005,2400.60, '2012-07-27', 3007, 5001),
(70008,5760.00, '2012-09-10', 3002, 5001),
(70010,1983.43, '2012-10-10', 3004, 5006),
(70003,2480.40, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011,  75.29, '2012-08-17', 3003, 5007),
(70013,3045.60, '2012-04-25', 3002, 5001);

CREATE TABLE item_mast (
    pro_id INT PRIMARY KEY,
    pro_name VARCHAR(50),
    pro_price DECIMAL(10,2),
    pro_com INT
);

go

INSERT INTO item_mast (pro_id, pro_name, pro_price, pro_com) VALUES
(101, 'Mother Board',     3200.00, 15),
(102, 'Key Board',         450.00, 16),
(103, 'ZIP drive',         250.00, 14),
(104, 'Speaker',           550.00, 16),
(105, 'Monitor',          5000.00, 11),
(106, 'DVD drive',         900.00, 12),
(107, 'CD drive',          800.00, 12),
(108, 'Printer',          2600.00, 13),
(109, 'Refill cartridge',  350.00, 13),
(110, 'Mouse',             250.00, 12);


go

CREATE PROCEDURE sp_HighestPurchase_Customer AS BEGIN
SELECT customer_id,MAX(purch_amt) AS highest_purchase
FROM orders
WHERE ord_date = '2012-08-17' AND salesman_id = 5003
GROUP BY customer_id;
END;
GO

CREATE PROCEDURE sp_AveragePurchaseAboveThreshold @Threshold DECIMAL(10,2) AS BEGIN
SELECT AVG(purch_amt) AS average_purchase
FROM orders
WHERE purch_amt > @Threshold;
END;
GO

CREATE PROCEDURE sp_MaxPurchase_CustomerInRange @StartID INT,@EndID INT,@Threshold DECIMAL(10,2)
AS BEGIN
SELECT customer_id,
MAX(purch_amt) AS max_purchase
FROM orders
WHERE customer_id BETWEEN @StartID AND @EndID
GROUP BY customer_id
HAVING MAX(purch_amt) > @Threshold;
END;
GO

CREATE PROCEDURE sp_MaxPurchase_SalespersonRange @StartSalesmanID INT,@EndSalesmanID INT
AS BEGIN
SELECT salesman_id, MAX(purch_amt) AS max_purchase
FROM orders
WHERE salesman_id BETWEEN @StartSalesmanID AND @EndSalesmanID
GROUP BY salesman_id;
END;
GO

CREATE PROCEDURE sp_AvgPrice_ByCompany @CompanyID INT
AS BEGIN
SELECT AVG(pro_price) AS average_product_price
FROM item_mast
WHERE pro_com = @CompanyID;
END;
GO