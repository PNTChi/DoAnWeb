-- Script Insert Dữ liệu mẫu (Seed Data)
-- Chạy script này SAU KHI đã tạo Database bằng script database_schema.sql

USE [WebBanHangDienTu]
GO

USE [WebBanHangDienTu]
GO

-- ==================================================================================
-- 1. INSERT DANH MỤC (1 LỆNH DUY NHẤT)
-- ==================================================================================
INSERT INTO [dbo].[tb_DanhMuc] ([TenDanhMuc], [BiDanh], [Icon], [HienThi]) 
VALUES
(N'Điện thoại', 'dien-thoai', 'fas fa-mobile-alt', 1),
(N'Laptop', 'laptop', 'fas fa-laptop', 1),
(N'Tablet', 'tablet', 'fas fa-tablet-alt', 1),
(N'Phụ kiện', 'phu-kien', 'fas fa-headphones', 1);
GO

-- ==================================================================================
-- 2. INSERT THƯƠNG HIỆU (1 LỆNH DUY NHẤT)
-- ==================================================================================
INSERT INTO [dbo].[tb_ThuongHieu] ([TenThuongHieu], [BiDanh], [HienThi]) 
VALUES
(N'Apple', 'apple', 1), (N'Samsung', 'samsung', 1), (N'Xiaomi', 'xiaomi', 1), (N'Oppo', 'oppo', 1),
(N'Dell', 'dell', 1), (N'Asus', 'asus', 1), (N'Lenovo', 'lenovo', 1), (N'Sony', 'sony', 1),
(N'Anker', 'anker', 1), (N'UGREEN', 'ugreen', 1), (N'Baseus', 'baseus', 1), (N'AVA+', 'ava-plus', 1),
(N'Bowers & Wilkins', 'bowers-wilkins', 1), (N'Sennheiser', 'sennheiser', 1), (N'Shokz', 'shokz', 1);
GO

-- ==================================================================================
-- 3. INSERT 54 SẢN PHẨM (1 LỆNH DUY NHẤT - Mapping ID tự động)
-- ==================================================================================
INSERT INTO [dbo].[tb_SanPham] ([TenSanPham], [BiDanh], [MaSanPham], [Gia], [GiaKhuyenMai], [SoLuong], [DanhMucId], [ThuongHieuId], [HinhAnh], [HienThi], [LaSanPhamHot], [LaSanPhamMoi])
SELECT 
    Src.Ten, Src.Alias, Src.SKU, Src.Gia, Src.GiaKM, Src.SL, 
    D.Id, -- Tự động lấy ID Danh mục
    T.Id, -- Tự động lấy ID Thương hiệu
    Src.Anh, 1, Src.IsHot, Src.IsNew
FROM (VALUES
    -- IPHONE
    (N'iPhone 17', 'iphone-17', 'IP17', 22990000, 21990000, 50, 'dien-thoai', 'apple', 'DT_IP_17_1.png', 0, 1),
    (N'iPhone 17 Pro', 'iphone-17-pro', 'IP17P', 29990000, 28990000, 40, 'dien-thoai', 'apple', 'DT_IP_17Pro_1.png', 1, 1),
    (N'iPhone 17 Pro Max', 'iphone-17-pro-max', 'IP17PM', 34990000, 32990000, 100, 'dien-thoai', 'apple', 'DT_IP_17ProMax_1.png', 1, 1),
    (N'iPhone Air', 'iphone-air', 'IPAIR', 18990000, 0, 30, 'dien-thoai', 'apple', 'DT_IP_Air_1.png', 0, 1),
    -- OPPO
    (N'OPPO Find N5', 'oppo-find-n5', 'OPN5', 36990000, 34990000, 15, 'dien-thoai', 'oppo', 'DT_OPPO_Find_1.png', 1, 1),
    (N'OPPO Find N3 Flip', 'oppo-find-n3-flip', 'OPN3FLIP', 22990000, 19990000, 25, 'dien-thoai', 'oppo', 'DT_OPPO_FindFlip_1.png', 0, 0),
    (N'OPPO Find X8 Pro', 'oppo-find-x8-pro', 'OPX8PRO', 25990000, 0, 20, 'dien-thoai', 'oppo', 'DT_OPPO_FindX8Pro_1.png', 1, 1),
    (N'OPPO Reno12 Pro', 'oppo-reno12-pro', 'OPRENO12', 13990000, 12990000, 35, 'dien-thoai', 'oppo', 'DT_OPPO_Reno12Pro_1.png', 0, 0),
    -- SAMSUNG PHONE
    (N'Samsung Galaxy A56', 'samsung-galaxy-a56', 'SSA56', 10990000, 9990000, 60, 'dien-thoai', 'samsung', 'DT_SS_A56_1.png', 0, 1),
    (N'Samsung Galaxy Z Flip7', 'samsung-galaxy-z-flip7', 'SSFLIP7', 28990000, 26990000, 30, 'dien-thoai', 'samsung', 'DT_SS_Flip_1.png', 0, 1),
    (N'Samsung Galaxy Z Fold7', 'samsung-galaxy-z-fold7', 'SSFOLD7', 44990000, 41990000, 18, 'dien-thoai', 'samsung', 'DT_SS_Fold_1.png', 1, 1),
    (N'Samsung Galaxy S25 Ultra', 'samsung-galaxy-s25-ultra', 'SSS25U', 31990000, 29990000, 50, 'dien-thoai', 'samsung', 'DT_SS_S25Ultra_1.png', 1, 1),
    -- XIAOMI PHONE
    (N'Xiaomi 15', 'xiaomi-15', 'XM15', 19990000, 17990000, 40, 'dien-thoai', 'xiaomi', 'DT_XM_15_1.png', 0, 1),
    (N'Xiaomi 15 Ultra', 'xiaomi-15-ultra', 'XM15U', 24990000, 0, 20, 'dien-thoai', 'xiaomi', 'DT_XM_15Ultra_1.png', 1, 1),
    (N'Xiaomi Redmi 15', 'xiaomi-redmi-15', 'XMRM15', 4990000, 4590000, 80, 'dien-thoai', 'xiaomi', 'DT_XM_RM15_1.png', 0, 0),
    (N'Xiaomi Redmi Note 14 Pro+', 'xiaomi-redmi-note-14-pro-plus', 'XMRMN14', 14990000, 13990000, 50, 'dien-thoai', 'xiaomi', 'DT_XM_RMNote14Pro+_1.png', 0, 1),
    -- LAPTOP ASUS
    (N'Asus ROG Zephyrus G16', 'asus-rog-zephyrus-g16', 'ASROG16', 45990000, 43990000, 15, 'laptop', 'asus', 'LT_Asus_ROG16_1.png', 1, 1),
    (N'Asus TUF Gaming F16', 'asus-tuf-gaming-f16', 'ASTUF16', 28990000, 26990000, 25, 'laptop', 'asus', 'LT_Asus_TUF16_1.png', 0, 0),
    (N'Asus VivoBook S 14', 'asus-vivobook-s14', 'ASVIVO14', 18990000, 17990000, 30, 'laptop', 'asus', 'LT_Asus_VivoS14_1.png', 0, 0),
    (N'Asus ZenBook Duo', 'asus-zenbook-duo', 'ASZENDUO', 75990000, 73990000, 10, 'laptop', 'asus', 'LT_Asus_ZenDUO_1.png', 1, 1),
    -- LAPTOP DELL
    (N'Dell Alienware 16', 'dell-alienware-16', 'DELLAW16', 89990000, 85990000, 5, 'laptop', 'dell', 'LT_Dell_Alien16_1.png', 1, 1),
    (N'Dell Inspiron 16', 'dell-inspiron-16', 'DELLINS16', 25990000, 24990000, 20, 'laptop', 'dell', 'LT_Dell_Insp16_1.png', 0, 0),
    (N'Dell Latitude 7350', 'dell-latitude-7350', 'DELLLAT7350', 24990000, 23990000, 15, 'laptop', 'dell', 'LT_Dell_LatiUltra5_1.png', 0, 0),
    (N'Dell XPS 13', 'dell-xps-13', 'DELLXPS13', 38990000, 0, 25, 'laptop', 'dell', 'LT_Dell_XPS13_1.png', 1, 0),
    -- LAPTOP LENOVO
    (N'Lenovo LOQ 15', 'lenovo-loq-15', 'LNVLOQ15', 27990000, 25990000, 30, 'laptop', 'lenovo', 'LT_LNV_LOQ15_1.png', 0, 0),
    (N'Lenovo Legion Pro 7', 'lenovo-legion-pro-7', 'LNVLEG7', 55990000, 0, 10, 'laptop', 'lenovo', 'LT_LNV_LegiPro7_1.png', 1, 1),
    (N'Lenovo ThinkBook 16', 'lenovo-thinkbook-16', 'LNVTB16', 22990000, 21990000, 25, 'laptop', 'lenovo', 'LT_LNV_TB16_1.png', 0, 0),
    (N'Lenovo ThinkPad X1', 'lenovo-thinkpad-x1', 'LNVTPX1', 45990000, 42990000, 15, 'laptop', 'lenovo', 'LT_LNV_TPX1_1.png', 1, 0),
    -- MACBOOK
    (N'MacBook Air M1 2020', 'macbook-air-m1', 'MACM1', 18990000, 16990000, 150, 'laptop', 'apple', 'LT_Mac_AirM1_1.png', 0, 0),
    (N'MacBook Air M2 2022', 'macbook-air-m2', 'MACM2', 24990000, 22990000, 80, 'laptop', 'apple', 'LT_Mac_AirM2_1.png', 0, 0),
    (N'MacBook Air M4', 'macbook-air-m4', 'MACM4', 32990000, 0, 50, 'laptop', 'apple', 'LT_Mac_AirM4_1.png', 1, 1),
    (N'MacBook Pro M4', 'macbook-pro-m4', 'MACPROM4', 45990000, 43990000, 40, 'laptop', 'apple', 'LT_Mac_ProM4_1.png', 1, 1),
    -- TABLET IPAD
    (N'iPad Air 6', 'ipad-air-6', 'IPADAIR6', 16990000, 15990000, 60, 'tablet', 'apple', 'TB_IP_A16_1.png', 0, 1),
    (N'iPad Air M3', 'ipad-air-m3', 'IPADAIRM3', 21990000, 20990000, 45, 'tablet', 'apple', 'TB_IP_AirM3_1.png', 0, 1),
    (N'iPad Pro M4', 'ipad-pro-m4', 'IPADPROM4', 28990000, 0, 50, 'tablet', 'apple', 'TB_IP_ProM4_1.png', 1, 1),
    (N'iPad Mini 7', 'ipad-mini-7', 'IPADMINI7', 14990000, 0, 55, 'tablet', 'apple', 'TB_IP_Mini7_1.png', 0, 1),
    -- TABLET SAMSUNG
    (N'Samsung Galaxy Tab A9+', 'samsung-tab-a9-plus', 'SSTABA9P', 5990000, 5490000, 80, 'tablet', 'samsung', 'TB_SS_A9+_1.png', 0, 0),
    (N'Samsung Galaxy Tab A9', 'samsung-tab-a9', 'SSTABA9', 3990000, 3490000, 100, 'tablet', 'samsung', 'TB_SS_A9_1.png', 0, 0),
    (N'Samsung Galaxy Tab S11 Ultra', 'samsung-tab-s11-ultra', 'SSTABS11U', 29990000, 27990000, 20, 'tablet', 'samsung', 'TB_SS_S11Ultra_1.png', 1, 1),
    (N'Samsung Galaxy Tab S6 Lite', 'samsung-tab-s6-lite', 'SSTABS6L', 8990000, 7990000, 60, 'tablet', 'samsung', 'TB_SS_S6Lite_1.png', 0, 0),
    -- TABLET LENOVO
    (N'Lenovo Tab 4G', 'lenovo-tab-4g', 'LNVTAB4G', 4190000, 3950000, 40, 'tablet', 'lenovo', 'TB_LNV_4G_1.png', 0, 0),
    (N'Lenovo Tab Plus', 'lenovo-tab-plus', 'LNVTABPLUS', 6990000, 5590000, 35, 'tablet', 'lenovo', 'TB_LNV_Plus_1.png', 0, 0),
    -- TABLET XIAOMI
    (N'Xiaomi Pad 7 Pro', 'xiaomi-pad-7-pro', 'XMPAD7', 10990000, 0, 60, 'tablet', 'xiaomi', 'TB_XM_7Pro_1.png', 1, 1),
    (N'Xiaomi Redmi Pad 2', 'xiaomi-redmi-pad-2', 'XMRMPAD2', 5990000, 5490000, 50, 'tablet', 'xiaomi', 'TB_XM_RM2_1.png', 0, 0),
    (N'Xiaomi Redmi Pad Pro', 'xiaomi-redmi-pad-pro', 'XMRMPADPRO', 7990000, 7490000, 40, 'tablet', 'xiaomi', 'TB_XM_RMPro_1.png', 0, 0),
    (N'Xiaomi Redmi Pad SE', 'xiaomi-redmi-pad-se', 'XMRMPADSE', 4990000, 4590000, 70, 'tablet', 'xiaomi', 'TB_XM_RMSE_1.png', 0, 0),
    -- PHỤ KIỆN
    (N'Sạc dự phòng Anker 20K', 'sac-du-phong-anker', 'ANKER20K', 1200000, 990000, 200, 'phu-kien', 'anker', 'PK_SDP_Anker_1.png', 0, 0),
    (N'Sạc dự phòng AVA+ Q7', 'sac-du-phong-ava', 'AVAPLUS20K', 590000, 350000, 300, 'phu-kien', 'ava-plus', 'PK_SDP_AVA+_1.png', 0, 0),
    (N'Sạc dự phòng Baseus Lipow', 'sac-du-phong-baseus', 'BASEUS20K', 890000, 799000, 150, 'phu-kien', 'baseus', 'PK_SDP_Baseus_1.png', 0, 0),
    (N'Sạc dự phòng Ugreen Nexode', 'sac-du-phong-ugreen', 'UGREEN20K', 3180000, 2890000, 50, 'phu-kien', 'ugreen', 'PK_SDP_Ugreen_1.png', 1, 0),
    (N'Tai nghe Sennheiser IE200', 'tai-nghe-sennheiser-ie200', 'SENIE200', 3190000, 2890000, 30, 'phu-kien', 'sennheiser', 'PK_TN_Sen_1.png', 0, 0),
    (N'Tai nghe Shokz OpenRun', 'tai-nghe-shokz', 'SHOKZOPEN', 3490000, 0, 40, 'phu-kien', 'shokz', 'PK_TN_Shokz_1.png', 0, 0),
    (N'Tai nghe Sony WH-1000XM6', 'tai-nghe-sony-wh-1000xm6', 'SONYXM6', 10990000, 9990000, 20, 'phu-kien', 'sony', 'PK_TN_Sony_1.png', 1, 1),
    (N'Tai nghe B&W Pi8 TWS', 'tai-nghe-bw-pi8', 'BWPI8', 13645000, 12990000, 15, 'phu-kien', 'bowers-wilkins', 'PK_TN_TWS_1.png', 1, 1)
) AS Src (Ten, Alias, SKU, Gia, GiaKM, SL, CatAlias, BrandAlias, Anh, IsHot, IsNew)
JOIN tb_DanhMuc D ON Src.CatAlias = D.BiDanh
JOIN tb_ThuongHieu T ON Src.BrandAlias = T.BiDanh;
GO

-- ==================================================================================
-- 4. INSERT 324 HÌNH ẢNH (1 LỆNH DUY NHẤT - Mapping SP cũ sang SKU mới)
-- ==================================================================================
INSERT INTO [dbo].[tb_AnhSanPham] ([SanPhamId], [HinhAnh], [LaAnhMacDinh])
SELECT 
    P.Id,           -- Lấy ID sản phẩm thật trong DB
    Img.FileName,   -- Tên file ảnh
    Img.IsMain      -- Cờ ảnh chính
