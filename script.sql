USE [libreria]
GO
/****** Object:  Table [dbo].[autor]    Script Date: 17/08/2019 20:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[autor](
	[idautor] [int] NOT NULL,
	[nombreautor] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_autor] PRIMARY KEY CLUSTERED 
(
	[idautor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[estadousuario]    Script Date: 17/08/2019 20:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estadousuario](
	[idestadousuario] [int] NOT NULL,
	[estadousuario] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_estadousuario] PRIMARY KEY CLUSTERED 
(
	[idestadousuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[libro]    Script Date: 17/08/2019 20:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[libro](
	[idlibro] [int] IDENTITY(1,1) NOT NULL,
	[idautor] [int] NOT NULL,
	[titulolibro] [nvarchar](max) NOT NULL,
	[editorial] [nvarchar](max) NOT NULL,
	[pais] [nvarchar](max) NOT NULL,
	[año] [int] NOT NULL,
	[npag] [int] NOT NULL,
	[existencia] [int] NOT NULL,
	[fechaingreso] [datetime] NOT NULL,
 CONSTRAINT [PK_libro] PRIMARY KEY CLUSTERED 
(
	[idlibro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[prestamo]    Script Date: 17/08/2019 20:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prestamo](
	[idprestamo] [int] NOT NULL,
	[idLibro] [int] NOT NULL,
	[idusuario] [int] NOT NULL,
	[fechaprestamo] [datetime] NOT NULL,
	[fechadevo] [datetime] NOT NULL,
	[ndias] [int] NOT NULL,
	[observacion] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_prestamo] PRIMARY KEY CLUSTERED 
(
	[idprestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[usuario]    Script Date: 17/08/2019 20:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[idusuario] [int] IDENTITY(1,1) NOT NULL,
	[idestadousuario] [int] NOT NULL,
	[edadusuario] [int] NOT NULL,
	[apelusuario] [nvarchar](max) NOT NULL,
	[nomusuario] [nvarchar](max) NOT NULL,
	[telusuario] [int] NOT NULL,
	[direccion] [nvarchar](max) NOT NULL,
	[fechaingreso] [datetime] NOT NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[idusuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_autor_libro]    Script Date: 17/08/2019 20:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_autor_libro]
AS
SELECT        dbo.autor.nombreautor, dbo.libro.titulolibro, dbo.libro.editorial, dbo.libro.año, dbo.libro.existencia
FROM            dbo.autor INNER JOIN
                         dbo.libro ON dbo.autor.idautor = dbo.libro.idautor

GO
/****** Object:  View [dbo].[View_usuario_estado_libro_prestamo]    Script Date: 17/08/2019 20:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_usuario_estado_libro_prestamo]
AS
SELECT        dbo.usuario.nomusuario, dbo.usuario.telusuario, dbo.estadousuario.estadousuario, dbo.libro.titulolibro, dbo.prestamo.ndias, dbo.prestamo.fechaprestamo, dbo.prestamo.fechadevo, dbo.prestamo.observacion
FROM            dbo.usuario INNER JOIN
                         dbo.estadousuario ON dbo.usuario.idestadousuario = dbo.estadousuario.idestadousuario INNER JOIN
                         dbo.prestamo ON dbo.usuario.idusuario = dbo.prestamo.idusuario INNER JOIN
                         dbo.libro ON dbo.prestamo.idLibro = dbo.libro.idlibro

GO
ALTER TABLE [dbo].[libro]  WITH CHECK ADD  CONSTRAINT [FK_libro_autor] FOREIGN KEY([idautor])
REFERENCES [dbo].[autor] ([idautor])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[libro] CHECK CONSTRAINT [FK_libro_autor]
GO
ALTER TABLE [dbo].[prestamo]  WITH CHECK ADD  CONSTRAINT [FK_prestamo_libro] FOREIGN KEY([idLibro])
REFERENCES [dbo].[libro] ([idlibro])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[prestamo] CHECK CONSTRAINT [FK_prestamo_libro]
GO
ALTER TABLE [dbo].[prestamo]  WITH CHECK ADD  CONSTRAINT [FK_prestamo_usuario] FOREIGN KEY([idusuario])
REFERENCES [dbo].[usuario] ([idusuario])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[prestamo] CHECK CONSTRAINT [FK_prestamo_usuario]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK_usuario_estadousuario] FOREIGN KEY([idestadousuario])
REFERENCES [dbo].[estadousuario] ([idestadousuario])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_estadousuario]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "autor"
            Begin Extent = 
               Top = 29
               Left = 43
               Bottom = 125
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "libro"
            Begin Extent = 
               Top = 0
               Left = 475
               Bottom = 130
               Right = 683
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_autor_libro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_autor_libro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[30] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "usuario"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "estadousuario"
            Begin Extent = 
               Top = 6
               Left = 284
               Bottom = 102
               Right = 492
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "prestamo"
            Begin Extent = 
               Top = 6
               Left = 530
               Bottom = 136
               Right = 738
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "libro"
            Begin Extent = 
               Top = 102
               Left = 284
               Bottom = 232
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_usuario_estado_libro_prestamo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_usuario_estado_libro_prestamo'
GO
