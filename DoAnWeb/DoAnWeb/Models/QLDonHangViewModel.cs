using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnWeb.Models
{
    public class QLDonHangViewModel : tb_DonHang
    {
        public string PhuongThucThanhToan { get; set; }
        public string PhuongThucVanChuyen { get; set; }
        public string MaGiamGia {  get; set; }
    }
}