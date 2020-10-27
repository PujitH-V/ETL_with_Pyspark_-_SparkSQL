/****** Object:  Schema [excell]    Script Date: 10/27/2020 5:25:38 PM ******/
CREATE SCHEMA [excell]
GO
/****** Object:  Schema [histsales]    Script Date: 10/27/2020 5:25:38 PM ******/
CREATE SCHEMA [histsales]
GO
/****** Object:  Schema [incr]    Script Date: 10/27/2020 5:25:38 PM ******/
CREATE SCHEMA [incr]
GO
/****** Object:  Schema [incrsales]    Script Date: 10/27/2020 5:25:38 PM ******/
CREATE SCHEMA [incrsales]
GO
/****** Object:  Schema [metadata]    Script Date: 10/27/2020 5:25:38 PM ******/
CREATE SCHEMA [metadata]
GO
/****** Object:  Schema [salessrc]    Script Date: 10/27/2020 5:25:38 PM ******/
CREATE SCHEMA [salessrc]
GO
/****** Object:  Schema [vvin]    Script Date: 10/27/2020 5:25:38 PM ******/
CREATE SCHEMA [vvin]
GO
/****** Object:  Table [histsales].[payment_types_lookup]    Script Date: 10/27/2020 5:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [histsales].[payment_types_lookup](
	[payment_type_Id] [int] IDENTITY(1,1) NOT NULL,
	[payment_type_value] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_type_Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [histsales].[products]    Script Date: 10/27/2020 5:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [histsales].[products](
	[product_id] [int] NOT NULL,
	[product_name] [varchar](100) NOT NULL,
	[product_unit_cost] [money] NOT NULL,
	[product_max_discount_price] [money] NULL,
	[product_seller_id] [nvarchar](40) NOT NULL,
	[product_created_timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [histsales].[sellers]    Script Date: 10/27/2020 5:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [histsales].[sellers](
	[seller_id] [nvarchar](40) NOT NULL,
	[seller_organization_name] [nvarchar](60) NOT NULL,
	[seller_state] [nvarchar](50) NULL,
	[seller_city] [nvarchar](50) NOT NULL,
	[seller_address] [nvarchar](200) NULL,
	[sellers_created_timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[seller_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [incrsales].[customers]    Script Date: 10/27/2020 5:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [incrsales].[customers](
	[c_id] [int] IDENTITY(1,1) NOT NULL,
	[c_unique_id] [nvarchar](40) NOT NULL,
	[c_name] [nvarchar](50) NOT NULL,
	[Customer_Account_Created_Timestamp] [datetime] NOT NULL,
	[customer_pincode] [nvarchar](10) NULL,
	[customer_city] [nvarchar](80) NULL,
	[customer_mobile_number] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[c_unique_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [incrsales].[orders]    Script Date: 10/27/2020 5:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [incrsales].[orders](
	[or_id] [int] IDENTITY(1,1) NOT NULL,
	[order_unique_id] [nvarchar](40) NOT NULL,
	[customer_unique_id] [nvarchar](40) NOT NULL,
	[product_id] [int] NOT NULL,
	[order_units] [int] NOT NULL,
	[order_received_timestamp] [datetime] NOT NULL,
	[order_status] [nvarchar](20) NULL,
	[payment_id] [nvarchar](25) NOT NULL,
	[Discount_Applied] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_unique_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [incrsales].[payment_information]    Script Date: 10/27/2020 5:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [incrsales].[payment_information](
	[payment_transaction_id] [nvarchar](25) NOT NULL,
	[payment_type] [int] NOT NULL,
	[payment_status] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_transaction_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [metadata].[lookup_master]    Script Date: 10/27/2020 5:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [metadata].[lookup_master](
	[SubjectId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectName] [nvarchar](20) NOT NULL,
	[src_Schema] [nvarchar](20) NOT NULL,
	[src_TableName] [nvarchar](50) NOT NULL,
	[ADLS_FolderName] [nvarchar](50) NULL,
	[Synapse_DW_Schema] [nvarchar](20) NOT NULL,
	[Synapse_DW_TableName] [nvarchar](50) NOT NULL,
	[LoadType] [nvarchar](10) NULL,
	[threshhold_datetime_value] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubjectId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [histsales].[products] ADD  DEFAULT (getdate()) FOR [product_created_timestamp]
GO
ALTER TABLE [histsales].[sellers] ADD  DEFAULT (getdate()) FOR [sellers_created_timestamp]
GO
ALTER TABLE [incrsales].[customers] ADD  DEFAULT (getdate()) FOR [Customer_Account_Created_Timestamp]
GO
ALTER TABLE [incrsales].[orders] ADD  DEFAULT (getdate()) FOR [order_received_timestamp]
GO
ALTER TABLE [incrsales].[orders] ADD  DEFAULT ('Y') FOR [Discount_Applied]
GO
ALTER TABLE [metadata].[lookup_master] ADD  DEFAULT (NULL) FOR [LoadType]
GO
ALTER TABLE [metadata].[lookup_master] ADD  DEFAULT ('1998-01-05 00:00:01') FOR [threshhold_datetime_value]
GO
ALTER TABLE [salessrc].[metadata] ADD  DEFAULT (NULL) FOR [LoadType]
GO
ALTER TABLE [histsales].[products]  WITH CHECK ADD FOREIGN KEY([product_seller_id])
REFERENCES [histsales].[sellers] ([seller_id])
GO
ALTER TABLE [incrsales].[orders]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Unique_Id] FOREIGN KEY([customer_unique_id])
REFERENCES [incrsales].[customers] ([c_unique_id])
GO
ALTER TABLE [incrsales].[orders] CHECK CONSTRAINT [FK_Customer_Unique_Id]
GO
ALTER TABLE [incrsales].[orders]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Id] FOREIGN KEY([payment_id])
REFERENCES [incrsales].[payment_information] ([payment_transaction_id])
GO
ALTER TABLE [incrsales].[orders] CHECK CONSTRAINT [FK_Payment_Id]
GO
ALTER TABLE [incrsales].[orders]  WITH CHECK ADD  CONSTRAINT [FK_Product_Id] FOREIGN KEY([product_id])
REFERENCES [histsales].[products] ([product_id])
GO
ALTER TABLE [incrsales].[orders] CHECK CONSTRAINT [FK_Product_Id]
GO
ALTER TABLE [incrsales].[payment_information]  WITH CHECK ADD  CONSTRAINT [FK_payment_Type] FOREIGN KEY([payment_type])
REFERENCES [histsales].[payment_types_lookup] ([payment_type_Id])
GO
ALTER TABLE [incrsales].[payment_information] CHECK CONSTRAINT [FK_payment_Type]
GO
