USE CourseReport;
GO

CREATE PROCEDURE [dbo].[Course_GetList]
AS
	SELECT
		CourseId,
		CourseCode,
		[Description]
	FROM 
		[dbo].[Course]

GO

CREATE PROCEDURE [dbo].[Student_GetList]
AS
	
	SELECT 
		StudentId,
		FirstName,
		LastName
	FROM 
		[dbo].[Student]

GO

CREATE PROCEDURE [dbo].[Enrollments_GetList]
AS
	SELECT
		EnrollmentId,
		StudentId,
		CourseId
	FROM 
		[dbo].[Enrollments]

GO


CREATE TYPE [dbo].[EnrollmentType] AS TABLE
(
	 [EnrollmentId] INT NOT NULL
    ,[StudentId] INT NOT NULL
    ,[CourseId] INT NOT NULL
);
GO

ALTER TABLE [dbo].[Enrollments]
ADD CreateDate DATETIME NOT NULL DEFAULT(GETDATE()),
	CreateId VARCHAR(50) NOT NULL DEFAULT('System'),
	UpdateDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdateId VARCHAR(50) NOT NULL DEFAULT('System')
GO 

CREATE PROCEDURE [dbo].[Enrollments_Upsert]
	@EnrollmentType EnrollmentType READONLY,
	@UserId VARCHAR(50)
AS
	MERGE INTO Enrollments TARGET
    USING 
	(
		SELECT 
			[EnrollmentId],
			[StudentId],
			[CourseId],
			@UserId [UpdateId],
			GETDATE() [UpdateDate], 
			@UserId [CreateId],
			GETDATE() [CreateDate]
		FROM
			@EnrollmentType
	) AS SOURCE
    ON 
	(
		TARGET.EnrollmentId = SOURCE.EnrollmentId
	)
    WHEN MATCHED THEN
        UPDATE SET
			TARGET.[StudentId] = SOURCE.[StudentId],
			TARGET.[CourseId] = SOURCE.[CourseId],
			TARGET.[UpdateId] = SOURCE.[UpdateId],
			TARGET.[UpdateDate] = SOURCE.[UpdateDate]

    WHEN NOT MATCHED BY TARGET THEN
        INSERT (
			[StudentId],
			[CourseId],
			[CreateDate],
			[CreateId],
			[UpdateDate],
			[UpdateId]) 
		VALUES (
			SOURCE.[StudentId],
			SOURCE.[CourseId],
			SOURCE.[CreateDate],
			SOURCE.[CreateId],
			SOURCE.[UpdateDate],
			SOURCE.[UpdateId]);
GO