FROM 
    -- Bảng 1: Chứa dữ liệu ảnh thô (Mã SP Cũ + Tên file)
    (VALUES 
        -- iPhone
        ('SP003','DT_IP_17ProMax_1.png',1), ('SP003','DT_IP_17ProMax_2.png',0), ('SP003','DT_IP_17ProMax_3.png',0), ('SP003','DT_IP_17ProMax_4.png',0), ('SP003','DT_IP_17ProMax_5.png',0), ('SP003','DT_IP_17ProMax_6.png',0),
        ('SP002','DT_IP_17Pro_1.png',1), ('SP002','DT_IP_17Pro_2.png',0), ('SP002','DT_IP_17Pro_3.png',0), ('SP002','DT_IP_17Pro_4.png',0), ('SP002','DT_IP_17Pro_5.png',0), ('SP002','DT_IP_17Pro_6.png',0),
        ('SP001','DT_IP_17_1.png',1), ('SP001','DT_IP_17_2.png',0), ('SP001','DT_IP_17_3.png',0), ('SP001','DT_IP_17_4.png',0), ('SP001','DT_IP_17_5.png',0), ('SP001','DT_IP_17_6.png',0),
        ('SP004','DT_IP_Air_1.png',1), ('SP004','DT_IP_Air_2.png',0), ('SP004','DT_IP_Air_3.png',0), ('SP004','DT_IP_Air_4.png',0), ('SP004','DT_IP_Air_5.png',0), ('SP004','DT_IP_Air_6.png',0),
        -- OPPO
        ('SP006','DT_OPPO_FindFlip_1.png',1), ('SP006','DT_OPPO_FindFlip_2.png',0), ('SP006','DT_OPPO_FindFlip_3.png',0), ('SP006','DT_OPPO_FindFlip_4.png',0), ('SP006','DT_OPPO_FindFlip_5.png',0), ('SP006','DT_OPPO_FindFlip_6.png',0),
        ('SP007','DT_OPPO_FindX8Pro_1.png',1), ('SP007','DT_OPPO_FindX8Pro_2.png',0), ('SP007','DT_OPPO_FindX8Pro_3.png',0), ('SP007','DT_OPPO_FindX8Pro_4.png',0), ('SP007','DT_OPPO_FindX8Pro_5.png',0), ('SP007','DT_OPPO_FindX8Pro_6.png',0),
        ('SP005','DT_OPPO_Find_1.png',1), ('SP005','DT_OPPO_Find_2.png',0), ('SP005','DT_OPPO_Find_3.png',0), ('SP005','DT_OPPO_Find_4.png',0), ('SP005','DT_OPPO_Find_5.png',0), ('SP005','DT_OPPO_Find_6.png',0),
        ('SP008','DT_OPPO_Reno12Pro_1.png',1), ('SP008','DT_OPPO_Reno12Pro_2.png',0), ('SP008','DT_OPPO_Reno12Pro_3.png',0), ('SP008','DT_OPPO_Reno12Pro_4.png',0), ('SP008','DT_OPPO_Reno12Pro_5.png',0), ('SP008','DT_OPPO_Reno12Pro_6.png',0),
        -- Samsung
        ('SP009','DT_SS_A56_1.png',1), ('SP009','DT_SS_A56_2.png',0), ('SP009','DT_SS_A56_3.png',0), ('SP009','DT_SS_A56_4.png',0), ('SP009','DT_SS_A56_5.png',0), ('SP009','DT_SS_A56_6.png',0),
        ('SP010','DT_SS_Flip_1.png',1), ('SP010','DT_SS_Flip_2.png',0), ('SP010','DT_SS_Flip_3.png',0), ('SP010','DT_SS_Flip_4.png',0), ('SP010','DT_SS_Flip_5.png',0), ('SP010','DT_SS_Flip_6.png',0),
        ('SP011','DT_SS_Fold_1.png',1), ('SP011','DT_SS_Fold_2.png',0), ('SP011','DT_SS_Fold_3.png',0), ('SP011','DT_SS_Fold_4.png',0), ('SP011','DT_SS_Fold_5.png',0), ('SP011','DT_SS_Fold_6.png',0),
        ('SP012','DT_SS_S25Ultra_1.png',1), ('SP012','DT_SS_S25Ultra_2.png',0), ('SP012','DT_SS_S25Ultra_3.png',0), ('SP012','DT_SS_S25Ultra_4.png',0), ('SP012','DT_SS_S25Ultra_5.png',0), ('SP012','DT_SS_S25Ultra_6.png',0),
        -- Xiaomi Phone
        ('SP014','DT_XM_15Ultra_1.png',1), ('SP014','DT_XM_15Ultra_2.png',0), ('SP014','DT_XM_15Ultra_3.png',0), ('SP014','DT_XM_15Ultra_4.png',0), ('SP014','DT_XM_15Ultra_5.png',0), ('SP014','DT_XM_15Ultra_6.png',0),
        ('SP013','DT_XM_15_1.png',1), ('SP013','DT_XM_15_2.png',0), ('SP013','DT_XM_15_3.png',0), ('SP013','DT_XM_15_4.png',0), ('SP013','DT_XM_15_5.png',0), ('SP013','DT_XM_15_6.png',0),
        ('SP015','DT_XM_RM15_1.png',1), ('SP015','DT_XM_RM15_2.png',0), ('SP015','DT_XM_RM15_3.png',0), ('SP015','DT_XM_RM15_4.png',0), ('SP015','DT_XM_RM15_5.png',0), ('SP015','DT_XM_RM15_6.png',0),
        ('SP016','DT_XM_RMNote14Pro+_1.png',1), ('SP016','DT_XM_RMNote14Pro+_2.png',0), ('SP016','DT_XM_RMNote14Pro+_3.png',0), ('SP016','DT_XM_RMNote14Pro+_4.png',0), ('SP016','DT_XM_RMNote14Pro+_5.png',0), ('SP016','DT_XM_RMNote14Pro+_6.png',0),
        -- Laptop
        ('SP017','LT_Asus_ROG16_1.png',1), ('SP017','LT_Asus_ROG16_2.png',0), ('SP017','LT_Asus_ROG16_3.png',0), ('SP017','LT_Asus_ROG16_4.png',0), ('SP017','LT_Asus_ROG16_5.png',0), ('SP017','LT_Asus_ROG16_6.png',0),
        ('SP018','LT_Asus_TUF16_1.png',1), ('SP018','LT_Asus_TUF16_2.png',0), ('SP018','LT_Asus_TUF16_3.png',0), ('SP018','LT_Asus_TUF16_4.png',0), ('SP018','LT_Asus_TUF16_5.png',0), ('SP018','LT_Asus_TUF16_6.png',0),
        ('SP019','LT_Asus_VivoS14_1.png',1), ('SP019','LT_Asus_VivoS14_2.png',0), ('SP019','LT_Asus_VivoS14_3.png',0), ('SP019','LT_Asus_VivoS14_4.png',0), ('SP019','LT_Asus_VivoS14_5.png',0), ('SP019','LT_Asus_VivoS14_6.png',0),
        ('SP020','LT_Asus_ZenDUO_1.png',1), ('SP020','LT_Asus_ZenDUO_2.png',0), ('SP020','LT_Asus_ZenDUO_3.png',0), ('SP020','LT_Asus_ZenDUO_4.png',0), ('SP020','LT_Asus_ZenDUO_5.png',0), ('SP020','LT_Asus_ZenDUO_6.png',0),
        ('SP021','LT_Dell_Alien16_1.png',1), ('SP021','LT_Dell_Alien16_2.png',0), ('SP021','LT_Dell_Alien16_3.png',0), ('SP021','LT_Dell_Alien16_4.png',0), ('SP021','LT_Dell_Alien16_5.png',0), ('SP021','LT_Dell_Alien16_6.png',0),
        ('SP022','LT_Dell_Insp16_1.png',1), ('SP022','LT_Dell_Insp16_2.png',0), ('SP022','LT_Dell_Insp16_3.png',0), ('SP022','LT_Dell_Insp16_4.png',0), ('SP022','LT_Dell_Insp16_5.png',0), ('SP022','LT_Dell_Insp16_6.png',0),
        ('SP023','LT_Dell_LatiUltra5_1.png',1), ('SP023','LT_Dell_LatiUltra5_2.png',0), ('SP023','LT_Dell_LatiUltra5_3.png',0), ('SP023','LT_Dell_LatiUltra5_4.png',0), ('SP023','LT_Dell_LatiUltra5_5.png',0), ('SP023','LT_Dell_LatiUltra5_6.png',0),
        ('SP024','LT_Dell_XPS13_1.png',1), ('SP024','LT_Dell_XPS13_2.png',0), ('SP024','LT_Dell_XPS13_3.png',0), ('SP024','LT_Dell_XPS13_4.png',0), ('SP024','LT_Dell_XPS13_5.png',0), ('SP024','LT_Dell_XPS13_6.png',0),
        ('SP026','LT_LNV_LegiPro7_1.png',1), ('SP026','LT_LNV_LegiPro7_2.png',0), ('SP026','LT_LNV_LegiPro7_3.png',0), ('SP026','LT_LNV_LegiPro7_4.png',0), ('SP026','LT_LNV_LegiPro7_5.png',0), ('SP026','LT_LNV_LegiPro7_6.png',0),
        ('SP025','LT_LNV_LOQ15_1.png',1), ('SP025','LT_LNV_LOQ15_2.png',0), ('SP025','LT_LNV_LOQ15_3.png',0), ('SP025','LT_LNV_LOQ15_4.png',0), ('SP025','LT_LNV_LOQ15_5.png',0), ('SP025','LT_LNV_LOQ15_6.png',0),
        ('SP027','LT_LNV_TB16_1.png',1), ('SP027','LT_LNV_TB16_2.png',0), ('SP027','LT_LNV_TB16_3.png',0), ('SP027','LT_LNV_TB16_4.png',0), ('SP027','LT_LNV_TB16_5.png',0), ('SP027','LT_LNV_TB16_6.png',0),
        ('SP028','LT_LNV_TPX1_1.png',1), ('SP028','LT_LNV_TPX1_2.png',0), ('SP028','LT_LNV_TPX1_3.png',0), ('SP028','LT_LNV_TPX1_4.png',0), ('SP028','LT_LNV_TPX1_5.png',0), ('SP028','LT_LNV_TPX1_6.png',0),
        ('SP029','LT_Mac_AirM1_1.png',1), ('SP029','LT_Mac_AirM1_2.png',0), ('SP029','LT_Mac_AirM1_3.png',0), ('SP029','LT_Mac_AirM1_4.png',0), ('SP029','LT_Mac_AirM1_5.png',0), ('SP029','LT_Mac_AirM1_6.png',0),
        ('SP030','LT_Mac_AirM2_1.png',1), ('SP030','LT_Mac_AirM2_2.png',0), ('SP030','LT_Mac_AirM2_3.png',0), ('SP030','LT_Mac_AirM2_4.png',0), ('SP030','LT_Mac_AirM2_5.png',0), ('SP030','LT_Mac_AirM2_6.png',0),
        ('SP031','LT_Mac_AirM4_1.png',1), ('SP031','LT_Mac_AirM4_2.png',0), ('SP031','LT_Mac_AirM4_3.png',0), ('SP031','LT_Mac_AirM4_4.png',0), ('SP031','LT_Mac_AirM4_5.png',0), ('SP031','LT_Mac_AirM4_6.png',0),
        ('SP032','LT_Mac_ProM4_1.png',1), ('SP032','LT_Mac_ProM4_2.png',0), ('SP032','LT_Mac_ProM4_3.png',0), ('SP032','LT_Mac_ProM4_4.png',0), ('SP032','LT_Mac_ProM4_5.png',0), ('SP032','LT_Mac_ProM4_6.png',0),
        -- PK
        ('SP047','PK_SDP_Anker_1.png',1), ('SP047','PK_SDP_Anker_2.png',0), ('SP047','PK_SDP_Anker_3.png',0), ('SP047','PK_SDP_Anker_4.png',0), ('SP047','PK_SDP_Anker_5.png',0), ('SP047','PK_SDP_Anker_6.png',0),
        ('SP048','PK_SDP_AVA+_1.png',1), ('SP048','PK_SDP_AVA+_2.png',0), ('SP048','PK_SDP_AVA+_3.png',0), ('SP048','PK_SDP_AVA+_4.png',0), ('SP048','PK_SDP_AVA+_5.png',0), ('SP048','PK_SDP_AVA+_6.png',0),
        ('SP049','PK_SDP_Baseus_1.png',1), ('SP049','PK_SDP_Baseus_2.png',0), ('SP049','PK_SDP_Baseus_3.png',0), ('SP049','PK_SDP_Baseus_4.png',0), ('SP049','PK_SDP_Baseus_5.png',0), ('SP049','PK_SDP_Baseus_6.png',0),
        ('SP050','PK_SDP_Ugreen_1.png',1), ('SP050','PK_SDP_Ugreen_2.png',0), ('SP050','PK_SDP_Ugreen_3.png',0), ('SP050','PK_SDP_Ugreen_4.png',0), ('SP050','PK_SDP_Ugreen_5.png',0), ('SP050','PK_SDP_Ugreen_6.png',0),
        ('SP051','PK_TN_Sen_1.png',1), ('SP051','PK_TN_Sen_2.png',0), ('SP051','PK_TN_Sen_3.png',0), ('SP051','PK_TN_Sen_4.png',0), ('SP051','PK_TN_Sen_5.png',0), ('SP051','PK_TN_Sen_6.png',0),
        ('SP052','PK_TN_Shokz_1.png',1), ('SP052','PK_TN_Shokz_2.png',0), ('SP052','PK_TN_Shokz_3.png',0), ('SP052','PK_TN_Shokz_4.png',0), ('SP052','PK_TN_Shokz_5.png',0), ('SP052','PK_TN_Shokz_6.png',0),
        ('SP053','PK_TN_Sony_1.png',1), ('SP053','PK_TN_Sony_2.png',0), ('SP053','PK_TN_Sony_3.png',0), ('SP053','PK_TN_Sony_4.png',0), ('SP053','PK_TN_Sony_5.png',0), ('SP053','PK_TN_Sony_6.png',0),
        ('SP054','PK_TN_TWS_1.png',1), ('SP054','PK_TN_TWS_2.png',0), ('SP054','PK_TN_TWS_3.png',0), ('SP054','PK_TN_TWS_4.png',0), ('SP054','PK_TN_TWS_5.png',0), ('SP054','PK_TN_TWS_6.png',0),
        -- Tablet
        ('SP033','TB_IP_A16_1.png',1), ('SP033','TB_IP_A16_2.png',0), ('SP033','TB_IP_A16_3.png',0), ('SP033','TB_IP_A16_4.png',0), ('SP033','TB_IP_A16_5.png',0), ('SP033','TB_IP_A16_6.png',0),
        ('SP034','TB_IP_AirM3_1.png',1), ('SP034','TB_IP_AirM3_2.png',0), ('SP034','TB_IP_AirM3_3.png',0), ('SP034','TB_IP_AirM3_4.png',0), ('SP034','TB_IP_AirM3_5.png',0), ('SP034','TB_IP_AirM3_6.png',0),
        ('SP035','TB_IP_ProM4_1.png',1), ('SP035','TB_IP_ProM4_2.png',0), ('SP035','TB_IP_ProM4_3.png',0), ('SP035','TB_IP_ProM4_4.png',0), ('SP035','TB_IP_ProM4_5.png',0), ('SP035','TB_IP_ProM4_6.png',0),
        ('SP036','TB_IP_Mini7_1.png',1), ('SP036','TB_IP_Mini7_2.png',0), ('SP036','TB_IP_Mini7_3.png',0), ('SP036','TB_IP_Mini7_4.png',0), ('SP036','TB_IP_Mini7_5.png',0), ('SP036','TB_IP_Mini7_6.png',0),
        ('SP041','TB_LNV_4G_1.png',1), ('SP041','TB_LNV_4G_2.png',0), ('SP041','TB_LNV_4G_3.png',0), ('SP041','TB_LNV_4G_4.png',0), ('SP041','TB_LNV_4G_5.png',0), ('SP041','TB_LNV_4G_6.png',0),
        ('SP042','TB_LNV_Plus_1.png',1), ('SP042','TB_LNV_Plus_2.png',0), ('SP042','TB_LNV_Plus_3.png',0), ('SP042','TB_LNV_Plus_4.png',0), ('SP042','TB_LNV_Plus_5.png',0), ('SP042','TB_LNV_Plus_6.png',0),
        ('SP037','TB_SS_A9+_1.png',1), ('SP037','TB_SS_A9+_2.png',0), ('SP037','TB_SS_A9+_3.png',0), ('SP037','TB_SS_A9+_4.png',0), ('SP037','TB_SS_A9+_5.png',0), ('SP037','TB_SS_A9+_6.png',0),
        ('SP038','TB_SS_A9_1.png',1), ('SP038','TB_SS_A9_2.png',0), ('SP038','TB_SS_A9_3.png',0), ('SP038','TB_SS_A9_4.png',0), ('SP038','TB_SS_A9_5.png',0), ('SP038','TB_SS_A9_6.png',0),
        ('SP039','TB_SS_S11Ultra_1.png',1), ('SP039','TB_SS_S11Ultra_2.png',0), ('SP039','TB_SS_S11Ultra_3.png',0), ('SP039','TB_SS_S11Ultra_4.png',0), ('SP039','TB_SS_S11Ultra_5.png',0), ('SP039','TB_SS_S11Ultra_6.png',0),
        ('SP040','TB_SS_S6Lite_1.png',1), ('SP040','TB_SS_S6Lite_2.png',0), ('SP040','TB_SS_S6Lite_3.png',0), ('SP040','TB_SS_S6Lite_4.png',0), ('SP040','TB_SS_S6Lite_5.png',0), ('SP040','TB_SS_S6Lite_6.png',0),
        ('SP043','TB_XM_7Pro_1.png',1), ('SP043','TB_XM_7Pro_2.png',0), ('SP043','TB_XM_7Pro_3.png',0), ('SP043','TB_XM_7Pro_4.png',0), ('SP043','TB_XM_7Pro_5.png',0), ('SP043','TB_XM_7Pro_6.png',0),
        ('SP044','TB_XM_RM2_1.png',1), ('SP044','TB_XM_RM2_2.png',0), ('SP044','TB_XM_RM2_3.png',0), ('SP044','TB_XM_RM2_4.png',0), ('SP044','TB_XM_RM2_5.png',0), ('SP044','TB_XM_RM2_6.png',0),
        ('SP045','TB_XM_RMPro_1.png',1), ('SP045','TB_XM_RMPro_2.png',0), ('SP045','TB_XM_RMPro_3.png',0), ('SP045','TB_XM_RMPro_4.png',0), ('SP045','TB_XM_RMPro_5.png',0), ('SP045','TB_XM_RMPro_6.png',0),
        ('SP046','TB_XM_RMSE_1.png',1), ('SP046','TB_XM_RMSE_2.png',0), ('SP046','TB_XM_RMSE_3.png',0), ('SP046','TB_XM_RMSE_4.png',0), ('SP046','TB_XM_RMSE_5.png',0), ('SP046','TB_XM_RMSE_6.png',0)
    ) AS Img(OldSP, FileName, IsMain)
    -- Bảng 2: Mapping Mã cũ (SP001) -> Mã SKU mới (IP17)
    JOIN (VALUES
        ('SP001', 'IP17'),      ('SP002', 'IP17P'),     ('SP003', 'IP17PM'),    ('SP004', 'IPAIR'),
        ('SP005', 'OPN5'),      ('SP006', 'OPN3FLIP'),  ('SP007', 'OPX8PRO'),   ('SP008', 'OPRENO12'),
        ('SP009', 'SSA56'),     ('SP010', 'SSFLIP7'),   ('SP011', 'SSFOLD7'),   ('SP012', 'SSS25U'),
        ('SP013', 'XM15'),      ('SP014', 'XM15U'),     ('SP015', 'XMRM15'),    ('SP016', 'XMRMN14'),
        ('SP017', 'ASROG16'),   ('SP018', 'ASTUF16'),   ('SP019', 'ASVIVO14'),  ('SP020', 'ASZENDUO'),
        ('SP021', 'DELLAW16'),  ('SP022', 'DELLINS16'), ('SP023', 'DELLLAT7350'),('SP024', 'DELLXPS13'),
        ('SP025', 'LNVLOQ15'),  ('SP026', 'LNVLEG7'),   ('SP027', 'LNVTB16'),   ('SP028', 'LNVTPX1'),
        ('SP029', 'MACM1'),     ('SP030', 'MACM2'),     ('SP031', 'MACM4'),     ('SP032', 'MACPROM4'),
        ('SP033', 'IPADAIR6'),  ('SP034', 'IPADAIRM3'), ('SP035', 'IPADPROM4'), ('SP036', 'IPADMINI7'),
        ('SP037', 'SSTABA9P'),  ('SP038', 'SSTABA9'),   ('SP039', 'SSTABS11U'), ('SP040', 'SSTABS6L'),
        ('SP041', 'LNVTAB4G'),  ('SP042', 'LNVTABPLUS'),
        ('SP043', 'XMPAD7'),    ('SP044', 'XMRMPAD2'),  ('SP045', 'XMRMPADPRO'),('SP046', 'XMRMPADSE'),
        ('SP047', 'ANKER20K'),  ('SP048', 'AVAPLUS20K'),('SP049', 'BASEUS20K'), ('SP050', 'UGREEN20K'),
        ('SP051', 'SENIE200'),  ('SP052', 'SHOKZOPEN'), ('SP053', 'SONYXM6'),   ('SP054', 'BWPI8')
    ) AS Map(OldSP, RealSKU) ON Img.OldSP = Map.OldSP
    -- Join bảng sản phẩm để lấy ID
    JOIN tb_SanPham P ON Map.RealSKU = P.MaSanPham;
