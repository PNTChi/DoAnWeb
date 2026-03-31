-- =============================================
-- Script: Ki?m Tra Triggers và Stored Procedures
-- M?c ?ích: Phát hi?n các logic t? ??ng có th? ?nh h??ng t?n kho
-- =============================================

USE [WebBanHangDienTu]
GO

PRINT '========================================'
PRINT 'KI?M TRA H? TH?NG QU?N LÝ T?N KHO'
PRINT '========================================'
PRINT ''

-- 1. Ki?m tra t?t c? triggers liên quan ??n tb_SanPham
PRINT '1. TRIGGERS trên b?ng tb_SanPham:'
PRINT '----------------------------------------'
IF EXISTS (SELECT * FROM sys.triggers WHERE OBJECT_NAME(parent_id) = 'tb_SanPham')
BEGIN
    SELECT 
        '? TRIGGER' AS Type,
        t.name AS Name,
        OBJECT_NAME(t.parent_id) AS OnTable,
        CASE 
            WHEN t.is_disabled = 1 THEN 'Disabled'
            ELSE 'Enabled'
        END AS Status,
        t.create_date AS Created,
        t.modify_date AS Modified
    FROM sys.triggers t
    WHERE OBJECT_NAME(t.parent_id) = 'tb_SanPham'
END
ELSE
BEGIN
    PRINT '  ? Không có trigger nào trên tb_SanPham'
END
PRINT ''

-- 2. Ki?m tra t?t c? triggers liên quan ??n tb_ChiTietDonHang
PRINT '2. TRIGGERS trên b?ng tb_ChiTietDonHang:'
PRINT '----------------------------------------'
IF EXISTS (SELECT * FROM sys.triggers WHERE OBJECT_NAME(parent_id) = 'tb_ChiTietDonHang')
BEGIN
    SELECT 
        '? TRIGGER' AS Type,
        t.name AS Name,
        OBJECT_NAME(t.parent_id) AS OnTable,
        CASE 
            WHEN t.is_disabled = 1 THEN 'Disabled'
            ELSE 'Enabled'
        END AS Status,
        t.create_date AS Created,
        t.modify_date AS Modified
    FROM sys.triggers t
    WHERE OBJECT_NAME(t.parent_id) = 'tb_ChiTietDonHang'
END
ELSE
BEGIN
    PRINT '  ? Không có trigger nào trên tb_ChiTietDonHang'
END
PRINT ''

-- 3. Ki?m tra trigger ?ã b? xóa ch?a
PRINT '3. KI?M TRA trigger trg_TruSoLuongTonKho:'
PRINT '----------------------------------------'
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_TruSoLuongTonKho')
BEGIN
    PRINT '  ? C?NH BÁO: Trigger trg_TruSoLuongTonKho V?N T?N T?I!'
    PRINT '  ? Hãy ch?y script Fix_Remove_Duplicate_Trigger.sql'
END
ELSE
BEGIN
    PRINT '  ? Trigger trg_TruSoLuongTonKho ?ã ???c xóa'
END
PRINT ''

-- 4. Ki?m tra stored procedures liên quan ??n SoLuong
PRINT '4. STORED PROCEDURES liên quan ??n t?n kho:'
PRINT '----------------------------------------'
IF EXISTS (
    SELECT * FROM sys.procedures p
    INNER JOIN sys.sql_modules m ON p.object_id = m.object_id
    WHERE m.definition LIKE '%SoLuong%' 
       OR m.definition LIKE '%tb_SanPham%'
       OR p.name LIKE '%TonKho%'
       OR p.name LIKE '%SanPham%'
)
BEGIN
    SELECT 
        '? PROCEDURE' AS Type,
        p.name AS Name,
        p.create_date AS Created,
        p.modify_date AS Modified,
        CASE 
            WHEN m.definition LIKE '%UPDATE%tb_SanPham%SoLuong%' THEN 'C?P NH?T T?N KHO'
            WHEN m.definition LIKE '%INSERT%tb_ChiTietDonHang%' THEN 'THÊM CHI TI?T ??N'
            ELSE 'KHÁC'
        END AS Action
    FROM sys.procedures p
    INNER JOIN sys.sql_modules m ON p.object_id = m.object_id
    WHERE m.definition LIKE '%SoLuong%' 
       OR m.definition LIKE '%tb_SanPham%'
       OR p.name LIKE '%TonKho%'
       OR p.name LIKE '%SanPham%'
    
    PRINT ''
    PRINT '  ? Tìm th?y stored procedures liên quan!'
    PRINT '  ? Hãy ki?m tra xem có procedure nào t? ??ng tr? t?n kho không'
