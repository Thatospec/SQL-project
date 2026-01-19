create database trigger_base;
go
use trigger_base;
go

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    list_price DECIMAL(10,2),
    quantity_in_stock INT
);
go
INSERT INTO products (product_id, product_name, list_price, quantity_in_stock) VALUES
(101, 'Laptop', 1200.00, 10),
(102, 'Mouse', 25.00, 100),
(103, 'Keyboard', 45.00, 50),
(104, 'Monitor', 250.00, 30);
go

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    product_id INT FOREIGN KEY REFERENCES products(product_id)
);

go
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id, product_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002, 102), 
(70009, 270.65, '2012-09-10', 3001, 5005, 104), 
(70002, 65.26,  '2012-10-05', 3002, 5001, 103), 
(70004, 110.50, '2012-08-17', 3009, 5003, 102),
(70007, 948.50, '2012-09-10', 3005, 5002, 101),
(70005, 2400.60,'2012-07-27', 3007, 5001, 101),
(70008, 5760.00,'2012-09-10', 3002, 5001, 104),
(70010, 1983.43,'2012-10-10', 3004, 5006, 101),
(70003, 2480.40,'2012-10-10', 3009, 5003, 103),
(70012, 250.45, '2012-06-27', 3008, 5002, 102),
(70011, 75.29,  '2012-08-17', 3003, 5007, 103),
(70013, 3045.60,'2012-04-25', 3002, 5001, 104);

go

create table order_logs(
	ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
	updated_at datetime default getdate()
);

go

create trigger orders_insert on orders
after insert as begin 
insert into order_logs(ord_no, purch_amt,ord_date,customer_id,salesman_id)
select ord_no,purch_amt,ord_date,customer_id,salesman_id
from inserted
end;
go

insert into orders(ord_no,purch_amt,ord_date,customer_id,salesman_id,product_id)
values (70014,500.00,'2012-11-01',3010,5008,103);

select * from order_logs;
go

drop trigger orders_insert;

CREATE TRIGGER prevent_delete
ON orders
INSTEAD OF DELETE 
AS BEGIN
PRINT 'Deletion of orders are not allowed';
END;
GO

DELETE FROM orders WHERE ord_no = 70001;
SELECT * FROM orders;
go

DROP TRIGGER prevent_delete;
go

create trigger update_product_stock
on orders
after insert
as begin 
update p
set p.quantity_in_stock = p.quantity_in_stock -1
from products p 
inner join inserted i on p.product_id = i.product_id
end;
go

insert into orders(ord_no,purch_amt,ord_date,customer_id,salesman_id,product_id)
values (70015,1200.00,'2012-11-05',3011,5009,101);

select * from products;
select * from orders;
go

drop trigger update_product_stock;
go