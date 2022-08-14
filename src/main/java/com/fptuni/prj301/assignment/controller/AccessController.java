/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fptuni.prj301.assignment.controller;

import com.fptuni.prj301.assignment.dbmanager.AccessManager;
import com.fptuni.prj301.assignment.dbmanager.CommentManager;
import com.fptuni.prj301.assignment.dbmanager.DiscountFoodManager;
import com.fptuni.prj301.assignment.model.Comment;
import com.fptuni.prj301.assignment.model.DiscountFood;
import com.fptuni.prj301.assignment.model.UserSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class AccessController extends HttpServlet {

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
        String path = request.getPathInfo();
        DiscountFoodManager dfm = new DiscountFoodManager();
        List<DiscountFood> discountList = dfm.list();
        CommentManager cm = new CommentManager();
        List<Comment> commentList = cm.list();
        System.out.println(path);
        if (path.equals("/login")) {

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String registration = request.getParameter("username_signup");
            if (username == null) {
                if (registration != null) {
                    String usernameSignup = request.getParameter("username_signup");
                    String passwordSignup = request.getParameter("password_signup");
                    String emailSignup = request.getParameter("email_signup");
                    String phoneSignup = request.getParameter("phone_signup");
                    AccessManager manager = new AccessManager();
                    boolean signupSuccess = manager.signup(usernameSignup, passwordSignup, emailSignup, phoneSignup);
                    if (signupSuccess) {
                        request.setAttribute("signupSuccess", true);
                    } else {
                        request.setAttribute("signupSuccess", false);
                        String messError = "";
                        if (!manager.checkUsername(usernameSignup)) messError += "Tên đăng nhập, ";
                        if (!manager.checkEmail(emailSignup)) messError += "Email, ";
                        if (!manager.checkPhone(phoneSignup)) messError += "Số điện thoại, ";
                        messError += "đã được sử dụng!";
                        request.setAttribute("signupErrorMess", messError);
                    }
                }
                request.setAttribute("discountList", discountList);
                request.setAttribute("commentList", commentList);
                RequestDispatcher rd = request.getRequestDispatcher("/view/Login.jsp");
                rd.forward(request, response);

            } else {
                AccessManager manager = new AccessManager();
                UserSession us = manager.login(username, password);

                HttpSession ss = request.getSession(true);
                ss.setAttribute("usersession", us);

                if (us != null) {
                    if (us.getAccessRight().equals("user")) {
                        response.sendRedirect(request.getContextPath() + "/Home/home");
                    } else if (us.getAccessRight().equals("admin")) {
                        response.sendRedirect(request.getContextPath() + "/Admin/customer");
                    }
                } else {
                    request.setAttribute("signinSuccess", false);
                    request.setAttribute("discountList", discountList);
                    request.setAttribute("commentList", commentList);
                    RequestDispatcher rd = request.getRequestDispatcher("/view/Login.jsp");
                    rd.forward(request, response);
                }
            }

        } else if (path.equals("/logout")) {
            HttpSession ss = request.getSession();
            ss.setAttribute("usersession", null);
            request.setAttribute("discountList", discountList);
            request.setAttribute("commentList", commentList);
            request.setAttribute("login-msg", "");
            RequestDispatcher rd = request.getRequestDispatcher("/view/Login.jsp");
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
