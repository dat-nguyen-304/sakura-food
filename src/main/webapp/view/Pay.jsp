<%-- 
    Document   : Login
    Created on : Mar 3, 2022, 6:25:10 PM
    Author     : Admin
--%>
<%@page import="java.util.List"%>
<%@page import="com.fptuni.prj301.assignment.model.Customer"%>
<%@page import="com.fptuni.prj301.assignment.dbmanager.CustomerManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
        <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
        <link href="../assets/css/toastr.css" rel="stylesheet" />
        <link rel="stylesheet" href="../assets/css/grid.css">
        <link rel="stylesheet" href="../assets/css/base.css">
        <link rel="stylesheet" href="../assets/css/Payment/Web-Style/Payment.css">
        <link rel="stylesheet" href="../assets/css/Payment/Web-Style/ListFood.css">
        <link rel="stylesheet" href="../assets/css/Payment/Web-Style/Bootstrap/Bootstrap/bootstrap-3.4.1-dist/bootstrap-3.4.1-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/header.css">
        <link rel="stylesheet" href="../assets/css/footer.css">
        <link rel="stylesheet" href="../assets/css/modal_vip.css">
    </head>

    <body>
        <%! HttpSession ss;
            UserSession us;%>
        <%
            ss = request.getSession();
            us = (UserSession) (UserSession) ss.getAttribute("usersession");
            if (us.getAccessRight().equals("admin")) {
                out.print("<div>Không thể truy cập trang này với tài khoản " + us.getUsername() + "</div>");
                out.print("<a href='" + request.getContextPath() + "/Admin/customer" + "'>Quay về</a>");
                return;
            }
        %>

        <%@include file="/view/layout/header.jsp" %>
        <div class="container">
            <div class="container list-order ">
                <div class="row list-body">
                    <div class="col-md-2 order-header-product">
                        <span class="order-header-content">Food</span>
                    </div>
                    <div class="col-md-9 list-order-type">
                        <div class="list-order-detail">
                            <ul class="list-order-header">
                                <li class="item-order-header">Giá tiền / sản phẩm</li>
                                <li class="item-order-header">Số Lượng</li>
                                <li class="item-order-header">Thành tiền</li>
                                <li class="item-order-header">Chọn mua</li>
                                <li class="item-order-header">Xóa</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <c:set var="usersession" value="${sessionScope.usersession}" />
                <c:set var="itemList" value="${usersession.cart}" />
                <c:if test="${itemList.size() == 0}">
                    <h1>Chưa có món nào</h1>
                </c:if>
                <c:forEach items="${itemList}" var="item">
                    <div class="row list-body-item  food">
                        <div class="col-md-2 order-info-product">
                            <img src="${item.getFood().getImgLink()}" alt="" class="product-image-description">
                        </div>
                        <div class="col-md-9 list-order-type">
                            <div class="list-product-order-detail">
                                <ul class="list-order-item">
                                    <li class="item-order-detail price-default">${item.getFood().getFinalPrice() / 1000}00</li>
                                    <li class="item-order-detail amount-list">
                                        <button class="item-order-minus symbol">
                                            <i class="fa-solid fa-minus"></i>
                                        </button>
                                        <div class="item-order-amount">
                                            <span class="order-amount">${item.getQuantity()}</span>
                                        </div>
                                        <button class="item-order-plus symbol">
                                            <i class="fa-solid fa-plus"></i>
                                        </button>
                                    </li>
                                    <li class="item-order-detail price-calc"></li>
                                    <li class="item-order-detail">
                                        <form action="" class="order-detail-form">
                                            <input type="checkbox" name="" id="" class="order-detail-checking" />
                                        </form>
                                    </li>
                                    <c:url var="removeLink" value="/Pay/pay">
                                        <c:param name="removeId" value="${item.getFood().getId()}" />
                                    </c:url>
                                    <li class="item-order-detail"><a href="${removeLink}" class="btn-Action">Xóa</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
            <div class="order-info">
                <div class="price-info">
                    <div class="price-info__title">Thông tin đơn hàng</div>
                    <div class="price-info__container">
                        <div class="price-item">
                            <span class="price-item__label ">Tổng giá trị:</span>
                            <span class="price-item__value price-total">0.000 VNĐ</span>
                        </div>
                        <div class="price-item">
                            <span class="price-item__label ">Voucher:</span>
                            <%
                                CustomerManager cm = new CustomerManager();
                                int voucher = 0;
                                Customer c = cm.getByUsername(us.getUsername());
                                if (c.getIdVipAccount() != 0) {
                                    if (c.getVoucherLeft() > 0) {
                                        voucher = cm.getVoucherPercent(c.getIdVipAccount());
                                    }
                                }
                                out.print("<span class='price-item__value voucher'>" + voucher + " %</span>");
                            %>

                        </div>
                        <div class="price-item">
                            <span class="price-item__label ">Giảm:</span>
                            <span class="price-item__value decrease">0.000 VNĐ</span>
                        </div>
                        <div class="final-price">
                            <span class="final-price__label ">Thành tiền:</span>
                            <span class="final-price__value payment">0.000 VNĐ</span>
                        </div>
                    </div>

                </div>
                <form action="${request.contextPath}" class="customer-info">
                    <div class="customer-info__title">Thông tin khách hàng</div>
                    <div class="customer-info__container">
                        <div>
                            <input name="boughtList" type="hidden" class="checkListInput">
                            <div class="input-item">
                                <label for="">Địa chỉ:</label>
                                <input type="text" name="address">
                            </div>
                            <div class="input-item">
                                <label for="">Số điện thoại:</label>
                                <input type="text" name="phone">
                            </div>
                            <div class="input-item">
                                <label for="">Ghi chú:</label>
                                <input type="text" name="note">
                            </div>
                            <button class="pay-btn" type="submit">Thanh toán</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="modal-vip">
            <div class="vip-container">
                <h4 class="vip-title">Hãy chọn gói phù hợp với bạn</h4>
                <ul class="vip-list">
                    <li class="container-package" style="background-color: #9bb0b9;">
                        <div class=" container-package__VIP ">Gói VIP Bạc</div>
                        <div class="container-package__info ">
                            <div class="container-package__info-line "></div>
                            <div class="container-package__info-month ">1 tháng</div>
                            <div class="container-package__info-price ">
                                <div class="price-new ">
                                    <div class="before-dot ">69</div>
                                    <div class="price-dot ">
                                        <div class="after-dot ">000</div>
                                        <div class="unit-currency ">VNĐ</div>
                                    </div>
                                </div>
                                <s class="price-old ">159000 VNĐ</s>
                            </div>
                            <div class="container-package__voucher ">- Tặng 5 voucher 10%</div>
                            <a class="container-package__btn " href="${request.contextPath}?idVip=1">Mua VIP</a>
                        </div>
                    </li>
                    <li class=" container-package" style=" background-color: #edd67d; ">
                        <div class=" container-package__VIP ">Gói VIP Vàng</div>
                        <div class=" container-package__info ">
                            <div class=" container-package__info-line "></div>
                            <div class=" container-package__info-month ">3 tháng</div>
                            <div class=" container-package__info-price ">
                                <div class=" price-new ">
                                    <div class=" before-dot ">199</div>
                                    <div class=" price-dot ">
                                        <div class=" after-dot ">000</div>
                                        <div class=" unit-currency ">VNĐ</div>
                                    </div>
                                </div>
                                <s class=" price-old ">269000 VNĐ</s>
                            </div>
                            <div class=" container-package__voucher ">- Tặng 15 voucher 15%</div>
                            <a class=" container-package__btn " href="${request.contextPath}?idVip=2">Mua VIP</a>
                        </div>
                    </li>
                    <li class=" container-package" style=" background-color: #58d496; ">
                        <div class=" container-package__VIP ">Gói VIP Bạch Kim</div>
                        <div class=" container-package__info ">
                            <div class=" container-package__info-line "></div>
                            <div class=" container-package__info-month ">6 tháng</div>
                            <div class=" container-package__info-price ">
                                <div class=" price-new ">
                                    <div class=" before-dot ">369</div>
                                    <div class=" price-dot ">
                                        <div class=" after-dot ">000</div>
                                        <div class=" unit-currency ">VNĐ</div>
                                    </div>
                                </div>
                                <s class=" price-old ">529000 VNĐ</s>
                            </div>
                            <div class=" container-package__voucher ">- Tặng 30 voucher 20%</div>
                            <a class=" container-package__btn " href="${request.contextPath}?idVip=3">Mua VIP</a>
                        </div>
                    </li>
                    <li class=" container-package" style=" background-color: #b6a0cf; ">
                        <div class=" container-package__VIP ">Gói VIP Kim Cương</div>
                        <div class=" container-package__info ">
                            <div class=" container-package__info-line "></div>
                            <div class=" container-package__info-month ">12 tháng</div>
                            <div class=" container-package__info-price ">
                                <div class=" price-new ">
                                    <div class=" before-dot ">699</div>
                                    <div class=" price-dot ">
                                        <div class=" after-dot ">000</div>
                                        <div class=" unit-currency ">VNĐ</div>
                                    </div>
                                </div>
                                <s class=" price-old ">999000 VNĐ</s>
                            </div>
                            <div class=" container-package__voucher ">- Tặng 60 voucher 25%</div>
                            <a class=" container-package__btn " href="${request.contextPath}?idVip=4">Mua VIP</a>
                        </div>
                    </li>
                </ul>
                <p class=" vip-note ">* Bạn không thể đăng kí gói VIP cho đến khi gói VIP hiện tại hết hạn hoặc dùng hết voucher.</p>
            </div>
        </div>
        <%@include file="/view/layout/footer.jsp" %>
        <script src="../assets/javascript/Home/modal_vip.js"></script>
        <script src="../assets/javascript/jquery/jquery.min.js"></script>

        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
        <script>
            function showToast(type, msg, duplicate) {
                toastr.options.positionClass = 'toast-bottom-right';
                toastr.options.extendedTimeOut = 0; //1000;
                toastr.options.timeOut = 3000;
                toastr.options.hideDuration = 250;
                toastr.options.showDuration = 250;
                toastr.options.hideMethod = 'slideUp';
                toastr.options.showMethod = 'slideDown';
                toastr.options.preventDuplicates = duplicate === 1 ? true : false;
                toastr.options.closeButton = true;
                toastr.options.progressBar = true;
                toastr[type](msg);
            }
        </script>
        <c:if test="${requestScope.updateVip != null}">
            <script>
                showToast('info', "${requestScope.updateVip}");
            </script>
        </c:if>
        <c:if test="${requestScope.payment == true}">
            <script>
                showToast('success', "Mua thành công");
            </script>
        </c:if>
        <c:if test="${requestScope.payment == false}">
            <script>
                showToast('success', "Mua thất bại");
            </script>
        </c:if>
    </body>
    <script src="../assets/javascript/Payment/Payment.js" ></script>

</html>