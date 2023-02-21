USE [master]
GO
/****** Object:  Database [Comic]    Script Date: 21-02-2023 7:36:27 ******/
CREATE DATABASE [Comic]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Comic', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER2017\MSSQL\DATA\Comic.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Comic_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER2017\MSSQL\DATA\Comic_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Comic] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Comic].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Comic] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Comic] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Comic] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Comic] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Comic] SET ARITHABORT OFF 
GO
ALTER DATABASE [Comic] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Comic] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Comic] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Comic] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Comic] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Comic] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Comic] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Comic] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Comic] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Comic] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Comic] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Comic] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Comic] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Comic] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Comic] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Comic] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Comic] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Comic] SET RECOVERY FULL 
GO
ALTER DATABASE [Comic] SET  MULTI_USER 
GO
ALTER DATABASE [Comic] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Comic] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Comic] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Comic] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Comic] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Comic] SET QUERY_STORE = OFF
GO
USE [Comic]
GO
/****** Object:  UserDefinedFunction [dbo].[FNDateTimeOffset]    Script Date: 21-02-2023 7:36:27 ******/
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
/****** Object:  Table [dbo].[Biografia]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biografia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NombreCompleto] [nvarchar](50) NOT NULL,
	[Genero] [char](1) NOT NULL,
	[Aparicion] [date] NOT NULL,
	[Alias] [nvarchar](200) NOT NULL,
	[Editor] [varchar](25) NOT NULL,
 CONSTRAINT [PK_Biografia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacto]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CorreoElectronico] [nvarchar](50) NOT NULL,
	[Telefono] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Contacto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadisticasPoder]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadisticasPoder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Inteligencia] [int] NOT NULL,
	[Fuerza] [int] NOT NULL,
	[Velocidad] [int] NOT NULL,
	[Durabilidad] [int] NOT NULL,
	[Poder] [int] NOT NULL,
	[Combate] [int] NOT NULL,
 CONSTRAINT [PK_EstadisticasPoder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Heroe]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Heroe](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[RutaImagen] [nvarchar](355) NOT NULL,
	[BiografiaId] [int] NOT NULL,
	[EstadisticasPoderId] [int] NOT NULL,
 CONSTRAINT [PK_Heroe] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Nombre_Heroe] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Nombre_Rol] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Rut] [varchar](10) NOT NULL,
	[Nombre] [nvarchar](45) NOT NULL,
	[Apellido] [nvarchar](45) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[Contrasena] [nvarchar](64) NOT NULL,
	[Activo] [bit] NOT NULL,
	[Registrado] [datetimeoffset](7) NOT NULL,
	[ContactoId] [int] NOT NULL,
	[RolId] [int] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Rut_Usuario] UNIQUE NONCLUSTERED 
(
	[Rut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Heroe]  WITH CHECK ADD  CONSTRAINT [FK_Biografia_Heroe] FOREIGN KEY([BiografiaId])
REFERENCES [dbo].[Biografia] ([Id])
GO
ALTER TABLE [dbo].[Heroe] CHECK CONSTRAINT [FK_Biografia_Heroe]
GO
ALTER TABLE [dbo].[Heroe]  WITH CHECK ADD  CONSTRAINT [FK_EstadisticasPoder_Heroe] FOREIGN KEY([EstadisticasPoderId])
REFERENCES [dbo].[EstadisticasPoder] ([Id])
GO
ALTER TABLE [dbo].[Heroe] CHECK CONSTRAINT [FK_EstadisticasPoder_Heroe]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Contacto_Usuario] FOREIGN KEY([ContactoId])
REFERENCES [dbo].[Contacto] ([Id])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Contacto_Usuario]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Rol_Usuario] FOREIGN KEY([RolId])
REFERENCES [dbo].[Rol] ([Id])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Rol_Usuario]
GO
/****** Object:  StoredProcedure [dbo].[SPDeleteHeroe]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Eliminar Heroe>
-- =============================================
CREATE PROCEDURE [dbo].[SPDeleteHeroe] (@HeroeId INT)
AS
BEGIN

	DECLARE @BiografiaId INT;
	DECLARE @EstadisticasPoderId INT;

	SELECT @BiografiaId = [BiografiaId], @EstadisticasPoderId = [EstadisticasPoderId]
	FROM [dbo].[Heroe]
	WHERE [Id] = @HeroeId;

	DELETE FROM [dbo].[Biografia]
	WHERE [Id] = @BiografiaId;

	DELETE FROM [dbo].[EstadisticasPoder]
	WHERE [Id] = @EstadisticasPoderId;

	DELETE FROM [dbo].[Heroe]
	WHERE [Id] = @HeroeId;

END
GO
/****** Object:  StoredProcedure [dbo].[SPDeleteUsuario]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Eliminar Usuario>
-- =============================================
CREATE PROCEDURE [dbo].[SPDeleteUsuario] (@UsuarioId INT)
AS
BEGIN

	DECLARE @ContactoId INT;

	SELECT @ContactoId = [ContactoId]
	FROM [dbo].[Usuario]
	WHERE [Id] = @UsuarioId;

	DELETE FROM [dbo].[Contacto]
	WHERE [Id] = @ContactoId;

	DELETE FROM [dbo].[Usuario]
	WHERE [Id] = @UsuarioId;

END
GO
/****** Object:  StoredProcedure [dbo].[SPInsertHeroe]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Insertar Heroe>
-- =============================================
CREATE PROCEDURE [dbo].[SPInsertHeroe](
	-- Tabla Heroe
	@Nombre NVARCHAR(50),
	@Descripcion NVARCHAR(255),
	@RutaImagen NVARCHAR(355),
	-- Tabla Biografia
	@NombreCompleto NVARCHAR(50),
	@Genero CHAR(1),
	@Aparicion DATE,
	@Alias NVARCHAR(200),
	@Editor VARCHAR(25),
	-- Tabla EstadisticasPoder
	@Inteligencia INT,
	@Fuerza INT,
	@Velocidad INT,
	@Durabilidad INT,
	@Poder INT,
	@Combate INT
	)
AS
BEGIN

	DECLARE @BiografiaId INT;
	DECLARE @EstadisticasPoderId INT;

	INSERT INTO [dbo].[Biografia]([NombreCompleto], [Genero], [Aparicion], [Alias], [Editor])
	VALUES(@NombreCompleto, @Genero, @Aparicion, @Alias, @Editor);

	SET @BiografiaId = SCOPE_IDENTITY();

	INSERT INTO [dbo].[EstadisticasPoder]([Inteligencia], [Fuerza], [Velocidad], [Durabilidad], [Poder], [Combate])
	VALUES(@Inteligencia, @Fuerza, @Velocidad, @Durabilidad, @Poder, @Combate);

	SET @EstadisticasPoderId = SCOPE_IDENTITY();

	INSERT INTO [dbo].[Heroe]([Nombre], [Descripcion], [RutaImagen], [BiografiaId], [EstadisticasPoderId])
	VALUES(@Nombre, @Descripcion, @RutaImagen, @BiografiaId, @EstadisticasPoderId);

END
GO
/****** Object:  StoredProcedure [dbo].[SPInsertUsuario]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Insertar Usuario>
-- =============================================
CREATE PROCEDURE [dbo].[SPInsertUsuario] (
	-- Tabla Usuario
	@Rut VARCHAR(10),
	@Nombre NVARCHAR(45),
	@Apellido NVARCHAR(45),
	@FechaNacimiento DATE,
	@Contrasena NVARCHAR(64),
	@Activo BIT,
	@Registrado DATETIMEOFFSET(7),
	-- Tabla Contacto
	@CorreoElectronico NVARCHAR(50),
	@Telefono VARCHAR(15),
	-- Tabla Rol
	@RolId INT
	)
AS
BEGIN

	DECLARE @ContactoId INT;

	INSERT INTO [dbo].[Contacto]([CorreoElectronico], [Telefono]) 
	VALUES(@CorreoElectronico, @Telefono);

	SET @ContactoId = SCOPE_IDENTITY();

	INSERT INTO [dbo].[Usuario]([Rut], [Nombre], [Apellido], [FechaNacimiento], [Contrasena], [Activo], [Registrado], [ContactoId], [RolId])
	VALUES (@Rut, @Nombre, @Apellido, @FechaNacimiento, @Contrasena, @Activo, @Registrado, @ContactoId, @RolId);

END
GO
/****** Object:  StoredProcedure [dbo].[SPListBiografia]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Biografia>
-- =============================================
CREATE PROCEDURE [dbo].[SPListBiografia]
AS
BEGIN
	
	SELECT [Id], [NombreCompleto], [Genero], [Aparicion], [Alias], [Editor]
	FROM [dbo].[Biografia]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListBiografiaPaginated]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Biografia paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListBiografiaPaginated](@PageIndex INT, @PageSize INT)
AS
BEGIN
	
	SELECT [Id], [NombreCompleto], [Genero], [Aparicion], [Alias], [Editor]
	FROM [dbo].[Biografia]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListContacto]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Contacto>
-- =============================================
CREATE PROCEDURE [dbo].[SPListContacto]
AS
BEGIN

	SELECT [Id], [CorreoElectronico], [Telefono]
	FROM [dbo].[Contacto]	
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListContactoPaginated]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Contacto paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListContactoPaginated](@PageIndex INT, @PageSize INT)
AS
BEGIN

	SELECT [Id], [CorreoElectronico], [Telefono]
	FROM [dbo].[Contacto]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListEstadisticasPoder]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar EstadisticasPoder>
-- =============================================
CREATE PROCEDURE [dbo].[SPListEstadisticasPoder]
AS
BEGIN

	SELECT [Id], [Inteligencia], [Fuerza], [Velocidad], [Durabilidad], [Poder], [Combate]
	FROM [dbo].[EstadisticasPoder]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListEstadisticasPoderPaginated]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar EstadisticasPoder paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListEstadisticasPoderPaginated] (@PageIndex INT, @PageSize INT)
AS
BEGIN

	SELECT [Id], [Inteligencia], [Fuerza], [Velocidad], [Durabilidad], [Poder], [Combate]
	FROM [dbo].[EstadisticasPoder]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListHeroe]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Hero>
-- =============================================
CREATE PROCEDURE [dbo].[SPListHeroe]
AS
BEGIN

	SELECT [Id], [Nombre], [Descripcion], [RutaImagen], [BiografiaId], [EstadisticasPoderId]
	FROM [dbo].[Heroe]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListHeroePaginated]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Heroe paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListHeroePaginated] (@PageIndex INT, @PageSize INT)
AS
BEGIN

	SELECT [Id], [Nombre], [Descripcion], [RutaImagen], [BiografiaId], [EstadisticasPoderId]
	FROM [dbo].[Heroe]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListRol]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Rol>
-- =============================================
CREATE PROCEDURE [dbo].[SPListRol]
AS
BEGIN

	SELECT [Id],[Nombre]
	FROM [dbo].[Rol]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListRolPaginated]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Rol paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListRolPaginated] (@PageIndex INT, @PageSize INT)
AS
BEGIN

	SELECT [Id],[Nombre]
	FROM [dbo].[Rol]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListUsuario]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Usuario>
-- =============================================
CREATE PROCEDURE [dbo].[SPListUsuario](@TimeZoneInfoName NVARCHAR(50))
AS
BEGIN

	SELECT [Rut], [Nombre], [Apellido], [FechaNacimiento], [Contrasena], [Activo], ([dbo].[FNDateTimeOffset]([Registrado], @TimeZoneInfoName)) AS Registrado, [ContactoId], [RolId]
	FROM [dbo].[Usuario]
	ORDER BY [Id] ASC;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListUsuarioPaginated]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Listar Usuario paginado>
-- =============================================
CREATE PROCEDURE [dbo].[SPListUsuarioPaginated] (@PageIndex INT, @PageSize INT, @TimeZoneInfoName NVARCHAR(50))
AS
BEGIN

	SELECT [Rut], [Nombre], [Apellido], [FechaNacimiento], [Contrasena], [Activo], ([dbo].[FNDateTimeOffset]([Registrado], @TimeZoneInfoName)) AS Registrado, [ContactoId], [RolId]
	FROM [dbo].[Usuario]
	ORDER BY [Id] DESC
	OFFSET(@PageIndex - 1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
GO
/****** Object:  StoredProcedure [dbo].[SPLogin]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Login>
-- =============================================
CREATE PROCEDURE [dbo].[SPLogin] (@UserRut VARCHAR(10), @UserContrasena NVARCHAR(64))
AS
BEGIN
	
	DECLARE @Table TABLE([Id] INT, [Message] VARCHAR(100));

	IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuario] WHERE [Rut] = @UserRut)
	BEGIN
		INSERT INTO @Table([Id], [Message]) VALUES(0, 'No existe usuario con el Rut ingresado');
	END
	ELSE IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuario] WHERE [Rut] = @UserRut AND [Contrasena] = @UserContrasena)
	BEGIN
		INSERT INTO @Table([Id], [Message]) VALUES(1, 'Rut o Password incorrecto');
	END
	ELSE IF EXISTS (SELECT 1 FROM [dbo].[Usuario] WHERE [Rut] = @UserRut AND [Activo] = 0)
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
/****** Object:  StoredProcedure [dbo].[SPSelectHeroe]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Consultar todos los datos del heroe>
-- =============================================
CREATE PROCEDURE [dbo].[SPSelectHeroe] (@HeroeId INT)
AS
BEGIN

	SELECT [Heroe].[Id] AS HeroeId, [Heroe].[Nombre], [Heroe].[Descripcion], [Heroe].[RutaImagen],
		   [Biografia].[Id] AS BiografiaId, [Biografia].[NombreCompleto], [Biografia].[Genero], [Biografia].[Aparicion], [Biografia].[Alias], [Biografia].[Editor],
		   [EstadisticasPoder].[Id] AS EstadisticasPoderId, [EstadisticasPoder].[Inteligencia], [EstadisticasPoder].[Fuerza], [EstadisticasPoder].[Velocidad], [EstadisticasPoder].[Durabilidad], [EstadisticasPoder].[Poder], [EstadisticasPoder].[Combate]
	FROM [dbo].[Heroe] [Heroe]
	RIGHT JOIN [dbo].[Biografia] [Biografia] ON [Biografia].[Id] = [Heroe].[BiografiaId]
	RIGHT JOIN [dbo].[EstadisticasPoder] [EstadisticasPoder] ON [EstadisticasPoder].[Id] = [Heroe].[EstadisticasPoderId]
	WHERE [Heroe].[Id] = @HeroeId;

END
GO
/****** Object:  StoredProcedure [dbo].[SPSelectUsuario]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Consultar todos los datos del usuario>
-- =============================================
CREATE PROCEDURE [dbo].[SPSelectUsuario] (@UsuarioId INT, @TimeZoneInfoName NVARCHAR(50))
AS
BEGIN

	SELECT [Usuario].[Id] AS UserId, [Usuario].[Rut], [Usuario].[Nombre], [Usuario].[Apellido], [Usuario].[FechaNacimiento], [Usuario].[Activo], ([dbo].[FNDateTimeOffset]([Usuario].[Registrado], @TimeZoneInfoName)) AS Registrado,
		   [Contacto].[Id] AS ContactId, [Contacto].[CorreoElectronico], [Contacto].[Telefono],
		   [Rol].[Id] AS RoleId, [Rol].[Nombre]
	FROM [dbo].[Usuario] [Usuario]
	LEFT JOIN [dbo].[Contacto] [Contacto] ON [Usuario].[ContactoId] = [Contacto].[Id]
	LEFT JOIN [dbo].[Rol] [Rol] ON [Usuario].[RolId] = [Rol].[Id]	
	WHERE [Usuario].[Id] = @UsuarioId;

END
GO
/****** Object:  StoredProcedure [dbo].[SPUpdateHeroe]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Actualizar Heroe>
-- =============================================
CREATE PROCEDURE [dbo].[SPUpdateHeroe](
	-- Tabla Heroe
	@HeroeId INT,
	@Nombre NVARCHAR(50),
	@Descripcion NVARCHAR(255),
	@RutaImagen NVARCHAR(355),
	-- Tabla Biografia
	@BiografiaId INT,
	@NombreCompleto NVARCHAR(50),
	@Genero CHAR(1),
	@Aparicion DATE,
	@Alias NVARCHAR(200),
	@Editor VARCHAR(25),
	-- Tabla EstadisticasPoder
	@EstadisticasPoderId INT,
	@Inteligencia INT,
	@Fuerza INT,
	@Velocidad INT,
	@Durabilidad INT,
	@Poder INT,
	@Combate INT
	)
AS
BEGIN

	UPDATE [dbo].[Heroe]
	SET [Nombre] = @Nombre, [Descripcion] = @Descripcion, [RutaImagen] = @RutaImagen
	WHERE [Id] = @HeroeId;

	UPDATE [dbo].[Biografia]
	SET [NombreCompleto] = @NombreCompleto, [Genero] = @Genero, [Aparicion] = @Aparicion, [Alias] = @Alias, [Editor] = @Editor
	WHERE [Id] = @BiografiaId;

	UPDATE [dbo].[EstadisticasPoder]
	SET [Inteligencia] = @Inteligencia, [Fuerza] = @Fuerza, [Velocidad] = @Velocidad, [Durabilidad] = @Durabilidad, [Poder] = @Poder, [Combate] = @Combate
	WHERE [Id] = @EstadisticasPoderId;

END
GO
/****** Object:  StoredProcedure [dbo].[SPUpdateUsuario]    Script Date: 21-02-2023 7:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ignacio Chavez>
-- Create date: <2023-02-18>
-- Description:	<Actualizar Usuario>
-- =============================================
CREATE PROCEDURE [dbo].[SPUpdateUsuario](
	-- Tabla Usuario
	@UsuarioId INT,
	@Rut VARCHAR(10),
	@Nombre NVARCHAR(45),
	@Apellido NVARCHAR(45),
	@FechaNacimiento DATE,
	@Contrasena NVARCHAR(64),
	@Activo BIT,
	-- Tabla Contacto
	@ContactoId INT,
	@CorreoElectronico NVARCHAR(50),
	@Telefono NUMERIC(15, 0),
	-- Tabla Rol
	@RolId INT
)
AS
BEGIN

	UPDATE [dbo].[Usuario]
	SET [Rut] = @Rut, [Nombre] = @Nombre, [Apellido] = @Apellido, [FechaNacimiento] = @FechaNacimiento, [Contrasena] = @Contrasena, [Activo] = @Activo, [RolId] =  @RolId
	WHERE [Id] = @UsuarioId;

	UPDATE [dbo].[Contacto]
	SET [CorreoElectronico] = @CorreoElectronico, [Telefono] = @Telefono
	WHERE [Id] = @ContactoId;

END
GO
USE [master]
GO
ALTER DATABASE [Comic] SET  READ_WRITE 
GO