GO

USE [WebBanHangDienTu]
GO

USE [WebBanHangDienTu]
GO

-- UPDATE MÔ TẢ VÀ CHI TIẾT TỪ DỮ LIỆU CŨ (Mapping SP00x -> SKU mới)
UPDATE P
SET 
    P.MoTa = Src.MoTaNgan,
    P.ChiTiet = Src.MoTaChiTiet
FROM [dbo].[tb_SanPham] P
JOIN (
    -- 1. NGUỒN DỮ LIỆU CŨ (COPY NGUYÊN VĂN TỪ BẠN GỬI)
    VALUES
    -- iPhone
    ('SP001', N'iPhone 17 tiêu chuẩn với thiết kế tinh tế, hiệu năng mạnh mẽ và camera nâng cấp vượt trội cho năm 2025', N'iPhone 17 sở hữu màn hình Super Retina XDR OLED 6,1 inch, độ phân giải 2556x1179 pixel, mật độ điểm ảnh khoảng 460 ppi. Máy được trang bị chip A18 Bionic với hiệu năng cao, hỗ trợ trí tuệ nhân tạo và tiết kiệm điện năng hơn. Hệ thống camera kép 48MP cải tiến, chụp đêm và quay video tốt hơn. Thiết kế khung nhôm cao cấp, hỗ trợ sạc MagSafe và kết nối USB-C.'),
    ('SP002', N'Chiếc iPhone 17 Pro là mẫu flagship “Pro” của Apple cho năm 2025, với chip mạnh mẽ, camera chuyên nghiệp', N'iPhone 17 Pro có màn hình Super Retina XDR OLED 6,3 inch, độ phân giải 2.622 × 1.206 pixel, mật độ điểm ảnh khoảng 460 ppi, Thiết bị được trang bị chip A19 Pro, kết hợp với thiết kế buồng hơi (vapor chamber) giúp quản lý nhiệt và hiệu suất bền hơn.'),
    ('SP003', N'iPhone 17 chính hãng', N'iPhone 17 với Màn hình Super Retina XDR, Màn hình toàn phần OLED 6,9 inch (theo đường chéo), Độ phân giải 2868x1320 pixel với mật độ điểm ảnh 460 ppi'),
    ('SP004', N'iPhone Air – phiên bản nhẹ nhất trong dòng iPhone 17 với thiết kế siêu mỏng, hiệu năng ổn định và giá dễ tiếp cận', N'iPhone Air được trang bị màn hình Super Retina XDR OLED 6,1 inch, độ phân giải 2556x1179 pixel, mật độ điểm ảnh 460 ppi. Máy sử dụng chip A18, tối ưu cho hiệu suất và tiết kiệm năng lượng. Thiết kế siêu mỏng, khung nhôm tái chế, mặt lưng kính mờ chống bám vân tay. Camera kép 48MP với khả năng chụp đêm tốt, quay video 4K HDR. Hỗ trợ sạc nhanh USB-C, kết nối 5G và Face ID.'),
    
    -- Samsung
    ('SP005', N'OPPO Find N5 – smartphone màn hình gập cao cấp, thiết kế tinh tế, hiệu năng mạnh mẽ và camera tiên tiến', N'OPPO Find N5 sở hữu màn hình chính LTPO2 AMOLED 7,1 inch khi mở ra, màn hình phụ 6,3 inch, cả hai đều hỗ trợ tần số quét 120Hz và độ phân giải Full HD+. Máy trang bị chip Snapdragon 8 Gen 3, RAM 12GB, bộ nhớ trong 256GB/512GB. Hệ thống 3 camera sau gồm: camera chính 50MP, góc siêu rộng 50MP, telephoto 13MP. Camera selfie 32MP. Pin 4600mAh hỗ trợ sạc nhanh 100W, sạc không dây 50W. Thiết kế bản lề chắc chắn, khung nhôm cao cấp, chạy Android 15 với giao diện ColorOS 14.'),
    ('SP006', N'OPPO Find N3 Flip Hồng – smartphone gập dọc thời trang, nhỏ gọn với màu sắc nổi bật và hiệu năng ổn định', N'OPPO Find N3 Flip sở hữu màn hình chính LTPO AMOLED 6,7 inch, màn hình phụ 1,9 inch bên ngoài để hiển thị thông báo và điều khiển nhanh. Máy trang bị chip Snapdragon 8+ Gen 2, RAM 8GB, bộ nhớ trong 256GB. Hệ thống camera kép sau 50MP + 13MP, camera selfie 32MP. Pin 4300mAh hỗ trợ sạc nhanh 66W. Thiết kế bản lề chắc chắn, khung nhôm, mặt lưng kính màu hồng thời trang, chạy Android 15 với ColorOS 14.'),
    ('SP007', N'OPPO Find X8 Pro – flagship cao cấp với màn hình AMOLED 6,8 inch, hiệu năng mạnh mẽ và camera chuyên nghiệp', N'OPPO Find X8 Pro sở hữu màn hình LTPO2 AMOLED 6,8 inch, độ phân giải QHD+ (3200 x 1440 pixel), tần số quét 120Hz, hỗ trợ HDR10+. Máy trang bị chip Snapdragon 8 Gen 3, RAM 12GB, bộ nhớ trong 256GB/512GB. Hệ thống 3 camera sau gồm: camera chính 50MP, camera góc siêu rộng 50MP, telephoto 13MP. Camera selfie 32MP. Pin 5000mAh hỗ trợ sạc nhanh 100W, sạc không dây 50W và sạc ngược. Thiết kế khung nhôm cao cấp, mặt lưng kính gốm, chạy Android 15 với giao diện ColorOS 14.'),
    ('SP008', N'OPPO Reno12 Pro – smartphone tầm trung cao cấp với thiết kế sang trọng, hiệu năng ổn định và camera cải tiến', N'OPPO Reno12 Pro sở hữu màn hình AMOLED 6,7 inch, độ phân giải Full HD+ (2412 x 1080 pixel), tần số quét 120Hz. Máy trang bị chip MediaTek Dimensity 9200+, RAM 12GB, bộ nhớ trong 256GB/512GB. Hệ thống 3 camera sau gồm: camera chính 50MP, góc siêu rộng 8MP và macro 2MP. Camera selfie 32MP. Pin 4500mAh hỗ trợ sạc nhanh 100W. Thiết kế khung nhôm, mặt lưng kính Gradient, chạy Android 15 với giao diện ColorOS 14.'),
    ('SP009', N'Samsung Galaxy A56 – smartphone tầm trung với thiết kế hiện đại, hiệu năng ổn định và camera ấn tượng', N'Samsung Galaxy A56 sở hữu màn hình Super AMOLED 6,6 inch độ phân giải Full HD+ (2340 x 1080 pixel), tần số quét 120Hz cho trải nghiệm mượt mà. Máy được trang bị chip Exynos 1480 (5nm), RAM 8GB và bộ nhớ trong 128GB/256GB. Hệ thống 3 camera sau gồm: cảm biến chính 50MP, góc siêu rộng 12MP và macro 5MP. Camera selfie 32MP hỗ trợ quay video 4K. Pin 5000mAh hỗ trợ sạc nhanh 25W. Thiết kế khung nhôm, mặt lưng kính, kháng nước IP67, chạy Android 15 với giao diện One UI 7.'),
    ('SP010', N'Samsung Galaxy Z Flip7 – điện thoại gập dọc thời trang, nhỏ gọn với hiệu năng mạnh mẽ và camera nâng cấp', N'Samsung Galaxy Z Flip7 trang bị màn hình chính Dynamic AMOLED 2X 6,7 inch, độ phân giải Full HD+ (2640 x 1080 pixel) và tần số quét 120Hz. Màn hình phụ bên ngoài 3,9 inch Super AMOLED hỗ trợ hiển thị thông báo, điều khiển nhạc và camera selfie. Thiết bị sử dụng chip Snapdragon 8 Gen 3 for Galaxy, RAM 8GB, bộ nhớ trong 256GB. Camera kép gồm cảm biến chính 50MP và góc siêu rộng 12MP, camera selfie 10MP. Pin 4000mAh hỗ trợ sạc nhanh 25W, sạc không dây và sạc ngược. Thiết kế bản lề Armor Aluminum chắc chắn, kháng nước IPX8, chạy Android 15 với One UI 7.'),
    ('SP011', N'Samsung Galaxy Z Fold7 512GB – điện thoại gập cao cấp với thiết kế tinh tế, màn hình lớn và hiệu năng vượt trội', N'Samsung Galaxy Z Fold7 512GB sở hữu màn hình chính Dynamic AMOLED 2X 7,6 inch độ phân giải QXGA+ (2176 x 1812 pixel) và màn hình phụ 6,3 inch HD+. Thiết bị trang bị chip Snapdragon 8 Gen 3 for Galaxy, RAM 12GB, bộ nhớ trong 512GB. Hệ thống 3 camera sau gồm cảm biến chính 50MP, góc siêu rộng 12MP và telephoto 10MP. Pin dung lượng 4400mAh hỗ trợ sạc nhanh 45W, sạc không dây và sạc ngược. Thiết kế gập bền bỉ với bản lề Armor Aluminum, chống nước chuẩn IPX8, chạy Android 15 cùng giao diện One UI 7.'),
    ('SP012', N'Samsung Galaxy S25 Ultra – flagship đỉnh cao với hiệu năng mạnh mẽ, camera 200MP và bút S Pen đặc trưng', N'Samsung Galaxy S25 Ultra trang bị màn hình Dynamic AMOLED 2X 6,8 inch độ phân giải QHD+ (3120 x 1440 pixel), tần số quét 120Hz và độ sáng tối đa 2.600 nits. Thiết bị sử dụng chip Snapdragon 8 Gen 3 for Galaxy, RAM 12GB, bộ nhớ trong từ 256GB đến 1TB. Hệ thống 4 camera sau gồm: cảm biến chính 200MP, góc siêu rộng 12MP, telephoto 50MP và 10MP. Camera selfie 12MP. Pin 5000mAh hỗ trợ sạc nhanh 45W, sạc không dây và sạc ngược. Máy hỗ trợ bút S Pen, khung titan siêu bền, chạy Android 15 với giao diện One UI 7, hỗ trợ cập nhật phần mềm đến 7 năm.'),
    
    -- Xiaomi
    ('SP013', N'Xiaomi 15 – smartphone cao cấp với hiệu năng mạnh mẽ, camera 50MP và thiết kế mỏng nhẹ', N'Xiaomi 15 sở hữu màn hình AMOLED 6,67 inch, độ phân giải Full HD+ (2400 x 1080 pixel), tần số quét 120Hz, hỗ trợ HDR10+. Máy trang bị chip Snapdragon 8 Gen 3, RAM 8GB/12GB, bộ nhớ trong 128GB/256GB. Hệ thống 3 camera sau gồm: camera chính 50MP, góc siêu rộng 13MP và macro 5MP. Camera selfie 32MP. Pin 4500mAh hỗ trợ sạc nhanh 100W có dây và 30W không dây. Thiết kế khung nhôm, mặt lưng kính, chạy MIUI 16 trên nền Android 15.'),
    ('SP014', N'Xiaomi 15 Ultra Trắng – flagship cao cấp với hiệu năng mạnh mẽ, camera 200MP và thiết kế sang trọng', N'Xiaomi 15 Ultra sở hữu màn hình AMOLED 6,73 inch, độ phân giải QHD+ (3200 x 1440 pixel), tần số quét 120Hz, hỗ trợ HDR10+. Máy trang bị chip Snapdragon 8 Gen 3, RAM 12GB, bộ nhớ trong 256GB/512GB. Hệ thống 3 camera sau gồm: camera chính 200MP, góc siêu rộng 48MP và telephoto 48MP. Camera selfie 32MP. Pin 5000mAh hỗ trợ sạc nhanh 120W có dây và 50W không dây. Thiết kế khung nhôm, mặt lưng gốm màu trắng, chạy MIUI 16 trên nền Android 15.'),
    ('SP015', N'Xiaomi Redmi 15 – smartphone tầm trung, hiệu năng ổn định, pin dung lượng lớn và giá hợp lý', N'Xiaomi Redmi 15 sở hữu màn hình IPS LCD 6,6 inch, độ phân giải Full HD+ (2408 x 1080 pixel), tần số quét 90Hz. Máy trang bị chip MediaTek Helio G99, RAM 6GB, bộ nhớ trong 128GB. Hệ thống 3 camera sau gồm: camera chính 50MP, góc siêu rộng 2MP và macro 2MP. Camera selfie 8MP. Pin 5000mAh hỗ trợ sạc nhanh 18W. Thiết kế khung nhựa, mặt lưng nhựa, chạy MIUI 14 trên nền Android 15.'),
    ('SP016', N'Xiaomi Redmi Note 14 Pro+ 5G – smartphone tầm trung cao cấp, hiệu năng mạnh mẽ, bộ nhớ lớn và kết nối 5G', N'Xiaomi Redmi Note 14 Pro+ 5G sở hữu màn hình AMOLED 6,67 inch, độ phân giải Full HD+ (2400 x 1080 pixel), tần số quét 120Hz, hỗ trợ HDR10+. Máy trang bị chip MediaTek Dimensity 6100+, RAM 12GB, bộ nhớ trong 512GB. Hệ thống 3 camera sau gồm: camera chính 108MP, góc siêu rộng 8MP và macro 2MP. Camera selfie 32MP. Pin 5000mAh hỗ trợ sạc nhanh 67W. Thiết kế khung nhôm, mặt lưng kính, chạy MIUI 16 trên nền Android 15, kết nối 5G.'),

    -- Laptop
    ('SP017', N'MacBook Pro 16-inch M4 Pro – laptop cao cấp của Apple với hiệu năng mạnh mẽ, màn hình lớn và pin lâu', N'MacBook Pro 16-inch trang bị chip Apple M4 Pro với RAM 24GB và bộ nhớ SSD 512GB, màn hình Liquid Retina XDR 16-inch, độ phân giải 3456 x 2234 pixel, hỗ trợ ProMotion 120Hz. Hệ thống âm thanh 6 loa, micro chất lượng studio, webcam 1080p. Pin 100Wh hỗ trợ sạc nhanh, chạy macOS Sonoma với khả năng tối ưu phần mềm và bảo mật cao. Thích hợp cho dựng phim, thiết kế đồ họa, lập trình và các công việc chuyên nghiệp.'),
    ('SP018', N'MacBook Air 13-inch M4 – laptop mỏng nhẹ của Apple với hiệu năng mạnh mẽ và pin lâu', N'MacBook Air 13-inch trang bị chip Apple M4 với RAM 24GB và bộ nhớ SSD 512GB, màn hình Retina 13,3 inch, độ phân giải 2560 x 1600 pixel, hỗ trợ True Tone. Hệ thống âm thanh 4 loa, micro chất lượng studio, webcam 1080p. Pin 75Wh hỗ trợ sạc nhanh, chạy macOS Sonoma với khả năng tối ưu phần mềm và bảo mật cao. Thiết kế mỏng nhẹ, thích hợp cho học tập, làm việc văn phòng và di chuyển nhiều.'),
    ('SP019', N'MacBook Air 2020 – laptop mỏng nhẹ, thiết kế tinh tế với hiệu năng ổn định cho công việc văn phòng và học tập', N'MacBook Air 2020 trang bị chip Apple M1, RAM 8GB, bộ nhớ SSD 256GB, màn hình Retina 13,3 inch, độ phân giải 2560 x 1600 pixel, hỗ trợ True Tone. Hệ thống âm thanh 2 loa, micro chất lượng cao, webcam 720p. Pin 49,9Wh cho thời gian sử dụng đến 18 giờ, chạy macOS Big Sur. Thiết kế mỏng nhẹ, khung nhôm nguyên khối, thích hợp cho học tập, làm việc văn phòng và di chuyển nhiều.'),
    ('SP020', N'MacBook Air M2 2022 – laptop mỏng nhẹ, hiệu năng mạnh mẽ với chip M2, RAM 16GB và bộ nhớ SSD 256GB', N'MacBook Air M2 2022 trang bị chip Apple M2 với RAM 16GB và SSD 256GB, màn hình Liquid Retina 13,6 inch, độ phân giải 2560 x 1664 pixel, hỗ trợ True Tone và P3 Wide Color. Hệ thống âm thanh 4 loa, micro chất lượng studio, webcam 1080p. Pin 52,6Wh hỗ trợ sạc nhanh 67W, chạy macOS Ventura với khả năng tối ưu phần mềm và bảo mật cao. Thiết kế mỏng nhẹ, khung nhôm nguyên khối, thích hợp cho học tập, làm việc văn phòng và di chuyển nhiều.'),
    ('SP021', N'Dell XPS 13 9350 – laptop cao cấp, mỏng nhẹ với hiệu năng ổn định cho công việc văn phòng và di chuyển', N'Dell XPS 13 9350 trang bị CPU Intel Core i7 thế hệ 7, RAM 8GB, bộ nhớ SSD 256GB, màn hình InfinityEdge 13,3 inch Full HD (1920 x 1080) với lớp kính chống chói. Hệ thống âm thanh 2 loa chất lượng tốt, webcam HD 720p. Pin 52Wh cho thời gian sử dụng đến 10 giờ, chạy Windows 10 Home. Thiết kế khung nhôm, nắp lưng sợi carbon, mỏng nhẹ, thích hợp cho học tập, làm việc văn phòng và di chuyển nhiều.'),
    ('SP022', N'Dell Alienware 16 Aurora – máy tính để bàn gaming cao cấp với hiệu năng mạnh mẽ, thiết kế hầm hố và hệ thống tản nhiệt tối ưu', N'Dell Alienware 16 Aurora AC16250 trang bị CPU Intel Core i9 thế hệ 9, RAM 32GB, bộ nhớ SSD 1TB + HDD 2TB, card đồ họa NVIDIA GeForce RTX 4080 16GB. Hệ thống tản nhiệt Alienware Cryo-Tech, hỗ trợ chơi game nặng, render 3D và xử lý đồ họa chuyên nghiệp. Cổng kết nối đa dạng, hỗ trợ Wi-Fi 6E, Bluetooth 5.2, chạy Windows 11 Pro. Thiết kế hầm hố, LED RGB tùy chỉnh, thích hợp cho game thủ và các công việc đồ họa nặng.'),
    ('SP023', N'Dell Latitude 7350 Ultra 5 – laptop doanh nghiệp cao cấp, mỏng nhẹ, hiệu năng ổn định và bảo mật cao', N'Dell Latitude 7350 Ultra 5 trang bị CPU Intel Core i5 thế hệ 8, RAM 16GB, bộ nhớ SSD 512GB, màn hình 13,3 inch Full HD (1920 x 1080) với công nghệ chống chói. Hệ thống âm thanh 2 loa, webcam HD 720p. Pin 60Wh cho thời gian sử dụng đến 12 giờ, chạy Windows 11 Pro. Thiết kế khung nhôm chắc chắn, kháng va đập, bảo mật TPM 2.0 và vân tay. Thích hợp cho doanh nghiệp, học tập và làm việc di động.'),
    ('SP024', N'Dell Inspiron 16 5640 – laptop hiệu năng cao, màn hình lớn, phù hợp học tập, làm việc và giải trí', N'Dell Inspiron 16 5640 trang bị CPU Intel Core i7 thế hệ 12, RAM 16GB, bộ nhớ SSD 512GB, màn hình 16 inch Full HD (1920 x 1200) với tấm nền IPS, hiển thị sắc nét, chống chói. Hệ thống âm thanh 2 loa, webcam HD 720p. Pin 68Wh cho thời gian sử dụng đến 10 giờ, chạy Windows 11 Home. Thiết kế khung nhôm + nhựa cao cấp, trọng lượng vừa phải, thích hợp cho làm việc văn phòng, học tập và giải trí đa phương tiện.'),
    ('SP025', N'Lenovo ThinkPad X1 2-in-1 Gen 10 – laptop doanh nghiệp cao cấp, hiệu năng mạnh mẽ, thiết kế 2-trong-1 linh hoạt', N'Lenovo ThinkPad X1 2-in-1 Gen 10 Ultra 7 255U trang bị CPU Intel Core i7 thế hệ 13, RAM 32GB, bộ nhớ SSD 1TB, màn hình 14 inch 2.8K OLED cảm ứng, hỗ trợ HDR, Dolby Vision và bút cảm ứng. Hệ thống âm thanh 4 loa Harman, micro chất lượng studio, webcam 1080p với ThinkShutter. Pin 63Wh cho thời gian sử dụng lên tới 12 giờ, chạy Windows 11 Pro. Thiết kế bản lề 360 độ, khung nhôm + sợi carbon, bảo mật vân tay, TPM 2.0, thích hợp cho doanh nghiệp, sáng tạo nội dung và làm việc di động.'),
    ('SP026', N'Lenovo Legion Pro 7 16IAX10H – laptop gaming cao cấp với hiệu năng mạnh mẽ, màn hình lớn và thiết kế hầm hố', N'Lenovo Legion Pro 7 16IAX10H Ultra 9 275HX trang bị CPU Intel Core i9 thế hệ 13, RAM 32GB, bộ nhớ SSD 1TB, card đồ họa NVIDIA GeForce RTX 4080 16GB. Màn hình 16 inch QHD+ 165Hz IPS, hỗ trợ Dolby Vision và G-Sync. Hệ thống tản nhiệt Legion Coldfront 5.0, 4 loa âm thanh vòm, webcam 1080p. Pin 99Wh hỗ trợ sạc nhanh 300W, chạy Windows 11 Home. Thiết kế hầm hố, LED RGB tùy chỉnh, thích hợp cho game thủ và các tác vụ đồ họa nặng.'),
    ('SP027', N'Lenovo Gaming LOQ 15AHP10 – laptop gaming tầm trung với hiệu năng ổn định, thiết kế trẻ trung và màn hình 15 inch', N'Lenovo Gaming LOQ 15AHP10 R7 trang bị CPU AMD Ryzen 7 6800H, RAM 16GB, bộ nhớ SSD 512GB, card đồ họa NVIDIA GeForce RTX 4060 8GB. Màn hình 15,6 inch Full HD IPS, tần số quét 144Hz, hỗ trợ Dolby Vision. Hệ thống âm thanh 2 loa, webcam HD 720p. Pin 60Wh, chạy Windows 11 Home. Thiết kế trẻ trung, logo LED RGB, bàn phím RGB 4-zone, phù hợp cho học tập, làm việc và chơi game nhẹ đến trung bình.'),
    ('SP028', N'Lenovo ThinkBook 16 Ultra 7 – laptop doanh nghiệp cao cấp với hiệu năng mạnh mẽ, màn hình lớn và thiết kế mỏng nhẹ', N'Lenovo ThinkBook 16 Ultra 7 21SK006YVN trang bị CPU Intel Core i7 thế hệ 13, RAM 32GB, bộ nhớ SSD 1TB, màn hình 16 inch 2.5K IPS, hỗ trợ HDR và Dolby Vision. Hệ thống âm thanh 2 loa, webcam 1080p với ThinkShutter. Pin 71Wh cho thời gian sử dụng lên tới 12 giờ, chạy Windows 11 Pro. Thiết kế kim loại nguyên khối, bảo mật TPM 2.0 và vân tay, thích hợp cho doanh nghiệp, làm việc đa nhiệm và sáng tạo nội dung.'),
    ('SP029', N'ASUS VivoBook S 14 – laptop mỏng nhẹ, hiệu năng ổn định, thiết kế hiện đại phù hợp học tập và làm việc văn phòng', N'ASUS VivoBook S 14 S5406SA Ultra 7 PP059WS trang bị CPU Intel Core i7 thế hệ 13, RAM 16GB, bộ nhớ SSD 512GB, màn hình 14 inch Full HD (1920 x 1080) IPS, chống chói, viền mỏng. Hệ thống âm thanh 2 loa, webcam HD 720p. Pin 50Wh cho thời gian sử dụng đến 8 giờ, chạy Windows 11 Home. Thiết kế mỏng nhẹ, vỏ kim loại, bàn phím full-size, thích hợp cho học tập, làm việc văn phòng và di chuyển nhiều.'),
    ('SP030', N'ASUS TUF Gaming F16 – laptop gaming tầm trung với hiệu năng ổn định, thiết kế bền bỉ và màn hình 16 inch', N'ASUS TUF Gaming F16 FX608JMR trang bị CPU Intel Core i7 thế hệ 12, RAM 16GB, bộ nhớ SSD 512GB, card đồ họa NVIDIA GeForce RTX 4060 8GB. Màn hình 16 inch Full HD IPS, tần số quét 144Hz, chống chói, hỗ trợ Adaptive Sync. Hệ thống âm thanh 2 loa, webcam HD 720p. Pin 90Wh, chạy Windows 11 Home. Thiết kế cứng cáp đạt chuẩn quân đội MIL-STD-810H, bàn phím RGB 4-zone, LED logo TUF, thích hợp cho chơi game, học tập và làm việc đa nhiệm.'),
    ('SP031', N'ASUS ZenBook Duo UX8406CA – laptop cao cấp 2 màn hình, thiết kế sáng tạo, hiệu năng mạnh mẽ, phù hợp làm việc đa nhiệm và sáng tạo nội dung', N'ASUS ZenBook Duo UX8406CA Ultra 9 PZ109WS trang bị CPU Intel Core i9 thế hệ 13, RAM 32GB, bộ nhớ SSD 1TB, card đồ họa NVIDIA GeForce RTX 4050 8GB. Màn hình chính 14 inch OLED 2.8K, màn hình phụ ScreenPad Plus 12.7 inch cảm ứng, hỗ trợ bút stylus. Hệ thống âm thanh 4 loa, webcam 1080p. Pin 76Wh, chạy Windows 11 Pro. Thiết kế 2 màn hình song song độc đáo, bản lề ErgoLift, vỏ nhôm nguyên khối, thích hợp cho sáng tạo nội dung, thiết kế đồ họa và làm việc đa nhiệm chuyên sâu.'),
    ('SP032', N'ASUS ROG Zephyrus G16 – laptop gaming cao cấp mỏng nhẹ, hiệu năng mạnh mẽ, màn hình 16 inch và thiết kế hiện đại', N'ASUS ROG Zephyrus G16 GU605CM Ultra 9 QR078W trang bị CPU Intel Core i9 thế hệ 13, RAM 32GB, bộ nhớ SSD 1TB, card đồ họa NVIDIA GeForce RTX 4070 8GB. Màn hình 16 inch QHD+ 165Hz IPS, hỗ trợ Adaptive Sync và Dolby Vision. Hệ thống âm thanh 4 loa, webcam 1080p. Pin 90Wh hỗ trợ sạc nhanh, chạy Windows 11 Home. Thiết kế mỏng nhẹ, vỏ nhôm, bàn phím RGB, logo ROG LED, thích hợp cho game thủ và làm việc đồ họa nặng.'),
    
    -- Tablet
    ('SP033', N'iPad Pro M4 11-inch – máy tính bảng cao cấp của Apple với hiệu năng mạnh mẽ, màn hình Liquid Retina và bộ nhớ lớn 1TB', N'iPad Pro M4 11-inch trang bị chip Apple M4, RAM 16GB, bộ nhớ 1TB, màn hình Liquid Retina 11 inch, độ phân giải 2388 x 1668 pixel, hỗ trợ ProMotion 120Hz, True Tone và P3 Wide Color. Camera sau 12MP + LiDAR Scanner, camera trước 12MP Ultra Wide. Pin sử dụng cả ngày (~10 giờ), chạy iPadOS 17. Hỗ trợ bút Apple Pencil 2, bàn phím Magic Keyboard, thích hợp cho thiết kế, vẽ, học tập và làm việc đa nhiệm.'),
    ('SP034', N'iPad Pro M4 11-inch – máy tính bảng cao cấp của Apple, hiệu năng mạnh mẽ với bộ nhớ 512GB', N'iPad Pro M4 11-inch trang bị chip Apple M4, RAM 16GB, bộ nhớ SSD 512GB, màn hình Liquid Retina 11 inch, độ phân giải 2388 x 1668 pixel, hỗ trợ ProMotion 120Hz, True Tone và P3 Wide Color. Camera sau 12MP + LiDAR Scanner, camera trước 12MP Ultra Wide. Pin sử dụng cả ngày (~10 giờ), chạy iPadOS 17. Hỗ trợ Apple Pencil 2 và bàn phím Magic Keyboard, phù hợp cho thiết kế, vẽ, học tập và làm việc đa nhiệm.'),
    ('SP035', N'iPad Air M3 13-inch – máy tính bảng mỏng nhẹ, hiệu năng mạnh mẽ với kết nối 5G và bộ nhớ 128GB', N'iPad Air M3 13-inch trang bị chip Apple M3, RAM 8GB, bộ nhớ SSD 128GB, màn hình Liquid Retina 13 inch, độ phân giải 2732 x 2048 pixel, hỗ trợ ProMotion 120Hz, True Tone và P3 Wide Color. Camera sau 12MP, camera trước 12MP Ultra Wide với Center Stage. Pin sử dụng cả ngày (~10 giờ), chạy iPadOS 17. Hỗ trợ Apple Pencil 2 và bàn phím Magic Keyboard, phù hợp cho học tập, làm việc đa nhiệm và sáng tạo nội dung.'),
    ('SP036', N'iPad Mini 7 – máy tính bảng nhỏ gọn, hiệu năng mạnh mẽ với bộ nhớ 512GB', N'iPad Mini 7 trang bị chip Apple M3, RAM 6GB, bộ nhớ SSD 512GB, màn hình Liquid Retina 8,3 inch, độ phân giải 2266 x 1488 pixel, hỗ trợ True Tone và P3 Wide Color. Camera sau 12MP, camera trước 12MP Ultra Wide với Center Stage. Pin sử dụng cả ngày (~10 giờ), chạy iPadOS 17. Hỗ trợ Apple Pencil 2, thích hợp cho học tập, vẽ, giải trí và làm việc di động.'),
    ('SP037', N'Samsung Galaxy Tab S11 Ultra – máy tính bảng cao cấp, màn hình lớn, hiệu năng mạnh mẽ với kết nối 5G và bộ nhớ 1TB', N'Samsung Galaxy Tab S11 Ultra trang bị chip Snapdragon 8 Gen 3, RAM 16GB, bộ nhớ 1TB, màn hình AMOLED 14,6 inch, độ phân giải 2960 x 1848 pixel, hỗ trợ 120Hz và HDR10+. Camera sau 13MP + 5MP, camera trước 12MP. Pin 11.500mAh, hỗ trợ sạc nhanh 45W, chạy Android 14 với One UI 6. Hỗ trợ S Pen, Samsung DeX, thích hợp cho làm việc đa nhiệm, giải trí và sáng tạo nội dung.'),
    ('SP038', N'Samsung Galaxy Tab S6 Lite 2024 – máy tính bảng tầm trung với bút S‑Pen kèm theo, thiết kế mỏng nhẹ và màn hình 10,4 inch', N'Samsung Galaxy Tab S6 Lite (2024) sở hữu màn hình TFT LCD 10,4 inch độ phân giải 2000×1200 pixel, khung mỏng chỉ 7,0 mm, trọng lượng khoảng 465 g (WiFi). Máy dùng chip Exynos 1280, RAM 4GB, bộ nhớ trong 64GB hoặc 128GB, hỗ trợ thẻ microSD lên đến 1TB. Máy ảnh sau 8MP và camera trước 5MP, pin dung lượng 7.040 mAh cho thời lượng sử dụng lên tới ~14 giờ. Hệ điều hành Android 14 với giao diện One UI 6.1, hỗ trợ bút S Pen kèm theo và nhiều màu sắc trẻ trung (Oxford Gray, Chiffon Pink, Mint).'),
    ('SP039', N'Samsung Galaxy Tab A9 Plus 5G – máy tính bảng 11″ tầm trung‑cao với kết nối 5G, màn hình lớn và hiệu năng ổn định', N'Samsung Galaxy Tab A9 Plus 5G trang bị màn hình TFT LCD 11,0 inch 1200×1920 pixel, tần số quét 90Hz, vi xử lý Snapdragon 695 5G, RAM 4GB/8GB, bộ nhớ trong 64GB/128GB (hỗ trợ microSD đến 1TB), camera sau 8MP, camera trước 5MP, pin 7.040mAh, sạc 15W, chạy Android 13 với One UI 5.1. Thiết kế mỏng nhẹ (~6,9 mm, ~490g), phù hợp giải trí, học tập và làm việc di động.'),
    ('SP040', N'Samsung Galaxy Tab A9 – máy tính bảng nhỏ gọn, hiệu năng ổn định và giá dễ tiếp cận', N'Samsung Galaxy Tab A9 trang bị màn hình TFT LCD 8,7 inch độ phân giải 800×1340 pixel, vi xử lý Mediatek Helio G99, RAM 4GB, bộ nhớ trong 64GB (hỗ trợ thẻ microSD). Máy có camera sau 8MP, camera trước 2MP, pin khoảng 5.100mAh, sạc 15W, chạy Android 13 với One UI. Thiết kế nhẹ (~332g) và mỏng (~8mm), phù hợp cho giải trí, học tập và sử dụng hàng ngày.'),
    ('SP041', N'Xiaomi Pad 7 Pro – tablet cao cấp với màn hình lớn, hiệu năng mạnh và bộ nhớ lớn 512 GB', N'Xiaomi Pad 7 Pro trang bị màn hình 11,2″ độ phân giải 3.2K (3200×2136), tần số quét 144Hz, độ sáng cực đại ~800 nit. Máy sử dụng chip Snapdragon 8s Gen 3, RAM 12GB, bộ nhớ trong 512GB (LPDDR5X + UFS4.0) — phiên bản cao nhất trong dòng. Hệ thống âm thanh 4 loa với Dolby Atmos, pin dung lượng 8850mAh hỗ trợ sạc nhanh HyperCharge 67W. Thiết kế khung nhôm cao cấp, chạy HyperOS 2 trên nền Android. Thích hợp cho thiết kế, vẽ, học tập và làm việc đa nhiệm.'),
    ('SP042', N'Xiaomi Redmi Pad Pro – máy tính bảng tầm trung‑cao với màn hình lớn 12,1″, bộ nhớ 128GB và hiệu năng mạnh mẽ', N'Xiaomi Redmi Pad Pro trang bị màn hình LCD 12,1 inch độ phân giải 2560×1600 pixels, tần số quét 120Hz, hỗ trợ AdaptiveSync và Dolby Vision. Máy sử dụng chip Snapdragon 7s Gen 2 (4nm), RAM 6GB và bộ nhớ trong 128GB, hỗ trợ mở rộng lưu trữ lên đến ~1,5TB. Hệ thống camera sau 8MP, camera trước 8MP, pin dung lượng ~10.000mAh, sạc nhanh 33W. Chạy hệ điều hành HyperOS (Android) và hỗ trợ bàn phím/bút cảm ứng, phù hợp cho giải trí, học tập và làm việc đa nhiệm.'),
    ('SP043', N'Xiaomi Redmi Pad 2 – máy tính bảng tầm trung với màn hình lớn, bộ nhớ 8 GB/256 GB và hiệu năng ổn định', N'Xiaomi Redmi Pad 2 WiFi bản 8GB RAM + 256GB ROM sở hữu màn hình 11,0 inch độ phân giải 1600×2560 pixel, tần số quét 90Hz. Máy trang bị chip MediaTek Helio G100 Ultra (6nm), RAM 8GB, bộ nhớ trong 256GB và hỗ trợ thẻ nhớ microSD mở rộng. Camera sau 8MP, camera trước 5MP. Pin dung lượng khoảng 9000mAh, sạc nhanh 18W. Thiết bị chạy HyperOS (Android) và có thiết kế kim loại mỏng nhẹ, phù hợp cho học tập, giải trí và làm việc đa nhiệm.'),
    ('SP044', N'Xiaomi Redmi Pad SE – máy tính bảng tầm trung với màn hình lớn 11″, RAM 8 GB và bộ nhớ trong 256 GB', N'Xiaomi Redmi Pad SE trang bị màn hình 11.0 inch FHD+ (1920×1200), tần số quét lên đến 90 Hz. Máy sử dụng chip Snapdragon 680 (6nm) với RAM 8 GB, bộ nhớ trong 256 GB (hỗ trợ mở rộng qua microSD lên tới ~1TB). Camera sau 8MP, camera trước 5MP. Pin dung lượng 8000 mAh, sạc thường 10W. Thiết bị hỗ trợ 4 loa với Dolby Atmos, jack tai nghe 3.5mm, chạy MIUI Pad 14 trên Android 13. Thiết kế khung hợp kim nhôm nguyên khối, mỏng ~7.36 mm, phù hợp cho giải trí, học tập và làm việc đa nhiệm.'),
    ('SP045', N'Lenovo Tab Plus – máy tính bảng tầm trung‑cao với màn hình lớn, RAM 8GB và bộ nhớ trong 256GB', N'Lenovo Tab Plus WiFi 8GB/256GB sở hữu màn hình 11,5 inch độ phân giải 2000×1200 (2K), tần số quét 90Hz. Máy sử dụng chip MediaTek Helio G99 (8 nhân) hoặc tùy phiên bản, RAM 8GB, bộ nhớ trong 256GB, hỗ trợ thẻ microSD mở rộng. Camera sau 8MP, camera trước 8MP. Pin dung lượng ~8600mAh, hỗ trợ sạc nhanh (tùy theo thị trường). Hệ điều hành Android 14, thiết kế mỏng nhẹ (~7.8mm, ~650g), khung nhôm, thích hợp cho giải trí, học tập và làm việc đa nhiệm.'),
    ('SP046', N'Lenovo Tab 4G – máy tính bảng tầm trung với màn hình lớn và kết nối 4G thuận tiện', N'Lenovo Tab 4G (ZAEJ0145VN) trang bị màn hình 10,1 inch độ phân giải 1920 × 1200 pixel, bộ vi xử lý MediaTek Helio G85, RAM 4GB, bộ nhớ trong 64GB (hỗ trợ thẻ microSD). Máy hỗ trợ kết nối 4G LTE, có camera sau 8MP và camera trước 5MP, pin khoảng 5.100mAh – 5.100 mAh. Thiết kế mỏng nhẹ (khoảng 425g và dày ~7,5mm), chạy Android 14 (hoặc phiên bản tương đương) và phù hợp cho học tập, làm việc đa nhiệm nhẹ và giải trí.'),
    
    -- Phụ kiện
    ('SP047', N'UGREEN Nexode Power Bank 20 000mAh 145W Qi2 – sạc dự phòng công suất cao, hỗ trợ sạc không dây và nhiều thiết bị', N'UGREEN Nexode Power Bank 20 000mAh (mã PB771 / 35527) trang bị dung lượng lớn ~20.000mAh, hỗ trợ sạc tối đa **145W** qua cổng USB‑C, sạc không dây chuẩn Qi2 15W, màn hình TFT hiển thị trạng thái, hỗ trợ nhiều chuẩn sạc nhanh như PD3.0, QC3.0, PPS. Thiết kế thích hợp sạc laptop, tablet, smartphone và nhiều thiết bị đồng thời. Hàng chính hãng UGREEN, bảo hành đi kèm.'),
    ('SP048', N'Sạc dự phòng Anker Prime 20000mAh 200W – dung lượng lớn, hỗ trợ sạc nhanh laptop và máy tính bảng', N'Anker Prime A1336 trang bị dung lượng 20.000mAh, hỗ trợ tổng công suất đầu ra lên tới 200W. Có 2 cổng USB‑C và 1 cổng USB‑A, đủ khả năng sạc đồng thời hai laptop/thiết bị công suất cao (100W mỗi USB‑C) và một thiết bị qua USB‑A. Hỗ trợ các chuẩn sạc nhanh như PD / QC 3.0, có màn hình LED hiển thị dung lượng và công suất đầu ra/đầu vào. Với trọng lượng khoảng 540g, thiết kế nhỏ gọn để mang theo di chuyển.'),
    ('SP049', N'Baseus Lipow PPJP312 – sạc dự phòng dung lượng lớn 20.000mAh, sạc nhanh 22.5W, đi kèm cáp tích hợp Type‑C và Lightning', N'Baseus Lipow PPJP312 có dung lượng 20.000mAh (3.7V/74Wh) với tổng công suất đầu ra đạt tới 22.5W. Sản phẩm hỗ trợ các chuẩn sạc nhanh PD/QC và đi kèm cáp tích hợp USB‑C và Lightning để sạc cho các thiết bị Apple và Android. Có màn hình số hiển thị dung lượng còn lại, khung vỏ PC+ABS, trọng lượng khoảng 435g và kích thước ~152.2×69.6×30.7mm. Thiết kế phù hợp để sạc điện thoại, tablet và các thiết bị di động khi di chuyển.'),
    ('SP050', N'AVA+ Q7 – sạc dự phòng dung lượng lớn 20.000 mAh, thiết kế nhẹ, hiệu suất ổn định cho di động hàng ngày', N'AVA+ Q7 trang bị pin lõi Polymer dung lượng 20.000 mAh, hỗ trợ đầu ra 10.5 W, có màn hình LED báo dung lượng, thiết kế mỏng nhẹ (~152 × 69,6 × 30,7 mm) và trọng lượng phù hợp để mang theo. Hỗ trợ sạc qua cổng micro‑USB và USB‑C, có 2 cổng USB đầu ra. Thông số thực tại thị trường Việt Nam: công suất đầu ra tối đa 10.5 W, thời gian sạc đầy khoảng 9‑11 giờ với adapter 2A.'),
    ('SP051', N'Bowers & Wilkins Pi8 – tai nghe true wireless cao cấp với âm thanh hi‑fi, chống ồn chủ động và hỗ trợ codec lossless', N'Bowers & Wilkins Pi8 trang bị driver 12 mm Carbon Cone, hỗ trợ codec aptX™ Lossless và aptX™ Adaptive, kết nối Bluetooth 5.4. Tai nghe có chức năng chống ồn chủ động ANC, mỗi bên tai có 3 micro, thời lượng pin ~6.5 giờ tai nghe + ~13.5 giờ hộp sạc (khi bật ANC) tổng khoảng ~20 giờ. Hộp sạc hỗ trợ sạc không dây và cổng USB‑C, chống nước/bụi chuẩn IP54. Thiết kế cao cấp, vỏ kính/phụ kiện đa dạng với 4 màu: Anthracite Black, Dove White, Jade Green, Midnight Blue. Thích hợp cho người dùng yêu cầu âm thanh chất lượng cao, lifestyle & di động.'),
    ('SP052', N'Sennheiser IE200 – tai nghe in‑ear có dây audiophile với driver dynamic 7 mm, cable tháo rời MMCX và chất âm trung tính cao cấp', N'Sennheiser IE200 được trang bị driver TrueResponse® 7 mm, trở kháng 18 Ω, độ nhạy 119 dB SPL, tổng méo hài THD < 0.08%. Thiết kế nhỏ gọn, đeo thoải mái với ear‑hook và nhiều lựa chọn tip (silicon & memory foam). Cable bện cao cấp nối đầu MMCX và jack 3.5 mm tháo rời, thuận tiện thay dây hoặc nâng cấp. Âm thanh cân bằng (neutral), độ chi tiết cao, phù hợp cho người nghe chuyên sâu (audiophile). Thiết kế & sản xuất bởi Sennheiser, phù hợp cả văn phòng và nghe nhạc nghiêm túc.'),
    ('SP053', N'Sony WH‑1000XM6 – tai nghe Bluetooth chụp tai chống ồn cao cấp với codec Hi‑Res, bộ xử lý ANC tiên tiến và thời lượng sử dụng dài', N'Sony WH‑1000XM6 trang bị driver 30 mm, công nghệ âm thanh Hi‑Res không dây với LDAC & LC3, chip QN3 xử lý chống ồn, hỗ trợ multipoint và chuyển đổi thiết bị nhanh. Thời lượng pin lên tới ~30 giờ khi bật ANC, ~40 giờ khi tắt ANC. Trở kháng 48 Ω, kết nối Bluetooth 5.3, vật liệu cao cấp, trọng lượng ~254 g, thiết kế gấp gọn tiện di chuyển.'),
    ('SP054', N'Sony WH‑1000XM6 – tai nghe Bluetooth chụp tai chống ồn cao cấp với codec Hi‑Res, bộ xử lý ANC tiên tiến và thời lượng sử dụng dài', N'Sony WH‑1000XM6 trang bị driver 30 mm, công nghệ âm thanh Hi‑Res không dây với codec LDAC & LC3, chip HD Noise Cancelling Processor QN3 và hệ thống 12 micro cho chống ồn chủ động/đàm thoại. Hỗ trợ kết nối Bluetooth phiên bản 5.3, multipoint 2 thiết bị, hỗ trợ cáp 3,5 mm. Trở kháng 48 Ω (khi bật nguồn) / 16 Ω (khi tắt nguồn). Phạm vi tần số từ 4 Hz‑40 000 Hz (khi dùng dây) hoặc 20 Hz‑40 000 Hz (không dây LDAC). Thời lượng pin tới ~30 giờ khi bật ANC, tới ~40 giờ khi tắt ANC. Trọng lượng ~254 g, thiết kế gấp gọn tiện di chuyển, với ba màu Black, Midnight Blue và Platinum Silver.')

) AS Src (MaSP, MoTaNgan, MoTaChiTiet)

