-- =============================================
-- Script: Test Case Sau Khi S?a L?i
-- M?c ?ích: Xác minh t?n kho ch? gi?m 1 l?n
-- L?u ý: Script này CH? ?? DEMO - không nên ch?y trên production
-- =============================================

USE [WebBanHangDienTu]
GO

PRINT '========================================'
PRINT 'TEST CASE: Ki?m Tra T?n Kho Sau S?a L?i'
PRINT '========================================'
PRINT ''

-- B?t transaction ?? có th? rollback
BEGIN TRANSACTION TestInventory
GO

-- 1. T?o s?n ph?m test
PRINT '1. T?o s?n ph?m test...'
DECLARE @TestProductId INT
DECLARE @InitialStock INT = 100

INSERT INTO tb_SanPham (
    TenSanPham, MaSanPham, BiDanh, 
    Gia, SoLuong, DanhMucId, HienThi, NgayTao
)
VALUES (
    N'[TEST] S?n ph?m ki?m tra t?n kho',
    'TEST-INV-' + CAST(NEWID() AS VARCHAR(36)),
    'test-inventory-' + CAST(NEWID() AS VARCHAR(36)),
    1000000, -- 1 tri?u VND
    @InitialStock, -- T?n kho ban ??u = 100
    1, -- DanhMucId
    1, -- HienThi
    GETDATE()
)

SET @TestProductId = SCOPE_IDENTITY()
PRINT '   ? ?ã t?o s?n ph?m ID: ' + CAST(@TestProductId AS VARCHAR(10))
PRINT '   ? T?n kho ban ??u: ' + CAST(@InitialStock AS VARCHAR(10))
PRINT ''

-- 2. T?o ??n hàng test
PRINT '2. T?o ??n hàng test...'
DECLARE @TestOrderId INT

INSERT INTO tb_DonHang (
    MaDonHang, TenKhachHang, SoDienThoai, DiaChi, Email,
    TongTien, SoLuongSanPham, TrangThai, NgayTao
)
VALUES (
    'TEST-' + FORMAT(GETDATE(), 'yyyyMMddHHmmss'),
    N'Khách hàng test',
    '0123456789',
    N'??a ch? test',
    'test@test.com',
    1000000, -- T?ng ti?n
    1, -- S? l??ng s?n ph?m
    1, -- Tr?ng thái
    GETDATE()
)

SET @TestOrderId = SCOPE_IDENTITY()
PRINT '   ? ?ã t?o ??n hàng ID: ' + CAST(@TestOrderId AS VARCHAR(10))
PRINT ''

-- 3. Ki?m tra t?n kho TR??C khi thêm chi ti?t
PRINT '3. Ki?m tra t?n kho TR??C khi thêm chi ti?t ??n hàng...'
DECLARE @StockBefore INT

SELECT @StockBefore = SoLuong
FROM tb_SanPham
WHERE Id = @TestProductId

PRINT '   ? T?n kho hi?n t?i: ' + CAST(@StockBefore AS VARCHAR(10))
PRINT ''

-- 4. Thêm chi ti?t ??n hàng (TRIGGER s? t? ??ng tr? n?u còn t?n t?i)
PRINT '4. Thêm chi ti?t ??n hàng v?i s? l??ng = 1...'
DECLARE @OrderQuantity INT = 1

INSERT INTO tb_ChiTietDonHang (
    DonHangId, SanPhamId, Gia, SoLuong
)
VALUES (
    @TestOrderId,
    @TestProductId,
    1000000,
    @OrderQuantity
)

PRINT '   ? ?ã thêm chi ti?t ??n hàng (Quantity = ' + CAST(@OrderQuantity AS VARCHAR(10)) + ')'
PRINT ''

-- 5. Ki?m tra t?n kho SAU khi thêm chi ti?t
PRINT '5. Ki?m tra t?n kho SAU khi thêm chi ti?t ??n hàng...'
DECLARE @StockAfterInsert INT

