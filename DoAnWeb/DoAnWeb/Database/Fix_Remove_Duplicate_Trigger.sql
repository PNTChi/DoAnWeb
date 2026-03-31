-- =============================================
-- Script: Xóa Trigger Trùng L?p Tr? T?n Kho
-- M?c ?ích: S?a l?i t?n kho b? tr? 2 l?n
-- Ngày t?o: 2024
-- =============================================

USE [WebBanHangDienTu]
GO

-- Ki?m tra và hi?n th? trigger hi?n t?i
PRINT '=== Ki?m tra trigger hi?n t?i ==='
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_TruSoLuongTonKho')
BEGIN
    PRINT 'Trigger [trg_TruSoLuongTonKho] t?n t?i - S? XÓA'
END
ELSE
BEGIN
    PRINT 'Trigger [trg_TruSoLuongTonKho] không t?n t?i'
END
GO

-- Xóa trigger gây l?i trùng l?p
PRINT ''
PRINT '=== ?ang xóa trigger... ==='
GO

DROP TRIGGER IF EXISTS [dbo].[trg_TruSoLuongTonKho]
GO

PRINT '? ?ã xóa trigger [trg_TruSoLuongTonKho] thành công!'
PRINT ''
PRINT '=== Lý do xóa trigger này ==='
PRINT '1. Code C# trong ThanhToanController.cs ?ã x? lý tr? t?n kho'
PRINT '2. Trigger này gây ra vi?c tr? t?n kho 2 l?n (duplicate)'
PRINT '3. Vi?c qu?n lý t?n kho trong code C# cho phép:'
PRINT '   - Logging chi ti?t'
PRINT '   - Error handling t?t h?n'
PRINT '   - Transaction control ch?t ch? h?n'
PRINT '   - D? debug và maintain'
PRINT ''
PRINT '=== K?t qu? ==='
PRINT '? T?n kho gi? ch? b? tr? 1 l?n duy nh?t khi ??t hàng'
PRINT '? Logic nghi?p v? ???c ki?m soát hoàn toàn trong code C#'
GO

-- Ki?m tra l?i sau khi xóa
PRINT ''
PRINT '=== Ki?m tra sau khi xóa ==='
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_TruSoLuongTonKho')
BEGIN
    PRINT '? C?NH BÁO: Trigger v?n còn t?n t?i!'
END
ELSE
BEGIN
    PRINT '? Xác nh?n: Trigger ?ã ???c xóa hoàn toàn'
END
GO

-- Li?t kê t?t c? triggers còn l?i
PRINT ''
PRINT '=== Danh sách các triggers còn l?i trên b?ng tb_ChiTietDonHang ==='
SELECT 
    t.name AS TriggerName,
    OBJECT_NAME(t.parent_id) AS TableName,
    t.create_date AS CreateDate,
    t.modify_date AS ModifyDate
FROM sys.triggers t
WHERE OBJECT_NAME(t.parent_id) = 'tb_ChiTietDonHang'
GO

PRINT ''
PRINT '=== HOÀN T?T ==='
PRINT 'Script ?ã ch?y xong. Vui lòng test l?i ch?c n?ng ??t hàng.'
PRINT ''
GO