-- 2. BẢNG MAPPING ID CŨ (SP001) -> MÃ SKU MỚI (IP17)
JOIN (VALUES
    ('SP001', 'IP17'),      ('SP002', 'IP17P'),     ('SP003', 'IP17PM'),    ('SP004', 'IPAIR'),
    ('SP005', 'OPN5'),      ('SP006', 'OPN3FLIP'),  ('SP007', 'OPX8PRO'),   ('SP008', 'OPRENO12'),
    ('SP009', 'SSA56'),     ('SP010', 'SSFLIP7'),   ('SP011', 'SSFOLD7'),   ('SP012', 'SSS25U'),
    ('SP013', 'XM15'),      ('SP014', 'XM15U'),     ('SP015', 'XMRM15'),    ('SP016', 'XMRMN14'),
    ('SP017', 'MACPROM4'),  ('SP018', 'MACM4'),     ('SP019', 'MACM1'),     ('SP020', 'MACM2'),
    ('SP021', 'DELLXPS13'), ('SP022', 'DELLAW16'),  ('SP023', 'DELLLAT7350'),('SP024', 'DELLINS16'),
    ('SP025', 'LNVTPX1'),   ('SP026', 'LNVLEG7'),   ('SP027', 'LNVLOQ15'),  ('SP028', 'LNVTB16'),
    ('SP029', 'ASVIVO14'),  ('SP030', 'ASTUF16'),   ('SP031', 'ASZENDUO'),  ('SP032', 'ASROG16'),
    ('SP033', 'IPADPROM4'), ('SP034', 'IPADPROM4'), ('SP035', 'IPADAIRM3'), ('SP036', 'IPADMINI7'),
    ('SP037', 'SSTABS11U'), ('SP038', 'SSTABS6L'),  ('SP039', 'SSTABA9P'),  ('SP040', 'SSTABA9'),
    ('SP041', 'XMPAD7'),    ('SP042', 'XMRMPADPRO'),('SP043', 'XMRMPAD2'),  ('SP044', 'XMRMPADSE'),
    ('SP045', 'LNVTABPLUS'),('SP046', 'LNVTAB4G'),
    ('SP047', 'UGREEN20K'), ('SP048', 'ANKER20K'),  ('SP049', 'BASEUS20K'), ('SP050', 'AVAPLUS20K'),
    ('SP051', 'BWPI8'),     ('SP052', 'SENIE200'),  ('SP053', 'SONYXM6'),   ('SP054', 'SONYXM6')
) AS Map (OldSP, RealSKU) ON Src.MaSP = Map.OldSP

