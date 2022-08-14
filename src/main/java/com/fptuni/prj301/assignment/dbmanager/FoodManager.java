/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fptuni.prj301.assignment.dbmanager;

import com.fptuni.prj301.assignment.model.Food;
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
public class FoodManager {

    public List<Food> list() {

        ArrayList<Food> list;
        list = new ArrayList<Food>();
        String sql = "select id, name, img_link, description, sold_quantity, idCategory, original_price, discount, final_price FROM Foods";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Food(rs.getInt("id"), rs.getString("name"), rs.getString("img_link"), rs.getString("description"), rs.getInt("idCategory"),
                        rs.getInt("sold_quantity"), rs.getInt("original_price"), rs.getInt("discount"), rs.getInt("final_price")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Food getById(int id) {
        String sql = "select id, name, img_link, description, sold_quantity, idCategory, original_price, discount, final_price FROM Foods WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Food(rs.getInt("id"), rs.getString("name"), rs.getString("img_link"), rs.getString("description"), rs.getInt("idCategory"),
                        rs.getInt("sold_quantity"), rs.getInt("original_price"), rs.getInt("discount"), rs.getInt("final_price"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<Food> getByCateId(int cateId) {
        ArrayList<Food> list;
        list = new ArrayList<Food>();
        String sql = "select id, name, img_link, description, sold_quantity, idCategory, original_price, discount, final_price FROM Foods WHERE idCategory = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cateId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Food(rs.getInt("id"), rs.getString("name"), rs.getString("img_link"), rs.getString("description"), rs.getInt("idCategory"),
                        rs.getInt("sold_quantity"), rs.getInt("original_price"), rs.getInt("discount"), rs.getInt("final_price")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<Food> getRelatedList(Food food) {
        ArrayList<Food> list;
        list = new ArrayList<Food>();
        String sql = "SELECT TOP 5 id, name, img_link, description, sold_quantity, idCategory, original_price, discount, final_price FROM Foods "
                + "WHERE idCategory = ? AND id <> ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, food.getIdCategory());
            ps.setInt(2, food.getId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Food(rs.getInt("id"), rs.getString("name"), rs.getString("img_link"), rs.getString("description"), rs.getInt("idCategory"),
                        rs.getInt("sold_quantity"), rs.getInt("original_price"), rs.getInt("discount"), rs.getInt("final_price")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<Food> getByKeyword(String keyword) {
        ArrayList<Food> list;
        list = new ArrayList<Food>();
        String sql = "select id, name, img_link, description, sold_quantity, idCategory, original_price, discount, final_price FROM Foods WHERE name like ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Food(rs.getInt("id"), rs.getString("name"), rs.getString("img_link"), rs.getString("description"), rs.getInt("idCategory"),
                        rs.getInt("sold_quantity"), rs.getInt("original_price"), rs.getInt("discount"), rs.getInt("final_price")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public String getNameCategory(int idCategory) {
        String sql = "SELECT name FROM Categories WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idCategory);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean insert(String name, String imgLink, String description, int idCategory, int originalPrice, int finalPrice) {
        String sql = "INSERT INTO Foods(name, img_link, description, idCategory, original_Price, final_price) VALUES(?, ?, ?, ?, ?, ?)";
        try {
            Connection connect = DBUtils.getConnection();
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, imgLink);
            ps.setString(3, description);
            ps.setInt(4, idCategory);
            ps.setInt(5, originalPrice);
            ps.setInt(6, finalPrice);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean update(int id, String name, String desc, int price, int finalPrice) {
        String sql = "Update foods set name = ?, description = ?, original_Price = ?, final_Price = ? where id = ?";
        try {
            Connection connect = DBUtils.getConnection();
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, desc);
            ps.setInt(3, price);
            ps.setInt(4, finalPrice);
            ps.setInt(5, id);
            int rowSuccess = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        int percent = -1;
        String getPercent = "SELECT discount_percent FROM FoodsOnsale WHERE idFood = ?";
        try {
            Connection connect = DBUtils.getConnection();
            PreparedStatement ps = connect.prepareStatement(getPercent);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                percent = rs.getInt("discount_percent");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        if (percent != -1) {
            String updateFinalPercent = "Update foods set discount = ?, final_price = ? where id = ?";
            try {
                Connection connect = DBUtils.getConnection();
                PreparedStatement ps = connect.prepareStatement(updateFinalPercent);
                int discountMoney = (int) Math.round(price / 1000 * ((double) percent / 100)) * 1000;
                ps.setInt(1, discountMoney);
                ps.setInt(2, price - discountMoney);
                ps.setInt(3, id);
                ps.executeUpdate();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return true;
    }

    public boolean remove(int id) {
        String sqlI = "DELETE FROM Items WHERE idFood = ?";
        String sqlO = "DELETE FROM FoodsOnSale WHERE idFood = ?";
        String sqlC = "DELETE FROM Comments WHERE idFood = ?";
        String sqlF = "DELETE FROM Foods WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement psI = conn.prepareStatement(sqlI);
            PreparedStatement psO = conn.prepareStatement(sqlO);
            PreparedStatement psC = conn.prepareStatement(sqlC);
            PreparedStatement psF = conn.prepareStatement(sqlF);
            psI.setInt(1, id);
            psO.setInt(1, id);
            psC.setInt(1, id);
            psF.setInt(1, id);
            psI.executeUpdate();
            psO.executeUpdate();
            psC.executeUpdate();
            psF.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public int getCoffeeQuantity() {
        String sql = "SELECT sum(sold_quantity) as quantity FROM Foods WHERE idCategory = 4";
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

    public int getBreadQuantity() {
        String sql = "SELECT sum(sold_quantity) as quantity FROM Foods WHERE idCategory = 3";
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
