CREATE DATABASE CustomerOrderViewer;
GO

USE CustomerOrderViewer;
GO

CREATE TABLE [dbo].[Customer] (
	CustomerId INT IDENTITY(1, 1) NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	MiddleName VARCHAR(50) NULL,
	LastName VARCHAR(50) NOT NULL,
	Age INT NOT NULL,
	PRIMARY KEY (CustomerId)
);
GO

CREATE TABLE [dbo].[Item] (
	ItemId INT IDENTITY(1, 1) NOT NULL,
	[Description] VARCHAR(100) NOT NULL,
	Price DECIMAL(4, 2) NOT NULL,
	PRIMARY KEY (ItemId)
);
GO

CREATE TABLE [dbo].[CustomerOrder] (
	CustomerOrderId INT IDENTITY(1,1) NOT NULL,
	CustomerId INT NOT NULL,
	ItemId INT NOT NULL,
	PRIMARY KEY (CustomerOrderId),
	FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
	FOREIGN KEY (ItemId) REFERENCES Item (ItemId)
);
GO

INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Lawrence', NULL, 'Keener', 27);
INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Lynette', NULL, 'Snyder', 34);
INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Jesus', NULL, 'Dimick', 34);
INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Betty', NULL, 'Hall', 21);
INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Maryann', NULL, 'Castro', 43);
INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Michael ', NULL, 'Cooper', 45);
INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Alfred', NULL, 'Cervantes', 21);
INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Megan', NULL, 'Read', 22);
INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Melissa', NULL, 'Sherlock', 31);
INSERT INTO [dbo].[Customer] (FirstName, MiddleName, LastName, Age) VALUES ('Kori', NULL, 'Higgins', 57);

INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('Duracell Alkaline AA Batteries', 15.99);
INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('Kirkland Signature Moist Flushable Wipes', 14.99);
INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('Carnation Breakfast Essentials', 12.59);
INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('Capri Sun Variety Pack', 7.99);
INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('Mott''s Clamato Juice', 11.79);
INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('Dr. Pepper', 9.99);
INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('Mountain Dew', 9.99);
INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('Pepsi Cola', 9.99);
INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('Sprite', 10.99);
INSERT INTO [dbo].[Item] ([Description], Price) VALUES ('San Pellegrino Mineral Water', 17.99);

INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (1, 1);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (1, 2);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (1, 3);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (1, 4);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (1, 5);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (1, 6);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (2, 1);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (2, 2);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (2, 3);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (3, 1);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (4, 1);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (4, 2);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (5, 1);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (6, 1);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (6, 2);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (7, 1);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (7, 2);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (8, 1);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (8, 2);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (9, 1);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (9, 2);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (9, 3);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (9, 4);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (9, 5);
INSERT INTO [dbo].[CustomerOrder] (CustomerId, ItemId) VALUES (9, 6);
GO -- End the batch

CREATE VIEW [dbo].[CustomerOrderDetail] AS
	SELECT
		t1.CustomerOrderId,
		t2.CustomerId,
		t3.ItemId,
		t2.FirstName,
		t2.LastName,
		t3.[Description],
		t3.Price
	FROM
		dbo.CustomerOrder t1
	INNER JOIN
		dbo.Customer t2 ON t2.CustomerId = t1.CustomerId
	INNER JOIN
		dbo.Item t3 ON t3.ItemId = t1.ItemId;
GO