-- 3. KHỚP MÃ SKU VỚI BẢNG SẢN PHẨM ĐỂ UPDATE
ON P.MaSanPham = Map.RealSKU;

PRINT N'Đã cập nhật toàn bộ nội dung chi tiết cho 54 sản phẩm!';
GO

-- Lệnh INSERT trực tiếp (Xoay dữ liệu từ Ngang sang Dọc ngay khi chạy)
INSERT INTO [dbo].[tb_ThongSo] ([SanPhamId], [TenThongSo], [GiaTri], [ThuTu])
SELECT 
    sp.Id,          -- Lấy ID thật từ bảng Sản phẩm
    TS.Ten,         -- Tên thông số (RAM, Pin...)
    TS.GiaTri,      -- Giá trị (8GB, 5000mAh...)
    TS.ThuTu        -- Thứ tự hiển thị
FROM 
    (VALUES 
        -- ĐIỆN THOẠI
        ('IP17',   N'8 GB',N'256 GB',N'6.3" - Tần số quét 120 Hz',N'30 giờ',N'Chính 48 MP & Phụ 48 MP',N'iOS 26',N'Type-C'),
        ('IP17P',  N'12 GB',N'256 GB',N'6.3" - Tần số quét 120 Hz',N'31 giờ',N'Chính 48 MP & Phụ 48 MP, 48 MP',N'iOS 26',N'Type-C'),
        ('IP17PM', N'12 GB',N'256 GB',N'6.9" - Tần số quét 120 Hz',N'37 giờ',N'Chính 48 MP & Phụ 48 MP, 48 MP',N'iOS 26',N'Type-C'),
        ('IPAIR',  N'12 GB',N'256 GB',N'6.5" - Tần số quét 120 Hz',N'27 giờ',N'48 MP',N'iOS 26',N'Type-C'),
        ('OPN5',   N'16 GB',N'512 GB',N'Chính 8.0" & Phụ 6.5" - 120 Hz',N'4400 mAh',N'Chính 200 MP & Phụ 12 MP, 10 MP',N'Android 16',N'Type-C'),
        ('OPN3FLIP',N'12 GB',N'256 GB',N'Chính 6.9" & Phụ 4.1" - 120 Hz',N'4300 mAh',N'Chính 50 MP & Phụ 12 MP',N'Android 16',N'Type-C'),
        ('OPX8PRO',N'16 GB',N'512 GB',N'6.78" - Tần số quét 120 Hz',N'5910 mAh',N'4 camera 50 MP',N'Android 15',N'Type-C'),
        ('OPRENO12',N'12 GB',N'512 GB',N'6.7" - Tần số quét 120 Hz',N'5000 mAh',N'Chính 50 MP & Phụ 50 MP, 8 MP',N'Android 14',N'Type-C'),
        ('SSA56',  N'12 GB',N'256 GB',N'6.7" - Tần số quét 120 Hz',N'5000 mAh',N'Chính 50 MP & Phụ 12 MP, 5 MP',N'Android 15',N'Type-C'),
        ('SSFLIP7',N'12 GB',N'256 GB',N'Chính 6.9" & Phụ 4.1" - 120 Hz',N'4300 mAh',N'Chính 50 MP & Phụ 12 MP',N'Android 16',N'Type-C'),
        ('SSFOLD7',N'12 GB',N'512 GB',N'Chính 8.0" & Phụ 6.5" - 120 Hz',N'4400 mAh',N'Chính 200 MP & Phụ 12 MP, 10 MP',N'Android 16',N'Type-C'),
        ('SSS25U', N'12 GB',N'256 GB',N'6.9" - Tần số quét 120 Hz',N'5000 mAh',N'Chính 200 MP & Phụ 50 MP, 50 MP, 10 MP',N'Android 15',N'Type-C'),
        ('XM15',   N'12 GB',N'512 GB',N'6.36" - Tần số quét 120 Hz',N'5240 mAh',N'3 camera 50 MP',N'Xiaomi HyperOS 2',N'Type-C'),
        ('XM15U',  N'16 GB',N'512 GB',N'6.73" - Tần số quét 120 Hz',N'5410 mAh',N'Chính 50 MP & Phụ 200 MP, 50 MP, 50 MP',N'Xiaomi HyperOS 2',N'Type-C'),
        ('XMRM15', N'6 GB', N'128 GB',N'6.9" - Tần số quét 144 Hz',N'7000 mAh',N'Chính 50 MP & Phụ QVGA',N'Android 15',N'Type-C'),
        ('XMRMN14',N'12 GB',N'512 GB',N'6.67" - Tần số quét 120 Hz',N'5110 mAh',N'Chính 200 MP & Phụ 8 MP, 2 MP',N'Android 14',N'Type-C'),

        -- LAPTOP
        ('ASROG16',N'16 GB',N'1 TB SSD',N'16" WUXGA',N'100 Wh',N'1080p FaceTime HD camera',N'Windows 11 Home',N'3 x Thunderbolt 4'),
        ('ASTUF16',N'16 GB',N'512 GB SSD',N'16" WQXGA',N'6-cell Li-ion',N'HD webcam',N'Windows 11 Home',N'HDMI 1 x USB Type-C 3.2'),
        ('ASVIVO14',N'8 GB',N'256 GB SSD',N'13.3" Retina (2560 x 1600)',N'18 giờ',N'720p FaceTime Camera',N'Windows 11',N'2 x Thunderbolt 3'),
        ('ASZENDUO',N'16 GB',N'256 GB SSD',N'13.6" Liquid Retina',N'18 giờ',N'1080p FaceTime HD camera',N'Windows 11',N'2 x Thunderbolt 3'),
        ('DELLAW16',N'32 GB',N'1 TB SSD NVMe',N'16" WQXGA (2560 x 1600)',N'96 Wh',N'HD webcam',N'Windows 11 Home',N'HDMI + USB Type-C'),
        ('DELLINS16',N'16 GB',N'1 TB SSD M.2',N'16" 2.5K',N'54Wh',N'Full HD Webcam',N'Windows 11 Home',N'1 x USB Type-C 3.2'),
        ('DELLLAT7350',N'32 GB',N'1 TB SSD NVMe',N'14" WUXGA (1920 x 1200)',N'57 Wh',N'FHD 1080p + IR',N'Windows 11 Pro',N'2 x USB Type-C'),
        ('DELLXPS13',N'32 GB',N'1 TB SSD NVMe',N'16" WQXGA OLED',N'80 Wh',N'Camera 5.0 MP',N'Windows 11 Home',N'1 x USB 3.2'),
        ('LNVLOQ15',N'16 GB',N'DDR5 16+16 GB',N'15.6" Full HD',N'60 Wh',N'5.0 MP with E-shutter',N'Windows 11 Home',N'1 x USB-C 3.2 Gen 2'),
        ('LNVLEG7',N'32 GB',N'1 TB SSD M.2',N'16" WUXGA (1920 x 1200)',N'45Wh',N'Full HD Webcam Camera IR',N'Windows 11 Home',N'1 x USB-C'),
        ('LNVTB16',N'32 GB',N'1 TB SSD NVMe',N'16" WUXGA (1920 x 1200)',N'90 Wh',N'Full HD Webcam Camera IR',N'Windows 11 Home',N'1 x Thunderbolt 4'),
        ('LNVTPX1',N'32 GB',N'1 TB SSD NVMe',N'16" WQXGA OLED',N'90 Wh',N'Full HD Webcam Camera IR',N'Windows 11 Home',N'1 x Thunderbolt 4'),
        ('MACM1',  N'16 GB',N'1 TB',N'13.3" Retina',N'18 giờ',N'720p Facetime',N'macOS',N'2 x Thunderbolt 3'),
        ('MACM2',  N'16 GB',N'512 GB',N'13.6" Liquid Retina',N'18 giờ',N'1080p Facetime',N'macOS',N'MagSafe 3'),
        ('MACM4',  N'16 GB',N'512 GB',N'13.6" Liquid Retina',N'18 giờ',N'1080p Facetime',N'macOS',N'MagSafe 3'),
        ('MACPROM4',N'18 GB',N'512 GB',N'14.2" Liquid Retina XDR',N'22 giờ',N'1080p Facetime',N'macOS',N'3 x Thunderbolt 4'),

        -- TABLET
        ('IPADAIR6',N'8 GB',N'128 GB',N'13" Liquid Retina',N'10 giờ',N'12 MP',N'iPadOS 17',N'Type-C'),
        ('IPADAIRM3',N'8 GB',N'512 GB',N'13" Liquid Retina',N'10 giờ',N'12 MP',N'iPadOS 17',N'Type-C'),
        ('IPADPROM4',N'16 GB',N'1 TB',N'14.6" Ultra Retina XDR',N'10 giờ',N'12 MP',N'iPadOS 17',N'Type-C'),
        ('IPADMINI7',N'4 GB',N'64 GB',N'8.3" Liquid Retina',N'10 giờ',N'12 MP',N'iPadOS 17',N'Type-C'),
        ('SSTABA9P',N'4 GB',N'64 GB',N'11" - 90 Hz',N'7040 mAh',N'8 MP',N'Android 13',N'Type-C'),
        ('SSTABA9',N'4 GB',N'64 GB',N'8.7" - 60 Hz',N'5100 mAh',N'8 MP',N'Android 13',N'Type-C'),
        ('SSTABS11U',N'12 GB',N'512 GB',N'14.6" - 120 Hz',N'11200 mAh',N'13 MP + 8 MP',N'Android 14',N'Type-C'),
        ('SSTABS6L',N'4 GB',N'64 GB',N'10.4" - 60 Hz',N'7040 mAh',N'8 MP',N'Android 14',N'Type-C'),
        ('XMPAD7',N'8 GB',N'256 GB',N'11" - 144 Hz',N'8840 mAh',N'13 MP',N'Android 13',N'Type-C'),
        ('XMRMPAD2',N'6 GB',N'128 GB',N'11.5" - 120 Hz',N'8000 mAh',N'8 MP',N'Android 13',N'Type-C'),
        ('XMRMPADPRO',N'8 GB',N'256 GB',N'12.1" - 120 Hz',N'10000 mAh',N'8 MP',N'Android 14',N'Type-C'),
        ('XMRMPADSE',N'8 GB',N'256 GB',N'11" - 90 Hz',N'8000 mAh',N'8 MP',N'Android 13',N'Type-C'),
        ('LNVTAB4G',N'4 GB',N'64 GB',N'10.1" IPS',N'5100 mAh',N'8 MP',N'Android 13',N'Type-C'),
        ('LNVTABPLUS',N'8 GB',N'128 GB',N'11.5" 2K',N'8600 mAh',N'13 MP',N'Android 13',N'Type-C'),

        -- PHỤ KIỆN (Giữ lại dòng không có để bạn dễ sửa nếu cần)
        ('ANKER20K',N'Không',N'Không',N'Không',N'20000 mAh',N'Không',N'Không',N'Max 22.5W'),
        ('AVAPLUS20K',N'Không',N'Không',N'Không',N'20000 mAh',N'Không',N'Không',N'Max 100W'),
        ('BASEUS20K',N'Không',N'Không',N'Không',N'20000 mAh',N'Không',N'Không',N'Max 65W'),
        ('UGREEN20K',N'Không',N'Không',N'Không',N'20000 mAh',N'Không',N'Không',N'2.1A'),
        ('SENIE200',N'Không',N'Không',N'Không',N'20 giờ',N'Không',N'Không',N'Jack 3.5mm/Type-C'),
        ('SHOKZOPEN',N'Không',N'Không',N'Không',N'40 giờ',N'Không',N'Không',N'Bluetooth'),
        ('SONYXM6',N'Không',N'Không',N'Không',N'30 giờ',N'Không',N'Không',N'Bluetooth/Type-C'),
        ('BWPI8',N'Không',N'Không',N'Không',N'25 giờ',N'Không',N'Không',N'Bluetooth')

    ) AS Source (SKU, Ram, Rom, ManHinh, Pin, Cam, OS, Conn)
    
    -- JOIN để lấy ID thật dựa trên mã SKU (IP17, IP17P...)
    JOIN tb_SanPham sp ON sp.MaSanPham = Source.SKU
    
    -- UNPIVOT: Biến cột thành dòng
    CROSS APPLY (
        VALUES 
            (N'Bộ nhớ RAM',   Source.Ram, 1),
            (N'Bộ nhớ trong', Source.Rom, 2),
            (N'Màn hình',     Source.ManHinh, 3),
            (N'Dung lượng Pin',Source.Pin, 4),
            (N'Camera',       Source.Cam, 5),
            (N'Hệ điều hành', Source.OS, 6),
            (N'Cổng kết nối', Source.Conn, 7)
    ) AS TS (Ten, GiaTri, ThuTu)

