-- Script tạo Database Website Bán Hàng Điện Tử (Phiên bản Tiếng Việt)
-- Chạy script này trong SQL Server Management Studio (SSMS)
CREATE DATABASE [WebBanHangDienTu]
GO
USE [WebBanHangDienTu]
GO

-- 1. Bảng Danh mục sản phẩm
CREATE TABLE [dbo].[tb_DanhMuc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](150) NOT NULL,
	[BiDanh] [nvarchar](150) NULL, -- Alias/Slug
	[Icon] [nvarchar](250) NULL,
	[MoTa] [nvarchar](max) NULL,
	[TieuDeSeo] [nvarchar](250) NULL,
	[MoTaSeo] [nvarchar](500) NULL,
	[TuKhoaSeo] [nvarchar](250) NULL,
	[ThuTu] [int] DEFAULT 1,
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[NguoiTao] [nvarchar](150) NULL,
	[NgayCapNhat] [datetime] NULL,
	[NguoiCapNhat] [nvarchar](150) NULL,
	[HienThi] [bit] DEFAULT 1, -- IsActive
 CONSTRAINT [PK_tb_DanhMuc] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 2. Bảng Thương hiệu
CREATE TABLE [dbo].[tb_ThuongHieu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenThuongHieu] [nvarchar](150) NOT NULL,
	[BiDanh] [nvarchar](150) NULL,
	[HinhAnh] [nvarchar](250) NULL,
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[HienThi] [bit] DEFAULT 1,
 CONSTRAINT [PK_tb_ThuongHieu] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 3. Bảng Sản phẩm
CREATE TABLE [dbo].[tb_SanPham](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenSanPham] [nvarchar](250) NOT NULL,
	[BiDanh] [nvarchar](250) NULL,
	[MaSanPham] [nvarchar](50) NULL,
	[MoTa] [nvarchar](max) NULL,
	[ChiTiet] [nvarchar](max) NULL, -- Nội dung HTML
	[HinhAnh] [nvarchar](250) NULL,
	[Gia] [decimal](18, 2) DEFAULT 0,
	[GiaKhuyenMai] [decimal](18, 2) DEFAULT 0,
	[SoLuong] [int] DEFAULT 0,
	[LuotXem] [int] DEFAULT 0,
	[DanhMucId] [int] NOT NULL,
	[ThuongHieuId] [int] NULL,
	[LaSanPhamTrangChu] [bit] DEFAULT 0, -- IsHome
	[LaSanPhamKhuyenMai] [bit] DEFAULT 0, -- IsSale
	[LaSanPhamNoiBat] [bit] DEFAULT 0, -- IsFeature
	[LaSanPhamHot] [bit] DEFAULT 0, -- IsHot
	[LaSanPhamMoi] [bit] DEFAULT 0, -- IsNew
	[LaSanPhamBanChay] [bit] DEFAULT 0, -- IsBestSeller
	[HienThi] [bit] DEFAULT 1,
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[NguoiTao] [nvarchar](150) NULL,
	[NgayCapNhat] [datetime] NULL,
	[NguoiCapNhat] [nvarchar](150) NULL,
 CONSTRAINT [PK_tb_SanPham] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 4. Bảng Ảnh sản phẩm
CREATE TABLE [dbo].[tb_AnhSanPham](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SanPhamId] [int] NOT NULL,
	[HinhAnh] [nvarchar](250) NULL,
	[LaAnhMacDinh] [bit] DEFAULT 0,
 CONSTRAINT [PK_tb_AnhSanPham] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 5. Bảng Đánh giá
CREATE TABLE [dbo].[tb_DanhGia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SanPhamId] [int] NOT NULL,
	[TenNguoiGui] [nvarchar](150) NULL,
	[Email] [nvarchar](150) NULL,
	[NoiDung] [nvarchar](max) NULL,
	[Sao] [int] DEFAULT 5, -- Rating
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[HienThi] [bit] DEFAULT 1,
 CONSTRAINT [PK_tb_DanhGia] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 6. Bảng Danh mục tin tức
