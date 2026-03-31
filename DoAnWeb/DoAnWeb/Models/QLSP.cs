using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnWeb.Models
{
    public class QLSP :tb_SanPham
    {
        public string TenDanhMuc { get; set; }
        public string TenThuongHieu { get; set; }

        // Thông số
        public string BoNhoRAM { get; set; }
        public string BoNhoTrong { get; set; }
        public string ManHinh { get; set; }
        public string DungLuongPin { get; set; }
        public string Camera { get; set; }
        public string HeDieuHanh { get; set; }
        public string CongKetNoi { get; set; }
    }
}