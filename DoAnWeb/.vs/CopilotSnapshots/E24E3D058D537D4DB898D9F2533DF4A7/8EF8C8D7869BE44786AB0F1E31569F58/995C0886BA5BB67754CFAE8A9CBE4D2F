/**
 * QR Payment Handler
 * Xử lý hiển thị QR code cho các phương thức thanh toán chuyển khoản
 */

$(document).ready(function() {
    // Xử lý khi click vào phương thức thanh toán
    $('input[name="PaymentMethod"]').on('change', function() {
        var paymentMethod = $(this).val();
        var $submitBtn = $('#btnSubmitOrder');
        
        // Hiển thị thông báo cho phương thức chuyển khoản
        if (paymentMethod == '2' || paymentMethod == '3' || paymentMethod == '4') {
            var methodName = getPaymentMethodName(paymentMethod);
            $submitBtn.attr('data-payment-method', paymentMethod);
            $submitBtn.find('.payment-text').html('<i class="fas fa-qrcode"></i> Xác nhận và xem mã QR ' + methodName);
        } else {
            $submitBtn.removeAttr('data-payment-method');
            $submitBtn.find('.payment-text').html('<i class="fas fa-check-circle"></i> Xác nhận đặt hàng');
        }
    });
    
    // Xử lý khi submit form
    $('#checkoutForm').on('submit', function(e) {
        var paymentMethod = $('input[name="PaymentMethod"]:checked').val();
        
        // Nếu là phương thức chuyển khoản (2, 3, 4)
        if (paymentMethod == '2' || paymentMethod == '3' || paymentMethod == '4') {
            e.preventDefault(); // Ngăn submit form thông thường
            
            // Hiển thị QR code modal trước
            showQRCodeModal(paymentMethod);
            
            // Sau khi user đóng modal, mới submit form
            $('#qrPaymentModal').on('hidden.bs.modal', function() {
                // Submit form sau khi đóng modal
                $('#checkoutForm').off('submit').submit();
            });
        }
    });
});

/**
 * Lấy tên phương thức thanh toán
 */
function getPaymentMethodName(paymentMethod) {
    switch(paymentMethod) {
        case '2': return 'Ngân hàng';
        case '3': return 'MoMo';
        case '4': return 'ZaloPay';
        default: return '';
    }
}

/**
 * Lấy đường dẫn ảnh QR theo phương thức
 */
function getQRImagePath(paymentMethod) {
    switch(paymentMethod) {
        case '2': return '/Content/Images/bank.jpg';
        case '3': return '/Content/Images/momo.jpg';
        case '4': return '/Content/Images/zalopay.jpg';
        default: return '';
    }
}

/**
 * Hiển thị modal QR code
 */
function showQRCodeModal(paymentMethod, form) {
    var methodName = getPaymentMethodName(paymentMethod);
    var qrImagePath = getQRImagePath(paymentMethod);
    
    // Lấy tổng tiền từ trang
    var totalText = $('#total').text().replace(/[^\d]/g, '');
    var finalTotal = parseInt(totalText) || 0;
    
    // Tạo modal HTML
    var modalHTML = `
        <div class="modal fade" id="qrPaymentModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">
                            <i class="fas fa-qrcode"></i> Thanh toán qua ${methodName}
                        </h5>
                        <button type="button" class="close text-white" data-dismiss="modal">
                            <span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i>
                            <strong>Số tiền cần thanh toán:</strong>
                            <h3 class="text-danger mb-0">${formatCurrency(finalTotal)}</h3>
                        </div>
                        
                        <div class="qr-code-container mb-3">
                            <img src="${qrImagePath}" 
                                 alt="QR Code ${methodName}" 
                                 class="img-fluid rounded shadow"
                                 style="max-width: 400px; max-height: 400px;"
                                 onerror="this.src='/Content/Images/no-qr.png'; this.alt='QR Code không khả dụng';">
                        </div>
                        
                        <div class="payment-instructions">
                            <h6 class="text-primary">
                                <i class="fas fa-hand-point-right"></i> Hướng dẫn thanh toán:
                            </h6>
                            <ol class="text-left">
                                <li>Mở ứng dụng <strong>${methodName}</strong> trên điện thoại</li>
                                <li>Quét mã QR bên trên</li>
                                <li>Kiểm tra số tiền: <strong class="text-danger">${formatCurrency(finalTotal)}</strong></li>
                                <li>Xác nhận thanh toán</li>
                                <li>Chụp màn hình giao dịch thành công (để đối chiếu nếu cần)</li>
                            </ol>
                        </div>
                        
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            <small>
                                Đơn hàng sẽ được xử lý sau khi chúng tôi xác nhận thanh toán của bạn.
                                Thời gian xử lý: <strong>5-30 phút</strong>
                            </small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            <i class="fas fa-times"></i> Đóng
                        </button>
                        <button type="button" class="btn btn-success" id="btnConfirmPayment">
                            <i class="fas fa-check"></i> Đã chuyển khoản
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    // Xóa modal cũ nếu có
    $('#qrPaymentModal').remove();
    
    // Thêm modal mới
    $('body').append(modalHTML);
    
    // Hiển thị modal
    $('#qrPaymentModal').modal({
        backdrop: 'static',
        keyboard: false
    });
    
    // Xử lý nút "Đã chuyển khoản"
    $('#btnConfirmPayment').on('click', function() {
        $('#qrPaymentModal').modal('hide');
        
        // Show confirmation dialog
        setTimeout(function() {
            if (typeof showOrderConfirmation === 'function') {
                showOrderConfirmation(form);
            } else {
                // Fallback: submit form directly
                Swal.fire({
                    title: 'Đang xử lý đơn hàng...',
                    html: 'Vui lòng đợi trong giây lát',
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });
                
                // Submit form
                $('button[type="submit"]').prop('disabled', true)
                    .html('<i class="fas fa-spinner fa-spin mr-2"></i>Đang xử lý...');
                form.submit();
            }
        }, 300);
    });
}

/**
 * Format tiền tệ
 */
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}

/**
 * Kiểm tra file ảnh QR tồn tại
 */
function checkQRImageExists(paymentMethod, callback) {
    var img = new Image();
    var qrPath = getQRImagePath(paymentMethod);
    
    img.onload = function() {
        callback(true);
    };
    
    img.onerror = function() {
        callback(false);
    };
    
    img.src = qrPath;
}

/**
 * Hiển thị thông báo lỗi nếu không có QR code
 */
function showNoQRError(paymentMethod) {
    var methodName = getPaymentMethodName(paymentMethod);
    
    Swal.fire({
        icon: 'warning',
        title: 'Chưa có mã QR',
        html: `
            <p>Mã QR thanh toán qua <strong>${methodName}</strong> chưa được cấu hình.</p>
            <p>Vui lòng chọn phương thức thanh toán khác hoặc liên hệ admin.</p>
        `,
        confirmButtonText: 'Đã hiểu'
    });
}
