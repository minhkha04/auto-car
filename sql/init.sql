USE [master]
GO
/****** Object:  Database [Car_Dealership]    Script Date: 8/03/2025 11:47:53 am ******/
CREATE DATABASE [Car_Dealership]
GO
USE [Car_Dealership]
GO
/****** Object:  Table [dbo].[Cars]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cars](
	[carID] [decimal](18, 0) NOT NULL,
	[serialNumber] [nvarchar](100) NULL,
	[model] [nvarchar](100) NULL,
	[colour] [nvarchar](100) NULL,
	[year] [int] NULL,
	[price] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[carID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[custID] [decimal](18, 0) NOT NULL,
	[custName] [nvarchar](100) NULL,
	[phone] [decimal](18, 0) NULL,
	[sex] [char](5) NULL,
	[cusAddress] [nvarchar](100) NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[custID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mechanic]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mechanic](
	[mechanicID] [decimal](18, 0) NOT NULL,
	[mechanicName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[mechanicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parts]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parts](
	[partID] [decimal](18, 0) NOT NULL,
	[partName] [nvarchar](100) NULL,
	[purchasePrice] [money] NULL,
	[retailPrice] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[partID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartsUsed]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartsUsed](
	[serviceTicketID] [int] NOT NULL,
	[partID] [decimal](18, 0) NOT NULL,
	[numberUsed] [int] NULL,
	[price] [money] NULL,
 CONSTRAINT [PRK_serviceTicketID_partID] PRIMARY KEY CLUSTERED 
(
	[serviceTicketID] ASC,
	[partID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesInvoice]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesInvoice](
	[invoiceID] [int] NOT NULL,
	[invoiceDate] [date] NULL,
	[salesID] [decimal](18, 0) NULL,
	[carID] [decimal](18, 0) NULL,
	[custID] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[invoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesPerson]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesPerson](
	[salesID] [decimal](18, 0) NOT NULL,
	[salesName] [nvarchar](100) NULL,
	[birthday] [date] NULL,
	[sex] [char](5) NULL,
	[salesAddress] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[salesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[serviceID] [int] NOT NULL,
	[serviceName] [nvarchar](100) NULL,
	[hourlyRate] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[serviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceMehanic]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceMehanic](
	[serviceTicketID] [int] NOT NULL,
	[serviceID] [int] NOT NULL,
	[mechanicID] [decimal](18, 0) NOT NULL,
	[hours] [int] NULL,
	[comment] [text] NULL,
	[rate] [money] NULL,
 CONSTRAINT [PRK_serviceTicketID_serviceID_mechanicID] PRIMARY KEY CLUSTERED 
(
	[serviceTicketID] ASC,
	[serviceID] ASC,
	[mechanicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceTicket]    Script Date: 8/03/2025 11:47:53 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceTicket](
	[serviceTicketID] [int] NOT NULL,
	[dateReceived] [date] NULL,
	[dateReturned] [date] NULL,
	[custID] [decimal](18, 0) NULL,
	[carID] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[serviceTicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334454 AS Decimal(18, 0)), N'2ABC2ABC2ABC2ABC2', N'chevrolet', N'Silver', 2017, 800000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334455 AS Decimal(18, 0)), N'1ABC1ABC1ABC1ABC1', N'volkswagen', N'Black', 2017, 950000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334456 AS Decimal(18, 0)), N'3ABC3ABC3ABC3ABC3', N'Tundra LX', N'Gray', 2019, 1200000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334457 AS Decimal(18, 0)), N'4ABC4ABC4ABC4ABC4', N'plymouth', N'Tan', 2019, 750000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334458 AS Decimal(18, 0)), N'5ABC5ABC5ABC5ABC5', N'amc', N'White', 2020, 640000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334459 AS Decimal(18, 0)), N'6ABC6ABC6ABC6ABC6', N'ford', N'Black', 2017, 780000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334460 AS Decimal(18, 0)), N'7ABC7ABC7ABC7ABC7', N'Vehicle', N'Silver', 2019, 1100000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334470 AS Decimal(18, 0)), N'8ABC8ABC8ABC8ABC8', N'pontiac', N'Gray', 2017, 870000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334471 AS Decimal(18, 0)), N'9ABC9ABC9ABC9ABC9', N'Escape', N'Tan', 2020, 980000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334472 AS Decimal(18, 0)), N'10ABC10ABC10ABC10', N'TLX', N'White', 2017, 890000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334473 AS Decimal(18, 0)), N'11ABC11ABC11ABC11', N'buick', N'Black', 2017, 990000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334474 AS Decimal(18, 0)), N'12ABC12ABC12ABC12', N'citroen', N'Silver', 2019, 1020000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334475 AS Decimal(18, 0)), N'13ABC13ABC13ABC13', N'toyota', N'Gray', 2017, 1150000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334476 AS Decimal(18, 0)), N'14ACB14ABC14ABC14', N'Escape', N'Tan', 2020, 870000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334477 AS Decimal(18, 0)), N'15ABC15ABC15ABC15', N'chevrolet', N'White', 2017, 750000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334478 AS Decimal(18, 0)), N'16ABC16ABC16ABC16', N'Grand Caravan', N'Black', 2017, 1400000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334479 AS Decimal(18, 0)), N'17ABC17ABC17ABC17', N'audi', N'Silver', 2019, 1500000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334480 AS Decimal(18, 0)), N'18ABC18ABC18ABC18', N'bmw', N'Gray', 2017, 1700000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334481 AS Decimal(18, 0)), N'19ABC19ACB19ABC19', N'Escape', N'Tan', 2020, 1250000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334482 AS Decimal(18, 0)), N'20ABC20ABC20ABC20', N'TLX', N'White', 2017, 1150000000)
INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) VALUES (CAST(1122334483 AS Decimal(18, 0)), N'21ABC21ABC21ABC21', N'dodge', N'Black', 2017, 1350000000)
GO
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11013 AS Decimal(18, 0)), N'Phạm Nguyên Dũng', CAST(906572342 AS Decimal(18, 0)), N'M    ', N'Long An', 1)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11019 AS Decimal(18, 0)), N'Nguyễn Thị Thùy Dung', CAST(753634123 AS Decimal(18, 0)), N'F    ', N'TP. Hà Nội', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11024 AS Decimal(18, 0)), N'Hà Mỹ Duyên', CAST(763989821 AS Decimal(18, 0)), N'F    ', N'Nam Định', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11032 AS Decimal(18, 0)), N'Bùi Phương Ngọc', CAST(903426751 AS Decimal(18, 0)), N'M    ', N'Vũng Tàu', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11037 AS Decimal(18, 0)), N'Nguyễn Thạc Hải', CAST(112755456 AS Decimal(18, 0)), N'M    ', N'Khánh Hòa', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11051 AS Decimal(18, 0)), N'Phan Thành Đăng', CAST(12272718 AS Decimal(18, 0)), N'M    ', N'Khánh Hòa', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11055 AS Decimal(18, 0)), N'Nguyễn Thị Minh Hằng', CAST(987653421 AS Decimal(18, 0)), N'F    ', N'Nha Trang', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11076 AS Decimal(18, 0)), N'Đoàn Minh Đạo', CAST(879355621 AS Decimal(18, 0)), N'M    ', N'Huế', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11077 AS Decimal(18, 0)), N'Nguyễn Thị Thu Hằng', CAST(81200176 AS Decimal(18, 0)), N'F    ', N'Bình Thuận', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11078 AS Decimal(18, 0)), N'Vương Thị Kim Cúc', CAST(904532178 AS Decimal(18, 0)), N'F    ', N'Huế', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11089 AS Decimal(18, 0)), N'Huỳnh Thị Ngọc Điệp', CAST(907772818 AS Decimal(18, 0)), N'F    ', N'Thanh Hóa', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11095 AS Decimal(18, 0)), N'Hồ Đức Trung Hữu', CAST(1278654321 AS Decimal(18, 0)), N'M    ', N'Thanh Hóa ', 0)
INSERT [dbo].[Customer] ([custID], [custName], [phone], [sex], [cusAddress], [isDeleted]) VALUES (CAST(11098 AS Decimal(18, 0)), N'Nguyễn Thị Minh Hà', CAST(907865432 AS Decimal(18, 0)), N'F    ', N'TP. Hà Nội', 1)
GO
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230025 AS Decimal(18, 0)), N'Cao Xuân Trường')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230026 AS Decimal(18, 0)), N'Nguyễn Nam Ninh')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230027 AS Decimal(18, 0)), N'Đoàn Huy An')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230031 AS Decimal(18, 0)), N'Cao Văn Minh')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230032 AS Decimal(18, 0)), N'Bùi Minh Tiến')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230033 AS Decimal(18, 0)), N'Lê Văn Bình')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230034 AS Decimal(18, 0)), N'Nguyễn Văn Linh')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230035 AS Decimal(18, 0)), N'Trường Văn Cao')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230038 AS Decimal(18, 0)), N'Mai Huy Ân')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230039 AS Decimal(18, 0)), N'Bùi Văn Thịnh')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230040 AS Decimal(18, 0)), N'Nguyễn Xuân Thịnh')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230041 AS Decimal(18, 0)), N'Lê Hào')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230060 AS Decimal(18, 0)), N'Nguyễn Văn Sang')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230062 AS Decimal(18, 0)), N'Lê Minh Tâm')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230142 AS Decimal(18, 0)), N'Bùi Văn Nhất')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230143 AS Decimal(18, 0)), N'Ngô Đăng Khoa')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230158 AS Decimal(18, 0)), N'Thái Văn Hiếu')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230159 AS Decimal(18, 0)), N'Trường Xuân Đức')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230244 AS Decimal(18, 0)), N'Ngô Mạnh Quỳnh')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230245 AS Decimal(18, 0)), N'Ngô Văn Tiến')
INSERT [dbo].[Mechanic] ([mechanicID], [mechanicName]) VALUES (CAST(41051230246 AS Decimal(18, 0)), N'Nguyễn Minh Huy')
GO
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(101 AS Decimal(18, 0)), N'Ắc quy', 1345000.0000, 1750000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(102 AS Decimal(18, 0)), N'Dầu trợ lực lái', 12000.0000, 155000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(103 AS Decimal(18, 0)), N'Lọc nhiên liệu', 78000.0000, 99000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(104 AS Decimal(18, 0)), N'Lọc gió động cơ', 120000.0000, 155000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(105 AS Decimal(18, 0)), N'Dầu hộp số tự động', 215000.0000, 266000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(106 AS Decimal(18, 0)), N'Bugi đánh lửa', 38000.0000, 45000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(107 AS Decimal(18, 0)), N'Dây curoa động cơ và dây curoa cam', 278000.0000, 350000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(108 AS Decimal(18, 0)), N'Dung dịch nước làm mát', 38000.0000, 45000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(109 AS Decimal(18, 0)), N'Lốp xe', 1030000.0000, 1200000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(110 AS Decimal(18, 0)), N'Dầu phanh', 34000.0000, 55000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(111 AS Decimal(18, 0)), N'Má phanh', 370000.0000, 450000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(112 AS Decimal(18, 0)), N'Kính chắn gió', 1420000.0000, 1500000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(113 AS Decimal(18, 0)), N'Cần gạt nước', 280000.0000, 396000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(114 AS Decimal(18, 0)), N'Hệ thống đèn', 1750000.0000, 2000000.0000)
INSERT [dbo].[Parts] ([partID], [partName], [purchasePrice], [retailPrice]) VALUES (CAST(115 AS Decimal(18, 0)), N'Bộ lọc không khí', 176000.0000, 200000.0000)
GO
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111231, CAST(112 AS Decimal(18, 0)), 1, 1500000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111231, CAST(115 AS Decimal(18, 0)), 1, 200000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111232, CAST(102 AS Decimal(18, 0)), 1, 155000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111234, CAST(107 AS Decimal(18, 0)), 1, 350000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111235, CAST(102 AS Decimal(18, 0)), 1, 155000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111235, CAST(115 AS Decimal(18, 0)), 1, 200000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111236, CAST(103 AS Decimal(18, 0)), 1, 99000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111236, CAST(110 AS Decimal(18, 0)), 1, 55000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111236, CAST(112 AS Decimal(18, 0)), 1, 1500000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111237, CAST(104 AS Decimal(18, 0)), 1, 155000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111237, CAST(106 AS Decimal(18, 0)), 1, 45000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111238, CAST(114 AS Decimal(18, 0)), 1, 2000000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111243, CAST(101 AS Decimal(18, 0)), 1, 1750000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111244, CAST(111 AS Decimal(18, 0)), 1, 450000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111244, CAST(113 AS Decimal(18, 0)), 1, 396000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111245, CAST(115 AS Decimal(18, 0)), 1, 200000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111248, CAST(101 AS Decimal(18, 0)), 21, 1345000.0000)
INSERT [dbo].[PartsUsed] ([serviceTicketID], [partID], [numberUsed], [price]) VALUES (10111248, CAST(108 AS Decimal(18, 0)), 22, 38000.0000)
GO
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (1, CAST(N'2021-01-01' AS Date), CAST(30121050004 AS Decimal(18, 0)), CAST(1122334454 AS Decimal(18, 0)), CAST(11013 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (2, CAST(N'2020-01-14' AS Date), CAST(30121050015 AS Decimal(18, 0)), CAST(1122334455 AS Decimal(18, 0)), CAST(11019 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (3, CAST(N'2021-02-25' AS Date), CAST(30121050027 AS Decimal(18, 0)), CAST(1122334456 AS Decimal(18, 0)), CAST(11024 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (4, CAST(N'2020-04-15' AS Date), CAST(30121050035 AS Decimal(18, 0)), CAST(1122334457 AS Decimal(18, 0)), CAST(11032 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (5, CAST(N'2021-05-23' AS Date), CAST(30121050037 AS Decimal(18, 0)), CAST(1122334458 AS Decimal(18, 0)), CAST(11037 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (6, CAST(N'2021-05-24' AS Date), CAST(30121050038 AS Decimal(18, 0)), CAST(1122334459 AS Decimal(18, 0)), CAST(11051 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (7, CAST(N'2020-05-12' AS Date), CAST(30121050035 AS Decimal(18, 0)), CAST(1122334460 AS Decimal(18, 0)), CAST(11055 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (8, CAST(N'2020-10-20' AS Date), CAST(30121050060 AS Decimal(18, 0)), CAST(1122334470 AS Decimal(18, 0)), CAST(11076 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (9, CAST(N'2020-12-15' AS Date), CAST(30121050142 AS Decimal(18, 0)), CAST(1122334471 AS Decimal(18, 0)), CAST(11077 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (10, CAST(N'2020-11-20' AS Date), CAST(30121050027 AS Decimal(18, 0)), CAST(1122334472 AS Decimal(18, 0)), CAST(11078 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (11, CAST(N'2020-01-15' AS Date), CAST(30121050038 AS Decimal(18, 0)), CAST(1122334473 AS Decimal(18, 0)), CAST(11089 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (12, CAST(N'2021-03-18' AS Date), CAST(30121050184 AS Decimal(18, 0)), CAST(1122334474 AS Decimal(18, 0)), CAST(11095 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (13, CAST(N'2020-06-24' AS Date), CAST(30121050142 AS Decimal(18, 0)), CAST(1122334475 AS Decimal(18, 0)), CAST(11098 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (14, CAST(N'2021-08-10' AS Date), CAST(30121050265 AS Decimal(18, 0)), CAST(1122334476 AS Decimal(18, 0)), CAST(11051 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (15, CAST(N'2020-05-05' AS Date), CAST(30121050035 AS Decimal(18, 0)), CAST(1122334477 AS Decimal(18, 0)), CAST(11095 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (16, CAST(N'2021-12-17' AS Date), CAST(30121050038 AS Decimal(18, 0)), CAST(1122334478 AS Decimal(18, 0)), CAST(11032 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (17, CAST(N'2020-11-11' AS Date), CAST(30121050027 AS Decimal(18, 0)), CAST(1122334479 AS Decimal(18, 0)), CAST(11076 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (18, CAST(N'2021-04-27' AS Date), CAST(30121050142 AS Decimal(18, 0)), CAST(1122334480 AS Decimal(18, 0)), CAST(11076 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (19, CAST(N'2020-08-09' AS Date), CAST(30121050341 AS Decimal(18, 0)), CAST(1122334481 AS Decimal(18, 0)), CAST(11051 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (21, CAST(N'2020-11-24' AS Date), CAST(30121050027 AS Decimal(18, 0)), CAST(1122334483 AS Decimal(18, 0)), CAST(11013 AS Decimal(18, 0)))
INSERT [dbo].[SalesInvoice] ([invoiceID], [invoiceDate], [salesID], [carID], [custID]) VALUES (29, CAST(N'2021-07-25' AS Date), CAST(30121050035 AS Decimal(18, 0)), CAST(1122334482 AS Decimal(18, 0)), CAST(11019 AS Decimal(18, 0)))
GO
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050004 AS Decimal(18, 0)), N'Mai Duy An', CAST(N'1968-02-17' AS Date), N'M    ', N'Long An')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050015 AS Decimal(18, 0)), N'Huỳnh Mai Anh', CAST(N'1963-05-04' AS Date), N'F    ', N'TP. Hồ Chí Minh')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050027 AS Decimal(18, 0)), N'Nguyễn Thúy Quỳnh Anh', CAST(N'1977-04-10' AS Date), N'F    ', N'Nam Định')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050035 AS Decimal(18, 0)), N'Tống Thị Lan Anh', CAST(N'1978-10-28' AS Date), N'F    ', N'Vũng Tàu')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050037 AS Decimal(18, 0)), N'Võ Việt Anh', CAST(N'1974-11-11' AS Date), N'M    ', N'Khánh Hòa')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050038 AS Decimal(18, 0)), N'Vũ Thuỵ Hồng Anh', CAST(N'1966-06-13' AS Date), N'F    ', N'TP. Hồ Chí Minh')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050049 AS Decimal(18, 0)), N'Trần Nguyễn Phương Bình', CAST(N'1959-05-17' AS Date), N'F    ', N'TP. Hồ Chí Minh')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050060 AS Decimal(18, 0)), N'Trần Thiện Bảo', CAST(N'1955-12-26' AS Date), N'M    ', N'TP. Hồ Chí Minh')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050142 AS Decimal(18, 0)), N'Nguyễn Hoàng Dũng', CAST(N'1956-02-26' AS Date), N'M    ', N'TP. Hồ Chí Minh')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050158 AS Decimal(18, 0)), N'Lê Hoàng Linh Giang', CAST(N'1957-07-16' AS Date), N'M    ', N'Huế')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050180 AS Decimal(18, 0)), N'Trần Ngọc Như Hằng', CAST(N'1970-05-29' AS Date), N'F    ', N'TP. Hồ Chí Minh')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050184 AS Decimal(18, 0)), N'Nguyễn Thị Minh Hưng', CAST(N'1976-12-23' AS Date), N'FS   ', N'Thanh Hóa ')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050254 AS Decimal(18, 0)), N'Bùi Thị Thu Hương', CAST(N'1970-01-06' AS Date), N'F    ', N'TP. Hà Nội')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050265 AS Decimal(18, 0)), N'Phạm Thị Ngọc Hảo', CAST(N'1975-02-04' AS Date), N'F    ', N'Gia Lai')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050294 AS Decimal(18, 0)), N'Trịnh Hạnh', CAST(N'1977-02-12' AS Date), N'F    ', N'TP. Đà Nẵng')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050295 AS Decimal(18, 0)), N'Huỳnh Thị Như Hồng', CAST(N'1970-08-14' AS Date), N'F    ', N'TP. Cần Thơ')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050322 AS Decimal(18, 0)), N'Đỗ Thị Thúy Hùng', CAST(N'1963-01-22' AS Date), N'F    ', N'Sông Bé')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050336 AS Decimal(18, 0)), N'Trương Thanh Hiền', CAST(N'1963-05-16' AS Date), N'M    ', N'TP. Hải Phòng')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050341 AS Decimal(18, 0)), N'Nguyễn Đặng Hiếu', CAST(N'1970-08-30' AS Date), N'M    ', N'TP. Hồ Chí Minh')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050418 AS Decimal(18, 0)), N'Vũ Phạm Minh Hương', CAST(N'1971-08-17' AS Date), N'M    ', N'TP. Hà Nội')
INSERT [dbo].[SalesPerson] ([salesID], [salesName], [birthday], [sex], [salesAddress]) VALUES (CAST(30121050982 AS Decimal(18, 0)), N'Hồ Việt Hoà', CAST(N'1970-02-03' AS Date), N'M    ', N'Đồng Nai')
GO
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (1, N'Thay nhớt', 1000000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (2, N'Vệ sinh lọc gió động cơ', 2000000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (3, N'Vệ sinh lọc điều hòa, máy lạnh', 1800000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (4, N'Thay lọc nhớt', 18800000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (5, N'Đảo lốp', 2000000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (6, N'Thay lọc gió điều hòa', 1750000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (7, N'Kiểm tra và vệ sinh phanh', 1650000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (8, N'Thay dầu phanh + dầu tay lái (nếu có), dầu hộp số, dầu cần sau', 3800000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (9, N'Thay nước làm mát', 4000000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (10, N'Thay lọc nhiên liệu (xăng hoặc dầu tùy xe sử dụng)', 6500000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (11, N'Thay dây curoa', 7600000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (12, N'Thay bugi', 1000000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (13, N'Kiểm tra hệ thống lái', 800000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (14, N'Kiểm tra hệ thống đèn', 7500000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (15, N'Kiểm tra Gầm', 6800000.0000)
INSERT [dbo].[Service] ([serviceID], [serviceName], [hourlyRate]) VALUES (16, N'Kiểm tra hệ thống gạt mưa', 3200000.0000)
GO
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111231, 1, CAST(41051230025 AS Decimal(18, 0)), 3, NULL, 1000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111231, 2, CAST(41051230025 AS Decimal(18, 0)), 2, NULL, 2000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111231, 3, CAST(41051230026 AS Decimal(18, 0)), 1, NULL, 1800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111232, 4, CAST(41051230027 AS Decimal(18, 0)), 2, NULL, 18800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111232, 5, CAST(41051230031 AS Decimal(18, 0)), 4, NULL, 2000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111232, 12, CAST(41051230032 AS Decimal(18, 0)), 2, NULL, 1000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111233, 7, CAST(41051230033 AS Decimal(18, 0)), 5, NULL, 1650000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111233, 8, CAST(41051230033 AS Decimal(18, 0)), 1, NULL, 3800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111233, 9, CAST(41051230033 AS Decimal(18, 0)), 4, NULL, 4000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111234, 10, CAST(41051230034 AS Decimal(18, 0)), 2, NULL, 6500000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111235, 1, CAST(41051230038 AS Decimal(18, 0)), 1, NULL, 1000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111235, 2, CAST(41051230039 AS Decimal(18, 0)), 1, NULL, 2000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111235, 11, CAST(41051230035 AS Decimal(18, 0)), 2, NULL, 7600000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111236, 1, CAST(41051230041 AS Decimal(18, 0)), 1, NULL, 1000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111236, 13, CAST(41051230040 AS Decimal(18, 0)), 2, NULL, 800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111236, 15, CAST(41051230041 AS Decimal(18, 0)), 3, NULL, 6800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111237, 5, CAST(41051230032 AS Decimal(18, 0)), 2, NULL, 2000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111237, 10, CAST(41051230062 AS Decimal(18, 0)), 3, NULL, 6500000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111237, 16, CAST(41051230060 AS Decimal(18, 0)), 5, NULL, 3200000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111238, 2, CAST(41051230143 AS Decimal(18, 0)), 1, NULL, 2000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111238, 7, CAST(41051230244 AS Decimal(18, 0)), 3, NULL, 1650000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111238, 12, CAST(41051230142 AS Decimal(18, 0)), 4, NULL, 1000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111238, 15, CAST(41051230159 AS Decimal(18, 0)), 5, NULL, 6800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111239, 4, CAST(41051230245 AS Decimal(18, 0)), 2, NULL, 18800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111239, 5, CAST(41051230246 AS Decimal(18, 0)), 2, NULL, 2000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111240, 2, CAST(41051230031 AS Decimal(18, 0)), 2, NULL, 2000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111240, 7, CAST(41051230244 AS Decimal(18, 0)), 4, NULL, 1650000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111240, 16, CAST(41051230041 AS Decimal(18, 0)), 1, NULL, 1000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111241, 3, CAST(41051230032 AS Decimal(18, 0)), 2, NULL, 1800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111241, 5, CAST(41051230026 AS Decimal(18, 0)), 2, NULL, 2000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111241, 11, CAST(41051230060 AS Decimal(18, 0)), 1, NULL, 7600000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111242, 16, CAST(41051230158 AS Decimal(18, 0)), 5, NULL, 3200000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111243, 13, CAST(41051230034 AS Decimal(18, 0)), 6, NULL, 800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111244, 3, CAST(41051230025 AS Decimal(18, 0)), 1, NULL, 1800000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111244, 10, CAST(41051230142 AS Decimal(18, 0)), 2, NULL, 6500000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111245, 12, CAST(41051230038 AS Decimal(18, 0)), 2, NULL, 1000000.0000)
INSERT [dbo].[ServiceMehanic] ([serviceTicketID], [serviceID], [mechanicID], [hours], [comment], [rate]) VALUES (10111248, 1, CAST(41051230244 AS Decimal(18, 0)), 123, NULL, 1000000.0000)
GO
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111231, CAST(N'2021-02-01' AS Date), CAST(N'2021-02-07' AS Date), CAST(11013 AS Decimal(18, 0)), CAST(1122334454 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111232, CAST(N'2021-12-10' AS Date), CAST(N'2021-12-18' AS Date), CAST(11078 AS Decimal(18, 0)), CAST(1122334472 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111233, CAST(N'2020-02-07' AS Date), CAST(N'2020-02-19' AS Date), CAST(11089 AS Decimal(18, 0)), CAST(1122334473 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111234, CAST(N'2021-12-19' AS Date), CAST(N'2021-12-27' AS Date), CAST(11095 AS Decimal(18, 0)), CAST(1122334474 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111235, CAST(N'2021-03-17' AS Date), CAST(N'2021-03-29' AS Date), CAST(11098 AS Decimal(18, 0)), CAST(1122334475 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111236, CAST(N'2021-12-01' AS Date), CAST(N'2021-12-06' AS Date), CAST(11051 AS Decimal(18, 0)), CAST(1122334476 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111237, CAST(N'2021-03-15' AS Date), CAST(N'2021-03-20' AS Date), CAST(11095 AS Decimal(18, 0)), CAST(1122334477 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111238, CAST(N'2022-08-01' AS Date), CAST(N'2022-08-05' AS Date), CAST(11032 AS Decimal(18, 0)), CAST(1122334478 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111239, CAST(N'2021-03-15' AS Date), CAST(N'2021-03-16' AS Date), CAST(11076 AS Decimal(18, 0)), CAST(1122334479 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111240, CAST(N'2022-08-01' AS Date), CAST(N'2022-08-03' AS Date), CAST(11076 AS Decimal(18, 0)), CAST(1122334480 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111241, CAST(N'2021-11-05' AS Date), CAST(N'2021-11-08' AS Date), CAST(11051 AS Decimal(18, 0)), CAST(1122334481 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111242, CAST(N'2021-05-16' AS Date), CAST(N'2021-05-20' AS Date), CAST(11019 AS Decimal(18, 0)), CAST(1122334455 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111243, CAST(N'2021-01-01' AS Date), CAST(N'2021-01-07' AS Date), CAST(11013 AS Decimal(18, 0)), CAST(1122334483 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111244, CAST(N'2021-09-15' AS Date), CAST(N'2021-09-23' AS Date), CAST(11019 AS Decimal(18, 0)), CAST(1122334482 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111245, CAST(N'2022-03-21' AS Date), CAST(N'2022-03-25' AS Date), CAST(11024 AS Decimal(18, 0)), CAST(1122334456 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111246, CAST(N'2025-03-09' AS Date), CAST(N'2025-03-09' AS Date), CAST(11032 AS Decimal(18, 0)), CAST(1122334481 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111247, CAST(N'2025-03-11' AS Date), CAST(N'2025-03-12' AS Date), CAST(11032 AS Decimal(18, 0)), CAST(1122334480 AS Decimal(18, 0)))
INSERT [dbo].[ServiceTicket] ([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) VALUES (10111248, CAST(N'2025-03-11' AS Date), CAST(N'2025-03-12' AS Date), CAST(11032 AS Decimal(18, 0)), CAST(1122334480 AS Decimal(18, 0)))
GO
ALTER TABLE [dbo].[PartsUsed]  WITH CHECK ADD  CONSTRAINT [PK_partID] FOREIGN KEY([partID])
REFERENCES [dbo].[Parts] ([partID])
GO
ALTER TABLE [dbo].[PartsUsed] CHECK CONSTRAINT [PK_partID]
GO
ALTER TABLE [dbo].[PartsUsed]  WITH CHECK ADD  CONSTRAINT [PK_serviceTicketID2] FOREIGN KEY([serviceTicketID])
REFERENCES [dbo].[ServiceTicket] ([serviceTicketID])
GO
ALTER TABLE [dbo].[PartsUsed] CHECK CONSTRAINT [PK_serviceTicketID2]
GO
ALTER TABLE [dbo].[SalesInvoice]  WITH CHECK ADD  CONSTRAINT [PK_carID] FOREIGN KEY([carID])
REFERENCES [dbo].[Cars] ([carID])
GO
ALTER TABLE [dbo].[SalesInvoice] CHECK CONSTRAINT [PK_carID]
GO
ALTER TABLE [dbo].[SalesInvoice]  WITH CHECK ADD  CONSTRAINT [PK_custID] FOREIGN KEY([custID])
REFERENCES [dbo].[Customer] ([custID])
GO
ALTER TABLE [dbo].[SalesInvoice] CHECK CONSTRAINT [PK_custID]
GO
ALTER TABLE [dbo].[SalesInvoice]  WITH CHECK ADD  CONSTRAINT [PK_salesID] FOREIGN KEY([salesID])
REFERENCES [dbo].[SalesPerson] ([salesID])
GO
ALTER TABLE [dbo].[SalesInvoice] CHECK CONSTRAINT [PK_salesID]
GO
ALTER TABLE [dbo].[ServiceMehanic]  WITH CHECK ADD  CONSTRAINT [PK_mechanicID] FOREIGN KEY([mechanicID])
REFERENCES [dbo].[Mechanic] ([mechanicID])
GO
ALTER TABLE [dbo].[ServiceMehanic] CHECK CONSTRAINT [PK_mechanicID]
GO
ALTER TABLE [dbo].[ServiceMehanic]  WITH CHECK ADD  CONSTRAINT [PK_serviceID] FOREIGN KEY([serviceID])
REFERENCES [dbo].[Service] ([serviceID])
GO
ALTER TABLE [dbo].[ServiceMehanic] CHECK CONSTRAINT [PK_serviceID]
GO
ALTER TABLE [dbo].[ServiceMehanic]  WITH CHECK ADD  CONSTRAINT [PK_serviceTicketID] FOREIGN KEY([serviceTicketID])
REFERENCES [dbo].[ServiceTicket] ([serviceTicketID])
GO
ALTER TABLE [dbo].[ServiceMehanic] CHECK CONSTRAINT [PK_serviceTicketID]
GO
ALTER TABLE [dbo].[ServiceTicket]  WITH CHECK ADD  CONSTRAINT [PK_carID2] FOREIGN KEY([carID])
REFERENCES [dbo].[Cars] ([carID])
GO
ALTER TABLE [dbo].[ServiceTicket] CHECK CONSTRAINT [PK_carID2]
GO
ALTER TABLE [dbo].[ServiceTicket]  WITH CHECK ADD  CONSTRAINT [PK_custID2] FOREIGN KEY([custID])
REFERENCES [dbo].[Customer] ([custID])
GO
ALTER TABLE [dbo].[ServiceTicket] CHECK CONSTRAINT [PK_custID2]
GO
USE [master]
GO
ALTER DATABASE [Car_Dealership] SET  READ_WRITE 
GO
