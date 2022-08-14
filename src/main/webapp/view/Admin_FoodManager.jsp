<%@page import="com.fptuni.prj301.assignment.model.UserSession"%>
<%@page import="com.fptuni.prj301.assignment.model.Food"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý sản phẩm</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
        <link rel="stylesheet" href="../assets/css/grid.css">
        <link rel="stylesheet" href="../assets/css/base.css">
        <link rel="stylesheet" href="../assets/css/Admin/qlsp.css">
    </head>

    <body>
        <%! HttpSession ss;
            UserSession us;%>
        <%
            ss = request.getSession();
            us = (UserSession) (UserSession) ss.getAttribute("usersession");
            if (us.getAccessRight().equals("user")) {
                out.print("<div>Không thể truy cập trang này với tài khoản " + us.getUsername() + "</div>");
                out.print("<a href='" + request.getContextPath() + "/Home/home" + "'>Quay về</a>");
                return;
            }
        %>
        <div id="main">   
            <div class="admin">
                <%
                    out.print("<span class='admin__name'>" + us.getUsername() + "</span>");
                    out.print("<a href='" + request.getContextPath() + "/Access/logout" + "' class='admin__logout'>");
                %>
                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                </a>
            </div>
            <!-- category -->
            <div id="category">
                <ul id="category_details">
                    <%
                        out.print("<li class='category__item'><a href='" + request.getContextPath() + "/Admin/customer" + "'>");
                    %>
                    <h3>THÔNG TIN KHÁCH HÀNG</h3>
                    </a></li>
                    <%
                        out.print("<li class='category__item'><a href='" + request.getContextPath() + "/Admin/order" + "'>");
                    %>
                    <h3>THÔNG TIN ĐƠN HÀNG</h3>
                    </a></li>
                    <%
                        out.print("<li class='category__item'><a href='" + request.getContextPath() + "/Admin/food" + "'>");
                    %>
                    <h3>QUẢN LÝ SẢN PHẨM</h3>
                    </a></li>
                    <%
                        out.print("<li class='category__item'><a href='" + request.getContextPath() + "/Admin/discount" + "'>");
                    %>
                    <h3>QUẢN LÝ SẢN PHẨM GIẢM GIÁ</h3>
                    </a></li>
                </ul>
            </div>
            <h1 class="title-page"  style="text-align:center; text-transform: uppercase;">Quản lí sản phẩm </h1>
            <div class="dropdown-choice">
                <c:url var="Cate" value="${request.contextPath}/Admin/food"/>
                <form action="${Cate}" method="POST">
                    <select name="idCate" class="dropdown-select">
                        <option selected disabled>Phân Loại</option>
                        <option value="0">Tất cả</option>
                        <option value="1">Hamburger</option>
                        <option value="2">Gà</option>
                        <option value="3">Bánh mì</option>
                        <option value="4">Cà phê</option>
                        <option value="5">Trà</option>
                        <option value="6">Trà sữa</option>
                    </select>
                    <button ztype="submit" name="idCate" value="0" style="background-color:white;border-radius:10px; padding:10px ;    position: absolute;
                            width: 100px;
                            margin-left: 10px;    border: 1px solid black;"> Tìm Kiếm </button>
                </form>
            </div>

            <div class="container">
                <!-- Button Thêm -->
                <button id="myBtn">
                    <h3 class="add-heading" style="    padding: 10px;
                        border-radius: 10px;
                        border: 1px solid black;">Thêm sản phẩm</h3>
                </button>
                <!-- The Modal -->
                <div id="myModal" class="modal">
                    <!-- Nội dung form đăng nhập -->
                    <div class="modal-content">
                        <c:url var="Insert" value="${request.contextPath}/Admin/food"/>
                        <form action="${Insert}" class="form-for-add" method="POST">
                            <span class="close">&times;</span>
                            <h2 style="color:green;background-color:white;border-radius:10px; padding:10px ;">Thêm Món Ăn</h2>
                            <div class="fomrgroup">
                                <div class="dropdown-choice-1 ">
                                    <select name="id" class="dropdown-select">
                                        <option selected disabled>Phân Loại</option>
                                        <option value="1">Hamburger</option>
                                        <option value="2">Gà</option>
                                        <option value="3">Bánh mì</option>
                                        <option value="4">Cà phê</option>
                                        <option value="5">Trà</option>
                                        <option value="6">Trà sữa</option>
                                    </select>
                                </div>
                            </div>
                            <div class="fomrgroup">
                                <b style="width: 150px">Tên sản phẩm:</b>
                                <input type="text" name="name" value="">
                            </div>
                            <div class="fomrgroup">
                                <b style="width: 150px">Link hình ảnh:</b>
                                <input type="text" name="link" value="">
                            </div>
                            <div class="fomrgroup">
                                <b style="width: 150px">Giá gốc:</b>
                                <input type="text" name="price" value="">
                            </div>
                            <div class="fomrgroup">
                                <b style="width: 150px">Thông tin chi tiết:</b>
                                <input type="text" name="infomation" value="">
                            </div>
                            <input type="hidden" name="price"  value="">
                            <div class="fomrgroup btn-submit">
                                <button type="submit" name="idInsert" value="Insert"> Thêm </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div id="info">
                <table class="table-item" border="1">
                    <thead>
                        <tr style="height: 50px;">
                            <th>
                                <div class="dropdown">
                                    ID
                                </div>
                            </th>
                            <th>Tên thức ăn

                            </th>
                            <th>Mô tả

                            </th>
                            <th class="arrow">

                                <div class="dropdown"> 
                                    <c:if test="${requestScope.idCate != null}">
                                        <a href="?idCate=${requestScope.idCate}&sortByPrice=default">Giá gốc </a>
                                    </c:if>
                                    <c:if test="${requestScope.idCate == null}">
                                        <a href="?sortByPrice=default">Giá gốc </a>
                                    </c:if>
                                    <div class="btn-dropdown">
                                        <div class="nut_dropdown-price">
                                            <i class="fa-solid fa-chevron-down"></i>
                                            <div class="contents-amount">
                                                <div class="noidung_dropdown">
                                                    <div class="amount-link">
                                                        <c:if test="${requestScope.idCate != null}">
                                                            <a href="?idCate=${requestScope.idCate}&sortByPrice=ASC">Tăng dần</a>
                                                        </c:if>
                                                        <c:if test="${requestScope.idCate == null}">
                                                            <a href="?sortByPrice=ASC">Tăng dần</a>
                                                        </c:if>  
                                                    </div>


                                                    <div class="amount-link">
                                                        <c:if test="${requestScope.idCate != null}">
                                                            <a href="?idCate=${requestScope.idCate}&sortByPrice=DESC">Giảm dần</a>
                                                        </c:if>
                                                        <c:if test="${requestScope.idCate == null}">
                                                            <a href="?sortByPrice=DESC">Giảm dần</a>
                                                        </c:if>  
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </th>
                            <th>Phân loại</th>
                            <th class="arrow">
                                <div class="dropdown"> 
                                    <c:if test="${requestScope.idCate != null}">
                                        <a href="?idCate=${requestScope.idCate}&sortBySoldQuantity=default">Số lượng đã bán </a>
                                    </c:if>
                                    <c:if test="${requestScope.idCate == null}">
                                        <a href="?sortBySoldQuantity=default">Số lượng đã bán </a>
                                    </c:if>
                                    <div class="btn-dropdown">
                                        <div class="nut_dropdown-amount">
                                            <i class="fa-solid fa-chevron-down dropdown-icon"></i>
                                            <div class="contents-amount">
                                                <div class="noidung_dropdown-amount">
                                                    <div class="amount-link">
                                                        <c:if test="${requestScope.idCate != null}">
                                                            <a href="?idCate=${requestScope.idCate}&sortBySoldQuantity=ASC">Tăng dần</a>
                                                        </c:if>
                                                        <c:if test="${requestScope.idCate == null}">
                                                            <a href="?sortBySoldQuantity=ASC">Tăng dần</a>
                                                        </c:if>  
                                                    </div>


                                                    <div class="amount-link">
                                                        <c:if test="${requestScope.idCate != null}">
                                                            <a href="?idCate=${requestScope.idCate}&sortBySoldQuantity=DESC">Giảm dần</a>
                                                        </c:if>
                                                        <c:if test="${requestScope.idCate == null}">
                                                            <a href="?sortBySoldQuantity=DESC">Giảm dần</a>
                                                        </c:if> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </th>

                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="food" items="${listFood}">
                            <tr class="table__row table-body">
                                <th>${food.id}</th>
                                <th class="name_food">${food.name}</th>
                                <th class="description-food">${food.description}</th>
                                <th class="sale-product">${food.originalPrice / 1000}00 VNĐ</th>
                                <th>${food.idCategory}</th>
                                <th>${food.quantitySold}</th>
                                <th>
                                    <div class="btn-action">
                                        <button id="myBtn" class="btn-edit-action btn-repair">Sửa</button>
                                        <div id="myModal" class=" modal-form" >
                                            <div class="modal-content-1">
                                                <div class="modal-header">
                                                    <h3>Sửa</h3>
                                                    <label for="control-modal" class="modal-close">X</label> 
                                                </div>
                                                <c:url var="Update" value="${request.contextPath}/Admin/food"/>
                                                <form action="${Update}" class="form" method="POST">
                                                    <input type="hidden" name="id"  value="${food.id}">
                                                    <div class="fomrgroup"> 
                                                        <lable class="form-lable" for="foodname">Tên món ăn :</lable>
                                                        <input type="text" name="foodname" class="form-input   food-name"  value="">
                                                    </div>
                                                    <div class="fomrgroup">
                                                        <lable class="form-lable" for="description">Mô tả :</lable>
                                                        <input type="text" name="description" class="form-input  food-des"  value="">
                                                    </div>
                                                    <div class="fomrgroup">
                                                        <lable class="form-lable" for="price">Gía tiến</lable>
                                                        <input type="text" name="price" class="form-input  food-price"  value="${food.originalPrice}">
                                                    </div>
                                                     <input type="hidden" name="price"  value="${food.originalPrice}">
                                                    <div class="fomrgroup submit">
                                                        <input type="submit" value="Sửa" name="idUpdate" class="submit-button">
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </th>
                                <th>
                                    <div class="btn-delete-action">
                                        <c:url var="Remove" value="${request.contextPath}/Admin/food"/>
                                        <form action="${Remove}" class="form" method="POST" >
                                            <input type="hidden" name="id"  value="${food.id}">
                                            <button id="myBtn" class="btn-edit-action btn-edit-delete btn-delete"  type="submit" name="idRemove" value="Remove" />Xóa</button>
                                        </form>
                                    </div>
                                </th>
                            </tr>
                        </c:forEach>
                    <tfoot>
                        <tr>
                            <td colspan="8">Tổng thức ăn: ${listFood.size()}</td>
                        </tr>
                    </tfoot>
                </table>

            </div>
        </div>
    </div>

</body>
<script src="../assets/javascript/Admin/qlsp.js"></script>
</html>
