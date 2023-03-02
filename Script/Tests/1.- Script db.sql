USE [master]
GO
/****** Object:  Database [ComicTests]    Script Date: 02-03-2023 20:23:26 ******/
CREATE DATABASE [ComicTests]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ComicTests', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER2017\MSSQL\DATA\ComicTests.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ComicTests_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER2017\MSSQL\DATA\ComicTests_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ComicTests] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ComicTests].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ComicTests] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ComicTests] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ComicTests] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ComicTests] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ComicTests] SET ARITHABORT OFF 
GO
ALTER DATABASE [ComicTests] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ComicTests] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ComicTests] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ComicTests] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ComicTests] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ComicTests] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ComicTests] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ComicTests] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ComicTests] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ComicTests] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ComicTests] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ComicTests] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ComicTests] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ComicTests] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ComicTests] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ComicTests] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ComicTests] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ComicTests] SET RECOVERY FULL 
GO
ALTER DATABASE [ComicTests] SET  MULTI_USER 
GO
ALTER DATABASE [ComicTests] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ComicTests] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ComicTests] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ComicTests] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ComicTests] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ComicTests] SET QUERY_STORE = OFF
GO
USE [ComicTests]
GO
/****** Object:  UserDefinedFunction [dbo].[FNDateTimeOffset]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Retorna nuevo fecha hora segun zona horaria>
-- =============================================
CREATE FUNCTION [dbo].[FNDateTimeOffset] (@DateTimeOffset DATETIMEOFFSET, @TimeZoneInfoName NVARCHAR(50))
RETURNS DATETIMEOFFSET
AS
BEGIN

	DECLARE @NewDateTimeOffset DATETIMEOFFSET;
	SET @NewDateTimeOffset = SWITCHOFFSET(CONVERT(DATETIMEOFFSET, @DateTimeOffset), (SELECT current_utc_offset FROM sys.time_zone_info WHERE name = @TimeZoneInfoName));
	RETURN @NewDateTimeOffset;
END

GO
/****** Object:  Table [dbo].[Biography]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biography](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Gender] [char](1) NOT NULL,
	[Appearance] [date] NOT NULL,
	[Alias] [nvarchar](500) NOT NULL,
	[Publisher] [varchar](25) NOT NULL,
 CONSTRAINT [PK_Biography] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hero]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hero](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[ImagePath] [nvarchar](355) NOT NULL,
	[BiographyId] [int] NOT NULL,
	[PowerStatsId] [int] NOT NULL,
 CONSTRAINT [PK_Hero] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Name_Hero] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PowerStats]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PowerStats](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Intelligence] [int] NOT NULL,
	[Strength] [int] NOT NULL,
	[Speed] [int] NOT NULL,
	[Durability] [int] NOT NULL,
	[Power] [int] NOT NULL,
	[Combat] [int] NOT NULL,
 CONSTRAINT [PK_PowerStats] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Name_Role] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Rut] [varchar](10) NOT NULL,
	[Name] [nvarchar](45) NOT NULL,
	[LastName] [nvarchar](45) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Password] [nvarchar](64) NOT NULL,
	[Active] [bit] NOT NULL,
	[Registered] [datetimeoffset](7) NOT NULL,
	[ContactId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Rut_User] UNIQUE NONCLUSTERED 
(
	[Rut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Hero]  WITH CHECK ADD  CONSTRAINT [FK_Biography_Hero] FOREIGN KEY([BiographyId])
REFERENCES [dbo].[Biography] ([Id])
GO
ALTER TABLE [dbo].[Hero] CHECK CONSTRAINT [FK_Biography_Hero]
GO
ALTER TABLE [dbo].[Hero]  WITH CHECK ADD  CONSTRAINT [FK_PowerStats_Hero] FOREIGN KEY([PowerStatsId])
REFERENCES [dbo].[PowerStats] ([Id])
GO
ALTER TABLE [dbo].[Hero] CHECK CONSTRAINT [FK_PowerStats_Hero]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_Contact_User] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_Contact_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_Role_User] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_Role_User]
GO
/****** Object:  StoredProcedure [dbo].[SPDeleteHero]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Eliminar Hero>
-- =============================================
CREATE PROCEDURE [dbo].[SPDeleteHero] (@HeroId INT)
AS
BEGIN

	DECLARE @BiographyId INT;
	DECLARE @PowerStatsId INT;

	SELECT @BiographyId = [BiographyId], @PowerStatsId = [PowerStatsId]
	FROM [dbo].[Hero]
	WHERE [Id] = @HeroId;

	DELETE FROM [dbo].[Hero]
	WHERE [Id] = @HeroId;

	DELETE FROM [dbo].[Biography]
	WHERE [Id] = @BiographyId;

	DELETE FROM [dbo].[PowerStats]
	WHERE [Id] = @PowerStatsId;
END
GO
/****** Object:  StoredProcedure [dbo].[SPDeleteUser]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Eliminar User>
-- =============================================
CREATE PROCEDURE [dbo].[SPDeleteUser] (@UserId INT)
AS
BEGIN

	DECLARE @ContactId INT;

	SELECT @ContactId = [ContactId]
	FROM [dbo].[User]
	WHERE [Id] = @UserId;

	DELETE FROM [dbo].[User]
	WHERE [Id] = @UserId;

	DELETE FROM [dbo].[Contact]
	WHERE [Id] = @ContactId;
END
GO
/****** Object:  StoredProcedure [dbo].[SPInsertHero]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Insertar Hero>
-- =============================================
CREATE PROCEDURE [dbo].[SPInsertHero](
	-- Tabla Hero
	@Name NVARCHAR(50),
	@Description NVARCHAR(500),
	@ImagePath NVARCHAR(355),
	-- Tabla Biography
	@FullName NVARCHAR(50),
	@Gender CHAR(1),
	@Appearance DATE,
	@Alias NVARCHAR(500),
	@Publisher VARCHAR(25),
	-- Tabla PowerStats
	@Intelligence INT,
	@Strength INT,
	@Speed INT,
	@Durability INT,
	@Power INT,
	@Combat INT
	)
AS
BEGIN

	DECLARE @BiographyId INT;
	DECLARE @PowerStatsId INT;

	INSERT INTO [dbo].[Biography]([FullName], [Gender], [Appearance], [Alias], [Publisher])
	VALUES(@FullName, @Gender, @Appearance, @Alias, @Publisher);

	SET @BiographyId = SCOPE_IDENTITY();

	INSERT INTO [dbo].[PowerStats]([Intelligence], [Strength], [Speed], [Durability], [Power], [Combat])
	VALUES(@Intelligence, @Strength, @Speed, @Durability, @Power, @Combat);

	SET @PowerStatsId = SCOPE_IDENTITY();

	INSERT INTO [dbo].[Hero]([Name], [Description], [ImagePath], [BiographyId], [PowerStatsId])
	VALUES(@Name, @Description, @ImagePath, @BiographyId, @PowerStatsId);

END
GO
/****** Object:  StoredProcedure [dbo].[SPInsertUser]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Insertar User>
-- =============================================
CREATE PROCEDURE [dbo].[SPInsertUser] (
	-- Tabla User
	@Rut VARCHAR(10),
	@Name NVARCHAR(45),
	@LastName NVARCHAR(45),
	@BirthDate DATE,
	@Password NVARCHAR(64),
	@Active BIT,
	@Registered DATETIMEOFFSET(7),
	-- Tabla Contact
	@Email NVARCHAR(50),
	@Phone VARCHAR(15),
	-- Tabla Role
	@RoleId INT
	)
AS
BEGIN

	DECLARE @ContactId INT;

	INSERT INTO [dbo].[Contact]([Email], [Phone]) 
	VALUES(@Email, @Phone);

	SET @ContactId = SCOPE_IDENTITY();

	INSERT INTO [dbo].[User]([Rut], [Name], [LastName], [BirthDate], [Password], [Active], [Registered], [ContactId], [RoleId])
	VALUES (@Rut, @Name, @LastName, @BirthDate, @Password, @Active, @Registered, @ContactId, @RoleId);

END
GO
/****** Object:  StoredProcedure [dbo].[SPListBiography]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Biography>
-- =============================================
CREATE PROCEDURE [dbo].[SPListBiography]
AS
BEGIN
	
	SELECT [Id], [FullName], [Gender], [Appearance], [Alias], [Publisher]
	FROM [dbo].[Biography]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListBiographyPaginated]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Biography paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListBiographyPaginated](@PageIndex INT, @PageSize INT)
AS
BEGIN
	
	SELECT [Id], [FullName], [Gender], [Appearance], [Alias], [Publisher]
	FROM [dbo].[Biography]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListContact]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Contact>
-- =============================================
CREATE PROCEDURE [dbo].[SPListContact]
AS
BEGIN

	SELECT [Id], [Email], [Phone]
	FROM [dbo].[Contact]	
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListContactPaginated]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Contact paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListContactPaginated](@PageIndex INT, @PageSize INT)
AS
BEGIN

	SELECT [Id], [Email], [Phone]
	FROM [dbo].[Contact]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListHero]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Hero>
-- =============================================
CREATE PROCEDURE [dbo].[SPListHero]
AS
BEGIN

	SELECT [Id], [Name], [Description], [ImagePath], [BiographyId], [PowerStatsId]
	FROM [dbo].[Hero]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListHeroPaginated]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Hero paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListHeroPaginated] (@PageIndex INT, @PageSize INT)
AS
BEGIN

	SELECT [Id], [Name], [Description], [ImagePath], [BiographyId], [PowerStatsId]
	FROM [dbo].[Hero]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListPowerStats]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar PowerStats>
-- =============================================
CREATE PROCEDURE [dbo].[SPListPowerStats]
AS
BEGIN

	SELECT [Id], [Intelligence], [Strength], [Speed], [Durability], [Power], [Combat]
	FROM [dbo].[PowerStats]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListPowerStatsPaginated]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar PowerStats paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListPowerStatsPaginated] (@PageIndex INT, @PageSize INT)
AS
BEGIN

	SELECT [Id], [Intelligence], [Strength], [Speed], [Durability], [Power], [Combat]
	FROM [dbo].[PowerStats]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListRole]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Role>
-- =============================================
CREATE PROCEDURE [dbo].[SPListRole]
AS
BEGIN

	SELECT [Id],[Name]
	FROM [dbo].[Role]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListRolePaginated]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Role paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListRolePaginated] (@PageIndex INT, @PageSize INT)
AS
BEGIN

	SELECT [Id],[Name]
	FROM [dbo].[Role]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListUser]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar User>
-- =============================================
CREATE PROCEDURE [dbo].[SPListUser](@TimeZoneInfoName NVARCHAR(50))
AS
BEGIN

	SELECT [Id], [Rut], [Name], [LastName], [BirthDate], [Active], ([dbo].[FNDateTimeOffset]([Registered], @TimeZoneInfoName)) AS Registered, [ContactId], [RoleId]
	FROM [dbo].[User]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListUserPaginated]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar User paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListUserPaginated] (@PageIndex INT, @PageSize INT, @TimeZoneInfoName NVARCHAR(50))
AS
BEGIN

	SELECT [Id], [Rut], [Name], [LastName], [BirthDate], [Active], ([dbo].[FNDateTimeOffset]([Registered], @TimeZoneInfoName)) AS Registered, [ContactId], [RoleId]
	FROM [dbo].[User]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPLogin]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Login>
-- =============================================
CREATE PROCEDURE [dbo].[SPLogin] (@UserRut VARCHAR(10), @UserPassword NVARCHAR(64))
AS
BEGIN
	
	DECLARE @Table TABLE([Id] INT, [Message] VARCHAR(100));

	IF NOT EXISTS (SELECT 1 FROM [dbo].[User] WHERE [Rut] = @UserRut)
	BEGIN
		INSERT INTO @Table([Id], [Message]) VALUES(0, 'No existe usuario con el Rut ingresado');
	END
	ELSE IF NOT EXISTS (SELECT 1 FROM [dbo].[User] WHERE [Rut] = @UserRut AND [Password] = @UserPassword)
	BEGIN
		INSERT INTO @Table([Id], [Message]) VALUES(1, 'Rut o Password incorrecto');
	END
	ELSE IF EXISTS (SELECT 1 FROM [dbo].[User] WHERE [Rut] = @UserRut AND [Active] = 0)
	BEGIN
		INSERT INTO @Table([Id], [Message]) VALUES(2, 'Usuario inactivo');
	END
	ELSE
	BEGIN
		INSERT INTO @Table([Id], [Message]) VALUES(3, 'Correcto');
	END

	SELECT [Id], [Message]
	FROM @Table
END
GO
/****** Object:  StoredProcedure [dbo].[SPSelectHero]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Consultar todos los datos del hero>
-- =============================================
CREATE PROCEDURE [dbo].[SPSelectHero] (@HeroId INT)
AS
BEGIN

	SELECT [Hero].[Id] AS HeroId, [Hero].[Name], [Hero].[Description], [Hero].[ImagePath],
		   [Biography].[Id] AS BiographyId, [Biography].[FullName], [Biography].[Gender], [Biography].[Appearance], [Biography].[Alias], [Biography].[Publisher],
		   [PowerStats].[Id] AS PowerStatsId, [PowerStats].[Intelligence], [PowerStats].[Strength], [PowerStats].[Speed], [PowerStats].[Durability], [PowerStats].[Power], [PowerStats].[Combat]
	FROM [dbo].[Hero] [Hero]
	RIGHT JOIN [dbo].[Biography] [Biography] ON [Biography].[Id] = [Hero].[BiographyId]
	RIGHT JOIN [dbo].[PowerStats] [PowerStats] ON [PowerStats].[Id] = [Hero].[PowerStatsId]
	WHERE [Hero].[Id] = @HeroId;

END
GO
/****** Object:  StoredProcedure [dbo].[SPSelectUser]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Consultar todos los datos del uset>
-- =============================================
CREATE PROCEDURE [dbo].[SPSelectUser] (@UserId INT, @TimeZoneInfoName NVARCHAR(50))
AS
BEGIN

	SELECT [User].[Id] AS UserId, [User].[Rut], [User].[Name], [User].[LastName], [User].[BirthDate], [User].[Active], ([dbo].[FNDateTimeOffset]([User].[Registered], @TimeZoneInfoName)) AS Registered,
		   [Contact].[Id] AS ContactId, [Contact].[Email], [Contact].[Phone],
		   [Role].[Id] AS RoleId, [Role].[Name] AS RoleName
	FROM [dbo].[User] [User]
	LEFT JOIN [dbo].[Contact] [Contact] ON [User].[ContactId] = [Contact].[Id]
	LEFT JOIN [dbo].[Role] [Role] ON [User].[RoleId] = [Role].[Id]	
	WHERE [User].[Id] = @UserId;

END
GO
/****** Object:  StoredProcedure [dbo].[SPUpdateHero]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Actualizar Hero>
-- =============================================
CREATE PROCEDURE [dbo].[SPUpdateHero](
	-- Tabla Hero
	@HeroId INT,
	@Name NVARCHAR(50),
	@Description NVARCHAR(500),
	@ImagePath NVARCHAR(355),
	-- Tabla Biography
	@BiographyId INT,
	@FullName NVARCHAR(50),
	@Gender CHAR(1),
	@Appearance DATE,
	@Alias NVARCHAR(500),
	@Publisher VARCHAR(25),
	-- Tabla PowerStats
	@PowerStatsId INT,
	@Intelligence INT,
	@Strength INT,
	@Speed INT,
	@Durability INT,
	@Power INT,
	@Combat INT
	)
AS
BEGIN

	UPDATE [dbo].[Hero]
	SET [Name] = @Name, [Description] = @Description, [ImagePath] = @ImagePath
	WHERE [Id] = @HeroId;

	UPDATE [dbo].[Biography]
	SET [FullName] = @FullName, [Gender] = @Gender, [Appearance] = @Appearance, [Alias] = @Alias, [Publisher] = @Publisher
	WHERE [Id] = @BiographyId;

	UPDATE [dbo].[PowerStats]
	SET [Intelligence] = @Intelligence, [Strength] = @Strength, [Speed] = @Speed, [Durability] = @Durability, [Power] = @Power, [Combat] = @Combat
	WHERE [Id] = @PowerStatsId;

END
GO
/****** Object:  StoredProcedure [dbo].[SPUpdateUser]    Script Date: 02-03-2023 20:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Actualizar User>
-- =============================================
CREATE PROCEDURE [dbo].[SPUpdateUser](
	-- Tabla User
	@UserId INT,
	@Rut VARCHAR(10),
	@Name NVARCHAR(45),
	@LastName NVARCHAR(45),
	@BirthDate DATE,
	@Password NVARCHAR(64),
	@Active BIT,
	-- Tabla Contact
	@ContactId INT,
	@Email NVARCHAR(50),
	@Phone VARCHAR(15),
	-- Tabla Rol
	@RoleId INT
)
AS
BEGIN

	UPDATE [dbo].[User]
	SET [Rut] = @Rut, [Name] = @Name, [LastName] = @LastName, [BirthDate] = @BirthDate, [Password] = @Password, [Active] = @Active, [RoleId] =  @RoleId
	WHERE [Id] = @UserId;

	UPDATE [dbo].[Contact]
	SET [Email] = @Email, [Phone] = @Phone
	WHERE [Id] = @ContactId;

END
GO
USE [master]
GO
ALTER DATABASE [ComicTests] SET  READ_WRITE 
GO
