<%@page import="com.fptuni.prj301.assignment.dbmanager.CustomerManager"%>
<%@page import="com.fptuni.prj301.assignment.model.Customer"%>
<%@page import="java.util.List"%>
<%@page import="com.fptuni.prj301.assignment.model.UserSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin khách hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
        <link rel="stylesheet" href="../assets/css/grid.css">
        <link rel="stylesheet" href="../assets/css/base.css">
        <link rel="stylesheet" href="../assets/css/Admin/ttkh.css">
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
            <div id="category">
                <ul id="category_details">
                    <%                        out.print("<li class='category__item'><a href='" + request.getContextPath() + "/Admin/customer" + "'>");
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
            <h1 class="title-page" style="text-align:center; text-transform: uppercase;">Thông tin khách hàng</h1>
            <div id="info">
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên người dùng</th>
                            <th>Email</th>
                            <th>Điện thoại</th>
                            <th class="regis_day"><a href="?sortRegisDate=default">Ngày đăng kí</a> 
                                <div class="dropdown">
                                    <i class="fa-solid fa-caret-down"></i>
                                    <div class="noidung_dropdown">
                                        <a href="?sortRegisDate=DESC">Gần nhất</a>
                                        <a href="?sortRegisDate=ASC">Xa Nhất</a>
                                    </div>
                            </th>
                            <th class="regis_vip"><a href="?sortRegisVip=default">Ngày đăng kí VIP</a>
                                <div class="dropdown">
                                    <i class="fa-solid fa-caret-down"></i>
                                    <div class="noidung_dropdown">
                                        <a href="?sortRegisVip=DESC">Gần nhất</a>
                                        <a href="?sortRegisVip=ASC">Xa nhất</a>
                                    </div>
                            </th>
                            <th>Loại VIP</th>
                            <th>Voucher còn lại</th>
                            <th class="total_vip">Phí VIP</th>
                        </tr>
                    </thead>
                     <tbody>
                         <%
                            List<Customer> list = (List<Customer>) request.getAttribute("listOfCus");
                            CustomerManager cm = new CustomerManager();
                            for (Customer customer : list) {
                                out.println("<tr>");
                                out.println("<th>" + customer.getId() + "</th>");
                                out.println("<th>" + customer.getUsername() + "</th>");
                                out.println("<th>" + customer.getEmail() + "</th>");
                                out.println("<th>" + customer.getPhone() + "</th>");
                                out.println("<th>" + customer.getRegistrationDate() + "</th>");
                                out.println("<th>" + customer.getVipRegistrationDate() + "</th>");
                                out.println("<th>" + customer.getIdVipAccount() + "</th>");
                                out.println("<th>" + customer.getVoucherLeft() + "</th>");
                                int value = cm.getVipValue(customer.getId());
                                if (value != 0)
                                    out.println("<th>" + value / 1000 + ".000 VNĐ</th>");
                                else out.println("<th>0</th>");
                                out.println("</tr>");
                            }
                        %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="5">Tổng số KH: <% 
                                int number = (int)request.getAttribute("numberUser");
                                out.print(number);
                            %>
                            </td>
                            <td colspan="4">Tổng KH đăng kí VIP:
                            <% 
                                int numberVipResgis = (int)request.getAttribute("resgistrationVip");
                                out.print(numberVipResgis);
                            %></td>
                            
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </body

</html>