-- Lọc bỏ các dòng "Không" hoặc "Không Có" để data sạch
WHERE TS.GiaTri NOT LIKE N'%Không%' AND TS.GiaTri IS NOT NULL;
GO

-- ==================================================================================
-- INSERT TÀI KHOẢN (Gộp Khách Hàng & Quản Trị Viên)
-- ==================================================================================

INSERT INTO [dbo].[tb_TaiKhoan] 
([TenDangNhap], [MatKhau], [HoTen], [Email], [SoDienThoai], [LaQuanTri], [HoatDong])
SELECT 
    Src.TenDN, Src.MatKhau, Src.HoTen, Src.Email, Src.SDT, Src.IsAdmin, Src.IsActive
FROM (VALUES
    -- 1. KHÁCH HÀNG (LaQuanTri = 0)
    -- Lưu ý: TenDangNhap được tự tạo từ Email (bỏ phần @...) để đảm bảo Unique
    ('an.nguyen', 'an@123', N'Nguyễn Văn An', 'an.nguyen@email.com', '0901234567', 0, 1),
    ('binh.tran', 'binh@123', N'Trần Thị Bình', 'binh.tran@email.com', '0912345678', 0, 1),
    ('cuong.le', 'cuong@123', N'Lê Minh Cường', 'cuong.le@email.com', '0987654321', 0, 0), -- Bị khóa (HoatDong = 0)
    ('dung.pham', 'dung@123', N'Phạm Thị Dung', 'dung.pham@email.com', '0934567890', 0, 1),
    ('em.hoang', 'em@123', N'Hoàng Văn Em', 'em.hoang@email.com', '0945678901', 0, 1),
    ('giang.vu', 'giang@123', N'Vũ Thị Giang', 'giang.vu@email.com', '0956789012', 0, 1),
    ('hai.do', 'hai@123', N'Đỗ Minh Hải', 'hai.do@email.com', '0967890123', 0, 1),
    ('kieu.bui', 'kieu@123', N'Bùi Thị Kiều', 'kieu.bui@email.com', '0978901234', 0, 0), -- Bị khóa
    ('long.ngo', 'long@123', N'Ngô Văn Long', 'long.ngo@email.com', '0989012345', 0, 1),
    ('mai.dang', 'mai@123', N'Đặng Thị Mai', 'mai.dang@email.com', '0990123456', 0, 1),

    -- 2. QUẢN TRỊ VIÊN (LaQuanTri = 1)
    ('superadmin', 'admin@123', N'Trần Tuấn Anh', 'admin@shop.com', NULL, 1, 1),
    ('sanpham_manager', 'sanpham@123', N'Lý Thị Bích', 'product@shop.com', NULL, 1, 1),
    ('donhang_manager', 'donhang@123', N'Bùi Văn Hùng', 'order@shop.com', NULL, 1, 1),
    ('bientapvien', 'bientapvien@123', N'Phạm Thùy Linh', 'editor@shop.com', NULL, 1, 1)

) AS Src (TenDN, MatKhau, HoTen, Email, SDT, IsAdmin, IsActive)
-- Kiểm tra trùng lặp (tránh lỗi nếu chạy lại script)
WHERE NOT EXISTS (
    SELECT 1 FROM [dbo].[tb_TaiKhoan] WHERE TenDangNhap = Src.TenDN OR Email = Src.Email
);
GO

