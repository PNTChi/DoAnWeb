-- Script bổ sung Khóa Ngoại (Foreign Keys) và Cột còn thiếu
-- Chạy script này để "kết nối" các bảng lại với nhau
USE [WebBanHangDienTu]
GO
-- 1. Bảng Đơn Hàng (tb_DonHang)
-- Thêm cột TaiKhoanId (để biết đơn hàng của ai)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_DonHang]') AND name = 'TaiKhoanId')
BEGIN
    ALTER TABLE [dbo].[tb_DonHang] ADD [TaiKhoanId] [int] NULL;
END
GO
-- Thêm cột PhuongThucVanChuyenId
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_DonHang]') AND name = 'PhuongThucVanChuyenId')
BEGIN
    ALTER TABLE [dbo].[tb_DonHang] ADD [PhuongThucVanChuyenId] [int] NULL;
END
GO
-- Tạo FK từ DonHang -> TaiKhoan
ALTER TABLE [dbo].[tb_DonHang] WITH CHECK ADD CONSTRAINT [FK_tb_DonHang_tb_TaiKhoan] FOREIGN KEY([TaiKhoanId])
REFERENCES [dbo].[tb_TaiKhoan] ([Id])
GO
-- Tạo FK từ DonHang -> PhuongThucThanhToan (Map cột LoaiThanhToan với bảng PhuongThucThanhToan)
-- Lưu ý: Đảm bảo dữ liệu trong cột LoaiThanhToan khớp với Id trong bảng tb_PhuongThucThanhToan
ALTER TABLE [dbo].[tb_DonHang] WITH CHECK ADD CONSTRAINT [FK_tb_DonHang_tb_PhuongThucThanhToan] FOREIGN KEY([LoaiThanhToan])
REFERENCES [dbo].[tb_PhuongThucThanhToan] ([Id])
GO
-- Tạo FK từ DonHang -> PhuongThucVanChuyen
ALTER TABLE [dbo].[tb_DonHang] WITH CHECK ADD CONSTRAINT [FK_tb_DonHang_tb_PhuongThucVanChuyen] FOREIGN KEY([PhuongThucVanChuyenId])
REFERENCES [dbo].[tb_PhuongThucVanChuyen] ([Id])
GO
-- 2. Bảng Yêu Thích (tb_YeuThich)
-- Tạo FK từ YeuThich -> TaiKhoan
ALTER TABLE [dbo].[tb_YeuThich] WITH CHECK ADD CONSTRAINT [FK_tb_YeuThich_tb_TaiKhoan] FOREIGN KEY([TaiKhoanId])
REFERENCES [dbo].[tb_TaiKhoan] ([Id])
ON DELETE CASCADE -- Xóa user thì xóa luôn danh sách yêu thích
GO
-- 3. Bảng Menu (tb_Menu)
-- Tạo FK đệ quy (Menu con trỏ về Menu cha)
ALTER TABLE [dbo].[tb_Menu] WITH CHECK ADD CONSTRAINT [FK_tb_Menu_tb_Menu] FOREIGN KEY([MenuChaId])
REFERENCES [dbo].[tb_Menu] ([Id])
GO
-- 4. Bảng Tài Khoản (tb_TaiKhoan) & Quyền (tb_Quyen)
-- Thêm cột QuyenId vào tb_TaiKhoan (nếu muốn quản lý quyền chi tiết hơn cột LaQuanTri)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_TaiKhoan]') AND name = 'QuyenId')
BEGIN
    ALTER TABLE [dbo].[tb_TaiKhoan] ADD [QuyenId] [int] NULL;
END
GO
-- Tạo FK từ TaiKhoan -> Quyen
ALTER TABLE [dbo].[tb_TaiKhoan] WITH CHECK ADD CONSTRAINT [FK_tb_TaiKhoan_tb_Quyen] FOREIGN KEY([QuyenId])
REFERENCES [dbo].[tb_Quyen] ([Id])
GO
-- 5. Bảng Mã Giảm Giá (tb_MaGiamGia)
-- Nếu muốn lưu lịch sử dùng mã, có thể thêm bảng trung gian, nhưng ở đây ta có thể link Đơn hàng -> Mã giảm giá (nếu cần)
-- Thêm cột MaGiamGiaId vào DonHang
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_DonHang]') AND name = 'MaGiamGiaId')
BEGIN
    ALTER TABLE [dbo].[tb_DonHang] ADD [MaGiamGiaId] [int] NULL;
END
GO
ALTER TABLE [dbo].[tb_DonHang] WITH CHECK ADD CONSTRAINT [FK_tb_DonHang_tb_MaGiamGia] FOREIGN KEY([MaGiamGiaId])
REFERENCES [dbo].[tb_MaGiamGia] ([Id])
GO
PRINT N'Đã cập nhật các mối quan hệ (Foreign Keys) thành công!'