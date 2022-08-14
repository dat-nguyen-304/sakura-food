<%@page import="com.fptuni.prj301.assignment.model.Item"%>
<%@page import="com.fptuni.prj301.assignment.model.Customer"%>
<%@page import="com.fptuni.prj301.assignment.dbmanager.CustomerManager"%>
<%@page import="com.fptuni.prj301.assignment.model.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.fptuni.prj301.assignment.model.UserSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin đơn hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
        <link rel="stylesheet" href="../assets/css/grid.css">
        <link rel="stylesheet" href="../assets/css/base.css">
        <link rel="stylesheet" href="../assets/css/Admin/ttdh.css">
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

            if (request.getAttribute("idOrderNoExist") != null) {
                out.print("<script>alert('id order không tồn tại')</script>");
            }
            if (request.getAttribute("idCusNoExist") != null) {
                out.print("<script>alert('id customer không tồn tại')</script>");
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
            <h1 class="title-page" style="text-align:center; text-transform: uppercase;">Thông tin đơn hàng</h1>
            <c:url var="adminOrder" value="${request.contextPath}/Admin/order"/>
            <div id="info_details">
                <div id="info">
                    <div class="search">
                        <!-- search User-->
                        <form action="" class="seach-user-form">
                            <input type="text" name="userid" value="" class="search-input" placeholder="Nhập ID người dùng">
                            <input type="submit" value="Search " class="search-submit">
                        </form>
                    </div>
                    <c:if test="${requestScope.userid != null}">
                        <h3>Danh sách đơn của khách hàng id = ${requestScope.userid}</h3>
                    </c:if>
                    <table border="1">
                        <thead>
                            <tr>
                                <th class="table-header" style="width: 50px;">ID đơn hàng</th>
                                <th class="table-header" style="width: 80px;">Tên người dùng</th>

                                <th class="total_vip table-header" style="width: 80px;">
                                    <c:if test="${requestScope.userid != null}">
                                        <a href="./order?userid=${requestScope.userid}&sortByDateOrder=default">Ngày đặt</a>
                                    </c:if>
                                    <c:if test="${requestScope.userid == null}">
                                        <a href="./order?sortByDateOrder=default">Ngày đặt</a>
                                    </c:if>
                                    <div class="dropdown">
                                        <button class="nut_dropdown">
                                            <i class="fa-solid fa-chevron-down"></i>
                                        </button>
                                        <div class="content-dropdown">
                                            <div class="noidung_dropdown">
                                                <c:if test="${requestScope.userid != null}">
                                                    <a href="./order?userid=${requestScope.userid}&sortByDateOrder=ASC">Xa nhất</a>
                                                </c:if>
                                                <c:if test="${requestScope.userid == null}">
                                                    <a href="./order?sortByDateOrder=ASC">Xa nhất</a>
                                                </c:if>
                                                <c:if test="${requestScope.userid != null}">
                                                    <a href="./order?userid=${requestScope.userid}&sortByDateOrder=DESC">Gần nhất</a>
                                                </c:if>
                                                <c:if test="${requestScope.userid == null}">
                                                    <a href="./order?sortByDateOrder=DESC">Gần nhất</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </th>
                                <th class="table-header" style="width: 200px;">Địa chỉ</th>

                                <th class="total_vip table-header" style="width: 80px;">
                                    <c:if test="${requestScope.userid != null}">
                                        <a href="./order?userid=${requestScope.userid}&sortByOrginalPrice=default">Tổng giá trị</a>
                                    </c:if>
                                    <c:if test="${requestScope.userid == null}">
                                        <a href="./order?sortByOrginalPrice=default">Tổng giá trị</a>
                                    </c:if>
                                    <div class="dropdown">
                                        <button class="nut_dropdown">
                                            <i class="fa-solid fa-chevron-down"></i>
                                        </button>
                                        <div class="content-dropdown">
                                            <div class="noidung_dropdown">
                                                <c:if test="${requestScope.userid != null}">
                                                    <a href="./order?userid=${requestScope.userid}&sortByOrginalPrice=ASC">Tăng dần</a>
                                                </c:if>
                                                <c:if test="${requestScope.userid == null}">
                                                    <a href="./order?sortByOrginalPrice=ASC">Tăng dần</a>
                                                </c:if>
                                                <c:if test="${requestScope.userid != null}">
                                                    <a href="./order?userid=${requestScope.userid}&sortByOrginalPrice=DESC">Giảm dần</a>
                                                </c:if>
                                                <c:if test="${requestScope.userid == null}">
                                                    <a href="./order?sortByOrginalPrice=DESC">Giảm dần</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </th>
                                <th class="table-header" style="width: 50px;">Khuyến mãi(VNĐ)</th>
                                <th class="table-header" style="width: 50px;">Khuyến mãi(%)</th>
                                <th class="total_vip table-header" style="width: 90px;">
                                    <c:if test="${requestScope.userid != null}">
                                        <a href="./order?userid=${requestScope.userid}&sortByFinalPrice=ASC">Thành tiền</a>
                                    </c:if>
                                    <c:if test="${requestScope.userid == null}">
                                        <a href="./order?sortByFinalPrice=ASC">Thành tiền</a>
                                    </c:if>
                                    <div class="dropdown">
                                        <button class="nut_dropdown">
                                            <i class="fa-solid fa-chevron-down"></i>
                                        </button>
                                        <div class="content-dropdown">
                                            <div class="noidung_dropdown">
                                                <c:if test="${requestScope.userid != null}">
                                                    <a href="./order?userid=${requestScope.userid}&sortByFinalPrice=ASC">Tăng dần</a>
                                                </c:if>
                                                <c:if test="${requestScope.userid == null}">
                                                    <a href="./order?sortByFinalPrice=ASC">Tăng dần</a>
                                                </c:if>
                                                <c:if test="${requestScope.userid != null}">
                                                    <a href="./order?userid=${requestScope.userid}&sortByFinalPrice=DESC">Giảm dần</a>
                                                </c:if>
                                                <c:if test="${requestScope.userid == null}">
                                                    <a href="./order?sortByFinalPrice=DESC">Giảm dần</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Order> list = (List<Order>) request.getAttribute("listOrder");
                                if (list.size() == 0) {
                                    out.print("<td colspan='8' style='font-size: 16px; font-weight: 300; color: #333; text-align: center; height: 35px;'>Người dùng này chưa mua hàng</td>");
                                }
                                for (Order order : list) {
                                    CustomerManager cm = new CustomerManager();
                                    Customer c = cm.getById(order.getIdCustomer());
                                    out.print("<tr>");
                                    out.print("<th>" + order.getId() + "</th>");
                                    out.print("<th>" + c.getUsername() + "</th>");
                                    out.print("<th>" + order.getDate() + "</th>");
                                    out.print("<th>" + order.getAddress() + "</th>");
                                    out.print("<th>" + order.getOriginalPrice() / 1000 + ".000 VNĐ</th>");
                                    if (order.getDiscount() != 0)
                                    out.print("<th>" + order.getDiscount() / 1000 + ".000 VNĐ</th>");
                                    else out.print("<th>0</th>");
                                    out.print("<th>" + cm.getVoucherPercent(c.getIdVipAccount()) + "</th>");
                                    out.print("<th>" + order.getFinalPrice() /1000 + ".000 VNĐ</th>");
                                    out.print("</tr>");
                                }
                            %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4">Tổng đơn hàng: ${requestScope.totalOrder}</td>
                                <td colspan="1">Tổng giá trị: ${requestScope.sumOriginalPrice} VNĐ</td>
                                <td colspan="2">Tổng khuyến mãi: ${sumDiscount} VNĐ</td>
                                <td>Tổng thành tiền: ${sumFinalPrice} VNĐ</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <div id="info1" >
                    <div class="search1">
                        <form action="" class="seach-user-form">
                            <input type="text" name="idOrder" value="" class="search-input" required placeholder="Nhập id đơn hàng">
                            <input type="submit" value="Search " class="search-submit">
                        </form>
                    </div>
                    <table border="1">
                        <thead>
                            <tr class="info-list">
                                <th>Tên sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Giá tiền</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                if (request.getAttribute("itemList") != null) {
                                    List<Item> itemList = (List<Item>) request.getAttribute("itemList");
                                    for (Item item : itemList) {
                                        out.print("<tr>");
                                        out.print("<th>" + item.getFood().getName() + "</th>");
                                        out.print("<th>" + item.getQuantity() + "</th>");
                                        out.print("<th>" + item.getPrice() / 1000 + ".000 VNĐ  x  " + item.getQuantity() + "</th>");
                                        out.print("</tr>");
                                    }
                                }
                                if (request.getAttribute("hasRemovedFood") != null) {
                                    out.print("<tr>");
                                    out.print("<th>Vài sản phẩm bị xóa</th>");
                                    out.print("<th> --- </th>");
                                    out.print("<th> --- </th>");
                                    out.print("</tr>");
                                }

                            %>
                        </tbody>

                        <tfoot>
                            <tr>
                                <%  if (request.getAttribute("itemList") != null) {
                                        List<Item> itemList = (List<Item>) request.getAttribute("itemList");
                                        out.print("<td>Số mặt hàng: " + itemList.size() + "</td>");
                                        out.print("<td>Tổng số lượng: " + request.getAttribute("totalQuantity") + "</td>");
                                        out.print("<td>Tổng giá tiền: " + request.getAttribute("totalPrice") + "</td>");
                                    }
                                %>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

        </div>
    </body>

</html>