/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fptuni.prj301.assignment.controller;

import com.fptuni.prj301.assignment.dbmanager.AccessManager;
import com.fptuni.prj301.assignment.dbmanager.CommentManager;
import com.fptuni.prj301.assignment.dbmanager.CustomerManager;
import com.fptuni.prj301.assignment.dbmanager.DiscountFoodManager;
import com.fptuni.prj301.assignment.model.Comment;
import com.fptuni.prj301.assignment.model.Customer;
import com.fptuni.prj301.assignment.model.DiscountFood;
import com.fptuni.prj301.assignment.model.Item;
import com.fptuni.prj301.assignment.model.UserSession;
import java.io.IOException;
import java.io.PrintWriter;
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
public class HomeController extends HttpServlet {

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

        HttpSession ss = request.getSession();
        UserSession us = (UserSession) ss.getAttribute("usersession");

        if (us == null) {
            response.sendRedirect(request.getContextPath() + "/Access/login");
            return;
        }
        String path = request.getPathInfo();
        if (path.equals("/home")) {
            
            if (request.getParameter("idVip") != null) {
                int idVip = Integer.parseInt(request.getParameter("idVip"));
                CustomerManager cm = new CustomerManager();
                Customer c = cm.getByUsername(us.getUsername());
                int daysLeft = cm.getDaysLeft(c.getId());
                if (daysLeft <= 0) {
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
            DiscountFoodManager dfm = new DiscountFoodManager();
            List<DiscountFood> discountList = dfm.getSliderList();
            request.setAttribute("discountList", discountList);
            CommentManager cm = new CommentManager();
            List<Comment> commentList = cm.list();
            request.setAttribute("commentList", commentList);
            RequestDispatcher rd = request.getRequestDispatcher("/view/Home.jsp");
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
