<%-- 
    Document   : Home
    Created on : Mar 3, 2022, 6:25:19 PM
    Author     : Admin
--%>
<%@page import="com.fptuni.prj301.assignment.dbmanager.OrderManager"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.fptuni.prj301.assignment.dbmanager.CustomerManager"%>
<%@page import="com.fptuni.prj301.assignment.dbmanager.FoodManager"%>
<%@page import="com.fptuni.prj301.assignment.model.Comment"%>
<%@page import="com.fptuni.prj301.assignment.model.Food"%>
<%@page import="com.fptuni.prj301.assignment.model.DiscountFood"%>
<%@page import="java.util.List"%>
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
        <link rel="stylesheet" href="../assets/css/grid.css">
        <link rel="stylesheet" href="../assets/css/base.css">
        <link rel="stylesheet" href="../assets/css/modal_vip.css">
        <link rel="stylesheet" href="../assets/css/Home/index.css">
        <link rel="stylesheet" href="../assets/css/Home/responsive.css">
        <link rel="stylesheet" href="../assets/css/header.css">
        <link rel="stylesheet" href="../assets/css/footer.css">

    </head>

    <body>
        <%! HttpSession ss;
            UserSession us;
        %>
        <%
            ss = request.getSession();
            us = (UserSession) ss.getAttribute("usersession");
            if (us.getAccessRight().equals("admin")) {
                out.print("<div>Không thể truy cập trang này với tài khoản " + us.getUsername() + "</div>");
                out.print("<a href='" + request.getContextPath() + "/Admin/customer" + "'>Quay về</a>");
                return;
            }
        %>
        <%
            if (request.getAttribute("updateVip") != null) {
                out.print("<script>alert('" + request.getAttribute("updateVip") + "')</script>");
            }
        %>
        <%@include file="/view/layout/header.jsp" %>
        <div class="container">
            <div class="slider">
                <%! List<DiscountFood> discountList; %>
                <% discountList = (List<DiscountFood>) request.getAttribute("discountList");
                %>

                <ul class="slider-dots">
                    <%
                        out.print("<li class='slider-dot-item active' data-index='0'></li>");
                        for (int i = 1; i < discountList.size(); i++) {
                            out.print("<li class='slider-dot-item' data-index='" + i + "'></li>");
                        }
                    %>
                </ul>
                <i class="fa fa-angle-left slider-prev"></i>
                <div class="slider-wrapper">
                    <div class="slider-main">

                        <%
                            if (discountList != null) {
                                for (DiscountFood food : discountList) {
                                    out.print("<div class='slider-item'>");
                                    out.print("<img src='" + food.getLink() + "' alt='' />");
                                    out.print("<div class='slider__info'> ");
                                    out.print("<div style='display: inline-block; margin-right: 30px;' class='slider-price'>Giá cũ <span class='slider-old-price'>" + food.getOriginPrice() / 1000 + ".000  VNĐ</span></div>");
                                    out.print("<div style='display: inline-block' class='slider-price'><span class='slider-sale'>-" + food.getDiscountPercent() + "%</span></div>");
                                    out.print("<div class='slider-price'>Chỉ còn <span class='slider-new-price'>" + food.getFinalPrice() / 1000 + ".000 <span style='font-size: 28px;'> VNĐ</span></span></div>");
                                    out.print("<div class='slider-name'>" + food.getName() + "</div>");
                                    out.print("<a href='" + request.getContextPath() + "/Food/detail?id=" + food.getIdFood() + "' class='slider-button' type='submit'>MUA NGAY</a>");
                                    out.print("</div>");
                                    out.print("</div>");
                                }
                            }
                        %>


                        <!-- 2 slides xử lí hiệu ứng -->
                        <%
                            for (int i = 0; i < 2; i++) {
                                out.print("<div class='slider-item'>");
                                out.print("<img src='" + discountList.get(i).getLink() + "' alt='' />");
                                out.print("<div class='slider__info'>");
                                out.print("<div style='display: inline-block; margin-right: 30px;' class='slider-price'>Giá cũ <span class='slider-old-price'>" + discountList.get(i).getOriginPrice() / 1000 + ".000 VNĐ</span></div>");
                                out.print("<div style='display: inline-block' class='slider-price'><span class='slider-sale'>-" + discountList.get(i).getDiscountPercent() + "%</span></div>");
                                out.print("<div class='slider-price'>Chỉ còn <span class='slider-new-price'>" + discountList.get(i).getFinalPrice() / 1000 + ".000 <span style='font-size: 28px;'> VNĐ</span></span></div>");
                                out.print("<div class='slider-name'>" + discountList.get(i).getName() + "</div>");
                                out.print("<a href='" + request.getContextPath() + "/Food/detail?id=" + discountList.get(i).getIdFood() + "' class='slider-button' type='submit'>MUA NGAY</a>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                        %>

                    </div>
                </div>
                <i class="fa fa-angle-right slider-next"></i>
            </div>
            <div class="category">
                <h3 class="category__title">Bạn cần gì</h3>
                <ul class="category__list">
                    <li class="category__item">
                        <a href="${pageContext.request.contextPath}/Food/list?idCate=2" class="category-item-container">
                            <div class="category-item-img">
                                <img style="width: 100px;" src="../assets/images/chicken.png" alt="">
                            </div>
                        </a>
                        <h4 class="category-item-title">Gà</h3>
                    </li>
                    <li class="category__item">
                        <a href="${pageContext.request.contextPath}/Food/list?idCate=1" class="category-item-container">
                            <div class="category-item-img">
                                <img src="../assets/images/burger.33e152d0.svg" alt="">
                            </div>
                        </a>
                        <h4 class="category-item-title">Hamburger</h3>
                    </li>
                    <li class="category__item">
                        <a href="${pageContext.request.contextPath}/Food/list?idCate=3" class="category-item-container">
                            <div class="category-item-img">
                                <img style="width: 100px;" src="../assets/images/banh-mi-logo.png" alt="">
                            </div>
                        </a>
                        <h4 class="category-item-title">Bánh mì</h3>
                    </li>
                    <li class="category__item">
                        <a href="${pageContext.request.contextPath}/Food/list?idCate=5" class="category-item-container">
                            <div class="category-item-img">
                                <img src="../assets/images/tea.591a2362.svg" alt="">
                            </div>
                        </a>
                        <h4 class="category-item-title">Trà</h3>
                    </li>
                    <li class="category__item">
                        <a href="${pageContext.request.contextPath}/Food/list?idCate=4" class="category-item-container">
                            <div class="category-item-img">
                                <img src="../assets/images/coffee.06d317df.svg" alt="">
                            </div>
                        </a>
                        <h4 class="category-item-title">Cà phê</h3>
                    </li>
                    <li class="category__item">
                        <a href="${pageContext.request.contextPath}/Food/list?idCate=6" class="category-item-container">
                            <div class="category-item-img">
                                <img style="width: 100px;" src="../assets/images/tra-sua.png" alt="">
                            </div>
                        </a>
                        <h4 class="category-item-title">Trà sữa</h3>
                    </li>
                </ul>
            </div>
            <div class="statictis">
                <div class="statictis-container">
                    <ul class="statistic__list">
                        <li class="statictis-item">
                            <%
                                FoodManager fm = new FoodManager();
                                int breadQuantity = fm.getBreadQuantity();
                                out.print("<div class='statistic-item__num'>" + breadQuantity + "</div>");
                            %>
                            <div class="statistic-item__text">Ổ bánh mì</div>
                        </li>
                        <li class="statictis-item">
                            <%
                                fm = new FoodManager();
                                int coffeeQuantity = fm.getCoffeeQuantity();
                                out.print("<div class='statistic-item__num'>" + coffeeQuantity + "</div>");
                            %>
                            <div class="statistic-item__text">Tách cà phê</div>
                        </li>
                        <li class="statictis-item">
                            <%
                                CustomerManager cm = new CustomerManager();
                                int customerQuantity = cm.getUserQuantity();
                                out.print("<div class='statistic-item__num'>" + customerQuantity + "</div>");
                            %>
                            <div class="statistic-item__text">Khách hàng</div>
                        </li>
                        <li class="statictis-item">
                            <%
                                OrderManager om = new OrderManager();
                                int orderQuantity = om.getOrderQuantity();
                                out.print("<div class='statistic-item__num'>" + orderQuantity + "</div>");
                            %>
                            <div class="statistic-item__text">Tổng đơn hàng</div>
                        </li>

                    </ul>
                </div>
            </div>
            <div class="review">
                <%! List<Comment> commentList;%>
                <%                    commentList = (List<Comment>) request.getAttribute("commentList");
                    if (commentList != null) {

                        for (Comment comment : commentList) {
                            fm = new FoodManager();
                            String imgFood = fm.getById(comment.getIdFood()).getImgLink();
                            cm = new CustomerManager();
                            String username = cm.getById(comment.getIdCustomer()).getUsername();
                            out.print("<div class='review__item'>");
                            out.print("<div class='review__img'>");
                            out.print("<img src='" + imgFood + "' alt=''>");
                            out.print("</div>");
                            out.print("<div class='review__name'>" + username + "</div>");
                            out.print("<div class='review__comment'>");
                            out.print(comment.getContent());
                            out.print("</div>");
                            out.print("</div>");
                        }
                    }
                %>

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
        <script src="../assets/javascript/Home/slider.js"></script>
        <script src="../assets/javascript/Home/review.js"></script>
        <script src="../assets/javascript/Home/modal_vip.js"></script>
    </body>

</html>