CREATE TABLE [dbo].[tb_DanhMucTin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](150) NOT NULL,
	[BiDanh] [nvarchar](150) NULL,
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[HienThi] [bit] DEFAULT 1,
 CONSTRAINT [PK_tb_DanhMucTin] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 7. Bảng Tin tức
CREATE TABLE [dbo].[tb_TinTuc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](250) NOT NULL,
	[BiDanh] [nvarchar](250) NULL,
	[DanhMucTinId] [int] NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[ChiTiet] [nvarchar](max) NULL,
	[HinhAnh] [nvarchar](250) NULL,
	[TieuDeSeo] [nvarchar](250) NULL,
	[MoTaSeo] [nvarchar](500) NULL,
	[TuKhoaSeo] [nvarchar](250) NULL,
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[NguoiTao] [nvarchar](150) NULL,
	[NgayCapNhat] [datetime] NULL,
	[NguoiCapNhat] [nvarchar](150) NULL,
	[HienThi] [bit] DEFAULT 1,
 CONSTRAINT [PK_tb_TinTuc] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 8. Bảng Quảng cáo/Slider
CREATE TABLE [dbo].[tb_QuangCao](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](250) NULL,
	[HinhAnh] [nvarchar](250) NOT NULL,
	[LienKet] [nvarchar](250) NULL, -- Link
	[ThuTu] [int] DEFAULT 1,
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[HienThi] [bit] DEFAULT 1,
 CONSTRAINT [PK_tb_QuangCao] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 9. Bảng Menu
CREATE TABLE [dbo].[tb_Menu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](150) NULL,
	[LienKet] [nvarchar](150) NULL,
	[MoTa] [nvarchar](500) NULL,
	[MenuChaId] [int] NULL, -- ParentId
	[ThuTu] [int] DEFAULT 1,
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[HienThi] [bit] DEFAULT 1,
 CONSTRAINT [PK_tb_Menu] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 10. Bảng Liên hệ
CREATE TABLE [dbo].[tb_LienHe](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenNguoiGui] [nvarchar](150) NULL,
	[Email] [nvarchar](150) NULL,
	[Website] [nvarchar](150) NULL,
	[NoiDung] [nvarchar](max) NULL,
	[DaDoc] [bit] DEFAULT 0,
	[NgayTao] [datetime] DEFAULT GETDATE(),
 CONSTRAINT [PK_tb_LienHe] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 11. Bảng Đơn hàng
CREATE TABLE [dbo].[tb_DonHang](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MaDonHang] [nvarchar](50) NOT NULL,
	[TenKhachHang] [nvarchar](150) NOT NULL,
	[SoDienThoai] [nvarchar](15) NOT NULL,
	[DiaChi] [nvarchar](250) NOT NULL,
	[Email] [nvarchar](150) NULL,
	[TongTien] [decimal](18, 2) NOT NULL,
	[SoLuongSanPham] [int] NOT NULL,
	[LoaiThanhToan] [int] DEFAULT 1,
	[TrangThai] [int] DEFAULT 1,
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[NgayCapNhat] [datetime] NULL,
	[NguoiTao] [nvarchar](150) NULL,
 CONSTRAINT [PK_tb_DonHang] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 12. Bảng Chi tiết đơn hàng
CREATE TABLE [dbo].[tb_ChiTietDonHang](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DonHangId] [int] NOT NULL,
	[SanPhamId] [int] NOT NULL,
	[Gia] [decimal](18, 2) NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_tb_ChiTietDonHang] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 13. Bảng Đăng ký nhận tin
