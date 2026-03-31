using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnWeb.Models
{
    /// <summary>
 /// ViewModel cho Menu Danh m?c v?i danh sách Th??ng hi?u
    /// </summary>
    public class MenuDanhMucViewModel
    {
        /// <summary>
        /// Thông tin danh m?c
        /// </summary>
        public tb_DanhMuc DanhMuc { get; set; }

        /// <summary>
        /// Danh sách th??ng hi?u có s?n ph?m trong danh m?c này
   /// </summary>
 public List<ThuongHieuItem> DanhSachThuongHieu { get; set; }

        /// <summary>
        /// S? l??ng s?n ph?m trong danh m?c
        /// </summary>
   public int SoLuongSanPham { get; set; }

        /// <summary>
        /// Constructor
        /// </summary>
        public MenuDanhMucViewModel()
        {
        DanhSachThuongHieu = new List<ThuongHieuItem>();
        }
    }

    /// <summary>
    /// Thông tin th??ng hi?u trong menu
 /// </summary>
    public class ThuongHieuItem
    {
        /// <summary>
    /// ID th??ng hi?u
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// Tên th??ng hi?u
      /// </summary>
      public string TenThuongHieu { get; set; }

        /// <summary>
        /// S? l??ng s?n ph?m c?a th??ng hi?u trong danh m?c
        /// </summary>
        public int SoLuongSanPham { get; set; }

        /// <summary>
        /// Hình ?nh/Logo th??ng hi?u (n?u có)
        /// </summary>
        public string HinhAnh { get; set; }
    }

    /// <summary>
    /// ViewModel cho Top Menu (Blue Bar Navigation)
    /// Thông tin ??n gi?n c?a danh m?c ?? hi?n th? trên thanh ?i?u h??ng
    /// </summary>
    public class TopMenuItemViewModel
    {
        /// <summary>
        /// ID danh m?c
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// Tên danh m?c
        /// </summary>
        public string TenDanhMuc { get; set; }

        /// <summary>
        /// Icon class (Font Awesome)
        /// </summary>
        public string Icon { get; set; }

        /// <summary>
        /// Bí danh (slug) cho URL
        /// </summary>
        public string BiDanh { get; set; }
    }
}
