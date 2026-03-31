using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DoAnWeb.Models;

namespace DoAnWeb.Controllers
{
    /// <summary>
    /// Controller xử lý trang liên hệ
    /// </summary>
    public class LienHeController : BaseController
    {
        /// <summary>
        /// GET: Trang liên hệ
        /// </summary>
        public ActionResult Index()
        {
            // Lấy thông tin cấu hình (nếu có)
            ViewBag.HotlineText = "1800.1060";
            ViewBag.EmailText = "support@laptopstore.vn";
            ViewBag.AddressText = "140 Lê Trọng Tấn, Phường Tây Thạnh, Quận Tân Phú, TP.HCM";
            ViewBag.WorkingHours = "Thứ 2 - Thứ 7: 8:00 - 21:00 | Chủ nhật: 9:00 - 18:00";

            // Nếu user đã đăng nhập, truyền thông tin vào ViewBag
            if (Session["UserId"] != null)
            {
                int userId = (int)Session["UserId"];
                var user = db.tb_TaiKhoan.Find(userId);
                
                if (user != null)
                {
                    ViewBag.UserHoTen = user.HoTen;
                    ViewBag.UserEmail = user.Email;
                    ViewBag.UserSoDienThoai = user.SoDienThoai;
                }
            }

            return View();
        }

        /// <summary>
        /// POST: Gửi form liên hệ
        /// </summary>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult GuiLienHe(string hoTen, string email, string soDienThoai, string chuDe, string noiDung)
        {
            // Validate
            if (string.IsNullOrWhiteSpace(hoTen) ||
                string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(noiDung))
            {
                TempData["ErrorMessage"] = "Vui lòng điền đầy đủ thông tin bắt buộc";
                return RedirectToAction("Index");
            }

            try
            {
                // Tạo record liên hệ
                // Note: tb_LienHe properties: TenNguoiGui, Email, Website, NoiDung, DaDoc, NgayTao
                // Format: [Chủ đề] | SĐT: xxx | Nội dung
                string formattedContent = noiDung.Trim();
                
                // Thêm thông tin chủ đề và SĐT vào đầu nội dung
                if (!string.IsNullOrWhiteSpace(chuDe))
                {
                    formattedContent = $"[{chuDe}]\n\n{formattedContent}";
                }
                
                if (!string.IsNullOrWhiteSpace(soDienThoai))
                {
                    formattedContent = $"SĐT: {soDienThoai}\n\n{formattedContent}";
                }
                
                var lienHe = new tb_LienHe
                {
                    TenNguoiGui = hoTen.Trim(),
                    Email = email.Trim(),
                    Website = soDienThoai?.Trim(), // Lưu SĐT vào Website
                    NoiDung = formattedContent,
                    NgayTao = DateTime.Now,
                    DaDoc = false
                };

                db.tb_LienHe.Add(lienHe);
                db.SaveChanges();

                // TODO: Send email notification to admin
                // SendEmailToAdmin(lienHe);

                TempData["SuccessMessage"] = "Gửi liên hệ thành công! Chúng tôi sẽ phản hồi trong thời gian sớm nhất.";
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Có lỗi xảy ra. Vui lòng thử lại sau.";
                return RedirectToAction("Index");
            }
        }

        /// <summary>
        /// AJAX: Gửi form liên hệ
        /// </summary>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult GuiLienHeAjax(string hoTen, string email, string soDienThoai, string chuDe, string noiDung)
        {
            // Validate
            if (string.IsNullOrWhiteSpace(hoTen) ||
                string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(noiDung))
            {
                return Json(new { success = false, message = "Vui lòng điền đầy đủ thông tin bắt buộc" });
            }

            try
            {
                // Tạo record liên hệ với format đầy đủ
                string formattedContent = noiDung.Trim();
                
                // Thêm thông tin chủ đề và SĐT vào đầu nội dung
                if (!string.IsNullOrWhiteSpace(chuDe))
                {
                    formattedContent = $"[{chuDe}]\n\n{formattedContent}";
                }
                
                if (!string.IsNullOrWhiteSpace(soDienThoai))
                {
                    formattedContent = $"SĐT: {soDienThoai}\n\n{formattedContent}";
                }
                
                var lienHe = new tb_LienHe
                {
                    TenNguoiGui = hoTen.Trim(),
                    Email = email.Trim(),
                    Website = soDienThoai?.Trim(),
                    NoiDung = formattedContent,
                    NgayTao = DateTime.Now,
                    DaDoc = false
                };

                db.tb_LienHe.Add(lienHe);
                db.SaveChanges();

                return Json(new { success = true, message = "Gửi liên hệ thành công! Chúng tôi sẽ phản hồi trong thời gian sớm nhất." });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Có lỗi xảy ra. Vui lòng thử lại sau." });
            }
        }
    }
}
