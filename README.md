# SQLServer

El presente proyecto es una db de Comic generada en SQL Server

## Tecnologias 📌

SQL Server 2017

### Pre-requisitos 📋

Tener instalado el motor de SQL Server 2017

Tener instalado SQL Server Management Studio 18 o uno compatible con en SQL Server 2017

### Instalación DB Original 🔧

Ejecutar script en carpeta Script\Model\ en el siguiente orden:

```
1.- Script db.sql
2.- Insert Hero.sql
3.- Insert Role.sql
4.- Insert User.sql
```


Ejecutar siguiente linea de comandos en bd Comic:

```
USE [Comic]
GO

EXEC	[dbo].[SPSelectUser]
		@UserId = 1,
		@TimeZoneInfoName = 'Pacific SA Standard Time'

GO
```

## Instalación DB Pruebas ⚙️

Ejecutar script en carpeta Script\Tests\ en el siguiente orden:

```
1.- Script db.sql
2.- Insert Hero.sql
3.- Insert Role.sql
4.- Insert User.sql
```


Ejecutar siguiente linea de comandos en bd ComicTests:

```
USE [ComicTests]
GO

EXEC	[dbo].[SPSelectUser]
		@UserId = 1,
		@TimeZoneInfoName = 'Pacific SA Standard Time'

GO
```

## Construido con 🛠️

* [SQL Server](https://www.microsoft.com/es-es/sql-server/sql-server-downloads) - Base de datos SQL Server

## Autores ✒️

* **Ignacio Chávez** - *Trabajo Inicial*
* **Ignacio Chávez** - *Documentación*

© Copyright IgnacioChávez, Todos Los Derechos Reservados