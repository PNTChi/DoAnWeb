-- Script Tạo Ràng buộc Toàn vẹn (Constraints) & Trigger
-- Chạy script này SAU KHI đã tạo Database và (tùy chọn) Insert dữ liệu mẫu
USE [WebBanHangDienTu]
GO
-- =============================================
-- 1. UNIQUE CONSTRAINTS (Ràng buộc Duy nhất)
-- =============================================
-- Tên đăng nhập và Email phải duy nhất
ALTER TABLE [dbo].[tb_TaiKhoan]
ADD CONSTRAINT [UQ_TaiKhoan_TenDangNhap] UNIQUE ([TenDangNhap]);
GO
ALTER TABLE [dbo].[tb_TaiKhoan]
ADD CONSTRAINT [UQ_TaiKhoan_Email] UNIQUE ([Email]);
GO
-- Mã sản phẩm (SKU) phải duy nhất
ALTER TABLE [dbo].[tb_SanPham]
ADD CONSTRAINT [UQ_SanPham_MaSanPham] UNIQUE ([MaSanPham]);
GO
-- Alias (Slug) nên duy nhất để SEO tốt (tùy chọn, nhưng khuyến khích)
ALTER TABLE [dbo].[tb_SanPham]
ADD CONSTRAINT [UQ_SanPham_BiDanh] UNIQUE ([BiDanh]);
GO
-- Mã giảm giá phải duy nhất
ALTER TABLE [dbo].[tb_MaGiamGia]
ADD CONSTRAINT [UQ_MaGiamGia_MaCode] UNIQUE ([MaCode]);
GO
-- =============================================
-- 2. CHECK CONSTRAINTS (Ràng buộc Kiểm tra)
-- =============================================
-- Giá sản phẩm phải >= 0
ALTER TABLE [dbo].[tb_SanPham]
ADD CONSTRAINT [CK_SanPham_Gia] CHECK ([Gia] >= 0);
GO
-- Giá khuyến mãi phải >= 0 và nhỏ hơn Giá gốc
ALTER TABLE [dbo].[tb_SanPham]
ADD CONSTRAINT [CK_SanPham_GiaKhuyenMai] CHECK ([GiaKhuyenMai] >= 0 AND ([GiaKhuyenMai] < [Gia] OR [GiaKhuyenMai] = 0));
GO
-- Số lượng tồn kho >= 0
ALTER TABLE [dbo].[tb_SanPham]
ADD CONSTRAINT [CK_SanPham_SoLuong] CHECK ([SoLuong] >= 0);
GO
-- Đánh giá sao từ 1 đến 5
ALTER TABLE [dbo].[tb_DanhGia]
ADD CONSTRAINT [CK_DanhGia_Sao] CHECK ([Sao] >= 1 AND [Sao] <= 5);
GO
-- Phần trăm giảm giá từ 0 đến 100
ALTER TABLE [dbo].[tb_MaGiamGia]
ADD CONSTRAINT [CK_MaGiamGia_PhanTram] CHECK ([PhanTramGiam] >= 0 AND [PhanTramGiam] <= 100);
GO
-- =============================================
-- 3. TRIGGERS (Tự động hóa)
-- =============================================
-- Trigger 1: Tự động cập nhật Tổng tiền đơn hàng khi thêm/sửa/xóa Chi tiết đơn hàng
CREATE TRIGGER [dbo].[trg_CapNhatTongTienDonHang]
ON [dbo].[tb_ChiTietDonHang]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    -- Cập nhật cho các đơn hàng có liên quan trong bảng Inserted
    UPDATE dh
    SET dh.TongTien = (SELECT ISNULL(SUM(ct.Gia * ct.SoLuong), 0) 
                       FROM [dbo].[tb_ChiTietDonHang] ct 
                       WHERE ct.DonHangId = dh.Id)
    FROM [dbo].[tb_DonHang] dh
    JOIN inserted i ON dh.Id = i.DonHangId;
    -- Cập nhật cho các đơn hàng có liên quan trong bảng Deleted (trường hợp xóa)
    UPDATE dh
    SET dh.TongTien = (SELECT ISNULL(SUM(ct.Gia * ct.SoLuong), 0) 
                       FROM [dbo].[tb_ChiTietDonHang] ct 
                       WHERE ct.DonHangId = dh.Id)
    FROM [dbo].[tb_DonHang] dh
    JOIN deleted d ON dh.Id = d.DonHangId;
END
GO
-- Trigger 2: Tự động trừ Số lượng tồn kho khi Đặt hàng (Insert Chi tiết đơn hàng)
-- Lưu ý: Đây là logic đơn giản. Thực tế có thể trừ khi duyệt đơn.
CREATE TRIGGER [dbo].[trg_TruSoLuongTonKho]
ON [dbo].[tb_ChiTietDonHang]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE sp
    SET sp.SoLuong = sp.SoLuong - i.SoLuong
    FROM [dbo].[tb_SanPham] sp
    JOIN inserted i ON sp.Id = i.SanPhamId;
    
    -- Kiểm tra nếu số lượng âm thì Rollback (tùy chọn)
    -- IF EXISTS (SELECT 1 FROM [dbo].[tb_SanPham] WHERE SoLuong < 0)
    -- BEGIN
    --     ROLLBACK TRANSACTION;
    --     RAISERROR ('Số lượng tồn kho không đủ!', 16, 1);
    -- END
END
GO
-- Trigger 3: Tự động tạo Alias (Slug) nếu chưa có khi thêm Sản phẩm (Ví dụ đơn giản)
-- (Thường xử lý ở Code C# tốt hơn, nhưng đây là ví dụ Trigger)
/*
CREATE TRIGGER [dbo].[trg_TaoAliasSanPham]
ON [dbo].[tb_SanPham]
AFTER INSERT
AS
BEGIN
    UPDATE sp
    SET sp.BiDanh = LOWER(REPLACE(sp.TenSanPham, ' ', '-')) -- Logic đơn giản, chưa xử lý dấu tiếng Việt
    FROM [dbo].[tb_SanPham] sp
    JOIN inserted i ON sp.Id = i.Id
    WHERE i.BiDanh IS NULL OR i.BiDanh = '';
END
GO
*/