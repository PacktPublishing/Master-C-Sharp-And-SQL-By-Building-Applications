USE CustomerOrderViewer;

ALTER TABLE [dbo].[CustomerOrder]
ADD CreateDate DATETIME NOT NULL DEFAULT(GETDATE()),
	CreateId VARCHAR(50) NOT NULL DEFAULT('System'),
	UpdateDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdateId VARCHAR(50) NOT NULL DEFAULT('System'),
	ActiveInd BIT NOT NULL DEFAULT(CONVERT(BIT, 1))
GO 

CREATE TYPE [dbo].[CustomerOrderType] AS TABLE
(
	CustomerOrderId int NOT NULL,
    CustomerId int  NOT NULL,
	ItemId int NOT NULL
);
GO

CREATE PROCEDURE [dbo].[CustomerOrderDetail_Upsert]
	@CustomerOrderType CustomerOrderType READONLY,
	@UserId VARCHAR(50)
AS
	MERGE INTO CustomerOrder TARGET
    USING 
	(
		SELECT 
			CustomerOrderId,
			CustomerId,
			ItemId,
			@UserId [UpdateId],
			GETDATE() [UpdateDate], 
			@UserId [CreateId],
			GETDATE() [CreateDate]
		FROM
			@CustomerOrderType
	) AS SOURCE
    ON 
	(
		TARGET.CustomerOrderId = COALESCE(SOURCE.CustomerOrderId, -1)
	)
    WHEN MATCHED THEN
        UPDATE SET 
			TARGET.CustomerId = SOURCE.CustomerId,
			TARGET.ItemId = SOURCE.ItemId,
			TARGET.UpdateId = SOURCE.UpdateId,
			TARGET.UpdateDate = SOURCE.UpdateDate

    WHEN NOT MATCHED BY TARGET THEN
        INSERT (CustomerId, ItemId, CreateId, CreateDate, UpdateId, UpdateDate, ActiveInd) 
		VALUES (SOURCE.CustomerId, SOURCE.ItemId, SOURCE.CreateId, SOURCE.CreateDate, SOURCE.UpdateId, SOURCE.UpdateDate, CONVERT(BIT, 1));
GO

CREATE PROCEDURE [dbo].[CustomerOrderDetail_Delete] 
	@CustomerOrderId INT,
	@UserId VARCHAR(50)
AS
	-- Show that it can be done with a delete but this is not what the requirement is asking for - and we cannot do the MERGE becasue we will only have the CustomerOrderId, we could but int this case we will separte our delete from the upsert
	--DELETE FROM CustomerOrder WHERE CustomerOrderId = @CustomerOrderId;

	-- Then change it to this
	UPDATE CustomerOrder 
	SET 
		ActiveInd = CONVERT(BIT, 0),
		UpdateId = @UserId,
		UpdateDate = GETDATE()
	WHERE 
		CustomerOrderId = @CustomerOrderId AND
		ActiveInd = CONVERT(BIT, 1);
GO

ALTER VIEW [dbo].[CustomerOrderDetail] AS
	SELECT 
		t1.CustomerOrderId,
		t2.CustomerId,
		t3.ItemId,
		t2.FirstName,
		t2.LastName,
		t3.[Description],
		t3.Price,
		t1.ActiveInd
	FROM 
		CustomerOrder t1
	INNER JOIN
		Customer t2 ON t2.CustomerId = t1.CustomerId
	INNER JOIN
		Item t3 ON t3.ItemId = t1.ItemId;
GO

CREATE PROCEDURE [dbo].[CustomerOrderDetail_GetList]
AS
	SELECT 
		CustomerOrderId,
		CustomerId,
		ItemId,
		FirstName,
		LastName,
		[Description],
		Price
	FROM 
		CustomerOrderDetail
	WHERE
		ActiveInd = CONVERT(BIT, 1);
GO

CREATE PROCEDURE [dbo].[Customer_GetList]
AS
	SELECT 
	   [CustomerId]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Age]
	FROM 
	   [dbo].[Customer];

GO

CREATE PROCEDURE [dbo].[Item_GetList]
AS

	SELECT 
	   [ItemId]
      ,[Description]
      ,[Price]
	FROM 
	   [dbo].[Item];

GO