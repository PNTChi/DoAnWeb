USE [WebBanHangDienTu]
GO
-- 1. Tạo bảng Thông số kỹ thuật
CREATE TABLE [dbo].[tb_ThongSo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SanPhamId] [int] NOT NULL,
	[TenThongSo] [nvarchar](150) NOT NULL, -- Ví dụ: Màn hình, Chip, RAM, Camera
	[GiaTri] [nvarchar](250) NOT NULL,     -- Ví dụ: 6.7 inch, Apple A17 Pro, 8GB
	[ThuTu] [int] DEFAULT 1,               -- Để sắp xếp thứ tự hiển thị
	CONSTRAINT [PK_tb_ThongSo] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO
-- 2. Tạo khóa ngoại liên kết với bảng Sản phẩm
ALTER TABLE [dbo].[tb_ThongSo] WITH CHECK ADD CONSTRAINT [FK_tb_ThongSo_tb_SanPham] FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[tb_SanPham] ([Id])
ON DELETE CASCADE -- Xóa sản phẩm thì xóa luôn thông số của nó
GO
-- 3. Insert dữ liệu mẫu (Ví dụ cho sản phẩm có Id = 1, bạn có thể bỏ comment để chạy thử)
/*
INSERT INTO [dbo].[tb_ThongSo] ([SanPhamId], [TenThongSo], [GiaTri], [ThuTu]) VALUES
(1, N'Màn hình', N'6.7 inch Super Retina XDR', 1),
(1, N'Hệ điều hành', N'iOS 18', 2),
(1, N'Camera sau', N'48MP + 48MP + 12MP', 3),
(1, N'Camera trước', N'12MP', 4),
(1, N'Chip', N'Apple A18 Pro', 5),
(1, N'RAM', N'8GB', 6),
(1, N'Dung lượng lưu trữ', N'256GB', 7),
(1, N'SIM', N'1 Nano SIM & 1 eSIM', 8),
(1, N'Pin, Sạc', N'4422 mAh, 20W', 9);
*/
PRINT N'Đã tạo bảng tb_ThongSo thành công!'