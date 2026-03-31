using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnWeb.Models
{
    /// <summary>
    /// ViewModel cho trang chi ti?t s?n ph?m
    /// </summary>
    public class ProductDetailViewModel
    {
        /// <summary>
        /// Thông tin s?n ph?m hi?n t?i
        /// </summary>
      public tb_SanPham SanPham { get; set; }

        /// <summary>
        /// Danh sách s?n ph?m liên quan (cùng danh m?c)
        /// </summary>
        public IEnumerable<tb_SanPham> SanPhamLienQuan { get; set; }

        /// <summary>
        /// Danh sách hình ?nh s?n ph?m (n?u có b?ng tb_AnhSanPham)
        /// </summary>
 public IEnumerable<tb_AnhSanPham> DanhSachAnh { get; set; }

        /// <summary>
        /// Danh sách ?ánh giá s?n ph?m (n?u có b?ng tb_DanhGia)
   /// </summary>
        public IEnumerable<tb_DanhGia> DanhSachDanhGia { get; set; }

        /// <summary>
        /// Trung bình ?i?m ?ánh giá
  /// </summary>
 public double DiemTrungBinh { get; set; }

        /// <summary>
        /// T?ng s? ?ánh giá
        /// </summary>
        public int TongSoDanhGia { get; set; }

        /// <summary>
 /// Constructor
  /// </summary>
 public ProductDetailViewModel()
        {
 SanPhamLienQuan = new List<tb_SanPham>();
            DanhSachAnh = new List<tb_AnhSanPham>();
       DanhSachDanhGia = new List<tb_DanhGia>();
}
    }
}
