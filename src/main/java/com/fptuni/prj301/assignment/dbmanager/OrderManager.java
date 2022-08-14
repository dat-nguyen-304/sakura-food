/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fptuni.prj301.assignment.dbmanager;

import com.fptuni.prj301.assignment.model.Food;
import com.fptuni.prj301.assignment.model.Item;
import com.fptuni.prj301.assignment.model.Order;
import com.fptuni.prj301.assignment.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class OrderManager {

    public List<Order> list() {
        ArrayList<Order> list;
        list = new ArrayList<Order>();
        String sql = "select id, idCustomer, address, date, phone, note, original_price, discount, final_price FROM Orders";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt("id"), rs.getInt("idCustomer"), rs.getString("address"), rs.getString("phone"),
                        rs.getString("note"), rs.getInt("original_price"), rs.getInt("discount"), rs.getInt("final_price"), rs.getDate("date")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public Order getOrderById(int id) {
        ArrayList<Order> list;
        list = new ArrayList<Order>();
        String sql = "select id, idCustomer, address, date, phone, note, original_price, discount, final_price FROM Orders WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Order(rs.getInt("id"), rs.getInt("idCustomer"), rs.getString("address"), rs.getString("phone"),
                        rs.getString("note"), rs.getInt("original_price"), rs.getInt("discount"), rs.getInt("final_price"), rs.getDate("date"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<Order> getByCustomerId(int idCustomer) {
        ArrayList<Order> list;
        list = new ArrayList<Order>();
        String sql = "select id, idCustomer, address, date, phone, note, original_price, discount, final_price FROM Orders WHERE idCustomer = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idCustomer);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt("id"), rs.getInt("idCustomer"), rs.getString("address"), rs.getString("phone"),
                        rs.getString("note"), rs.getInt("original_price"), rs.getInt("discount"), rs.getInt("final_price"), rs.getDate("date")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public boolean addOrder(int idCustomer, String address, String phone, String note) {
        String sql = "INSERT INTO Orders(idCustomer, address, date, phone, note, original_price, discount, final_price) "
                + "VALUES(?, ?, GETDATE(), ?, ?, 0, 0 , 0)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idCustomer);
            ps.setString(2, address);
            ps.setString(3, phone);
            ps.setString(4, note);
            int rowSuccess = ps.executeUpdate();
            if (rowSuccess > 0) {
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public int getQuantityOrder() {
        String sql = "SELECT MAX(id) as quantity FROM Orders";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("quantity");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public boolean addItem(int idOrder, Item item, int quantity) {
        String sql = "INSERT INTO Items(idOrder, idFood, quantity, price) "
                + "VALUES(?, ?, ?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idOrder);
            ps.setInt(2, item.getFood().getId());
            ps.setInt(3, quantity);
            ps.setInt(4, item.getFood().getFinalPrice());
            int rowSuccess = ps.executeUpdate();
            if (rowSuccess > 0) {
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean updateOrderPrice(int idOrder, int voucherPercent) {
        int originalPrice = 0;
        String sql = "SELECT SUM(I.price * I.quantity) As original_price FROM Items I INNER JOIN Orders O ON i.idOrder = O.id WHERE O.id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idOrder);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                originalPrice = rs.getInt("original_price");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        int discount = (int) Math.round((originalPrice / 1000) * ((double) voucherPercent / 100)) * 1000;
        int finalPrice = originalPrice - discount;
        sql = "UPDATE Orders SET original_price = ?, discount = ?, final_price = ? WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, originalPrice);
            ps.setInt(2, discount);
            ps.setInt(3, finalPrice);
            ps.setInt(4, idOrder);
            int rowSuccess = ps.executeUpdate();
            if (rowSuccess > 0) {
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean updateSoldQuantity(int idFood, int newSoldQuantity) {
        String sql = "UPDATE Foods SET sold_quantity = ? WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newSoldQuantity);
            ps.setInt(2, idFood);
            int rowSuccess = ps.executeUpdate();
            if (rowSuccess > 0) {
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public List<Item> getItemByOrderId(int idOrder) {
        ArrayList<Item> list;
        list = new ArrayList<Item>();
            String sql = "select id, idOrder, idFood, quantity, price FROM Items WHERE idOrder = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idOrder);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FoodManager fm = new FoodManager();
                Food food = fm.getById(rs.getInt("idFood"));
                list.add(new Item(rs.getInt("id"), rs.getInt("idOrder"), food, rs.getInt("quantity"), rs.getInt("price")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int getOrderQuantity() {
        String sql = "SELECT COUNT(id) as quantity FROM Orders";
        try {
            Connection connect = DBUtils.getConnection();
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("quantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    
}
