USE [ComicTests]
GO

DECLARE	@return_value int

EXEC	[dbo].[SPInsertUser]
		@Rut = '1-9',
		@Name = 'Ignacio',
		@LastName = 'Chávez',
		@BirthDate = '2000-01-01',
		@Password = '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',--123456
		@Active = 1,
		@Registered = '2023-02-18T16:00:00.0000000+00:00',
		@Email = 'ignacio.chavez4646@gmail.com',
		@Phone = '+56932151752',
		@RoleId = 1

EXEC	[dbo].[SPInsertUser]
		@Rut = '2-7',
		@Name = 'Jose',
		@LastName = 'Gonzalez',
		@BirthDate = '2005-08-19',
		@Password = '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',--123456
		@Active = 1,
		@Registered = '2023-02-18T16:00:00.0000000+00:00',
		@Email = 'jose.gonzales@gmail.com',
		@Phone = '+56912345678',
		@RoleId = 2

EXEC	[dbo].[SPInsertUser]
		@Rut = '3-5',
		@Name = 'Luis',
		@LastName = 'Romo',
		@BirthDate = '2008-01-28',
		@Password = '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',--123456
		@Active = 1,
		@Registered = '2023-02-18T16:00:00.0000000+00:00',
		@Email = 'luis.romo@gmail.com',
		@Phone = '+56912345678',
		@RoleId = 3


GO
