-- SQL Script ?? thêm các c?t còn thi?u vào b?ng tb_QuangCao
-- Ch?y script này trong SQL Server Management Studio

USE [WebBanHangDienTu]
GO

-- Thêm c?t MoTa (Description)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_QuangCao]') AND name = 'MoTa')
BEGIN
    ALTER TABLE [dbo].[tb_QuangCao]
    ADD [MoTa] NVARCHAR(500) NULL;
    PRINT 'Added column MoTa';
END
ELSE
BEGIN
    PRINT 'Column MoTa already exists';
END
GO

-- Thêm c?t ViTri (Position)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_QuangCao]') AND name = 'ViTri')
BEGIN
    ALTER TABLE [dbo].[tb_QuangCao]
    ADD [ViTri] NVARCHAR(100) NULL;
    PRINT 'Added column ViTri';
END
ELSE
BEGIN
    PRINT 'Column ViTri already exists';
END
GO

-- Thêm c?t NgayCapNhat (Last Updated Date)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_QuangCao]') AND name = 'NgayCapNhat')
BEGIN
    ALTER TABLE [dbo].[tb_QuangCao]
    ADD [NgayCapNhat] DATETIME NULL;
    PRINT 'Added column NgayCapNhat';
END
ELSE
BEGIN
    PRINT 'Column NgayCapNhat already exists';
END
GO

-- Thêm c?t NguoiTao (Creator)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_QuangCao]') AND name = 'NguoiTao')
BEGIN
    ALTER TABLE [dbo].[tb_QuangCao]
    ADD [NguoiTao] NVARCHAR(100) NULL;
    PRINT 'Added column NguoiTao';
END
ELSE
BEGIN
    PRINT 'Column NguoiTao already exists';
END
GO

-- Thêm c?t NguoiCapNhat (Last Updater)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_QuangCao]') AND name = 'NguoiCapNhat')
BEGIN
    ALTER TABLE [dbo].[tb_QuangCao]
    ADD [NguoiCapNhat] NVARCHAR(100) NULL;
    PRINT 'Added column NguoiCapNhat';
END
ELSE
BEGIN
    PRINT 'Column NguoiCapNhat already exists';
END
GO

-- ??i tên c?t LienKet thành Link (n?u c?n)
-- Ch? ch?y n?u b?n mu?n ??i tên
/*
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[tb_QuangCao]') AND name = 'LienKet')
BEGIN
    EXEC sp_rename 'tb_QuangCao.LienKet', 'Link', 'COLUMN';
    PRINT 'Renamed column LienKet to Link';
END
GO
*/

-- Ki?m tra c?u trúc b?ng sau khi thêm
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tb_QuangCao'
ORDER BY ORDINAL_POSITION;

PRINT 'Migration completed successfully!';
GO
