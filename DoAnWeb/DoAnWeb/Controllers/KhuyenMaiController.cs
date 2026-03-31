using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DoAnWeb.Models;

namespace DoAnWeb.Controllers
{
    /// <summary>
    /// Controller xử lý trang khuyến mãi
    /// </summary>
    public class KhuyenMaiController : BaseController
    {
        /// <summary>
        /// GET: Trang khuyến mãi
        /// </summary>
        public ActionResult Index(int? danhMucId, string sortBy = "discount_desc", int page = 1, int pageSize = 12)
        {
            // Query sản phẩm có khuyến mãi
            var query = db.tb_SanPham
                .Where(sp => sp.HienThi == true &&
                    sp.GiaKhuyenMai.HasValue &&
                    sp.GiaKhuyenMai < sp.Gia);

            // Lọc theo danh mục
            if (danhMucId.HasValue && danhMucId.Value > 0)
            {
                query = query.Where(sp => sp.DanhMucId == danhMucId.Value);
            }

            // Sắp xếp
            switch (sortBy)
            {
                case "discount_desc":
                    // Giảm giá nhiều nhất
                    query = query.OrderByDescending(sp =>
                        (sp.Gia - sp.GiaKhuyenMai) / sp.Gia * 100);
                    break;
                case "discount_asc":
                    // Giảm giá ít nhất
                    query = query.OrderBy(sp =>
                        (sp.Gia - sp.GiaKhuyenMai) / sp.Gia * 100);
                    break;
                case "price_asc":
                    query = query.OrderBy(sp => sp.GiaKhuyenMai);
                    break;
                case "price_desc":
                    query = query.OrderByDescending(sp => sp.GiaKhuyenMai);
                    break;
                case "newest":
                    query = query.OrderByDescending(sp => sp.NgayTao);
                    break;
                case "popular":
                    query = query.OrderByDescending(sp => sp.LuotXem);
                    break;
                default:
                    query = query.OrderByDescending(sp =>
                        (sp.Gia - sp.GiaKhuyenMai) / sp.Gia * 100);
                    break;
            }

            // Tổng số sản phẩm
            var totalProducts = query.Count();
            ViewBag.TotalProducts = totalProducts;

            // Pagination
            var totalPages = (int)Math.Ceiling((double)totalProducts / pageSize);
            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = totalPages;
            ViewBag.PageSize = pageSize;

            // Lấy sản phẩm cho trang hiện tại
            var products = query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            // ViewBag cho filters
            ViewBag.DanhMucId = danhMucId ?? 0;
            ViewBag.SortBy = sortBy;
            ViewBag.DanhMucList = db.tb_DanhMuc.Where(dm => dm.HienThi == true).ToList();

            // Tính tổng tiết kiệm
            ViewBag.TotalSavings = products.Sum(sp => sp.Gia - sp.GiaKhuyenMai);

            return View(products);
        }

        /// <summary>
        /// GET: Chi tiết chương trình khuyến mãi
        /// </summary>
        public ActionResult ChiTiet(int id)
        {
            // TODO: Implement promotion detail page
            return RedirectToAction("Index");
        }
    }
}