--Insert đánh giá
INSERT INTO [dbo].[tb_DanhGia] ([SanPhamId], [TenNguoiGui], [Email], [Sao], [NoiDung], [HienThi], [NgayTao])
SELECT 
    sp.Id,              -- Lấy ID Sản phẩm thật
    tk.HoTen,           -- Lấy Họ tên thật từ bảng Tài Khoản
    tk.Email,           -- Lấy Email thật từ bảng Tài Khoản
    Src.SoSao, 
    Src.NoiDung, 
    1,                  -- Hiển thị = True
    GETDATE()           -- Ngày hiện tại
FROM 
    -- 1. Nguồn dữ liệu đánh giá
    (VALUES 
        ('SP001','KH00000001',5,N'Tuyệt vời, rất hài lòng!'),
        ('SP001','KH00000002',4,N'Máy dùng tốt, đáng tiền.'),
        ('SP002','KH00000003',3,N'Chất lượng ổn, nhưng pin hơi yếu.'),
        ('SP003','KH00000004',4,N'Thiết kế đẹp, nhưng hơi nặng.'),
        ('SP003','KH00000005',5,N'Camera xuất sắc, màu sắc đẹp.'),
        ('SP004','KH00000006',2,N'Chưa hài lòng, pin yếu.'),
        ('SP004','KH00000007',3,N'Máy ổn, hơi nóng khi chơi game.'),
        ('SP005','KH00000008',5,N'Rất đẹp, cảm giác cầm chắc tay.'),
        ('SP006','KH00000009',4,N'Máy nhanh, pin ổn.'),
        ('SP006','KH00000010',3,N'Chưa thích màu sắc lắm.'),
        ('SP007','KH00000001',5,N'Tuyệt vời, đáng mua.'),
        ('SP008','KH00000002',4,N'Tốt, nhưng hơi nặng.'),
        ('SP008','KH00000003',3,N'Máy ổn, giá hợp lý.'),
        ('SP009','KH00000004',5,N'Camera đẹp, pin tốt.'),
        ('SP010','KH00000005',4,N'Máy dùng mượt, màu đẹp.'),
        ('SP010','KH00000006',5,N'Tuyệt vời, rất đáng tiền.'),
        ('SP011','KH00000007',3,N'Ổn, nhưng giá cao.'),
        ('SP012','KH00000008',5,N'Tuyệt vời, pin lâu.'),
        ('SP013','KH00000009',4,N'Máy ổn, thiết kế đẹp.'),
        ('SP013','KH00000010',5,N'Rất hài lòng, đáng mua.'),
        ('SP014','KH00000001',3,N'Máy ổn, pin hơi yếu.'),
        ('SP015','KH00000002',4,N'Tốt, đáng mua.'),
        ('SP016','KH00000003',5,N'Camera xuất sắc, máy nhanh.'),
        ('SP017','KH00000004',4,N'Màu sắc đẹp, cảm giác cầm tốt.'),
        ('SP017','KH00000005',5,N'Tuyệt vời, đáng tiền.'),
        ('SP018','KH00000006',3,N'Ổn, nhưng pin chưa lâu.'),
        ('SP019','KH00000007',5,N'Tốt, đáng mua.'),
        ('SP019','KH00000008',4,N'Máy nhanh, màu đẹp.'),
        ('SP020','KH00000009',3,N'Máy ổn, hơi nóng khi chơi game.'),
        ('SP021','KH00000010',4,N'Máy ổn, thiết kế đẹp.'),
        ('SP022','KH00000001',5,N'Tuyệt vời, đáng mua.'),
        ('SP022','KH00000002',4,N'Máy dùng mượt, pin tốt.'),
        ('SP023','KH00000003',3,N'Ổn, nhưng giá hơi cao.'),
        ('SP024','KH00000004',5,N'Tuyệt vời, camera đẹp.'),
        ('SP024','KH00000005',4,N'Máy dùng mượt, màu đẹp.'),
        ('SP025','KH00000006',3,N'Pin chưa lâu, nhưng máy ổn.'),
        ('SP026','KH00000007',5,N'Rất hài lòng, đáng mua.'),
        ('SP027','KH00000008',4,N'Máy nhanh, thiết kế đẹp.'),
        ('SP027','KH00000009',3,N'Ổn, nhưng pin hơi yếu.'),
        ('SP028','KH00000010',5,N'Tuyệt vời, đáng tiền.'),
        ('SP029','KH00000001',4,N'Máy dùng tốt, pin ổn.'),
        ('SP029','KH00000002',5,N'Tuyệt vời, camera đẹp.'),
        ('SP030','KH00000003',3,N'Ổn, giá hơi cao.'),
        ('SP031','KH00000004',5,N'Camera xuất sắc, máy nhanh.'),
        ('SP031','KH00000005',4,N'Màu sắc đẹp, cầm chắc tay.'),
        ('SP032','KH00000006',3,N'Pin chưa lâu, hơi nóng khi chơi game.'),
        ('SP033','KH00000007',4,N'Máy dùng mượt, đáng tiền.'),
        ('SP033','KH00000008',5,N'Tuyệt vời, camera đẹp.'),
        ('SP034','KH00000009',3,N'Ổn, nhưng hơi nặng.'),
        ('SP035','KH00000010',5,N'Tuyệt vời, rất hài lòng.'),
        ('SP036','KH00000001',4,N'Máy ổn, đáng tiền.'),
        ('SP036','KH00000002',3,N'Ổn, nhưng pin chưa lâu.'),
        ('SP037','KH00000003',5,N'Tuyệt vời, thiết kế đẹp.'),
        ('SP038','KH00000004',4,N'Máy dùng mượt, pin ổn.'),
        ('SP038','KH00000005',5,N'Tuyệt vời, đáng mua.'),
        ('SP039','KH00000006',3,N'Ổn, nhưng hơi nóng khi chơi game.'),
        ('SP040','KH00000007',5,N'Tuyệt vời, camera đẹp.'),
        ('SP040','KH00000008',4,N'Máy dùng mượt, thiết kế đẹp.'),
        ('SP041','KH00000009',3,N'Ổn, giá hơi cao.'),
        ('SP042','KH00000010',5,N'Tuyệt vời, đáng tiền.'),
        ('SP043','KH00000001',4,N'Máy dùng tốt, màu đẹp.'),
        ('SP043','KH00000002',5,N'Tuyệt vời, camera đẹp.'),
        ('SP044','KH00000003',3,N'Ổn, nhưng pin hơi yếu.'),
        ('SP045','KH00000004',5,N'Tuyệt vời, đáng mua.'),
        ('SP045','KH00000005',4,N'Máy dùng mượt, pin ổn.'),
        ('SP046','KH00000006',3,N'Ổn, hơi nóng khi chơi game.'),
        ('SP047','KH00000007',5,N'Tuyệt vời, camera đẹp.'),
        ('SP047','KH00000008',4,N'Máy dùng tốt, thiết kế đẹp.'),
        ('SP048','KH00000009',3,N'Ổn, pin chưa lâu.'),
        ('SP049','KH00000010',5,N'Tuyệt vời, rất hài lòng.'),
        ('SP050','KH00000001',4,N'Máy ổn, màu đẹp.'),
        ('SP050','KH00000002',5,N'Tuyệt vời, đáng mua.'),
        ('SP051','KH00000003',3,N'Ổn, hơi nóng khi chơi game.'),
        ('SP052','KH00000004',5,N'Tuyệt vời, camera đẹp.'),
        ('SP052','KH00000005',4,N'Máy dùng mượt, đáng tiền.'),
        ('SP053','KH00000006',3,N'Ổn, nhưng pin hơi yếu.'),
        ('SP054','KH00000007',5,N'Tuyệt vời, rất hài lòng.'),
        ('SP054','KH00000008',4,N'Máy dùng tốt, màu đẹp.')
    ) AS Src (ID_SP, ID_KH, SoSao, NoiDung)

    -- 2. Mapping Mã Sản phẩm Cũ (SP001) -> SKU Mới (IP17)
    JOIN (VALUES
        ('SP001', 'IP17'), ('SP002', 'IP17P'), ('SP003', 'IP17PM'), ('SP004', 'IPAIR'),
        ('SP005', 'OPN5'), ('SP006', 'OPN3FLIP'), ('SP007', 'OPX8PRO'), ('SP008', 'OPRENO12'),
        ('SP009', 'SSA56'), ('SP010', 'SSFLIP7'), ('SP011', 'SSFOLD7'), ('SP012', 'SSS25U'),
        ('SP013', 'XM15'), ('SP014', 'XM15U'), ('SP015', 'XMRM15'), ('SP016', 'XMRMN14'),
        ('SP017', 'ASROG16'), ('SP018', 'ASTUF16'), ('SP019', 'ASVIVO14'), ('SP020', 'ASZENDUO'),
        ('SP021', 'DELLAW16'), ('SP022', 'DELLINS16'), ('SP023', 'DELLLAT7350'),('SP024', 'DELLXPS13'),
        ('SP025', 'LNVLOQ15'), ('SP026', 'LNVLEG7'), ('SP027', 'LNVTB16'), ('SP028', 'LNVTPX1'),
        ('SP029', 'MACM1'), ('SP030', 'MACM2'), ('SP031', 'MACM4'), ('SP032', 'MACPROM4'),
        ('SP033', 'IPADAIR6'), ('SP034', 'IPADAIRM3'), ('SP035', 'IPADPROM4'), ('SP036', 'IPADMINI7'),
        ('SP037', 'SSTABA9P'), ('SP038', 'SSTABA9'), ('SP039', 'SSTABS11U'), ('SP040', 'SSTABS6L'),
        ('SP041', 'LNVTAB4G'), ('SP042', 'LNVTABPLUS'),
        ('SP043', 'XMPAD7'), ('SP044', 'XMRMPAD2'), ('SP045', 'XMRMPADPRO'),('SP046', 'XMRMPADSE'),
        ('SP047', 'ANKER20K'), ('SP048', 'AVAPLUS20K'),('SP049', 'BASEUS20K'), ('SP050', 'UGREEN20K'),
        ('SP051', 'SENIE200'), ('SP052', 'SHOKZOPEN'), ('SP053', 'SONYXM6'), ('SP054', 'BWPI8')
    ) AS MapSP (OldSP, RealSKU) ON Src.ID_SP = MapSP.OldSP

    -- 3. Mapping Mã Khách hàng Cũ (KH001) -> Email Thật trong DB (an.nguyen@email.com)
    JOIN (VALUES
        ('KH00000001', 'an.nguyen@email.com'),
        ('KH00000002', 'binh.tran@email.com'),
        ('KH00000003', 'cuong.le@email.com'),
        ('KH00000004', 'dung.pham@email.com'),
        ('KH00000005', 'em.hoang@email.com'),
        ('KH00000006', 'giang.vu@email.com'),
        ('KH00000007', 'hai.do@email.com'),
        ('KH00000008', 'kieu.bui@email.com'),
        ('KH00000009', 'long.ngo@email.com'),
        ('KH00000010', 'mai.dang@email.com')
    ) AS MapKH (OldKH, RealEmail) ON Src.ID_KH = MapKH.OldKH

    -- 4. Join lấy ID thật từ các bảng chính
    JOIN tb_SanPham sp ON MapSP.RealSKU = sp.MaSanPham
    JOIN tb_TaiKhoan tk ON MapKH.RealEmail = tk.Email 
    -- Điều kiện: Đảm bảo chỉ lấy user (không lấy admin)
    WHERE tk.LaQuanTri = 0; 
GO

USE [WebBanHangDienTu]
GO

-- ==================================================================================
-- 1. INSERT PHƯƠNG THỨC THANH TOÁN (Khớp với logic đơn hàng đã tạo)
-- ==================================================================================
INSERT INTO [dbo].[tb_PhuongThucThanhToan] ([TenPhuongThuc], [MoTa], [HienThi]) 
VALUES 
(N'Tiền mặt (COD)', N'Thanh toán khi nhận hàng tại nhà.', 1),           -- Id sẽ là 1
(N'Chuyển khoản ngân hàng', N'Chuyển khoản qua VietQR / Internet Banking.', 1), -- Id sẽ là 2
(N'Ví điện tử MoMo', N'Thanh toán qua ứng dụng MoMo.', 1),               -- Id sẽ là 3
(N'Cổng thanh toán VNPAY', N'Thanh toán qua thẻ ATM/Visa/MasterCard.', 1); -- Id sẽ là 4
GO

-- ==================================================================================
-- 2. INSERT PHƯƠNG THỨC VẬN CHUYỂN (Giá khớp với dữ liệu cũ)
-- ==================================================================================
INSERT INTO [dbo].[tb_PhuongThucVanChuyen] ([TenPhuongThuc], [Gia], [MoTa]) 
VALUES 
(N'Giao hàng Tiêu chuẩn', 30000, N'Thời gian giao hàng từ 3 - 5 ngày làm việc.'),
(N'Giao hàng Nhanh', 50000, N'Thời gian giao hàng từ 1 - 2 ngày làm việc.'),
(N'Giao hàng Hỏa tốc', 100000, N'Nhận hàng trong ngày (Chỉ áp dụng nội thành).'),
(N'Miễn phí vận chuyển', 0, N'Áp dụng cho đơn hàng giá trị cao hoặc có mã khuyến mãi.');
GO

