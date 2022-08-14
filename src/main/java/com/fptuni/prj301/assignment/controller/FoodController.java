/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fptuni.prj301.assignment.controller;

import com.fptuni.prj301.assignment.dbmanager.CommentManager;
import com.fptuni.prj301.assignment.dbmanager.CustomerManager;
import com.fptuni.prj301.assignment.dbmanager.FoodManager;
import com.fptuni.prj301.assignment.model.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 *
 * @author Admin
 */
public class FoodController extends HttpServlet {

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
        if (path.equals("/list")) {
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
                    request.setAttribute("updateVip", "Thất bại. Bạn còn: " + c.getVoucherLeft() + " vouchers và " + daysLeft + " ngày VIP.");
                }
            }
            FoodManager fm = new FoodManager();
            List<Food> listFood;

            if (request.getParameter("idCate") != null) {
                int idCate = Integer.parseInt(request.getParameter("idCate"));
                request.setAttribute("idCate", idCate);
                listFood = fm.getByCateId(idCate);
            } else if (request.getParameter("keyword") != null) {
                String keyword = request.getParameter("keyword");
                request.setAttribute("keyword", keyword);
                listFood = fm.getByKeyword(keyword);
            } else {
                listFood = fm.list();
            }
            if (request.getParameter("sortByPrice") != null) {
                if (request.getParameter("sortByPrice").equals("ASC")) {
                    Collections.sort(listFood, new Comparator<Food>() {
                        @Override
                        public int compare(Food o1, Food o2) {
                            return (o1.getFinalPrice() - o2.getFinalPrice());
                        }
                    });
                } else {
                    Collections.sort(listFood, new Comparator<Food>() {
                        @Override
                        public int compare(Food o1, Food o2) {
                            return (o2.getFinalPrice() - o1.getFinalPrice());
                        }
                    });
                }
            } else if (request.getParameter("sortBySoldQuantity") != null) {
                if (request.getParameter("sortBySoldQuantity").equals("ASC")) {
                    Collections.sort(listFood, new Comparator<Food>() {
                        @Override
                        public int compare(Food o1, Food o2) {
                            return (o1.getQuantitySold() - o2.getQuantitySold());
                        }
                    });
                } else {
                    Collections.sort(listFood, new Comparator<Food>() {
                        @Override
                        public int compare(Food o1, Food o2) {
                            return (o2.getQuantitySold() - o1.getQuantitySold());
                        }
                    });
                }
            }
            request.setAttribute("listFood", listFood);
            RequestDispatcher rd = request.getRequestDispatcher("/view/ListFood.jsp");
            rd.forward(request, response);
        }
        if (path.equals("/detail")) {
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
                    request.setAttribute("updateVip", "Thất bại. Bạn còn: " + c.getVoucherLeft() + " vouchers và " + daysLeft + " ngày VIP.");
                }
            }
            if (request.getParameter("idAddedFood") != null) {
                int idFood = Integer.parseInt(request.getParameter("idAddedFood"));
                FoodManager fm = new FoodManager();
                Food food = fm.getById(idFood);
                List<Item> listItem = us.getCart();
                listItem.add(new Item(listItem.size(), 0, food, 1, food.getFinalPrice()));
                request.setAttribute("added", true);
            }
            int id = Integer.parseInt(request.getParameter("id"));
            if (request.getParameter("addComment") != null) {
                CommentManager commentManager = new CommentManager();
                CustomerManager cm = new CustomerManager();
                Customer c = cm.getByUsername(us.getUsername());
                String content = request.getParameter("addComment");
                commentManager.addComment(c.getId(), id, content);
            }

            FoodManager fm = new FoodManager();
            CommentManager cm = new CommentManager();
            Food food = fm.getById(id);
            List<Comment> commentList = cm.getByIdFood(id);
            List<Food> relatedList = fm.getRelatedList(food);
            request.setAttribute("food", food);
            request.setAttribute("commentList", commentList);
            request.setAttribute("relatedList", relatedList);
            RequestDispatcher rd = request.getRequestDispatcher("/view/FoodDetail.jsp");
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
