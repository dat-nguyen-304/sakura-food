<%@page import="com.fptuni.prj301.assignment.model.DiscountFood"%>
<%@page import="java.util.List"%>
<%@page import="com.fptuni.prj301.assignment.model.UserSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý sản phẩm giảm giá</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
        <link rel="stylesheet" href="../assets/css/grid.css">
        <link rel="stylesheet" href="../assets/css/base.css">
        <link rel="stylesheet" href="../assets/css/Admin/spgg.css">
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

            <h1 class="title-page"  style="text-align:center; text-transform: uppercase;">Quản lí sản phẩm giảm giá</h1>
            <div class="container">
                <!-- Button Thêm -->
                <button id="myBtn">
                    <h3>Thêm</h3>
                </button>
                <!-- The Modal -->
                <div id="myModal" class="modal">

                    <!-- Nội dung form đăng nhập -->
                    <div class="modal-content">
                        <form action="#" class="form-for-add">
                            <span class="close">&times;</span>
                            <h2 style="color:green;background-color:white;border-radius:10px; padding:10px ;">Thêm Món Ăn
                            </h2>
                            <div class="fomrgroup">
                            </div>
                            <div class="fomrgroup">
                                <b>Mã sản phẩm:</b>
                                <input type="text" name="nameOfFood" value="">
                            </div>
                            <div class="fomrgroup">
                                <b>Khuyến mãi:</b>
                                <input type="text" name="sale_off" value="">
                            </div>

                            <div class="fomrgroup btn-submit">
                                <button type="submit" name="action-add" value="add">Thêm</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%
                String error = (String) request.getAttribute("error_message");
                if (error != null) {
                    out.print("<span style='color:red;font-weight:600;'>" + error + "</span>");
                }
            %>

            <div id="info">
                <table class="table-item" border="1">
                    <thead class="table-header">

                        <tr>
                            <th>ID</th>
                            <th>Tên thức ăn
                            </th>
                            <th>Giá cũ
                            </th>
                            <th>Khuyến mãi
                            </th>
                            <th>Phần trăm khuyến mãi</th>

                            <th>Giá mới
                            </th>
                            <th>

                            </th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<DiscountFood> list = (List<DiscountFood>) request.getAttribute("listOfDiscount");
                            for (DiscountFood discountFood : list) {
                                out.println("<tr class='table__row table-body'>");
                                out.println(" <th>" + discountFood.getIdFood() + "</th>");
                                out.println(" <th>" + discountFood.getName() + "</th>");
                                out.println(" <th class='price-default'>" + discountFood.getOriginPrice() / 1000 + ".000 VNĐ</th>");
                                out.println("<th class='sale-product'>" + discountFood.getDiscount() / 1000 + ".000 VNĐ </th>");
                                out.println(" <th class='sale-off-percent'>" + discountFood.getDiscountPercent() + "</th>");

                                out.println("<th>" + discountFood.getFinalPrice() / 1000 + ".000 VNĐ</th>");

                                out.println("<th>"
                                        + "<div class='btn-action'>"
                                        + "  <button id='myBtn' class='btn-edit-action btn-repair'>Sửa</button>"
                                        + "     <div class=' modal-form'>"
                                        + "      <div class='modal-content'>"
                                        + "        <div class='modal-header'>"
                                        + "      <h3>Sửa</h3>"
                                        + "  <label for='control-modal' class='modal-close'>X</label> "
                                        + " </div>"
                                        + " <form action='" + request.getContextPath() + "/Admin/discount' class='form' method='POST'>"
                                        + " <div class='fomrgroup form-info'>"
                                        + "<input type='hidden' name='product_id'  value='" + discountFood.getIdFood() + "'>"
                                        + "<input type='hidden' name='product_original_price'  value='" + discountFood.getOriginPrice() + "'>"
                                        + " <label for='sale'> Khuyến mãi</label>"
                                        + "<input type='text' name='sale' class='form-input' value=''>"
                                        + "</div>"
                                        + "<div class='fomrgroup submit'>"
                                        + "<input type='submit' name='repair-Action'value='Sửa' class='submit-button'>"
                                        + "</div>"
                                        + "</form>"
                                        + "</div>"
                                        + "</div>"
                                        + "</div>"
                                        + "</th>");
                                out.println("<th>"
                                        + " <form action='" + request.getContextPath() + "/Admin/discount' class='form' method='POST'>"
                                        + "<div class='btn-delete-action'>"
                                        + "<input type='hidden' name='food_id' value='" + discountFood.getIdFood() + "'>"
                                        + "<button id='myBtn' class='btn-edit-action btn-edit-delete btn-delete' type='submit' name='action_delete' value='delete'>Xóa</button>"
                                        + " </div>"
                                        + "</form>"
                                        + "</th>");
                                out.println("</tr>");

                            }
                        %>

                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="7">Tổng số lượng sản phẩm giảm giá: <% out.print(request.getAttribute("amount"));%> </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

    </body>   
    <script src="../assets/javascript/Admin/sqgg.js"></script>
</html>