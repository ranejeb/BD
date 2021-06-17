USE [DreamHome]
GO

CREATE TYPE [dbo].[member_no] FROM [smallint] NULL
GO
CREATE TYPE [dbo].[phonenumber] FROM [char](17) NULL
GO
CREATE TYPE [dbo].[postcode] FROM [char](6) NULL
GO
CREATE TYPE [dbo].[shortstring] FROM [varchar](20) NULL
GO

CREATE TABLE [dbo].[BRANCH](
	[Branch_no] [dbo].[member_no] NOT NULL,
	[Postcode] [dbo].[postcode] NULL,
	[City] [dbo].[shortstring] NOT NULL,
	[Street] [dbo].[shortstring] NOT NULL,
	[House] [nchar](10) NULL,
	[Btel_no] [dbo].[phonenumber] NOT NULL,
	[Fax_no] [dbo].[phonenumber] NULL,
 CONSTRAINT [PK_BRANCH] PRIMARY KEY CLUSTERED 
(
	[Branch_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BUYER](
	[Buyer_no] [dbo].[member_no] NOT NULL,
	[FName] [dbo].[shortstring] NOT NULL,
	[LName] [dbo].[shortstring] NOT NULL,
	[City] [dbo].[shortstring] NOT NULL,
	[Street] [dbo].[shortstring] NOT NULL,
	[House] [nchar](6) NOT NULL,
	[Flat] [smallint] NULL,
	[Htel_no] [dbo].[phonenumber] NULL,
	[Wtel_no] [dbo].[phonenumber] NULL,
	[Prof_Rooms] [tinyint] NOT NULL,
	[Max_Price] [money] NOT NULL,
	[Branch_no] [dbo].[member_no] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Buyer_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[CONTRACT](
	[Sale_no] [dbo].[member_no] NOT NULL,
	[Notary_Office] [dbo].[shortstring] NOT NULL,
	[Date_Contract] [smalldatetime] NOT NULL,
	[Service_Cost] [money] NOT NULL,
	[Property_no] [nchar](9) NOT NULL,
	[Buyer_no] [dbo].[member_no] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OWNER](
	[Owner_no] [dbo].[member_no] IDENTITY(1,1) NOT NULL,
	[FName] [dbo].[shortstring] NOT NULL,
	[LName] [dbo].[shortstring] NOT NULL,
	[City] [dbo].[shortstring] NOT NULL,
	[Street] [dbo].[shortstring] NOT NULL,
	[House] [nchar](6) NOT NULL,
	[Flat] [smallint] NULL,
	[Otel_no] [dbo].[phonenumber] NULL,
 CONSTRAINT [PK_OWNER] PRIMARY KEY CLUSTERED 
(
	[Owner_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PROPERTY](
	[Property_no] [nchar](9) NOT NULL,
	[Data_registration] [date] NOT NULL,
	[Postcode] [dbo].[postcode] NULL,
	[City] [dbo].[shortstring] NOT NULL,
	[Street] [dbo].[shortstring] NOT NULL,
	[House] [nchar](6) NOT NULL,
	[Flat] [smallint] NOT NULL,
	[Floor_Type] [nchar](3) NOT NULL,
	[Floor_n] [smallint] NOT NULL,
	[Rooms] [smallint] NOT NULL,
	[The_area] [dbo].[shortstring] NOT NULL,
	[Balcony] [nchar](3) NOT NULL,
	[Ptel] [nchar](1) NOT NULL,
	[Selling_Price] [int] NOT NULL,
	[Branch_no] [dbo].[member_no] NULL,
	[Staff_no] [nchar](9) NULL,
	[Owner_no] [dbo].[member_no] NOT NULL,
 CONSTRAINT [PK_PROPERTY] PRIMARY KEY CLUSTERED 
(
	[Property_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[STAFF](
	[Staff_no] [nchar](9) NOT NULL,
	[FName] [dbo].[shortstring] NOT NULL,
	[LName] [dbo].[shortstring] NOT NULL,
	[DOB] [date] NOT NULL,
	[Sex] [nchar](1) NOT NULL,
	[City] [dbo].[shortstring] NOT NULL,
	[Street] [dbo].[shortstring] NOT NULL,
	[House] [nchar](6) NOT NULL,
	[Flat] [smallint] NOT NULL,
	[Stel_no] [dbo].[phonenumber] NOT NULL,
	[Date_Joined] [date] NOT NULL,
	[Position] [dbo].[shortstring] NOT NULL,
	[Salary] [int] NOT NULL,
	[Branch_no] [dbo].[member_no] NULL,
 CONSTRAINT [PK_STAFF] PRIMARY KEY CLUSTERED 
(
	[Staff_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VIEWING](
	[Date_View] [date] NOT NULL,
	[Comments] [nchar](200) NOT NULL,
	[Property_no] [nchar](9) NOT NULL,
	[Buyer_no] [dbo].[member_no] NOT NULL,
 CONSTRAINT [Viewing_no] PRIMARY KEY CLUSTERED 
(
	[Property_no] ASC,
	[Buyer_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[BUYER]  WITH CHECK ADD  CONSTRAINT [FK_BUYER_BRANCH] FOREIGN KEY([Branch_no])
REFERENCES [dbo].[BRANCH] ([Branch_no])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[CONTRACT]  WITH CHECK ADD  CONSTRAINT [FK_CONTRACT_BUYER] FOREIGN KEY([Buyer_no])
REFERENCES [dbo].[BUYER] ([Buyer_no])
GO

ALTER TABLE [dbo].[PROPERTY]  WITH CHECK ADD FOREIGN KEY([Branch_no])
REFERENCES [dbo].[BRANCH] ([Branch_no])
GO

ALTER TABLE [dbo].[PROPERTY]  WITH CHECK ADD FOREIGN KEY([Branch_no])
REFERENCES [dbo].[BRANCH] ([Branch_no])
GO

ALTER TABLE [dbo].[PROPERTY]  WITH CHECK ADD FOREIGN KEY([Owner_no])
REFERENCES [dbo].[OWNER] ([Owner_no])
GO

ALTER TABLE [dbo].[PROPERTY]  WITH CHECK ADD  CONSTRAINT [staff_no_fk] FOREIGN KEY([Staff_no])
REFERENCES [dbo].[STAFF] ([Staff_no])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[STAFF]  WITH CHECK ADD FOREIGN KEY([Branch_no])
REFERENCES [dbo].[BRANCH] ([Branch_no])
GO

ALTER TABLE [dbo].[VIEWING]  WITH CHECK ADD  CONSTRAINT [FK_VIEWING_BUYER] FOREIGN KEY([Buyer_no])
REFERENCES [dbo].[BUYER] ([Buyer_no])
GO

ALTER TABLE [dbo].[VIEWING]  WITH CHECK ADD  CONSTRAINT [FK_VIEWING_PROPERTY] FOREIGN KEY([Property_no])
REFERENCES [dbo].[PROPERTY] ([Property_no])
GO

ALTER TABLE [dbo].[BRANCH]  WITH CHECK ADD  CONSTRAINT [CK_BRANCH] CHECK  (([Btel_no] like '8(021[2-6][0-9])[0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
GO
ALTER TABLE [dbo].[BUYER]  WITH CHECK ADD CHECK  (([Htel_no] IS NOT NULL OR [Wtel_no] IS NOT NULL))
GO

ALTER TABLE [dbo].[STAFF]  WITH CHECK ADD  CONSTRAINT [check_Sex] CHECK  (([Sex]='æ' OR [Sex]='ì' OR [Sex]='Æ' OR [Sex]='Ì'))
GO

ALTER TABLE [dbo].[PROPERTY] ADD  DEFAULT ('Ò') FOR [Ptel]
GO

CREATE INDEX [FName] ON [dbo].[STAFF] (FName)
GO

CREATE INDEX [Position] ON [dbo].[STAFF] (Position)
GO

CREATE INDEX [Date_View] ON [dbo].[VIEWING]
