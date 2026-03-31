using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnWeb.Models
{
    /// <summary>
    /// ViewModel cho trang danh sách s?n ph?m
    /// </summary>
    public class ProductListViewModel
    {
  /// <summary>
        /// Danh sách s?n ph?m
        /// </summary>
        public IEnumerable<tb_SanPham> Products { get; set; }

        /// <summary>
        /// Tên danh m?c ho?c th??ng hi?u hi?n t?i (?? hi?n th? title)
   /// </summary>
        public string CurrentCategoryName { get; set; }

        /// <summary>
  /// Trang hi?n t?i
        /// </summary>
        public int CurrentPage { get; set; }

        /// <summary>
        /// T?ng s? trang
  /// </summary>
        public int TotalPages { get; set; }

   /// <summary>
        /// T?ng s? s?n ph?m
        /// </summary>
   public int TotalProducts { get; set; }

        /// <summary>
     /// S? s?n ph?m trên m?i trang
        /// </summary>
        public int PageSize { get; set; }

        /// <summary>
   /// ID danh m?c (?? gi? filter khi phân trang)
  /// </summary>
   public int? DanhMucId { get; set; }

      /// <summary>
        /// ID th??ng hi?u (?? gi? filter khi phân trang)
     /// </summary>
        public int? ThuongHieuId { get; set; }

        /// <summary>
      /// T? khóa tìm ki?m (?? gi? filter khi phân trang)
        /// </summary>
        public string SearchKeyword { get; set; }

        /// <summary>
   /// B? l?c ??c bi?t: moi, banchay, khuyenmai
        /// </summary>
        public string FilterType { get; set; }

    /// <summary>
        /// Constructor
/// </summary>
        public ProductListViewModel()
        {
      Products = new List<tb_SanPham>();
    PageSize = 12; // M?c ??nh 12 s?n ph?m/trang
     CurrentPage = 1;
    }

        /// <summary>
        /// Ki?m tra có trang tr??c không
      /// </summary>
        public bool HasPreviousPage
        {
            get { return CurrentPage > 1; }
    }

        /// <summary>
   /// Ki?m tra có trang sau không
        /// </summary>
        public bool HasNextPage
        {
 get { return CurrentPage < TotalPages; }
        }
    }
}