SELECT @StockAfterInsert = SoLuong
FROM tb_SanPham
WHERE Id = @TestProductId

PRINT '   ? T?n kho sau khi INSERT: ' + CAST(@StockAfterInsert AS VARCHAR(10))
PRINT ''

-- 6. Phân tích k?t qu?
PRINT '6. PHÂN TÍCH K?T QU?:'
PRINT '   ----------------------------------------'
PRINT '   T?n kho ban ??u:       ' + CAST(@InitialStock AS VARCHAR(10))
PRINT '   S? l??ng ??t hàng:     ' + CAST(@OrderQuantity AS VARCHAR(10))
PRINT '   T?n kho mong ??i:      ' + CAST(@InitialStock - @OrderQuantity AS VARCHAR(10))
PRINT '   T?n kho th?c t?:       ' + CAST(@StockAfterInsert AS VARCHAR(10))
PRINT '   ----------------------------------------'

DECLARE @StockDecreased INT = @InitialStock - @StockAfterInsert

IF @StockDecreased = @OrderQuantity
BEGIN
    PRINT '   ? PASS: T?n kho gi?m ?ÚNG ' + CAST(@OrderQuantity AS VARCHAR(10))
    PRINT '   ? Trigger ?ã ???c xóa THÀNH CÔNG!'
    PRINT '   ? T?n kho ch? b? tr? 1 L?N (b?i code C# ho?c không b? tr? vì ?ây là test)'
END
ELSE IF @StockDecreased = @OrderQuantity * 2
BEGIN
    PRINT '   ? FAIL: T?n kho gi?m ' + CAST(@StockDecreased AS VARCHAR(10)) + ' (g?p ?ôi!)'
    PRINT '   ? Trigger V?N CÒN T?N T?I!'
    PRINT '   ? Hãy ch?y l?i script Fix_Remove_Duplicate_Trigger.sql'
END
ELSE IF @StockDecreased = 0
BEGIN
    PRINT '   ? WARNING: T?n kho KHÔNG GI?M'
    PRINT '   ? Trigger ?ã ???c xóa (t?t!)'
    PRINT '   ? Nh?ng code C# c?ng không tr? t?n kho (có th? do transaction test)'
    PRINT '   ? ?ây là bình th??ng trong test - code C# s? tr? trong ?ng d?ng th?c'
END
ELSE
BEGIN
    PRINT '   ? UNEXPECTED: T?n kho gi?m ' + CAST(@StockDecreased AS VARCHAR(10))
    PRINT '   ? Có logic b?t th??ng khác ?ang can thi?p'
    PRINT '   ? Hãy ch?y Check_Inventory_System.sql ?? tìm hi?u'
END
PRINT ''

-- 7. Ki?m tra có trigger nào còn t?n t?i không
PRINT '7. Ki?m tra trigger còn t?n t?i...'
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_TruSoLuongTonKho')
BEGIN
    PRINT '   ? Trigger trg_TruSoLuongTonKho V?N T?N T?I!'
    PRINT '   ? Hãy ch?y: Fix_Remove_Duplicate_Trigger.sql'
END
ELSE
BEGIN
    PRINT '   ? Trigger trg_TruSoLuongTonKho ?ã ???c xóa'
END
PRINT ''

-- 8. Rollback ?? không làm ?nh h??ng database
PRINT '8. Rollback transaction (xóa d? li?u test)...'
ROLLBACK TRANSACTION TestInventory
PRINT '   ? ?ã rollback - không có thay ??i nào trong database'
PRINT ''

PRINT '========================================'
PRINT 'K?T THÚC TEST'
PRINT '========================================'
PRINT ''
PRINT 'L?U Ý: Test này CH? ki?m tra trigger có b? xóa ch?a.'
PRINT '?? test ??y ??, hãy:'
PRINT '1. Ch?y ?ng d?ng web'
PRINT '2. ??t hàng th?c t?'
PRINT '3. Ki?m tra t?n kho trong database'
PRINT '4. Xem Debug Output trong Visual Studio'
GO
