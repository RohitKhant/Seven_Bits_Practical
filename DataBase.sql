USE [master]
GO
/****** Object:  Database [Seven_Bits]    Script Date: 2/19/2021 1:26:07 AM ******/
CREATE DATABASE [Seven_Bits]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Seven_Bits', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Seven_Bits.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Seven_Bits_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Seven_Bits_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Seven_Bits] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Seven_Bits].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Seven_Bits] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Seven_Bits] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Seven_Bits] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Seven_Bits] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Seven_Bits] SET ARITHABORT OFF 
GO
ALTER DATABASE [Seven_Bits] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Seven_Bits] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Seven_Bits] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Seven_Bits] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Seven_Bits] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Seven_Bits] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Seven_Bits] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Seven_Bits] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Seven_Bits] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Seven_Bits] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Seven_Bits] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Seven_Bits] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Seven_Bits] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Seven_Bits] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Seven_Bits] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Seven_Bits] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Seven_Bits] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Seven_Bits] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Seven_Bits] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Seven_Bits] SET  MULTI_USER 
GO
ALTER DATABASE [Seven_Bits] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Seven_Bits] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Seven_Bits] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Seven_Bits] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Seven_Bits]
GO
/****** Object:  StoredProcedure [dbo].[EmployeeListByFilter]    Script Date: 2/19/2021 1:26:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[EmployeeListByFilter] '1-1-1990','1-1-2020',12
CREATE PROCEDURE [dbo].[EmployeeListByFilter]	
	@StartDate DATETIME = NULL,
	@EndDate DATETIME = NULL,
	@Id int
	
AS
BEGIN
	SET NOCOUNT ON;


	SELECT top 1 E.Id,E.Name,E.Department,E.DOB,ES.Salary,(select AVG(Salary) from EmployeeSalary) as avgsalary
	FROM
	Employee E
	inner JOIN EmployeeSalary ES On ES.EmpId =E.Id
	WHERE
	CONVERT(date, E.DOB) >= CONVERT(date, @StartDate) AND CONVERT(date, E.DOB) <= CONVERT(date, @EndDate)
	AND E.Id =@Id
END
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 2/19/2021 1:26:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Department] [int] NOT NULL,
	[DOB] [datetime2](7) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmployeeSalary]    Script Date: 2/19/2021 1:26:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeSalary](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmpId] [int] NULL,
	[Salary] [money] NULL,
 CONSTRAINT [PK_EmployeeSalary] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (11, N'Employee1', 1, CAST(N'2020-01-01 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (12, N'Employee2', 2, CAST(N'2019-02-12 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (13, N'Employee3', 3, CAST(N'2018-07-12 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (14, N'Employee4', 5, CAST(N'2017-06-29 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Employee] ([Id], [Name], [Department], [DOB]) VALUES (15, N'Employee5', 6, CAST(N'2016-11-14 00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Employee] OFF
SET IDENTITY_INSERT [dbo].[EmployeeSalary] ON 

INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (4, 11, 25000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (5, 11, 30000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (6, 11, 35000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (7, 12, 20000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (8, 12, 35000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (9, 13, 15000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (10, 13, 35000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (11, 14, 20000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (12, 14, 30000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (13, 14, 40000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (14, 15, 25000.0000)
INSERT [dbo].[EmployeeSalary] ([Id], [EmpId], [Salary]) VALUES (15, 15, 35000.0000)
SET IDENTITY_INSERT [dbo].[EmployeeSalary] OFF
ALTER TABLE [dbo].[EmployeeSalary]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeSalary_Employee] FOREIGN KEY([EmpId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[EmployeeSalary] CHECK CONSTRAINT [FK_EmployeeSalary_Employee]
GO
USE [master]
GO
ALTER DATABASE [Seven_Bits] SET  READ_WRITE 
GO
