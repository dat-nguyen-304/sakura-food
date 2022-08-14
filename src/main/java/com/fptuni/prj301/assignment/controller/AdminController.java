/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fptuni.prj301.assignment.controller;

import com.fptuni.prj301.assignment.dbmanager.CustomerManager;
import com.fptuni.prj301.assignment.dbmanager.DiscountFoodManager;
import com.fptuni.prj301.assignment.dbmanager.FoodManager;
import com.fptuni.prj301.assignment.dbmanager.OrderManager;
import com.fptuni.prj301.assignment.model.Customer;
import com.fptuni.prj301.assignment.model.DiscountFood;
import com.fptuni.prj301.assignment.model.Food;
import com.fptuni.prj301.assignment.model.Item;
import com.fptuni.prj301.assignment.model.Order;
import com.fptuni.prj301.assignment.model.UserSession;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class AdminController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String path = request.getPathInfo();
        HttpSession ss = request.getSession();
        UserSession us = (UserSession) ss.getAttribute("usersession");

        if (us == null) {
            response.sendRedirect(request.getContextPath() + "/Access/login");
            return;
        }

        if (path.equals("/customer")) {
            CustomerManager manager = new CustomerManager();
            List<Customer> list = manager.list();
            request.setAttribute("listOfCus", list);
            int numberCus = manager.getUserQuantity();
            request.setAttribute("numberUser", numberCus);
            int numberOfRegisVip = manager.getVipUserQuantity();
            request.setAttribute("resgistrationVip", numberOfRegisVip);
            String sortRegisDate = request.getParameter("sortRegisDate");
            String sortRegisVip = request.getParameter("sortRegisVip");
            if (sortRegisDate != null) {
                if (sortRegisDate.equals("DESC")) {
                    list = manager.getListSortByDateRegis(true);
                    request.setAttribute("listOfCus", list);
                } else if (sortRegisDate.equals("ASC")) {
                    list = manager.getListSortByDateRegis(false);
                    request.setAttribute("listOfCus", list);
                } else {
                    list = manager.list();
                    request.setAttribute("listOfCus", list);
                }
            }
            if (sortRegisVip != null) {
                if (sortRegisVip.equals("DESC")) {
                    list = manager.getListSortByVipRegis(true);
                    request.setAttribute("listOfCus", list);
                } else if (sortRegisVip.equals("ASC")) {
                    list = manager.getListSortByVipRegis(false);
                    request.setAttribute("listOfCus", list);
                } else {
                    list = manager.list();
                    request.setAttribute("listOfCus", list);
                }
            }
            RequestDispatcher rd = request.getRequestDispatcher("/view/Admin_CustomerInfo.jsp");
            rd.forward(request, response);
        }

        if (path.equals("/food")) {
            FoodManager fm = new FoodManager();
            List<Food> listFood = fm.list();
            if (request.getParameter("idCate") != null) {
                int idCate = Integer.parseInt(request.getParameter("idCate"));
                if (idCate != 0) {
                    listFood = fm.getByCateId(idCate);
                    request.setAttribute("idCate", idCate);
                }
            }
            if (request.getParameter("idUpdate") != null) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("foodname");
                String decs = request.getParameter("description");
                int price = Integer.parseInt(request.getParameter("price"));
                int finalPrice = Integer.parseInt(request.getParameter("price"));
                fm.update(id, name, decs, price, finalPrice);
                listFood = fm.list();
            }
            if (request.getParameter("idInsert") != null) {
                String name = request.getParameter("name");
                String imgLink = request.getParameter("link");
                String description = request.getParameter("infomation");
                int id = Integer.parseInt(request.getParameter("id"));
                int originalPrice = Integer.parseInt(request.getParameter("price"));
                int finalPrice = Integer.parseInt(request.getParameter("price"));
                fm.insert(name, imgLink, description, id, originalPrice, finalPrice);
                listFood = fm.list();
            }
            if (request.getParameter("idRemove") != null) {
                int id = Integer.parseInt(request.getParameter("id"));
                fm.remove(id);
                listFood = fm.list();
            }

            String sortByPrice = request.getParameter("sortByPrice");
            String sortBySoldQuantity = request.getParameter("sortBySoldQuantity");
            if (sortByPrice != null) {
                if (sortByPrice.equals("DESC")) {
                    Collections.sort(listFood, new Comparator<Food>() {
                        @Override
                        public int compare(Food o1, Food o2) {
                            return (o2.getFinalPrice() - o1.getFinalPrice());
                        }
                    });
                } else if (sortByPrice.equals("ASC")) {
                    Collections.sort(listFood, new Comparator<Food>() {
                        @Override
                        public int compare(Food o1, Food o2) {
                            return (o1.getFinalPrice() - o2.getFinalPrice());
                        }
                    });
                }
            } else if (sortBySoldQuantity != null) {
                if (sortBySoldQuantity.equals("DESC")) {
                    Collections.sort(listFood, new Comparator<Food>() {
                        @Override
                        public int compare(Food o1, Food o2) {
                            return (o2.getQuantitySold() - o1.getQuantitySold());
                        }
                    });
                } else if (sortBySoldQuantity.equals("ASC")) {
                    Collections.sort(listFood, new Comparator<Food>() {
                        @Override
                        public int compare(Food o1, Food o2) {
                            return (o1.getQuantitySold() - o2.getQuantitySold());
                        }
                    });
                }
            }
            
            request.setAttribute("listFood", listFood);
            RequestDispatcher rd = request.getRequestDispatcher("/view/Admin_FoodManager.jsp");
            rd.forward(request, response);
        }

        if (path.equals("/order")) {
            OrderManager om = new OrderManager();
            CustomerManager cm = new CustomerManager();
            List<Order> listOrder = null;
            if (request.getParameter("userid") != null) {
                if (request.getParameter("userid").equals("")) {
                    listOrder = om.list();
                } else {
                    Customer c = cm.getById(Integer.parseInt(request.getParameter("userid")));
                    request.setAttribute("userid", request.getParameter("userid"));
                    if (c != null) {
                        listOrder = om.getByCustomerId(Integer.parseInt(request.getParameter("userid")));
                    } else {
                        request.setAttribute("idCusNoExist", true);
                        listOrder = om.list();
                    }
                }
            } else {
                listOrder = om.list();
            }
            if (request.getParameter("sortByDateOrder") != null) {
                if (request.getParameter("sortByDateOrder").equals("ASC")) {
                    Collections.sort(listOrder, new Comparator<Order>() {
                        @Override
                        public int compare(Order o1, Order o2) {
                            return o1.getDate().compareTo(o2.getDate());
                        }
                    });
                } else if (request.getParameter("sortByDateOrder").equals("DESC")) {
                    Collections.sort(listOrder, new Comparator<Order>() {
                        @Override
                        public int compare(Order o1, Order o2) {
                            return o2.getDate().compareTo(o1.getDate());
                        }
                    });
                }
            } else if (request.getParameter("sortByOrginalPrice") != null) {
                if (request.getParameter("sortByOrginalPrice").equals("ASC")) {
                    Collections.sort(listOrder, new Comparator<Order>() {
                        @Override
                        public int compare(Order o1, Order o2) {
                            return o1.getOriginalPrice() - o2.getOriginalPrice();
                        }
                    });
                } else if (request.getParameter("sortByOrginalPrice").equals("DESC")) {
                    Collections.sort(listOrder, new Comparator<Order>() {
                        @Override
                        public int compare(Order o1, Order o2) {
                            return o2.getOriginalPrice() - o1.getOriginalPrice();
                        }
                    });
                }
            } else if (request.getParameter("sortByFinalPrice") != null) {
                if (request.getParameter("sortByFinalPrice").equals("ASC")) {
                    Collections.sort(listOrder, new Comparator<Order>() {
                        @Override
                        public int compare(Order o1, Order o2) {
                            return o1.getFinalPrice() - o2.getFinalPrice();
                        }
                    });
                } else if (request.getParameter("sortByFinalPrice").equals("DESC")) {
                    Collections.sort(listOrder, new Comparator<Order>() {
                        @Override
                        public int compare(Order o1, Order o2) {
                            return o2.getFinalPrice() - o1.getFinalPrice();
                        }
                    });
                }
            }
            if (request.getParameter("idOrder") != null) {
                int idOrder = Integer.parseInt(request.getParameter("idOrder"));
                Order o = om.getOrderById(idOrder);
                if (o != null) {
                    List<Item> itemList = om.getItemByOrderId(idOrder);
                    int totalQuantity = 0;
                    int totalPrice = 0;
                    for (Item item : itemList) {
                        totalQuantity += item.getQuantity();
                        totalPrice += item.getQuantity() * item.getPrice();
                    }
                    if (o.getOriginalPrice() != totalPrice) {
                        request.setAttribute("hasRemovedFood", true);
                    }
                    request.setAttribute("itemList", itemList);
                    request.setAttribute("totalQuantity", totalQuantity);
                    request.setAttribute("totalPrice", o.getOriginalPrice());
                } else {
                    request.setAttribute("idOrderNoExist", true);
                }
            }
            int sumOriginalPrice = 0;
            for (Order order : listOrder) {
                sumOriginalPrice += order.getOriginalPrice();
            }
            int sumFinalPrice = 0;
            for (Order order : listOrder) {
                sumFinalPrice += order.getFinalPrice();
            }
            int sumDiscount = 0;
            for (Order order : listOrder) {
                sumDiscount += order.getDiscount();
            }
            request.setAttribute("sumOriginalPrice", sumOriginalPrice);
            request.setAttribute("sumFinalPrice", sumFinalPrice);
            request.setAttribute("sumDiscount", sumDiscount);
            request.setAttribute("listOrder", listOrder);
            request.setAttribute("totalOrder", listOrder.size());
            RequestDispatcher rd = request.getRequestDispatcher("/view/Admin_OrderInfo.jsp");
            rd.forward(request, response);

        }

        if (path.equals("/discount")) {
            DiscountFoodManager df = new DiscountFoodManager();
            List<DiscountFood> list = df.list();
            request.setAttribute("listOfDiscount", list);
            String action_repair = request.getParameter("repair-Action");
            if (action_repair != null) {
                String id_food = request.getParameter("product_id");
                String original_price = request.getParameter("product_original_price");
                String discount = request.getParameter("sale");
                boolean updateCheck = df.update(Integer.parseInt(id_food), Integer.parseInt(original_price), Integer.parseInt(discount));
            }
            String action_delete = request.getParameter("action_delete");
            if (action_delete != null) {
                String idFood = request.getParameter("food_id");
                boolean removeCheck = df.remove(Integer.parseInt(idFood));
            }
            String action_add = request.getParameter("action-add");
            if (action_add != null) {
                String id = request.getParameter("nameOfFood");
                String sale = request.getParameter("sale_off");
                boolean addCheck = df.insert(Integer.parseInt(id), Integer.parseInt(sale));
                if (!addCheck) {
                    request.setAttribute("error_message", "Sản phẩm đã được giảm giá ");
                }
            }
            int amount = df.getDiscountQuantity();
            request.setAttribute("amount", amount);
            list = df.list();
            request.setAttribute("listOfDiscount", list);
            RequestDispatcher rd = request.getRequestDispatcher("/view/Admin_DiscountFoodManager.jsp");
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