END
ELSE
BEGIN
    PRINT '  ? Không tìm th?y stored procedure nào liên quan'
END
PRINT ''

-- 5. Ki?m tra constraints
PRINT '5. CONSTRAINTS trên c?t SoLuong:'
PRINT '----------------------------------------'
SELECT 
    '? CONSTRAINT' AS Type,
    cc.name AS Name,
    cc.definition AS Definition,
    CASE 
        WHEN cc.is_disabled = 1 THEN 'Disabled'
        ELSE 'Enabled'
    END AS Status
FROM sys.check_constraints cc
INNER JOIN sys.columns c ON cc.parent_object_id = c.object_id
WHERE OBJECT_NAME(cc.parent_object_id) = 'tb_SanPham'
  AND c.name = 'SoLuong'
PRINT ''

-- 6. Ki?m tra giá tr? m?u
PRINT '6. KI?M TRA D? LI?U M?U (Top 5 s?n ph?m):'
PRINT '----------------------------------------'
SELECT TOP 5
    Id,
    TenSanPham,
    MaSanPham,
    SoLuong AS [T?n Kho Hi?n T?i],
    Gia,
    CASE 
        WHEN SoLuong < 0 THEN '? B?T TH??NG: T?n kho âm!'
        WHEN SoLuong = 0 THEN '? H?t hàng'
        WHEN SoLuong < 10 THEN '? S?p h?t'
        ELSE '? Bình th??ng'
    END AS [Tr?ng Thái]
FROM tb_SanPham
ORDER BY NgayTao DESC
PRINT ''

-- 7. Tóm t?t
PRINT '========================================'
PRINT 'TÓM T?T KI?M TRA'
PRINT '========================================'

DECLARE @triggerCount INT, @procCount INT, @negativStock INT

SELECT @triggerCount = COUNT(*) 
FROM sys.triggers 
WHERE OBJECT_NAME(parent_id) IN ('tb_SanPham', 'tb_ChiTietDonHang')

SELECT @procCount = COUNT(*)
FROM sys.procedures p
INNER JOIN sys.sql_modules m ON p.object_id = m.object_id
WHERE m.definition LIKE '%SoLuong%' 
   OR m.definition LIKE '%tb_SanPham%'

SELECT @negativStock = COUNT(*)
FROM tb_SanPham
WHERE SoLuong < 0

PRINT 'S? l??ng triggers liên quan: ' + CAST(@triggerCount AS VARCHAR(10))
PRINT 'S? l??ng stored procedures liên quan: ' + CAST(@procCount AS VARCHAR(10))
PRINT 'S? s?n ph?m có t?n kho âm: ' + CAST(@negativStock AS VARCHAR(10))
PRINT ''

IF @triggerCount > 0
    PRINT '? CÓ TRIGGERS CÓ TH? ?NH H??NG - Hãy xem xét lo?i b?'
ELSE
    PRINT '? Không có trigger nào có th? gây v?n ??'

IF @negativStock > 0
    PRINT '? CÓ S?N PH?M T?N KHO ÂM - C?n ?i?u tra!'
ELSE
    PRINT '? T?t c? t?n kho ??u h?p l?'

PRINT ''
PRINT '========================================'
GO
