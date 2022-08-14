<%@page import="com.fptuni.prj301.assignment.dbmanager.DiscountFoodManager"%>
<%@page import="com.fptuni.prj301.assignment.model.DiscountFood"%>
<%@page import="com.fptuni.prj301.assignment.model.Food"%>
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
        <link rel="stylesheet" href="../assets/css/FoodList/main.css">
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

        <%
            if (request.getAttribute("updateVip") != null) {
                out.print("<script>alert('" + request.getAttribute("updateVip") + "')</script>");
            }
        %>
        <%@include file="/view/layout/header.jsp" %>
        <div class="container">

            <div class="grid wide">
                <div class="row">
                    <div class="col l-2">
                        <div class="category">
                            <ul class="category__list">
                                <li class="category__title">
                                    <a href="./list">Tất cả</a>
                                </li>
                                <li>
                                    <a class="category__item" href="./list?idCate=2">
                                        <img src="../assets/images/chicken.png" alt="">
                                        <span>Gà</span>
                                    </a>

                                </li>
                                <li>
                                    <a class="category__item" href="./list?idCate=1">
                                        <img src="../assets/images/burger.33e152d0.svg" alt="">
                                        <span>Hamburger</span>
                                    </a>

                                </li>
                                <li>
                                    <a class="category__item" href="./list?idCate=3">
                                        <img src="../assets/images/banh-mi-logo.png" alt="">
                                        <span>Bánh mì</span>
                                    </a>

                                </li>
                                <li>
                                    <a class="category__item" href="./list?idCate=5">
                                        <img src="../assets/images/tea.591a2362.svg" alt="">
                                        <span>Trà</span>
                                    </a>

                                </li>
                                <li>
                                    <a class="category__item" href="./list?idCate=4">
                                        <img src="../assets/images/coffee.06d317df.svg" alt="">
                                        <span>Cà phê</span>
                                    </a>
                                </li>
                                <li>
                                    <a class="category__item" href="./list?idCate=6">
                                        <img src="../assets/images/tra-sua.png" alt="">
                                        <span>Trà sữa</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col l-10">
                        <div class="content">
                            <div class="search-bar">
                                <form action="./list" class="search-bar__input">
                                    <input name="keyword" type="text" placeholder="Nhập tên sản phẩm ...">
                                    <button class="search-bar__submit"  type="submit">Tìm kiếm</button>
                                </form>
                                <div class="search-bar__sort">
                                    Sắp xếp theo
                                    <ul class="search-bar-sort-list">
                                        <li class="search-bar-sort-item">
                                            <c:if test="${requestScope.keyword != null}">
                                                <a href="./list?keyword=${requestScope.keyword}&sortByPrice=ASC">Giá: Tăng dần</a>
                                            </c:if>
                                            <c:if test="${requestScope.idCate != null}">
                                                <a href="./list?idCate=${requestScope.idCate}&sortByPrice=ASC">Giá: Tăng dần</a>
                                            </c:if>
                                            <c:if test="${requestScope.keyword == null && requestScope.idCate == null}">
                                                <a href="./list?sortByPrice=ASC">Giá: Tăng dần</a>
                                            </c:if>

                                        </li>
                                        <li class="search-bar-sort-item">
                                            <c:if test="${requestScope.keyword != null}">
                                                <a href="./list?keyword=${requestScope.keyword}&sortByPrice=DESC">Giá: Giảm dần</a>
                                            </c:if>
                                            <c:if test="${requestScope.idCate != null}">
                                                <a href="./list?idCate=${requestScope.idCate}&sortByPrice=DESC">Giá: Giảm dần</a>
                                            </c:if>
                                            <c:if test="${requestScope.keyword == null && requestScope.idCate == null}">
                                                <a href="./list?sortByPrice=DESC">Giá: Giảm dần</a>
                                            </c:if>
                                        </li>
                                        <li class="search-bar-sort-item">
                                            <c:if test="${requestScope.keyword != null}">
                                                <a href="./list?keyword=${requestScope.keyword}&sortBySoldQuantity=ASC">Bán chạy: Tăng dần</a>
                                            </c:if>
                                            <c:if test="${requestScope.idCate != null}">
                                                <a href="./list?idCate=${requestScope.idCate}&sortBySoldQuantity=ASC">Bán chạy: Tăng dần</a>
                                            </c:if>
                                            <c:if test="${requestScope.keyword == null && requestScope.idCate == null}">
                                                <a href="./list?sortBySoldQuantity=ASC">Bán chạy: Tăng dần</a>
                                            </c:if>
                                        </li>
                                        <li class="search-bar-sort-item">
                                            <c:if test="${requestScope.keyword != null}">
                                                <a href="./list?keyword=${requestScope.keyword}&sortBySoldQuantity=DESC">Bán chạy: Giảm dần</a>
                                            </c:if>
                                            <c:if test="${requestScope.idCate != null}">
                                                <a href="./list?idCate=${requestScope.idCate}&sortBySoldQuantity=DESC">Bán chạy: Giảm dần</a>
                                            </c:if>
                                            <c:if test="${requestScope.keyword == null && requestScope.idCate == null}">
                                                <a href="./list?sortBySoldQuantity=DESC">Bán chạy: Giảm dần</a>
                                            </c:if>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <ul class="food-list row">
                                <%
                                    List<Food> listFood = (List<Food>) request.getAttribute("listFood");

                                    for (Food food : listFood) {
                                        DiscountFoodManager dfm = new DiscountFoodManager();
                                        DiscountFood df = dfm.getByIdFood(food.getId());
                                        out.print("<li class='col l-3'>");
                                        out.print("<a href='detail?id=" + food.getId() + "' class='food-item'>");

                                        out.print("<div class='food-item__img'>");
                                        out.print("<img src='" + food.getImgLink() + "' alt=''>");
                                        out.print("</div>");
                                        out.print("<div class='food-item__info'>");
                                        out.print("<div class='food-item__name'>" + food.getName() + "</div>");
                                        out.print("<div class='food-item__desc'>" + food.getDescription() + "</div>");
                                        out.print("<span class='food-item__price'>" + food.getFinalPrice() / 1000 + ".000 VNĐ</span>");
                                        if (df != null) {
                                            out.print("<span class='food-item__price'> - </span>");
                                            out.print("<span class='food-item__price' style='font-size: 16px; padding: 6px 6px 0 12px; text-decoration: line-through;'>" + food.getOriginalPrice() / 1000 + ".000</span>");
                                        }
                                        out.print("</div>");
                                        if (df != null) {
                                            out.print("<div class='food-item-sale-off'>");
                                            out.print("<div class='food-item-sale-off__value'>" + df.getDiscountPercent() + "%</div>");
                                            out.print("<div class='food-item-sale-off__text'>Giảm</div>");
                                            out.print("</div>");
                                        }

                                        out.print("</a>");
                                        out.print("</li>");
                                    }

                                %>

                            </ul>
                            <div class="pagination">
                            </div>
                        </div>
                    </div>
                </div>
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
                            <a class=" container-package__btn " href="${request.contextPath}?idVip=3 ">Mua VIP</a>
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
    </body>

</html>