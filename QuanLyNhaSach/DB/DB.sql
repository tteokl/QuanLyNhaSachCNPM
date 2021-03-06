USE [master]
GO
/****** Object:  Database [QuanLyNhaSach]    Script Date: 12/7/2020 11:30:28 PM ******/
CREATE DATABASE [QuanLyNhaSach]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyNhaSach', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLyNhaSach.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyNhaSach_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLyNhaSach_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyNhaSach] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyNhaSach].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyNhaSach] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyNhaSach] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyNhaSach] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyNhaSach] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyNhaSach] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyNhaSach] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyNhaSach] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QuanLyNhaSach]
GO
/****** Object:  StoredProcedure [dbo].[USP_CapNhatTaiKhoan]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CapNhatTaiKhoan]
@tendn NVARCHAR(50), @tenht NVARCHAR(50), @nhapsach INT, @thongke INT, @kesach INT, @themdl INT, @bansach INT, @tttaikhoan INT, @mkmoi NVARCHAR(50)
AS
BEGIN
	UPDATE TaiKhoan
	SET
		HoTen = @tenht,
		MatKhau = @mkmoi,
		NhapSach = @nhapsach,
		ThongKe = @thongke,
		KeSach = @kesach,
		ThemDuLieu = @themdl,
		BanSach = @bansach,
		TTTaiKhoan = @tttaikhoan
	WHERE
		TenDN = @tenDN
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DangNhap]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DangNhap]
@tenDN NVARCHAR(50), @matKhau NVARCHAR(50)
AS
BEGIN
	SELECT * FROM TaiKhoan WHERE TenDN = @tenDN AND MatKhau = @matKhau
END

GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiNhaXuatBan]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_HienThiNhaXuatBan]
AS
BEGIN
	SELECT
		nxb.MaNXB AS [Mã NXB],
		nxb.TenNXB AS [Tên NXB],
		nxb.DiaChiNXB AS [Địa chỉ NXB],
		nxb.DienThoai AS [Số Điện Thoại]
	FROM
		NhaXuatBan AS nxb
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiSach]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_HienThiSach]
AS
BEGIN
	Select s.MaSach AS [ID], s.TenSach AS [Tên Sách], tg.TenTG AS [Tác Giả],tl.TenTL AS [Thể Loại], nxb.TenNXB AS [Nhà Sản Xuất] ,s.SoLuongTon AS [Số Lượng Tồn],s.GiaTien AS [Giá Tiền]
from Sach s 
inner join ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
inner join TacGia tg on s.MaTG=tg.MaTG
inner join TheLoai tl on s.MaTL=tl.MaTL
inner join NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
END

GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiSachTimKiem]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_HienThiSachTimKiem]
AS
BEGIN
	SELECT
	s.MaSach AS [ID],
	s.TenSach AS [Tên Sách],
	s.SoLuongTon AS [Số Lượng],
	s.GiaTien AS [Giá Tiền]
	FROM Sach s , ChiTietPhieuNhap ct, TacGia tg, TheLoai tl, NhaXuatBan nxb
	WHERE s.MaSach=ct.MaSach AND s.MaTG=tg.MaTG AND s.MaTL=tl.MaTL AND s.MaNXB=nxb.MaNXB
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiTacGia]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_HienThiTacGia]
AS
BEGIN
	SELECT
		tg.MaTG AS [Mã Tác Giả],
		tg.TenTG AS [Tên Tác Giả],
		tg.LienLac AS [Số Điện Thoại]
	FROM
		TacGia AS tg
END

GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiTheLoai]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_HienThiTheLoai]
AS
BEGIN
	SELECT
		tl.MaTL AS [Mã Thể Loại],
		tl.TenTL AS [Tên Thể Loại]
	FROM
		TheLoai AS tl
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SuaTaiKhoan]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SuaTaiKhoan]
@tenDN NVARCHAR(50), @tenHT NVARCHAR(50), @matKhau NVARCHAR(50), @matKhauMoi NVARCHAR(50)
AS
BEGIN
	DECLARE @isMKDung INT = 0
	
	SELECT @isMKDung = COUNT(*) FROM TaiKhoan WHERE @tenDN = TenDN AND @matKhau = MatKhau
	
	IF (@isMKDung = 1)
	BEGIN
		IF (@matKhauMoi = NULL OR @matKhauMoi = '')
		UPDATE TaiKhoan SET HoTen = @tenHT WHERE TenDN = @tenDN
		ELSE
		UPDATE TaiKhoan SET HoTen = @tenHT, MatKhau = @matKhauMoi WHERE TenDN = @tenDN
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThanhToanSach]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ThanhToanSach]
@maSach NVARCHAR(50) , @soLuong INT
AS
BEGIN
	UPDATE Sach
	SET
		SoLuongTon = SoLuongTon - @soLuong
	WHERE MaSach = @maSach
END

GO
/****** Object:  StoredProcedure [dbo].[USP_ThemSach]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ThemSach]
@masach NVARCHAR(50), @tenSach NVARCHAR(100), @sopn NVARCHAR(50), @soluong INT, @giatien INT, @matl NVARCHAR(50), @matg NVARCHAR(50), @manxb NVARCHAR(50), @ngaynhap NVARCHAR(50)
AS
BEGIN
	SET DATEFORMAT DMY
	
	INSERT INTO PhieuNhap
	(
		SoPN,
		NgayNhap,
		MaNXB
	)
	VALUES
	(
		@sopn,
		@ngaynhap,
		@manxb
	)
	
	INSERT INTO Sach
(
	MaSach,
	TenSach,
	SoLuongTon,
	GiaTien,
	MaTL,
	MaTG,
	MaNXB
)
VALUES
(
	@masach,
	@tenSach,
	@soluong,
	@giatien,
	@matl,
	@matg,
	@manxb
)

	INSERT INTO ChiTietPhieuNhap
	(
		MaSach,
		SoPN,
		SoLuongNhap,
		GiaNhap
	)
	VALUES
	(
		@masach,
		@sopn,
		@soluong,
		@giatien
	)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemSLChoSach]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ThemSLChoSach]
@soluong INT, @maSach NVARCHAR(50)
AS
BEGIN
	UPDATE Sach
	SET
		SoLuongTon = SoLuongTon + @soluong
	WHERE
		MaSach = @maSach
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemTaiKhoan]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ThemTaiKhoan]
@tendn NVARCHAR(50),@matkhau NVARCHAR(50), @tenht NVARCHAR(50), @loai INT, @nhapsach INT, @thongke INT, @kesach INT, @themdl INT, @bansach INT, @tttaikhoan INT
AS
BEGIN
	INSERT INTO TaiKhoan
	(
		TenDN,
		HoTen,
		Loai,
		MatKhau,
		NhapSach,
		ThongKe,
		KeSach,
		ThemDuLieu,
		BanSach,
		TTTaiKhoan
	)
	VALUES
	(
		@tenDN,
		@tenht,
		@loai,
		@matKhau,
		@nhapsach,
		@thongke,
		@kesach,
		@themdl,
		@bansach,
		@tttaikhoan
	)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TacGia]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_TimSach_TacGia]
@tacGia NVARCHAR(50)
AS
BEGIN
	SELECT s.MaSach AS [ID], s.TenSach AS [Tên Sách], tg.TenTG AS [Tác Giả],tl.TenTL AS [Thể Loại], nxb.TenNXB AS [Nhà Sản Xuất] ,s.SoLuongTon AS [Số Lượng Tồn],s.GiaTien AS [Giá Tiền]
FROM Sach AS s 
inner join ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
inner join TacGia tg on s.MaTG=tg.MaTG
inner join TheLoai tl on s.MaTL=tl.MaTL
inner join NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
WHERE tg.TenTG LIKE CONCAT(@tacGia,'%')
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TacGia_TheLoai]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_TimSach_TacGia_TheLoai]
@tacGia NVARCHAR(50) , @theLoai NVARCHAR(50)
AS
BEGIN
	SELECT s.MaSach AS [ID], s.TenSach AS [Tên Sách], tg.TenTG AS [Tác Giả],tl.TenTL AS [Thể Loại], nxb.TenNXB AS [Nhà Sản Xuất] ,s.SoLuongTon AS [Số Lượng Tồn],s.GiaTien AS [Giá Tiền]
FROM Sach AS s 
inner join ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
inner join TacGia tg on s.MaTG=tg.MaTG
inner join TheLoai tl on s.MaTL=tl.MaTL
inner join NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
WHERE tg.TenTG LIKE CONCAT(@tacGia,'%') AND tl.TenTL LIKE CONCAT(@theLoai,'%')
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TenSach]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_TimSach_TenSach]
@tenSach NVARCHAR(50)
AS
BEGIN
	SELECT s.MaSach AS [ID], s.TenSach AS [Tên Sách], tg.TenTG AS [Tác Giả],tl.TenTL AS [Thể Loại], nxb.TenNXB AS [Nhà Sản Xuất] ,s.SoLuongTon AS [Số Lượng Tồn],s.GiaTien AS [Giá Tiền]
FROM Sach AS s 
inner join ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
inner join TacGia tg on s.MaTG=tg.MaTG
inner join TheLoai tl on s.MaTL=tl.MaTL
inner join NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
WHERE s.TenSach LIKE CONCAT(@tenSach,'%')
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TenSach_TacGia]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_TimSach_TenSach_TacGia]
@tenSach NVARCHAR(50), @tacGia NVARCHAR(50)
AS
BEGIN
	SELECT s.MaSach AS [ID], s.TenSach AS [Tên Sách], tg.TenTG AS [Tác Giả],tl.TenTL AS [Thể Loại], nxb.TenNXB AS [Nhà Sản Xuất] ,s.SoLuongTon AS [Số Lượng Tồn],s.GiaTien AS [Giá Tiền]
FROM Sach AS s 
inner join ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
inner join TacGia tg on s.MaTG=tg.MaTG
inner join TheLoai tl on s.MaTL=tl.MaTL
inner join NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
WHERE s.TenSach LIKE CONCAT(@tenSach,'%') AND tg.TenTG LIKE CONCAT(@tacGia,'%')
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TenSach_TacGia_TheLoai]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_TimSach_TenSach_TacGia_TheLoai]
@tenSach NVARCHAR(50) , @tacGia NVARCHAR(50) , @theLoai NVARCHAR(50)
AS
BEGIN
	SELECT s.MaSach AS [ID], s.TenSach AS [Tên Sách], tg.TenTG AS [Tác Giả],tl.TenTL AS [Thể Loại], nxb.TenNXB AS [Nhà Sản Xuất] ,s.SoLuongTon AS [Số Lượng Tồn],s.GiaTien AS [Giá Tiền]
FROM Sach AS s 
inner join ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
inner join TacGia tg on s.MaTG=tg.MaTG
inner join TheLoai tl on s.MaTL=tl.MaTL
inner join NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
WHERE s.TenSach LIKE CONCAT(@tenSach,'%') AND tg.TenTG LIKE CONCAT(@tacGia,'%') AND tl.TenTL LIKE CONCAT(@theLoai,'%')
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TenSach_TheLoai]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_TimSach_TenSach_TheLoai]
@tenSach NVARCHAR(50), @theLoai NVARCHAR(50)
AS
BEGIN
	SELECT s.MaSach AS [ID], s.TenSach AS [Tên Sách], tg.TenTG AS [Tác Giả],tl.TenTL AS [Thể Loại], nxb.TenNXB AS [Nhà Sản Xuất] ,s.SoLuongTon AS [Số Lượng Tồn],s.GiaTien AS [Giá Tiền]
FROM Sach AS s 
inner join ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
inner join TacGia tg on s.MaTG=tg.MaTG
inner join TheLoai tl on s.MaTL=tl.MaTL
inner join NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
WHERE tl.TenTL LIKE CONCAT(@theLoai,'%') AND s.TenSach LIKE CONCAT(@tenSach,'%')
END

GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TheLoai]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_TimSach_TheLoai]
@theLoai NVARCHAR(50)
AS
BEGIN
	SELECT s.MaSach AS [ID], s.TenSach AS [Tên Sách], tg.TenTG AS [Tác Giả],tl.TenTL AS [Thể Loại], nxb.TenNXB AS [Nhà Sản Xuất] ,s.SoLuongTon AS [Số Lượng Tồn],s.GiaTien AS [Giá Tiền]
FROM Sach AS s 
inner join ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
inner join TacGia tg on s.MaTG=tg.MaTG
inner join TheLoai tl on s.MaTL=tl.MaTL
inner join NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
WHERE tl.TenTL LIKE CONCAT(@theLoai,'%')
END

GO
/****** Object:  StoredProcedure [dbo].[USP_XoaTaiKhoan]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_XoaTaiKhoan]
@tenDN NVARCHAR(50)
AS
BEGIN
	DELETE FROM TaiKhoan WHERE TenDN = @tenDN
END
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 12/7/2020 11:30:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[MaSach] [char](10) NOT NULL,
	[SoHD] [char](10) NOT NULL,
	[SoLuongBan] [int] NULL,
	[GiaBan] [money] NULL,
 CONSTRAINT [pk_CTHD] PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC,
	[SoHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChiTietPhieuNhap]    Script Date: 12/7/2020 11:30:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChiTietPhieuNhap](
	[MaSach] [char](10) NOT NULL,
	[SoPN] [char](10) NOT NULL,
	[SoLuongNhap] [int] NULL,
	[GiaNhap] [money] NULL,
 CONSTRAINT [pk_CTPN] PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC,
	[SoPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 12/7/2020 11:30:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HoaDon](
	[SoHD] [char](10) NOT NULL,
	[NgayBan] [smalldatetime] NULL,
 CONSTRAINT [pk_HD] PRIMARY KEY CLUSTERED 
(
	[SoHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhaXuatBan]    Script Date: 12/7/2020 11:30:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaXuatBan](
	[MaNXB] [nvarchar](50) NOT NULL,
	[TenNXB] [nvarchar](100) NULL,
	[DiaChiNXB] [nvarchar](100) NULL,
	[DienThoai] [nvarchar](50) NULL,
 CONSTRAINT [pk_NXB] PRIMARY KEY CLUSTERED 
(
	[MaNXB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 12/7/2020 11:30:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhieuNhap](
	[SoPN] [char](10) NOT NULL,
	[NgayNhap] [smalldatetime] NULL,
	[MaNXB] [nvarchar](50) NULL,
 CONSTRAINT [pk_PN] PRIMARY KEY CLUSTERED 
(
	[SoPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sach]    Script Date: 12/7/2020 11:30:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sach](
	[MaSach] [char](10) NOT NULL,
	[TenSach] [nvarchar](100) NULL,
	[SoLuongTon] [int] NULL,
	[MaTL] [char](10) NULL,
	[MaTG] [char](10) NULL,
	[MaNXB] [nvarchar](50) NULL,
	[GiaTien] [int] NULL,
 CONSTRAINT [pk_S] PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TacGia]    Script Date: 12/7/2020 11:30:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TacGia](
	[MaTG] [char](10) NOT NULL,
	[TenTG] [nvarchar](40) NULL,
	[LienLac] [nvarchar](40) NULL,
 CONSTRAINT [pk_TG] PRIMARY KEY CLUSTERED 
(
	[MaTG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 12/7/2020 11:30:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenDN] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[Loai] [int] NULL,
	[MatKhau] [nvarchar](1000) NOT NULL,
	[NhapSach] [int] NULL,
	[ThongKe] [int] NULL,
	[KeSach] [int] NULL,
	[ThemDuLieu] [int] NULL,
	[BanSach] [int] NULL,
	[TTTaikhoan] [int] NULL,
	[CaiDat] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TenDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TheLoai]    Script Date: 12/7/2020 11:30:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TheLoai](
	[MaTL] [char](10) NOT NULL,
	[TenTL] [nvarchar](50) NULL,
 CONSTRAINT [pk_TL] PRIMARY KEY CLUSTERED 
(
	[MaTL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S001      ', N'HD009     ', 1, 80000.0000)
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S002      ', N'HD008     ', 1, 72000.0000)
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S003      ', N'HD007     ', 1, 59000.0000)
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S004      ', N'HD006     ', 1, 70000.0000)
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S005      ', N'HD005     ', 1, 95000.0000)
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S006      ', N'HD004     ', 1, 56000.0000)
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S007      ', N'HD003     ', 1, 63000.0000)
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S008      ', N'HD002     ', 1, 190000.0000)
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S009      ', N'HD001     ', 1, 160000.0000)
INSERT [dbo].[ChiTietHoaDon] ([MaSach], [SoHD], [SoLuongBan], [GiaBan]) VALUES (N'S010      ', N'HD009     ', 1, 34000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S001      ', N'PN010     ', 20, 60000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S002      ', N'PN009     ', 20, 50000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S003      ', N'PN008     ', 20, 30000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S004      ', N'PN007     ', 20, 60000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S005      ', N'PN006     ', 20, 60000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S006      ', N'PN005     ', 20, 40000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S007      ', N'PN004     ', 20, 60000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S008      ', N'PN003     ', 20, 60000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S009      ', N'PN002     ', 20, 60000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S010      ', N'PN001     ', 20, 20000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S023      ', N'PN020     ', 2, 10000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S025      ', N'PN018     ', 3, 2222.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S026      ', N'PN011     ', 100, 100000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S027      ', N'PN011     ', 100, 100000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S027      ', N'PN012     ', 100, 100000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S028      ', N'PN012     ', 100, 100000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'S029      ', N'PN014     ', 100, 100000.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'ss        ', N'pn        ', 1, 1111.0000)
INSERT [dbo].[ChiTietPhieuNhap] ([MaSach], [SoPN], [SoLuongNhap], [GiaNhap]) VALUES (N'sss       ', N'sss       ', 1, 111.0000)
INSERT [dbo].[HoaDon] ([SoHD], [NgayBan]) VALUES (N'HD001     ', CAST(0xAB680000 AS SmallDateTime))
INSERT [dbo].[HoaDon] ([SoHD], [NgayBan]) VALUES (N'HD002     ', CAST(0xAC160000 AS SmallDateTime))
INSERT [dbo].[HoaDon] ([SoHD], [NgayBan]) VALUES (N'HD003     ', CAST(0xAC050000 AS SmallDateTime))
INSERT [dbo].[HoaDon] ([SoHD], [NgayBan]) VALUES (N'HD004     ', CAST(0xAB9B0000 AS SmallDateTime))
INSERT [dbo].[HoaDon] ([SoHD], [NgayBan]) VALUES (N'HD005     ', CAST(0xAB530000 AS SmallDateTime))
INSERT [dbo].[HoaDon] ([SoHD], [NgayBan]) VALUES (N'HD006     ', CAST(0xAB6D0000 AS SmallDateTime))
INSERT [dbo].[HoaDon] ([SoHD], [NgayBan]) VALUES (N'HD007     ', CAST(0xAC3D0000 AS SmallDateTime))
INSERT [dbo].[HoaDon] ([SoHD], [NgayBan]) VALUES (N'HD008     ', CAST(0xAB470000 AS SmallDateTime))
INSERT [dbo].[HoaDon] ([SoHD], [NgayBan]) VALUES (N'HD009     ', CAST(0xAC9C0000 AS SmallDateTime))
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB001', N'Bách khoa Hà Nội', N'Số 1 Đường Đại Cồ Việt, Hai Bà Trưng , Hà Nội.', N'8823451')
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB002', N'Chính trị Quốc gia Sự thật', N'6/86 Duy Tân, Cầu Giấy, Hà Nội', N'908256478')
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB003', N'Công Thương', N'Tầng 4, Tòa nhà Bộ Công Thương, số 655 Phạm Văn Đồng, quận Bắc Từ Liêm, Hà Nội', N'938776266')
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB004', N'Công an nhân dân', N'92 Nguyễn Du, quận Hai Bà Trưng, TP. Hà Nội', N'917325476')
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB005', N'Dân trí', N'Số 9, ngõ 26, phố Hoàng Cầu, quận Đống Đa, thành phố Hà Nội', N'8246108')
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB006', N'Giao thông vận tải', N'80B Trần Hưng Đạo, Quận Hoàn Kiếm, Thành phố Hà Nội', N'8631738')
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB007', N'Giáo dục Việt Nam', N'81 Trần Hưng Đạo - Q. Hoàn KIếm - Hà Nội', N'916783565')
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB008', N'Hàng hải', N'484 Lạch Tray, Ngô Quyền, Hải Phòng', N'938435756')
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB009', N'Học viện Nông nghiệp', N'Trường Đại học Nông nghiệp Hà Nội - Thị trấn Trâu Quỳ, huyện Gia Lâm, Hà Nội', N'8654763')
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChiNXB], [DienThoai]) VALUES (N'NXB010', N'Hồng Đức', N'65 Tràng Thi, Hà Nội', N'8768904')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'pn        ', CAST(0xAB7C0000 AS SmallDateTime), N'NXB010')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN001     ', CAST(0xABF60000 AS SmallDateTime), N'NXB002')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN002     ', CAST(0xAC0A0000 AS SmallDateTime), N'NXB007')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN003     ', CAST(0xAB330000 AS SmallDateTime), N'NXB008')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN004     ', CAST(0xAB2D0000 AS SmallDateTime), N'NXB004')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN005     ', CAST(0xAC150000 AS SmallDateTime), N'NXB006')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN006     ', CAST(0xAB730000 AS SmallDateTime), N'NXB009')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN007     ', CAST(0xABAF0000 AS SmallDateTime), N'NXB003')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN008     ', CAST(0xAC180000 AS SmallDateTime), N'NXB001')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN009     ', CAST(0xAB250000 AS SmallDateTime), N'NXB010')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN010     ', CAST(0xAC090000 AS SmallDateTime), N'NXB007')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN011     ', CAST(0xAB7C0000 AS SmallDateTime), N'NXB005')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN012     ', CAST(0xAB7C0000 AS SmallDateTime), N'NXB005')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN014     ', CAST(0xAB7C0000 AS SmallDateTime), N'NXB008')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN018     ', CAST(0xAB7C0000 AS SmallDateTime), N'NXB009')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'PN020     ', CAST(0xAB7C0000 AS SmallDateTime), N'NXB009')
INSERT [dbo].[PhieuNhap] ([SoPN], [NgayNhap], [MaNXB]) VALUES (N'sss       ', CAST(0xAB7C0000 AS SmallDateTime), N'NXB009')
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S001      ', N'Tôi tài giỏi, bạn cũng thế', 97, N'TL002     ', N'TG003     ', N'NXB009', 80000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S002      ', N'Đắc nhân tâm', 115, N'TL003     ', N'TG002     ', N'NXB008', 72000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S003      ', N'Tội ác và trừng phạt', 84, N'TL004     ', N'TG004     ', N'NXB007', 59000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S004      ', N'Nhà giả kim', 60, N'TL002     ', N'TG005     ', N'NXB006', 70000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S005      ', N'Bắt trẻ đồng xanh', 200, N'TL001     ', N'TG006     ', N'NXB005', 95000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S006      ', N'Xách ba lô lên và đi', 134, N'TL006     ', N'TG007     ', N'NXB004', 56000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S007      ', N'Cứ đi rồi sẽ đến', 50, N'TL005     ', N'TG009     ', N'NXB003', 63000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S008      ', N'7 thói quen để thành đạt', 100, N'TL008     ', N'TG008     ', N'NXB002', 190000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S009      ', N'Thép đã tôi thế đấy', 200, N'TL009     ', N'TG001     ', N'NXB001', 160000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S010      ', N'Đọc vị bất kì ai', 100, N'TL010     ', N'TG002     ', N'NXB010', 34000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S011      ', N'Cuộc đời của Pi', 100, N'TL010     ', N'TG003     ', N'NXB009', 34000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S012      ', N'Những Người Đàn Ông Không Có Đàn Bà', 100, N'TL002     ', N'TG004     ', N'NXB008', 90000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S013      ', N'Trà hoa nữ', 200, N'TL001     ', N'TG005     ', N'NXB007', 67000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S014      ', N'Đàn ông đến từ sao Hỏa ', 100, N'TL003     ', N'TG006     ', N'NXB006', 50000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S015      ', N'Thần chú mê đắm', 300, N'TL004     ', N'TG007     ', N'NXB005', 95000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S016      ', N'Bạn Đắt Giá Bao Nhiêu?', 150, N'TL005     ', N'TG009     ', N'NXB004', 66000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S017      ', N'Đời ngắn đừng ngủ dài', 200, N'TL006     ', N'TG008     ', N'NXB003', 36000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S018      ', N'Tuổi trẻ đáng giá bao nhiêu', 150, N'TL007     ', N'TG003     ', N'NXB002', 94000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S019      ', N'Khéo ăn nói sẽ có được thiên hạ', 200, N'TL009     ', N'TG001     ', N'NXB001', 39000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S020      ', N'Cafe cùng Tony', 400, N'TL008     ', N'TG002     ', N'NXB010', 64000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S023      ', N'Tôi', 2, N'TL009     ', N'TG002     ', N'NXB009', 10000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S025      ', N'Chúng', 3, N'TL009     ', N'TG002     ', N'NXB009', 2222)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S026      ', N'Chịu hông chịu thì thôi', 100, N'TL009     ', N'TG006     ', N'NXB005', 100000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S027      ', N'Chịu hông chịu thì thôi', 100, N'TL004     ', N'TG003     ', N'NXB005', 100000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S028      ', N'Chịu hông chịu thì thôi', 100, N'TL004     ', N'TG003     ', N'NXB005', 100000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'S029      ', N'Chịu hông chịu thì CÓ', 100, N'TL008     ', N'TG004     ', N'NXB008', 100000)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'ss        ', N'ttt', 1, N'TL009     ', N'TG001     ', N'NXB010', 1111)
INSERT [dbo].[Sach] ([MaSach], [TenSach], [SoLuongTon], [MaTL], [MaTG], [MaNXB], [GiaTien]) VALUES (N'sss       ', N'too', 1, N'TL008     ', N'TG002     ', N'NXB009', 111)
INSERT [dbo].[TacGia] ([MaTG], [TenTG], [LienLac]) VALUES (N'TG001     ', N'Nguyễn Như Nhựt', N'927345678')
INSERT [dbo].[TacGia] ([MaTG], [TenTG], [LienLac]) VALUES (N'TG002     ', N'Lê Thị Phi Yến', N'987567390')
INSERT [dbo].[TacGia] ([MaTG], [TenTG], [LienLac]) VALUES (N'TG003     ', N'Nguyễn Văn B', N'997047382')
INSERT [dbo].[TacGia] ([MaTG], [TenTG], [LienLac]) VALUES (N'TG004     ', N'Ngô Thành Tuân', N'913758498')
INSERT [dbo].[TacGia] ([MaTG], [TenTG], [LienLac]) VALUES (N'TG005     ', N'Nguyễn Thị Trúc Thành', N'918590387')
INSERT [dbo].[TacGia] ([MaTG], [TenTG], [LienLac]) VALUES (N'TG006     ', N'Hà Duy Lập', N'87689042')
INSERT [dbo].[TacGia] ([MaTG], [TenTG], [LienLac]) VALUES (N'TG007     ', N'Lê Hà Vinh', N'865476323')
INSERT [dbo].[TacGia] ([MaTG], [TenTG], [LienLac]) VALUES (N'TG008     ', N'Nguyễn Văn Bình', N'824610823')
INSERT [dbo].[TacGia] ([MaTG], [TenTG], [LienLac]) VALUES (N'TG009     ', N'Lâm Thái Sơn', N'956412135')
INSERT [dbo].[TaiKhoan] ([TenDN], [HoTen], [Loai], [MatKhau], [NhapSach], [ThongKe], [KeSach], [ThemDuLieu], [BanSach], [TTTaikhoan], [CaiDat]) VALUES (N'nv2', N'Nhân viên 2', 0, N'1', 0, 0, 1, 0, 1, 1, 0)
INSERT [dbo].[TaiKhoan] ([TenDN], [HoTen], [Loai], [MatKhau], [NhapSach], [ThongKe], [KeSach], [ThemDuLieu], [BanSach], [TTTaikhoan], [CaiDat]) VALUES (N'nv3', N'nhân viên 3', 0, N'1', 0, 0, 1, 0, 1, 1, 0)
INSERT [dbo].[TaiKhoan] ([TenDN], [HoTen], [Loai], [MatKhau], [NhapSach], [ThongKe], [KeSach], [ThemDuLieu], [BanSach], [TTTaikhoan], [CaiDat]) VALUES (N'nv4', N'nhân viên 4', 0, N'nv4', 0, 0, 1, 0, 1, 1, 0)
INSERT [dbo].[TaiKhoan] ([TenDN], [HoTen], [Loai], [MatKhau], [NhapSach], [ThongKe], [KeSach], [ThemDuLieu], [BanSach], [TTTaikhoan], [CaiDat]) VALUES (N'tankhoa', N'Tấn Khoa', 1, N'1', 1, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL001     ', N'Chính trị')
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL002     ', N'Pháp luật')
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL003     ', N'Khoa học công nghệ')
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL004     ', N'Kinh tế')
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL005     ', N'Văn hóa xã hội')
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL006     ', N'Lịch sử')
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL007     ', N'Văn học nghệ thuật')
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL008     ', N'Tiểu thuyết')
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL009     ', N'Tâm lý')
INSERT [dbo].[TheLoai] ([MaTL], [TenTL]) VALUES (N'TL010     ', N'Tôn giáo')
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ((0)) FOR [Loai]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  CONSTRAINT [df_CaiDat]  DEFAULT ((0)) FOR [CaiDat]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [fk_CTHD_MaSach] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [fk_CTHD_MaSach]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [fk_CTHD_SoHD] FOREIGN KEY([SoHD])
REFERENCES [dbo].[HoaDon] ([SoHD])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [fk_CTHD_SoHD]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap]  WITH CHECK ADD  CONSTRAINT [fk_CTPN_MaSach] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] CHECK CONSTRAINT [fk_CTPN_MaSach]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap]  WITH CHECK ADD  CONSTRAINT [fk_CTPN_SoPN] FOREIGN KEY([SoPN])
REFERENCES [dbo].[PhieuNhap] ([SoPN])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] CHECK CONSTRAINT [fk_CTPN_SoPN]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [fk_PN] FOREIGN KEY([MaNXB])
REFERENCES [dbo].[NhaXuatBan] ([MaNXB])
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [fk_PN]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [fk_S_MaNXB] FOREIGN KEY([MaNXB])
REFERENCES [dbo].[NhaXuatBan] ([MaNXB])
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [fk_S_MaNXB]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [fk_S_MaTG] FOREIGN KEY([MaTG])
REFERENCES [dbo].[TacGia] ([MaTG])
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [fk_S_MaTG]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [fk_S_MaTL] FOREIGN KEY([MaTL])
REFERENCES [dbo].[TheLoai] ([MaTL])
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [fk_S_MaTL]
GO
USE [master]
GO
ALTER DATABASE [QuanLyNhaSach] SET  READ_WRITE 
GO
