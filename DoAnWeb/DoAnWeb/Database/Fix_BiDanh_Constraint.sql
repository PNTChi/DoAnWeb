-- ================================================
-- CHECK tb_SanPham CONSTRAINTS
-- ================================================

-- 1. Ki?m tra UNIQUE constraints
SELECT 
    kc.name AS ConstraintName,
    c.name AS ColumnName,
    t.name AS TableName
FROM sys.key_constraints kc
JOIN sys.index_columns ic ON kc.parent_object_id = ic.object_id AND kc.unique_index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.tables t ON kc.parent_object_id = t.object_id
WHERE t.name = 'tb_SanPham' AND kc.type = 'UQ';

-- 2. Ki?m tra s?n ph?m có BiDanh NULL
SELECT 
    Id, 
    TenSanPham, 
    BiDanh, 
    MaSanPham
FROM tb_SanPham
WHERE BiDanh IS NULL OR BiDanh = '';

-- 3. Ki?m tra BiDanh trùng l?p
SELECT 
    BiDanh, 
    COUNT(*) AS SoLuong
FROM tb_SanPham
WHERE BiDanh IS NOT NULL
GROUP BY BiDanh
HAVING COUNT(*) > 1;

-- 4. Xem c?u trúc c?t BiDanh
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tb_SanPham' 
  AND COLUMN_NAME = 'BiDanh';

-- ================================================
-- FIX: C?p nh?t NULL BiDanh thành unique values
-- ================================================

-- Set BiDanh = TenSanPham-Id cho các NULL
UPDATE tb_SanPham
SET BiDanh = LOWER(REPLACE(TenSanPham, ' ', '-')) + '-' + CAST(Id AS VARCHAR(10))
WHERE BiDanh IS NULL OR BiDanh = '';

-- ================================================
-- VERIFY: Ki?m tra sau khi fix
-- ================================================

-- Check l?i NULL
SELECT COUNT(*) AS SoLuongNull
FROM tb_SanPham
WHERE BiDanh IS NULL OR BiDanh = '';

-- Check l?i duplicate
SELECT 
    BiDanh, 
    COUNT(*) AS SoLuong
FROM tb_SanPham
GROUP BY BiDanh
HAVING COUNT(*) > 1;
