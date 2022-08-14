/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fptuni.prj301.assignment.dbmanager;

import com.fptuni.prj301.assignment.model.DiscountFood;
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
public class DiscountFoodManager {
    public List<DiscountFood> list() {

        ArrayList<DiscountFood> list;
        list = new ArrayList<DiscountFood>();
        String sql = "select fos.id as idFos, f.id as idF, f.name, f.img_link, f.original_price, fos.discount_percent, f.discount, f.final_price "
                + "from Foods f INNER JOIN FoodsOnSale fos ON f.id = fos.idFood";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int fodId = rs.getInt("idFos");
                int fId = rs.getInt("idF");
                String name = rs.getString("name");
                String link = rs.getString("img_link");
                int originPrice = rs.getInt("original_price");
                int discountPercent = rs.getInt("discount_percent");
                int discount = rs.getInt("discount");
                int finalPrice = rs.getInt("final_price");
                list.add(new DiscountFood(fodId, fId, name, link, originPrice, discountPercent, discount, finalPrice));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public List<DiscountFood> getSliderList() {

        ArrayList<DiscountFood> list;
        list = new ArrayList<DiscountFood>();
        String sql = "select TOP 10 fos.id as idFos, f.id as idF, f.name, f.img_link, f.original_price, fos.discount_percent, f.discount, f.final_price "
                + "from Foods f INNER JOIN FoodsOnSale fos ON f.id = fos.idFood ORDER BY fos.discount_percent DESC";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int fodId = rs.getInt("idFos");
                int fId = rs.getInt("idF");
                String name = rs.getString("name");
                String link = rs.getString("img_link");
                int originPrice = rs.getInt("original_price");
                int discountPercent = rs.getInt("discount_percent");
                int discount = rs.getInt("discount");
                int finalPrice = rs.getInt("final_price");
                list.add(new DiscountFood(fodId, fId, name, link, originPrice, discountPercent, discount, finalPrice));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public DiscountFood getById(int id) {
        String sql = "select fos.id as idFos, f.id as idF, f.name, f.img_link, f.original_price, fos.discount_percent, f.discount, f.final_price "
                + "from Foods f INNER JOIN FoodsOnSale fos ON f.id = fos.idFood WHERE fos.id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int fodId = rs.getInt("idFos");
                int fId = rs.getInt("idF");
                String name = rs.getString("name");
                String link = rs.getString("img_link");
                int originPrice = rs.getInt("original_price");
                int discountPercent = rs.getInt("discount_percent");
                int discount = rs.getInt("discount");
                int finalPrice = rs.getInt("final_price");
                return new DiscountFood(fodId, fId, name, link, originPrice, discountPercent, discount, finalPrice);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public DiscountFood getByIdFood(int idFood) {
        String sql = "select fos.id as idFos, f.id as idF, f.name, f.img_link, f.original_price, fos.discount_percent, f.discount, f.final_price "
                + "from Foods f INNER JOIN FoodsOnSale fos ON f.id = fos.idFood WHERE f.id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idFood);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int fodId = rs.getInt("idFos");
                int fId = rs.getInt("idF");
                String name = rs.getString("name");
                String link = rs.getString("img_link");
                int originPrice = rs.getInt("original_price");
                int discountPercent = rs.getInt("discount_percent");
                int discount = rs.getInt("discount");
                int finalPrice = rs.getInt("final_price");
                return new DiscountFood(fodId, fId, name, link, originPrice, discountPercent, discount, finalPrice);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public int getDiscountQuantity() {
        String sql = "SELECT COUNT(id) AS discountquantity FROM FoodsOnSale";
        int amount = 0 ;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                amount = rs.getInt("discountquantity");
            }
        } catch (Exception e) {
        }
        return amount ;
    }
    
    public boolean insert(int idFood, int discount) {
        String sqlFol = "INSERT INTO FoodsOnSale(idFood, discount_percent) VALUES(?, ?)";
        String sqlF = "UPDATE Foods SET discount = ? , final_price = ? WHERE id = ?";
        FoodManager fm = new FoodManager();
        int originPrice = fm.getById(idFood).getOriginalPrice();
        try {
            Connection connect = DBUtils.getConnection();
            PreparedStatement psFol = connect.prepareStatement(sqlFol);
            PreparedStatement psF = connect.prepareStatement(sqlF);
            psFol.setInt(1, idFood);
            psFol.setInt(2, discount);
            int discountMoney = (int)Math.round(originPrice / 1000 * ((double)discount / 100)) * 1000;
            psF.setInt(1, discountMoney);
            psF.setInt(2, originPrice - discountMoney);
            psF.setInt(3, idFood);
            psFol.executeUpdate();
            psF.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean update(int idFood, int originPrice, int discount) {
        String sqlFol = "UPDATE FoodsOnSale SET discount_percent = ? WHERE idFood = ?";
        String sqlF = "UPDATE Foods SET discount = ? , final_price = ? WHERE id = ?";
        try {
            Connection connect = DBUtils.getConnection();
            PreparedStatement psFol = connect.prepareStatement(sqlFol);
            PreparedStatement psF = connect.prepareStatement(sqlF);
            psFol.setInt(1, discount);
            psFol.setInt(2, idFood);
            int discountMoney = (int)Math.round(originPrice / 1000 * ((double)discount / 100)) * 1000;
            psF.setInt(1, discountMoney);
            psF.setInt(2, originPrice - discountMoney);
            psF.setInt(3, idFood);
            int row1 = psFol.executeUpdate();
            int row2 = psF.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    
    public boolean remove(int id) {
        String query_delete = "DELETE FROM FoodsOnSale WHERE idFood = ?";
        String update_food = "UPDATE Foods SET discount = ? , final_price = ? WHERE id = ? ";
        FoodManager fm = new FoodManager();
        Food f = fm.getById(id);
       
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement stm1 = conn.prepareStatement(query_delete);
            PreparedStatement stm2 = conn.prepareStatement(update_food);
            stm1.setInt(1,id);
            stm2.setInt(1, 0);
            stm2.setInt(2, f.getOriginalPrice());
            stm2.setInt(3, id);
            stm1.executeUpdate();
            stm2.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
