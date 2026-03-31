using System;
using System.ComponentModel.DataAnnotations;

namespace DoAnWeb.Models
{
    /// <summary>
    /// ViewModel cho qu?n lý Banner (Qu?ng cáo)
    /// </summary>
    public class BannerViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng nh?p tiêu ?? banner")]
        [StringLength(200, ErrorMessage = "Tiêu ?? không ???c v??t quá 200 ký t?")]
        [Display(Name = "Tiêu ??")]
        public string TieuDe { get; set; }

        [StringLength(500, ErrorMessage = "Mô t? không ???c v??t quá 500 ký t?")]
        [Display(Name = "Mô t?")]
        public string MoTa { get; set; }

        [Display(Name = "Hình ?nh")]
        public string HinhAnh { get; set; }

        [StringLength(500, ErrorMessage = "Link không ???c v??t quá 500 ký t?")]
        [Display(Name = "Link liên k?t")]
        public string Link { get; set; }

        [Display(Name = "Th? t? hi?n th?")]
        [Range(0, 999, ErrorMessage = "Th? t? ph?i t? 0 ??n 999")]
        public int ThuTu { get; set; }

        [Display(Name = "V? trí hi?n th?")]
        public string ViTri { get; set; }

        [Display(Name = "Hi?n th?")]
        public bool HienThi { get; set; }

        [Display(Name = "Ngày t?o")]
        public DateTime? NgayTao { get; set; }

        [Display(Name = "Ngày c?p nh?t")]
        public DateTime? NgayCapNhat { get; set; }
    }
}
