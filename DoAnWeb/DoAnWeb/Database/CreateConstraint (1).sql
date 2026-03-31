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
---------------------------------------------------------------
USE [WebBanHangDienTu]
GO

-- =============================================
-- 1. BẢNG tb_Menu
-- =============================================
-- Check HienThi chỉ nhận 0 hoặc 1
ALTER TABLE [dbo].[tb_Menu]
ADD CONSTRAINT [CK_tb_Menu_HienThi] CHECK ([HienThi] IN (0,1));
GO

-- UNIQUE (MenuChaId, ThuTu) để tránh trùng thứ tự menu con
ALTER TABLE [dbo].[tb_Menu]
ADD CONSTRAINT [UQ_tb_Menu_ThuTu] UNIQUE ([MenuChaId],[ThuTu]);
GO

-- =============================================
-- 2. BẢNG tb_Quyen
-- =============================================
-- TenQuyen duy nhất
ALTER TABLE [dbo].[tb_Quyen]
ADD CONSTRAINT [UQ_tb_Quyen_TenQuyen] UNIQUE ([TenQuyen]);
GO

-- =============================================
-- 3. BẢNG tb_LienHe
-- =============================================
-- Check DaDoc chỉ nhận 0 hoặc 1
ALTER TABLE [dbo].[tb_LienHe]
ADD CONSTRAINT [CK_tb_LienHe_DaDoc] CHECK ([DaDoc] IN (0,1));
GO

-- =============================================
-- 4. BẢNG tb_MaGiamGia
-- =============================================
-- Check SoLuong >= 0
ALTER TABLE [dbo].[tb_MaGiamGia]
ADD CONSTRAINT [CK_tb_MaGiamGia_SoLuong] CHECK ([SoLuong] >= 0);
GO

-- Check NgayKetThuc >= NgayTao
ALTER TABLE [dbo].[tb_MaGiamGia]
ADD CONSTRAINT [CK_tb_MaGiamGia_NgayKetThuc] CHECK ([NgayKetThuc] >= [NgayTao] OR [NgayKetThuc] IS NULL);
GO

-- Trigger: Tự động trừ số lượng khi mã giảm giá được dùng
CREATE TRIGGER [dbo].[trg_TruSoLuongMaGiamGia]
ON [dbo].[tb_DonHang]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE mg
    SET mg.SoLuong = mg.SoLuong - 1
    FROM [dbo].[tb_MaGiamGia] mg
    JOIN inserted i ON mg.Id = i.MaGiamGiaId
    WHERE i.MaGiamGiaId IS NOT NULL;

    -- Kiểm tra số lượng âm
    IF EXISTS (SELECT 1 FROM [dbo].[tb_MaGiamGia] WHERE SoLuong < 0)
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Số lượng mã giảm giá không đủ!',16,1);
    END
END
GO

-- =============================================
-- 5. BẢNG tb_QuangCao
-- =============================================
-- Check HienThi chỉ nhận 0 hoặc 1
ALTER TABLE [dbo].[tb_QuangCao]
ADD CONSTRAINT [CK_tb_QuangCao_HienThi] CHECK ([HienThi] IN (0,1));
GO

-- UNIQUE HinhAnh
ALTER TABLE [dbo].[tb_QuangCao]
ADD CONSTRAINT [UQ_tb_QuangCao_HinhAnh] UNIQUE ([HinhAnh]);
GO

-- =============================================
-- 6. BẢNG tb_TinTuc
-- =============================================
-- Check HienThi chỉ nhận 0 hoặc 1
ALTER TABLE [dbo].[tb_TinTuc]
ADD CONSTRAINT [CK_tb_TinTuc_HienThi] CHECK ([HienThi] IN (0,1));
GO

-- UNIQUE BiDanh
ALTER TABLE [dbo].[tb_TinTuc]
ADD CONSTRAINT [UQ_tb_TinTuc_BiDanh] UNIQUE ([BiDanh]);
GO

-- Trigger: Tự động tạo BiDanh (slug) nếu chưa có
CREATE TRIGGER [dbo].[trg_TaoSlugTinTuc]
ON [dbo].[tb_TinTuc]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE t
    SET t.BiDanh = LOWER(REPLACE(t.TieuDe,' ','-'))
    FROM [dbo].[tb_TinTuc] t
    JOIN inserted i ON t.Id = i.Id
    WHERE t.BiDanh IS NULL OR t.BiDanh = '';
END
GO

-- =============================================
-- 7. BẢNG tb_DanhMucTin
-- =============================================
-- Check HienThi chỉ nhận 0 hoặc 1
ALTER TABLE [dbo].[tb_DanhMucTin]
ADD CONSTRAINT [CK_tb_DanhMucTin_HienThi] CHECK ([HienThi] IN (0,1));
GO

-- UNIQUE BiDanh
ALTER TABLE [dbo].[tb_DanhMucTin]
ADD CONSTRAINT [UQ_tb_DanhMucTin_BiDanh] UNIQUE ([BiDanh]);
GO

PRINT N'Hoàn tất thêm ràng buộc và trigger cho tb_Menu, tb_Quyen, tb_LienHe, tb_MaGiamGia, tb_QuangCao, tb_TinTuc, tb_DanhMucTin!';
