using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnWeb.Models
{
    /// <summary>
    /// ViewModel cho trang ch?
    /// Ch?a danh sách s?n ph?m m?i, s?n ph?m bán ch?y, danh m?c và tin t?c
    /// </summary>
public class HomeViewModel
  {
     /// <summary>
    /// Danh sách s?n ph?m m?i (Top 10)
  /// </summary>
  public List<tb_SanPham> SanPhamMoi { get; set; }

     /// <summary>
        /// Danh sách s?n ph?m bán ch?y (Top 10)
     /// </summary>
        public List<tb_SanPham> SanPhamBanChay { get; set; }

        /// <summary>
   /// Danh sách t?t c? danh m?c s?n ph?m
        /// </summary>
  public List<tb_DanhMuc> DanhMuc { get; set; }

   /// <summary>
  /// Danh sách tin t?c m?i nh?t (Top 3)
        /// </summary>
  public List<tb_TinTuc> TinTuc { get; set; }

        /// <summary>
        /// Danh sách thương hiệu nổi bật
        /// </summary>
        public List<tb_ThuongHieu> ThuongHieu { get; set; }

        /// <summary>
        /// Danh sách quảng cáo (banner)
        /// </summary>
        public List<tb_QuangCao> QuangCao { get; set; }

  /// <summary>
  /// Constructor kh?i t?o các list r?ng
   /// </summary>
        public HomeViewModel()
  {
         SanPhamMoi = new List<tb_SanPham>();
     SanPhamBanChay = new List<tb_SanPham>();
DanhMuc = new List<tb_DanhMuc>();
       TinTuc = new List<tb_TinTuc>();
            ThuongHieu = new List<tb_ThuongHieu>();
            QuangCao = new List<tb_QuangCao>();
        }
    }
}
