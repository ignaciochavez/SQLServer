# SQLServer

El presente proyecto es una db de Comic generada en SQL Server

## Tecnologias 📌

SQL Server 2017

### Pre-requisitos 📋

Tener instalado el motor de SQL Server 2017

Tener instalado SQL Server Management Studio 18 o uno compatible con en SQL Server 2017

### Instalación 🔧

#### DB Original

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

#### DB Pruebas 

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

#### Permisos usuario

Habilitar 'Modo de autenticacion de Windows y SQL Server' de SQL Server 2017, en 'Propiedades' -> 'Seguridad'. Posteriormente reiniciar servicios

Crear usuario 'OpenAPICSharp', de contraseña 'R11MQZ18Ul0d', en 'Seguridad' -> 'Inicios de sesión' -> 'Nuevo inicio de sesion'. Para db 'Comic' y 'ComicTests', en 'Asignacion de usuarios' -> 'Esquemas predeterminado' -> 'dbo' y 'sys'.

'Perteneciente al rol de la base de datos para: (Comic o ComicTests)' -> 'public'.

Posteriorment, realizar el siguiente proceso para ambas db; 'Comic' y 'ComicTest'.

Ingresar a 'Bases de datos' -> ('Comic' o 'ComicTests') -> 'Seguridad' -> 'Usuarios' -> 'OpenAPICSharp' (Click derecho y 'Propiedades') -> 'Elementos protegibles' -> 'Buscar' -> 'Objetos especificos' -> 'Aceptar'. 'Tipos de objeto' -> 'Tablas', 'Procedimientos almacenados', 'Funciones'(Funciones Escalar) y 'Vistas'([sys].[time_zone_info]) -> 'Examinar' -> 'Aceptar' -> 'Aceptar'. Seleccionar todos los objetos creados para la db por los nombres estipulados en su comienzo.

Permisos para procedimientos de almacenados y funciones escalar: 'Ejecutar' WITH GRANT

Permisos para tablas: 'Actualizar', 'Insertar', 'Eliminar', 'Seleccionar' WITH GRANT

Permisos para vistas: 'Seleccionar' WITH GRANT

## Construido con 🛠️

* [SQL Server](https://www.microsoft.com/es-es/sql-server/sql-server-downloads) - Base de datos SQL Server

## Autores ✒️

* **Ignacio Chávez** - *Trabajo Inicial*
* **Ignacio Chávez** - *Documentación*

© Copyright IgnacioChávez, Todos Los Derechos Reservados
