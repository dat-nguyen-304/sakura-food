/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fptuni.prj301.assignment.controller;

import com.fptuni.prj301.assignment.dbmanager.CustomerManager;
import com.fptuni.prj301.assignment.dbmanager.FoodManager;
import com.fptuni.prj301.assignment.dbmanager.OrderManager;
import com.fptuni.prj301.assignment.model.Customer;
import com.fptuni.prj301.assignment.model.Food;
import com.fptuni.prj301.assignment.model.Item;
import com.fptuni.prj301.assignment.model.UserSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
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
public class PayController extends HttpServlet {

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
        HttpSession ss = request.getSession();
        UserSession us = (UserSession) ss.getAttribute("usersession");

        if (us == null) {
            response.sendRedirect(request.getContextPath() + "/Access/login");
            return;
        }
        String path = request.getPathInfo();

        if (path.equals("/pay")) {
            CustomerManager cm = new CustomerManager();
            Customer c = cm.getByUsername(us.getUsername());
            if (request.getParameter("idVip") != null) {
                int idVip = Integer.parseInt(request.getParameter("idVip"));
                int daysLeft = cm.getDaysLeft(c.getId());
                if (daysLeft <= 0 || c.getVoucherLeft() == 0) {
                    cm.resetVip(c.getId());
                }
                if (c.getIdVipAccount() == 0 || c.getVoucherLeft() == 0) {
                    if (cm.updateVip(c.getId(), idVip)) {
                        request.setAttribute("updateVip", "Thành công");
                    } else {
                        request.setAttribute("updateVip", "Thất bại");
                    }
                } else {
                    request.setAttribute("updateVip", "Thất bại. Bạn còn: " + c.getVoucherLeft() + " vouchers và "+ daysLeft + " ngày VIP.");
                }
            }
            if (request.getParameter("removeId") != null) {
                List<Item> listItem = us.getCart();
                int removeId = Integer.parseInt(request.getParameter("removeId"));
                for (int i = 0; i < listItem.size(); i++) {
                    if (listItem.get(i).getFood().getId() == removeId) {
                        listItem.remove(i);
                        break;
                    }
                }
            }
            if (request.getParameter("buynowId") != null) {
                int idFood = Integer.parseInt(request.getParameter("buynowId"));
                FoodManager fm = new FoodManager();
                Food food = fm.getById(idFood);
                List<Item> listItem = us.getCart();
                listItem.add(new Item(listItem.size(), 0, food, 1, food.getFinalPrice()));
            }
            if (request.getParameter("boughtList") != null) {
                String boughtStr = request.getParameter("boughtList");
                StringTokenizer st = new StringTokenizer(boughtStr);
                List<String> itemList = new ArrayList<>();
                while (st.hasMoreTokens()) {
                    itemList.add(st.nextToken());
                }
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                String note = request.getParameter("note");
                OrderManager om = new OrderManager();
                boolean addOrder = om.addOrder(c.getId(), address, phone, note);
                for (String itemInfo : itemList) {
                    st = new StringTokenizer(itemInfo, "-");
                    int itemNumber = Integer.parseInt(st.nextToken());
                    int quantity = Integer.parseInt(st.nextToken());
                    boolean addItem = om.addItem(om.getQuantityOrder(), us.getCart().get(itemNumber), quantity);
                    int idFood = us.getCart().get(itemNumber).getFood().getId();
                    int currentSoldQuantity = us.getCart().get(itemNumber).getFood().getQuantitySold();
                    om.updateSoldQuantity(idFood, currentSoldQuantity + quantity);
                        
                }
                int voucherPercent = 0;
                if (c.getIdVipAccount() != 0) {
                    if (c.getVoucherLeft() > 0) {
                        voucherPercent = cm.getVoucherPercent(c.getIdVipAccount());
                        cm.updateVoucherQuantity(c.getId(), c.getVoucherLeft() - 1);
                    }
                }
                boolean updateOrder = om.updateOrderPrice(om.getQuantityOrder(), voucherPercent);
                boolean updateSoldQuantity ;
                if (updateOrder) 
                    request.setAttribute("payment", true);
                else request.setAttribute("payment", false);
            }
            RequestDispatcher rd = request.getRequestDispatcher("/view/Pay.jsp");
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