INSERT INTO [dbo].[tb_DonHang] 
(
    [MaDonHang], 
    [TenKhachHang], 
    [SoDienThoai], 
    [DiaChi], 
    [Email], 
    [TongTien], 
    [SoLuongSanPham], 
    [LoaiThanhToan], 
    [TrangThai], 
    [NgayTao]
)
SELECT 
    Src.ID_DH,          -- Mã đơn hàng
    Src.TenNhan,        -- Tên người nhận
    Src.SDT,            -- Số điện thoại
    Src.DiaChi,         -- Địa chỉ giao hàng
    Src.Email,          -- Email người nhận
    (Src.TamTinh + Src.PhiShip), -- Tổng tiền (Tạm thời = Ship, vì TamTinh = 0)
    0,                  -- Số lượng SP (Tạm để 0, trigger sẽ tự tính khi thêm chi tiết)
    
    -- 1. Chuyển đổi Phương thức thanh toán sang số (Map với bảng tb_PhuongThucThanhToan)
    CASE Src.PTTT 
        WHEN N'COD' THEN 1 
        WHEN N'Chuyển khoản ngân hàng' THEN 2 
        WHEN N'MoMo' THEN 3 
        ELSE 1 -- Mặc định là COD nếu không khớp
    END,

    -- 2. Chuyển đổi Trạng thái sang số
    CASE Src.TrangThai 
        WHEN N'Chờ xử lý' THEN 1 
        WHEN N'Đang giao' THEN 2 
        WHEN N'Đã giao' THEN 3 
        WHEN N'Đã hủy' THEN 4 
        ELSE 1 
    END,

    GETDATE() -- Ngày tạo đơn
FROM 
    -- Bảng dữ liệu nguồn (Copy từ dữ liệu cũ của bạn)
    (VALUES 
        ('DH00000001', 'KH00000001', 'KM00000002', N'Nguyễn Văn An', N'123 Đồng Khởi, Quận 1, TP.HCM', '0901234567', 'an.nguyen@email.com', 0, 30000, N'Chuyển khoản ngân hàng', N'Đã giao'),
        ('DH00000002', 'KH00000002', NULL, N'Trần Thị Bình', N'456 Trúc Bạch, Quận Ba Đình, Hà Nội', '0912345678', 'binh.tran@email.com', 0, 50000, N'COD', N'Đang giao'),
        ('DH00000003', 'KH00000004', 'KM00000003', N'Phạm Thị Dung', N'101 Bạch Đằng, Quận Hải Châu, Đà Nẵng', '0934567890', 'dung.pham@email.com', 0, 40000, N'MoMo', N'Chờ xử lý'),
        ('DH00000004', 'KH00000007', NULL, N'Đỗ Minh Hải', N'33 Nguyễn Hữu Thọ, Quận 7, TP.HCM', '0967890123', 'hai.do@email.com', 0, 20000, N'Chuyển khoản ngân hàng', N'Chờ xử lý'),
        ('DH00000005', 'KH00000010', 'KM00000001', N'Đặng Thị Mai', N'567 Lạch Tray, Quận Ngô Quyền, Hải Phòng', '0990123456', 'mai.dang@email.com', 0, 50000, N'COD', N'Đã giao')
    ) AS Src (ID_DH, ID_KH, ID_KM, TenNhan, DiaChi, SDT, Email, TamTinh, PhiShip, PTTT, TrangThai)
    
    -- Kiểm tra để không insert trùng mã đơn hàng
    WHERE NOT EXISTS (SELECT 1 FROM tb_DonHang WHERE MaDonHang = Src.ID_DH);
GO

INSERT INTO [dbo].[tb_ChiTietDonHang] ([DonHangId], [SanPhamId], [Gia], [SoLuong])
SELECT 
    dh.Id,          -- Lấy ID Đơn hàng thật
    sp.Id,          -- Lấy ID Sản phẩm thật
    Src.DonGia,     -- Giá bán
    Src.SoLuong     -- Số lượng
FROM 
    -- 1. Dữ liệu nguồn (Copy từ bạn gửi)
    (VALUES 
        ('DH00000001', 'SP001', 1, 21900000),
        ('DH00000001', 'SP003', 1, 28900000),
        ('DH00000002', 'SP004', 1, 16900000),
        ('DH00000003', 'SP006', 2, 15900000),
        ('DH00000004', 'SP002', 1, 24900000),
        ('DH00000005', 'SP005', 1, 13900000)
    ) AS Src (MaDH, MaSP, SoLuong, DonGia)

    -- 2. Mapping Mã SP Cũ -> Mã SKU Mới
    JOIN (VALUES 
        ('SP001', 'IP17'),      -- iPhone 17
        ('SP002', 'IP17P'),     -- iPhone 17 Pro
        ('SP003', 'IP17PM'),    -- iPhone 17 Pro Max
        ('SP004', 'IPAIR'),     -- iPhone Air
        ('SP005', 'OPN5'),      -- OPPO Find N5
        ('SP006', 'OPN3FLIP')   -- OPPO Find N3 Flip
    ) AS Map (OldSP, NewSKU) ON Src.MaSP = Map.OldSP

    -- 3. Join lấy ID thật từ database
    JOIN tb_SanPham sp ON sp.MaSanPham = Map.NewSKU
    JOIN tb_DonHang dh ON dh.MaDonHang = Src.MaDH;
GO

INSERT INTO [dbo].[tb_YeuThich] ([TaiKhoanId], [SanPhamId], [NgayTao])
SELECT 
    tk.Id,      -- ID Tài khoản (Lấy theo Email)
    sp.Id,      -- ID Sản phẩm (Lấy theo Mã SP)
    GETDATE()   -- Ngày thích
FROM 
    -- 1. Danh sách giả định: Ai thích cái gì?
    (VALUES 
        -- Khách: Nguyễn Văn An (an.nguyen) thích đồ Apple & Oppo
        ('an.nguyen@email.com', 'IP17PM'),  -- iPhone 17 Pro Max
        ('an.nguyen@email.com', 'OPN5'),    -- Oppo Find N5
        ('an.nguyen@email.com', 'MACM4'),   -- MacBook Air M4

        -- Khách: Trần Thị Bình (binh.tran) thích Samsung
        ('binh.tran@email.com', 'SSS25U'),  -- Samsung S25 Ultra
        ('binh.tran@email.com', 'SSFOLD7'), -- Samsung Z Fold 7
        ('binh.tran@email.com', 'SSTABA9P'),-- Tab A9+

        -- Khách: Phạm Thị Dung (dung.pham) thích đồ mỏng nhẹ
        ('dung.pham@email.com', 'IPAIR'),   -- iPhone Air
        ('dung.pham@email.com', 'MACM1'),   -- MacBook Air M1
        ('dung.pham@email.com', 'IPADAIR6'),-- iPad Air 6

        -- Khách: Đỗ Minh Hải (hai.do) - Gamer thích cấu hình mạnh
        ('hai.do@email.com', 'ASROG16'),    -- Asus ROG
        ('hai.do@email.com', 'LNVLEG7'),    -- Lenovo Legion
        ('hai.do@email.com', 'DELLAW16'),   -- Alienware 16

        -- Khách: Đặng Thị Mai (mai.dang) - Thích phụ kiện & Xiaomi
        ('mai.dang@email.com', 'XM15'),     -- Xiaomi 15
        ('mai.dang@email.com', 'ANKER20K'), -- Sạc Anker
        ('mai.dang@email.com', 'SONYXM6')   -- Tai nghe Sony
    ) AS Src (Email, SKU)

    -- 2. Join lấy ID thật
    JOIN tb_TaiKhoan tk ON Src.Email = tk.Email
    JOIN tb_SanPham sp ON Src.SKU = sp.MaSanPham

    -- 3. Kiểm tra: Nếu đã thích rồi thì không thêm nữa (Tránh trùng lặp)
    WHERE NOT EXISTS (
        SELECT 1 FROM tb_YeuThich 
        WHERE TaiKhoanId = tk.Id AND SanPhamId = sp.Id
    );
GO

INSERT INTO [dbo].[tb_CauHinh] ([MaCauHinh], [GiaTri], [MoTa])
SELECT 
    Src.Ma, 
    Src.GiaTri, 
    Src.MoTa
FROM 
    (VALUES 
        (N'Hotline', N'0909.123.456', N'Số điện thoại hiển thị trên Header/Footer'),
        (N'EmailLienHe', N'hotro@shop.com', N'Email nhận liên hệ từ khách hàng'),
        (N'Logo', N'logo.png', N'Đường dẫn ảnh Logo website'),
        (N'TieuDeWeb', N'Shop Điện Tử Uy Tín', N'Tiêu đề mặc định của trang web (Page Title)')
    ) AS Src (Ma, GiaTri, MoTa)
WHERE NOT EXISTS (SELECT 1 FROM [dbo].[tb_CauHinh] WHERE MaCauHinh = Src.Ma);
GO

INSERT INTO [dbo].[tb_DangKyNhanTin] ([Email], [NgayTao])
SELECT 
    Src.Email, 
    Src.NgayDK
FROM 
    (VALUES 
        -- 1. Email của khách hàng đã có trong hệ thống
        (N'an.nguyen@email.com', '2023-10-15'),
        (N'binh.tran@email.com', '2023-11-20'),
        (N'dung.pham@email.com', '2023-12-05'),
        (N'hai.do@email.com', '2024-01-02'),
        
        -- 2. Email khách vãng lai (Guest) - Những người chỉ ghé xem web
        (N'khach.moi@gmail.com', '2024-01-15'),
        (N'fan.congnghe@yahoo.com', '2024-02-14'),
        (N'sanh.dieu@outlook.com', '2024-03-01'),
        (N'nguoi.mua.an.danh@icloud.com', '2024-03-20'),
        (N'sale.hunter.99@gmail.com', GETDATE()) -- Đăng ký hôm nay
    ) AS Src (Email, NgayDK)
    
    -- Kiểm tra: Chỉ thêm nếu email này chưa có trong bảng
    WHERE NOT EXISTS (SELECT 1 FROM [dbo].[tb_DangKyNhanTin] WHERE Email = Src.Email);
GO

-- Khai báo biến để hứng ID của menu cha
DECLARE @IdSanPham INT;

-- 1. Thêm các Menu Cha trước (Cấp 1)
-- Lưu ý: MenuChaId phải để NULL, không để 0
INSERT INTO tb_Menu (TieuDe, LienKet, MoTa, MenuChaId, ThuTu, NgayTao, HienThi)
VALUES
(N'Trang chủ', '/', N'Trang chủ website', NULL, 1, '2025-01-01', 1),
(N'Sản phẩm', '/san-pham', N'Danh sách sản phẩm', NULL, 2, '2025-01-01', 1),
(N'Tin tức', '/tin-tuc', N'Tin tức công nghệ', NULL, 3, '2025-01-01', 1),
(N'Liên hệ', '/lien-he', N'Liên hệ với chúng tôi', NULL, 4, '2025-01-01', 1);

-- 2. Lấy ID của thằng "Sản phẩm" vừa tạo để dùng cho tụi con
SELECT @IdSanPham = Id FROM tb_Menu WHERE TieuDe = N'Sản phẩm';

-- 3. Thêm các Menu Con (Cấp 2)
INSERT INTO tb_Menu (TieuDe, LienKet, MoTa, MenuChaId, ThuTu, NgayTao, HienThi)
VALUES
(N'Điện thoại', '/san-pham/dien-thoai', N'Điện thoại thông minh', @IdSanPham, 1, '2025-01-01', 1),
(N'Laptop', '/san-pham/laptop', N'Máy tính xách tay', @IdSanPham, 2, '2025-01-01', 1);

PRINT N'Đã thêm Menu thành công!';
GO

-----
INSERT INTO tb_LienHe (TenNguoiGui, Email, Website, NoiDung, DaDoc, NgayTao)
VALUES
(N'Nguyễn Văn A', 'vana@gmail.com', 'https://example.com', 
 N'Tôi cần hỗ trợ về sản phẩm A.', 0, '2025-01-01'),

(N'Trần Thị B', 'thib@gmail.com', 'https://khachhang.com', 
 N'Tôi muốn hỏi về chính sách bảo hành.', 0, '2025-01-01');

 ---
 INSERT INTO tb_Quyen (TenQuyen)
VALUES
(N'Admin'),
(N'Nhân viên'),
(N'Khách hàng');

---
INSERT INTO tb_MaGiamGia 
(MaCode, SoTienGiam, PhanTramGiam, NgayTao, NgayKetThuc, SoLuong, HienThi)
VALUES
('SALE10',    0,     10,  '2025-01-01', '2025-12-31', 100, 1),
('GIAM50K',   50000, 0,   '2025-01-01', '2025-06-30', 50,  1),
('FREESHIP',  0,     0,   '2025-01-01', '2026-01-01', 1000,1),
('XMAS25',    0,     25,  '2025-01-01', '2025-12-25', 500, 1);

---
INSERT INTO tb_QuangCao 
(TieuDe, HinhAnh, LienKet, ThuTu, NgayTao, HienThi)
VALUES
(N'Khuyến mãi hè 2025', 'banner1.jpg', '/khuyen-mai',        1, '2025-01-01', 1),
(N'Giảm giá cuối năm', 'banner2.jpg', '/sale-cuoi-nam',      2, '2025-01-01', 1),
(N'Flash Sale',        'banner3.jpg', '/flash-sale',         3, '2025-01-01', 1);

INSERT INTO tb_DanhMucTin (TenDanhMuc, BiDanh, NgayTao, HienThi)
VALUES
(N'Tin công nghệ',       'tin-cong-nghe',       '2025-01-01', 1),
(N'Đánh giá sản phẩm',   'danh-gia-san-pham',   '2025-01-01', 1),
(N'Khuyến mãi',          'khuyen-mai',          '2025-01-01', 1),
(N'Hướng dẫn sử dụng',   'huong-dan',           '2025-01-01', 1);

INSERT INTO tb_TinTuc 
(TieuDe, BiDanh, DanhMucTinId, MoTa, ChiTiet, HinhAnh, TieuDeSeo, MoTaSeo, TuKhoaSeo, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat, HienThi)
VALUES 
(N'Apple ra mắt iPhone 16', N'iphone-16-ra-mat', 1, N'iPhone 16 được nâng cấp mạnh mẽ về camera và hiệu năng.', N'Nội dung chi tiết bài viết về iPhone 16...', 'iphone16.jpg', N'Apple giới thiệu iPhone 16', N'Tổng hợp thông tin mới nhất về iPhone 16', N'iPhone 16, Apple, smartphone 2025', '2025-01-01', N'Admin', '2025-01-01', N'Nguyễn Văn An', 1),
(N'Đánh giá Samsung S25 Ultra', N'danh-gia-s25-ultra', 2, N'Bài đánh giá chi tiết Samsung S25 Ultra.', N'Nội dung đánh giá thiết bị...', 's25ultra.jpg', N'Đánh giá Samsung S25 Ultra', N'Thông tin review mới nhất', N'Samsung S25 Ultra, review smartphone', '2025-01-01', N'Admin', '2025-01-01', N'Trần Minh Qúy', 1),
(N'Giảm giá tháng 12 – Sale khủng', N'khuyen-mai-thang-12', 3, N'Chương trình giảm giá lớn nhất trong năm.', N'Thông tin chi tiết chương trình khuyến mãi...', 'sale12.jpg', N'Sale tháng 12', N'Giảm giá mạnh cuối năm', N'khuyến mãi, sale tháng 12', '2025-01-01', N'Marketing', '2025-01-01', N'Trần Minh Tâm', 1),
(N'Hướng dẫn sử dụng iPhone hiệu quả', N'huong-dan-su-dung-iphone', 4, N'Tips và mẹo dùng iPhone cho người mới.', N'Nội dung hướng dẫn chi tiết...', 'iphone-guide.jpg', N'Mẹo dùng iPhone', N'Các thủ thuật hữu ích cho người dùng iPhone', N'iphone, hướng dẫn sử dụng, mẹo iphone', '2025-01-01', N'Admin', '2025-01-01', N'Trần Minh Qúy', 1);


