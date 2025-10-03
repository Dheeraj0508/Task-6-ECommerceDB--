SQL TASK 6 — SUBQUERIES AND NESTED QUERIES

USE ECommerceDB;

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product VARCHAR(100),
    Amount DECIMAL(10,2),
    Order_Date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

INSERT INTO Customers VALUES
(1, 'Amit', 'India'),
(2, 'John', 'USA'),
(3, 'Priya', 'India'),
(4, 'Emily', 'UK');

INSERT INTO Orders VALUES
(101, 1, 'Laptop', 75000.00, '2025-09-01'),
(102, 2, 'Phone', 55000.00, '2025-09-05'),
(103, 1, 'Mouse', 1500.00, '2025-09-10'),
(104, 3, 'Tablet', 30000.00, '2025-09-15');

SELECT First_Name,
       (SELECT SUM(Amount) FROM Orders WHERE Orders.Customer_ID = Customers.Customer_ID) AS Total_Spent
FROM Customers;

SELECT * FROM Customers
WHERE Customer_ID IN (SELECT DISTINCT Customer_ID FROM Orders);

SELECT * FROM Customers c
WHERE EXISTS (
    SELECT 1 FROM Orders o WHERE o.Customer_ID = c.Customer_ID
);

SELECT First_Name, AvgOrder
FROM (
    SELECT Customer_ID, AVG(Amount) AS AvgOrder
    FROM Orders
    GROUP BY Customer_ID
) AS OrderSummary
JOIN Customers ON Customers.Customer_ID = OrderSummary.Customer_ID;

SELECT * FROM Orders o
WHERE Amount > (
    SELECT AVG(Amount)
    FROM Orders
    WHERE Customer_ID = o.Customer_ID
);