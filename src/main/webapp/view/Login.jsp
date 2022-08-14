<%-- 
    Document   : Login
    Created on : Mar 3, 2022, 6:25:10 PM
    Author     : Admin
--%>

<%@page import="com.fptuni.prj301.assignment.dbmanager.CustomerManager"%>
<%@page import="com.fptuni.prj301.assignment.dbmanager.FoodManager"%>
<%@page import="com.fptuni.prj301.assignment.model.Comment"%>
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
        <title>Đăng nhập</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
        <link rel="stylesheet" href="../assets/css/grid.css">
        <link rel="stylesheet" href="../assets/css/base.css">
        <link rel="stylesheet" href="../assets/css/Home/index.css">
        <link rel="stylesheet" href="../assets/css/Home/responsive.css">
        <link rel="stylesheet" href="../assets/css/header.css">
        <link rel="stylesheet" href="../assets/css/footer.css">
    </head>

    <body>
        <%!
            boolean signupSuccess;
            String signupErrorMess;
        %>
        <%

            if (request.getAttribute("signupSuccess") != null) {
                signupSuccess = (boolean) request.getAttribute("signupSuccess");
                if (signupSuccess) {
                    out.print("<script>alert(\"Đăng kí thành công\")</script>");
                } else {
                    signupErrorMess = (String) request.getAttribute("signupErrorMess");
                    out.print("<script>alert(\"Đăng kí thất bại. " + signupErrorMess + "\")</script>");
                }
            }

        %>
        <%@include file="/view/layout/header.jsp" %>
        <div class="container">

            <div class="slider">
                <%! List<DiscountFood> list; %>
                <% list = (List<DiscountFood>) request.getAttribute("discountList"); 
                %>
                
                <ul class="slider-dots">
                    <%
                        out.print("<li class='slider-dot-item active' data-index='0'></li>");
                        for (int i = 1; i < list.size(); i++) {
                            out.print("<li class='slider-dot-item' data-index='" + i + "'></li>");
                        }
                        %>
                </ul>
                <i class="fa fa-angle-left slider-prev"></i>
                <div class="slider-wrapper">
                    <div class="slider-main">
                        
                        <%         
                            if (list != null) {
                                for (DiscountFood food : list) {
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
                                out.print("<img src='" + list.get(i).getLink() + "' alt='' />");
                                out.print("<div class='slider__info'>");
                                out.print("<div style='display: inline-block; margin-right: 30px;' class='slider-price'>Giá cũ <span class='slider-old-price'>" + list.get(i).getOriginPrice() / 1000 + ".000 VNĐ</span></div>");
                                out.print("<div style='display: inline-block' class='slider-price'><span class='slider-sale'>-" + list.get(i).getDiscountPercent() + "%</span></div>");
                                out.print("<div class='slider-price'>Chỉ còn <span class='slider-new-price'>" + list.get(i).getFinalPrice() / 1000 + ".000 <span style='font-size: 28px;'> VNĐ</span></span></div>");
                                out.print("<div class='slider-name'>" + list.get(i).getName() + "</div>");
                                out.print("<a href='" + request.getContextPath() + "/Food/detail?id=" + list.get(i).getIdFood() + "' class='slider-button' type='submit'>MUA NGAY</a>");
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
                        <div class="category-item-container">
                            <div class="category-item-img">
                                <img style="width: 100px;" src="../assets/images/chicken.png" alt="">
                            </div>
                        </div>
                        <h4 class="category-item-title">Gà</h3>
                    </li>
                    <li class="category__item">
                        <div class="category-item-container">
                            <div class="category-item-img">
                                <img src="../assets/images/burger.33e152d0.svg" alt="">
                            </div>
                        </div>
                        <h4 class="category-item-title">Hamburger</h3>
                    </li>
                    <li class="category__item">
                        <div class="category-item-container">
                            <div class="category-item-img">
                                <img style="width: 100px;" src="../assets/images/banh-mi-logo.png" alt="">
                            </div>
                        </div>
                        <h4 class="category-item-title">Bánh mì</h3>
                    </li>
                    <li class="category__item">
                        <div class="category-item-container">
                            <div class="category-item-img">
                                <img src="../assets/images/tea.591a2362.svg" alt="">
                            </div>
                        </div>
                        <h4 class="category-item-title">Trà</h3>
                    </li>
                    <li class="category__item">
                        <div class="category-item-container">
                            <div class="category-item-img">
                                <img src="../assets/images/coffee.06d317df.svg" alt="">
                            </div>
                        </div>
                        <h4 class="category-item-title">Cà phê</h3>
                    </li>
                    <li class="category__item">
                        <div class="category-item-container">
                            <div class="category-item-img">
                                <img style="width: 100px;" src="../assets/images/tra-sua.png" alt="">
                            </div>
                        </div>
                        <h4 class="category-item-title">Trà sữa</h3>
                    </li>
                </ul>
            </div>
            <div class="statictis">
                <div class="statictis-container">
                    <ul class="statistic__list">
                        <li class="statictis-item">
                            <div class="statistic-item__num">1000</div>
                            <div class="statistic-item__text">Ổ bánh mì</div>
                        </li>
                        <li class="statictis-item">
                            <div class="statistic-item__num">400</div>
                            <div class="statistic-item__text">Tách cà phê</div>
                        </li>
                        <li class="statictis-item">
                            <div class="statistic-item__num">2000</div>
                            <div class="statistic-item__text">Khách hàng</div>
                        </li>
                        <li class="statictis-item">
                            <div class="statistic-item__num">200</div>
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
                            FoodManager fm = new FoodManager();
                            String imgFood = fm.getById(comment.getIdFood()).getImgLink();
                            CustomerManager cm = new CustomerManager();
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
        <div class="modal-signin" style="display: flex">
            <div class="form">
                <ul class="tab-group">
                    <li class="tab active"><a href="#login">Đăng nhập</a></li>
                    <li class="tab"><a href="#signup">Đăng ký</a></li>
                </ul>

                <div class="tab-content">


                    <div id="login">
                        <h1>Chào mừng trở lại!</h1>
                        <%
                            out.print("<form action='" + request.getContextPath() + "/Access/login" + "' method='post'>");
                        %>
                        <div class="field-wrap">
                            <label>
                                Tên đăng nhập<span class="req">*</span>
                            </label>
                            <input type="text" name="username" required autocomplete="off" />
                        </div>

                        <div class="field-wrap">

                            <label>
                                Mật khẩu<span class="req">*</span>
                            </label>
                            <input type="password" name="password" required autocomplete="off" />
                        </div>
                        <%
                            if (request.getAttribute("signinSuccess") != null) {
                                out.print("<div class='signin-error'>Sai tên đăng nhập hoặc mật khẩu</div>");
                            }

                        %>
                        <button type="submit" class="button button-block">Đăng nhập</button>

                        </form>

                    </div>

                    <div id="signup">
                        <h1>Đăng ký miễn phí</h1>

                        <%                            out.print("<form action='" + request.getContextPath() + "/Access/login" + "' method='post'>");
                        %>

                        <div class="top-row">
                            <div class="field-wrap">
                                <label>
                                    Tên đăng nhập<span class="req">*</span>
                                </label>
                                <input type="text" name="username_signup" required autocomplete="off" />
                            </div>

                            <div class="field-wrap">
                                <label>
                                    Mật khẩu<span class="req">*</span>
                                </label>
                                <input type="password" name="password_signup" required autocomplete="off" />
                            </div>
                        </div>

                        <div class="field-wrap">
                            <label>
                                Email<span class="req">*</span>
                            </label>
                            <input type="email" name="email_signup" required autocomplete="off" />
                        </div>

                        <div class="field-wrap">
                            <label>
                                Số điện thoại<span class="req">*</span>
                            </label>
                            <input type="text" name="phone_signup" required autocomplete="off" />
                        </div>
                        <%
                            if (request.getAttribute("signupSuccess") != null) {
                                signupSuccess = (boolean) request.getAttribute("signupSuccess");
                                if (!signupSuccess) {
                                    signupErrorMess = (String) request.getAttribute("signupErrorMess");
                                    out.print("<div class='signup-error'>" + signupErrorMess + "</div>");
                                }
                            }

                        %>
                        <button type="submit" class="button button-block" />Đăng ký</button>

                        </form>

                    </div>
                </div>

            </div>
        </div>


        <%@include file="/view/layout/footer.jsp" %>

        <script src="../assets/javascript/Home/slider.js"></script>
        <script src="../assets/javascript/Home/review.js"></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script src="../assets/javascript/Home/login.js"></script>
        <script src="../assets/javascript/Home/modal.js"></script>
    </body>

</html>