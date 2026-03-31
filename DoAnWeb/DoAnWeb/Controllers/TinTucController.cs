using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DoAnWeb.Models;

namespace DoAnWeb.Controllers
{
    /// <summary>
    /// Controller xử lý trang tin tức
    /// </summary>
    public class TinTucController : BaseController
    {
        /// <summary>
        /// GET: Danh sách tin tức (có tìm kiếm, lọc, sắp xếp)
        /// </summary>
        public ActionResult Index(int? danhMucId, string sortBy = "newest", string q = "", int page = 1, int pageSize = 9)
        {
            // Query tin tức
            var query = db.tb_TinTuc
                .Where(tt => tt.HienThi == true);

            // Tìm kiếm theo keyword
            bool isSearching = !string.IsNullOrWhiteSpace(q);
            if (isSearching)
            {
                var keyword = q.Trim();
                query = query.Where(tt => 
                    tt.TieuDe.Contains(keyword) ||
                    (tt.MoTa != null && tt.MoTa.Contains(keyword)) ||
                    (tt.ChiTiet != null && tt.ChiTiet.Contains(keyword)));
                
                ViewBag.SearchKeyword = keyword;
            }

            // Lọc theo danh mục tin
            if (danhMucId.HasValue && danhMucId.Value > 0)
            {
                query = query.Where(tt => tt.DanhMucTinId == danhMucId.Value);
            }

            // Sắp xếp
            switch (sortBy)
            {
                case "newest":
                    query = query.OrderByDescending(tt => tt.NgayTao);
                    break;
                case "oldest":
                    query = query.OrderBy(tt => tt.NgayTao);
                    break;
                case "title_asc":
                    query = query.OrderBy(tt => tt.TieuDe);
                    break;
                case "title_desc":
                    query = query.OrderByDescending(tt => tt.TieuDe);
                    break;
                default:
                    query = query.OrderByDescending(tt => tt.NgayTao);
                    break;
            }

            // Tổng số tin
            var totalNews = query.Count();
            ViewBag.TotalNews = totalNews;

            // Pagination
            var totalPages = (int)Math.Ceiling((double)totalNews / pageSize);
            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = totalPages;
            ViewBag.PageSize = pageSize;

            // Lấy tin cho trang hiện tại
            var news = query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            // ViewBag cho filters
            ViewBag.DanhMucId = danhMucId ?? 0;
            ViewBag.SortBy = sortBy;
            ViewBag.DanhMucTinList = db.tb_DanhMucTin.Where(dm => dm.HienThi == true).ToList();
            ViewBag.IsSearching = isSearching;

            // Tin nổi bật (sidebar) - lấy 5 tin mới nhất
            ViewBag.TinNoiBat = db.tb_TinTuc
                .Where(tt => tt.HienThi == true)
                .OrderByDescending(tt => tt.NgayTao)
                .Take(5)
                .ToList();

            return View(news);
        }

        /// <summary>
        /// GET: Chi tiết tin tức
        /// </summary>
        public ActionResult ChiTiet(int id)
        {
            var tinTuc = db.tb_TinTuc.Find(id);

            if (tinTuc == null || tinTuc.HienThi == false)
            {
                TempData["ErrorMessage"] = "Tin tức không tồn tại";
                return RedirectToAction("Index");
            }

            // Tin liên quan (cùng danh mục)
            ViewBag.TinLienQuan = db.tb_TinTuc
                .Where(tt => tt.HienThi == true &&
                    tt.Id != id &&
                    tt.DanhMucTinId == tinTuc.DanhMucTinId)
                .OrderByDescending(tt => tt.NgayTao)
                .Take(4)
                .ToList();

            // Tin mới nhất (sidebar)
            ViewBag.TinMoiNhat = db.tb_TinTuc
                .Where(tt => tt.HienThi == true && tt.Id != id)
                .OrderByDescending(tt => tt.NgayTao)
                .Take(5)
                .ToList();

            return View(tinTuc);
        }

        /// <summary>
        /// API: Live search tin tức (AJAX)
        /// </summary>
        [HttpGet]
        public JsonResult LiveSearch(string q)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(q) || q.Length < 2)
                {
                    return Json(new { success = false, message = "Từ khóa quá ngắn" }, JsonRequestBehavior.AllowGet);
                }

                var keyword = q.Trim();
                var results = db.tb_TinTuc
                    .Where(tt => tt.HienThi == true &&
                        (tt.TieuDe.Contains(keyword) ||
                        (tt.MoTa != null && tt.MoTa.Contains(keyword))))
                    .OrderByDescending(tt => tt.NgayTao)
                    .Take(5)
                    .Select(tt => new
                    {
                        id = tt.Id,
                        tieuDe = tt.TieuDe,
                        moTa = tt.MoTa,
                        hinhAnh = tt.HinhAnh,
                        ngayTao = tt.NgayTao.HasValue ? tt.NgayTao.Value.ToString("dd/MM/yyyy") : "",
                        danhMuc = tt.tb_DanhMucTin != null ? tt.tb_DanhMucTin.TenDanhMuc : ""
                    })
                    .ToList();

                return Json(new
                {
                    success = true,
                    count = results.Count,
                    results = results
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Có lỗi xảy ra: " + ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