CREATE TABLE [dbo].[tb_DangKyNhanTin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[NgayTao] [datetime] DEFAULT GETDATE(),
 CONSTRAINT [PK_tb_DangKyNhanTin] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 14. Bảng Cấu hình
CREATE TABLE [dbo].[tb_CauHinh](
	[MaCauHinh] [nvarchar](50) NOT NULL, -- SettingKey
	[GiaTri] [nvarchar](max) NULL,
	[MoTa] [nvarchar](250) NULL,
 CONSTRAINT [PK_tb_CauHinh] PRIMARY KEY CLUSTERED ([MaCauHinh] ASC)
)
GO
-- 15. Bảng Quyền
CREATE TABLE [dbo].[tb_Quyen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenQuyen] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tb_Quyen] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 16. Bảng Tài khoản/Người dùng
CREATE TABLE [dbo].[tb_TaiKhoan](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](100) NOT NULL,
	[HoTen] [nvarchar](150) NULL,
	[Email] [nvarchar](150) NULL,
	[SoDienThoai] [nvarchar](15) NULL,
	[LaQuanTri] [bit] DEFAULT 0, -- IsAdmin
	[HoatDong] [bit] DEFAULT 1, -- IsActive
 CONSTRAINT [PK_tb_TaiKhoan] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 17. Bảng Mã giảm giá
CREATE TABLE [dbo].[tb_MaGiamGia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MaCode] [nvarchar](50) NOT NULL,
	[SoTienGiam] [decimal](18, 2) DEFAULT 0,
	[PhanTramGiam] [int] DEFAULT 0,
	[NgayTao] [datetime] DEFAULT GETDATE(),
	[NgayKetThuc] [datetime] NULL,
	[SoLuong] [int] DEFAULT 0,
	[HienThi] [bit] DEFAULT 1,
 CONSTRAINT [PK_tb_MaGiamGia] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 18. Bảng Phương thức thanh toán
CREATE TABLE [dbo].[tb_PhuongThucThanhToan](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenPhuongThuc] [nvarchar](150) NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[HienThi] [bit] DEFAULT 1,
 CONSTRAINT [PK_tb_PhuongThucThanhToan] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 19. Bảng Phương thức vận chuyển
CREATE TABLE [dbo].[tb_PhuongThucVanChuyen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenPhuongThuc] [nvarchar](150) NOT NULL,
	[Gia] [decimal](18, 2) DEFAULT 0,
	[MoTa] [nvarchar](max) NULL,
 CONSTRAINT [PK_tb_PhuongThucVanChuyen] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 20. Bảng Yêu thích
CREATE TABLE [dbo].[tb_YeuThich](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SanPhamId] [int] NOT NULL,
	[TaiKhoanId] [int] NULL,
	[NgayTao] [datetime] DEFAULT GETDATE(),
 CONSTRAINT [PK_tb_YeuThich] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- Tạo Khóa Ngoại (Foreign Keys)
ALTER TABLE [dbo].[tb_SanPham]  WITH CHECK ADD  CONSTRAINT [FK_tb_SanPham_tb_DanhMuc] FOREIGN KEY([DanhMucId])
REFERENCES [dbo].[tb_DanhMuc] ([Id])
GO
ALTER TABLE [dbo].[tb_SanPham]  WITH CHECK ADD  CONSTRAINT [FK_tb_SanPham_tb_ThuongHieu] FOREIGN KEY([ThuongHieuId])
REFERENCES [dbo].[tb_ThuongHieu] ([Id])
GO
ALTER TABLE [dbo].[tb_AnhSanPham]  WITH CHECK ADD  CONSTRAINT [FK_tb_AnhSanPham_tb_SanPham] FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[tb_SanPham] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tb_DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_tb_DanhGia_tb_SanPham] FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[tb_SanPham] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tb_TinTuc]  WITH CHECK ADD  CONSTRAINT [FK_tb_TinTuc_tb_DanhMucTin] FOREIGN KEY([DanhMucTinId])
REFERENCES [dbo].[tb_DanhMucTin] ([Id])
GO
ALTER TABLE [dbo].[tb_ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_tb_ChiTietDonHang_tb_DonHang] FOREIGN KEY([DonHangId])
REFERENCES [dbo].[tb_DonHang] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tb_ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_tb_ChiTietDonHang_tb_SanPham] FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[tb_SanPham] ([Id])
GO
ALTER TABLE [dbo].[tb_YeuThich]  WITH CHECK ADD  CONSTRAINT [FK_tb_YeuThich_tb_SanPham] FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[tb_SanPham] ([Id])
ON DELETE CASCADE
GO