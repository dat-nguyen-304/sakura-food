<%@page import="com.fptuni.prj301.assignment.model.DiscountFood"%>
<%@page import="com.fptuni.prj301.assignment.dbmanager.DiscountFoodManager"%>
<%@page import="com.fptuni.prj301.assignment.dbmanager.CustomerManager"%>
<%@page import="com.fptuni.prj301.assignment.model.Comment"%>
<%@page import="java.util.List"%>
<%@page import="com.fptuni.prj301.assignment.dbmanager.FoodManager"%>
<%@page import="com.fptuni.prj301.assignment.model.Food"%>
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
        <link rel="stylesheet" href="../assets/css/FoodDetail/FoodDetail.css">
        <link rel="stylesheet" href="../assets/css/header.css">
        <link rel="stylesheet" href="../assets/css/footer.css">
        <link rel="stylesheet" href="../assets/css/modal_vip.css">
    </head>

    <body>
        <%! HttpSession ss;
            UserSession us;
            Food food;
        %>

        <%
            food = (Food) request.getAttribute("food");
            ss = request.getSession();
            us = (UserSession) (UserSession) ss.getAttribute("usersession");
            if (us.getAccessRight().equals("admin")) {
                out.print("<div>Không thể truy cập trang này với tài khoản " + us.getUsername() + "</div>");
                out.print("<a href='" + request.getContextPath() + "/Admin/customer" + "'>Quay về</a>");
                return;
            }
        %>


        <%@include file="/view/layout/header.jsp" %>
        <div class="detail">
            <div class="MuiContainer-root MuiContainer-maxWidthLg">
                <section class="detail__container">
                    <div class="MuiGrid-root MuiGrid-container MuiGrid-spacing-xs-6">
                        <div class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 MuiGrid-grid-md-6">
                            <div class="detail-img">
                                <div class="detail-img__main" style="user-select: none; cursor: crosshair;">
                                    <div style="position: relative;">
                                        <img src='${food.getImgLink()}' style='width: 100%; display: block; cursor: crosshair;' class='img-desciption'>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="MuiGrid-root MuiGrid-item MuiGrid-grid-xs-12 MuiGrid-grid-md-6">
                            <div class="detail-content">


                                <h2 class='detail-content__title'>${food.getName()}</h2>
                                <div class='detail-content__price'>
                                    <strong class='price-default'>${food.getFinalPrice() / 1000}00 VNĐ</strong>
                                    <%
                                        DiscountFoodManager dfm = new DiscountFoodManager();
                                        DiscountFood df = dfm.getByIdFood(food.getId());
                                        if (df != null) {
                                            out.print("<strong class='price-default' style='color: #333; font-weight: 300; font-size: 20px; text-decoration: line-through; padding-left: 32px;'>" + food.getOriginalPrice() / 1000 + ".000 VNĐ</strong>");
                                        }
                                    %>
                                </div>
                                <div class='detail-content__tags'>
                                    <div class='detail-content__tag'>
                                        <span class='detail-content'>
                                            <span class='detail-content__tag-label'>Nhóm đồ ăn:</span>
                                            <%
                                                FoodManager fm = new FoodManager();
                                                int idCategory = food.getIdCategory();
                                                String nameCategory = fm.getNameCategory(idCategory);
                                                out.print("<span class='detail-content__tag-detail category'>" + nameCategory + "</span>");
                                            %>

                                        </span>
                                        <span style='margin-left: 20px;' class='ordered-info'>
                                            <span class='detail-content__ordered detail-content__tag-label'>Đã bán: </span>
                                            <span class='detail-content__ordered-amount'>${food.getQuantitySold()}</span>
                                        </span>
                                    </div>
                                </div>




                                <div class="detail-content__btns">
                                    <div class="detail-content__add">
                                        <button class="MuiButtonBase-root MuiButton-root MuiButton-text primary-btn red"
                                                tabindex="0" type="button">
                                            <span class="MuiButton-label">
                                                <c:url var="payLink" value="/Food/detail">
                                                    <c:param name="idAddedFood" value="${food.getId()}" />
                                                    <c:param name="id" value="${food.getId()}" />
                                                </c:url>
                                                <a style="color: #fff;" href="${payLink}" >Thêm vào giỏ hàng</a>
                                            </span>
                                            <span class="MuiTouchRipple-root"></span>
                                        </button>
                                    </div>
                                    <div class="detail-content__add buy-now">
                                        <button class="MuiButtonBase-root MuiButton-root MuiButton-text primary-btn red"
                                                tabindex="0" type="button">
                                            <span class="MuiButton-label">
                                                <c:url var="payLink" value="/Pay/pay">
                                                    <c:param name="buynowId" value="${food.getId()}" />
                                                </c:url>
                                                <a href="${payLink}" class="MuiButton-link-to-payment"> Mua hàng ngay </a>

                                            </span>
                                            <span class="MuiTouchRipple-root"></span>
                                        </button>
                                    </div>
                                </div>

                                <div class="detail-tab__btns">
                                    <div class="detail-tab__btn"><span>Mô tả</span></div>
                                    <div class="detail-tab__btn-background" style="left: -10px; width: 141px;"></div>
                                </div>
                                <div class="detail-tab__content">
                                    <p class='detail-tab__content-description'>${food.getDescription()}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <div class="detail-tab">
                    <div class="detail-tab__btns">
                        <div class="detail-tab__btn"><span>Bình luận</span></div>
                        <div class="detail-tab__btn-background" style="left: 6px; width: 141px;"></div>
                    </div>
                    <div class="detail-tab__content">
                        <div class="detail-tab__list">
                            <%
                                List<Comment> commentList = (List<Comment>) request.getAttribute("commentList");
                                CustomerManager cm = new CustomerManager();
                                for (Comment comment : commentList) {
                                    String username = cm.getNameById(comment.getIdCustomer());
                                    out.print("<div class='detail-tab__item'>");
                                    out.print("<div class='detail-tab__user'>" + username + "</div>");
                                    out.print("<div class='detail-tab__date'>" + comment.getDate() + "</div>");
                                    out.print("<p class='detail-tab__description'>" + comment.getContent() + "</p>");
                                    out.print("</div>");
                                }
                            %>
                        </div>
                    </div>
                    <div class="comment-section">
                        <form action="${request.contextPath}">
                            <input type="hidden" name="id" value="${food.getId()}"/>
                            <textarea class="comment-content" name="addComment" cols="150" rows="5"></textarea>
                            <button class="comment-submit" type="submit">Bình luận</button>
                        </form>
                    </div>
                </div>

                <div class="detail-products">
                    <div class="detail-products__title">Sản phẩm liên quan</div>
                    <ul class="food-list row">
                        <c:set var="relatedList" value="${requestScope.relatedList}" />
                        <c:forEach items="${relatedList}" var="food">
                            <li class='col l-2-4'>
                                <a href='detail?id=${food.getId()}' class='food-item'>
                                    <div class='food-item__img'>
                                        <img src='${food.getImgLink()}' alt=''>
                                    </div>
                                    <div class='food-item__info'>
                                        <div class='food-item__name'>${food.getName()}</div>
                                        <div class='food-item__desc'>${food.getDescription()}</div>
                                        <div class='food-item__price'>${food.getFinalPrice() / 1000}00 VNĐ</div>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>

                    </ul>
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
                                <a class="container-package__btn " href="${request.contextPath}?idVip=1&id=${food.getId()}">Mua VIP</a>
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
                                <a class=" container-package__btn " href="${request.contextPath}?idVip=2&id=${food.getId()}">Mua VIP</a>
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
                                <a class=" container-package__btn " href="${request.contextPath}?idVip=3&id=${food.getId()}">Mua VIP</a>
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
                                <a class=" container-package__btn " href="${request.contextPath}?idVip=4&id=${food.getId()}">Mua VIP</a>
                            </div>
                        </li>
                    </ul>
                    <p class=" vip-note ">* Bạn không thể đăng kí gói VIP cho đến khi gói VIP hiện tại hết hạn hoặc dùng hết voucher.</p>
                </div>

                </ul>
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
        <c:if test="${requestScope.added != null}">
            <script>
                showToast('success', "Thêm thành công");
            </script>
        </c:if>
    </body>
    <script src="../assets/javascript/FoodDetail/FoodDetail.js"></script>

</html>