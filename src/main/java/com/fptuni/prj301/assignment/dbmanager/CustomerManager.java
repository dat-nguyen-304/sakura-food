/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fptuni.prj301.assignment.dbmanager;

import com.fptuni.prj301.assignment.model.Customer;
import com.fptuni.prj301.assignment.model.Food;
import com.fptuni.prj301.assignment.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
public class CustomerManager {

    public List<Customer> list() {

        ArrayList<Customer> list;
        list = new ArrayList<Customer>();
        String sql = "select id, username, email, phone, password, registration_date, access_right, idVipAccount, voucher_left, vip_registration_date FROM Customers ORDER BY id ASC";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Customer(rs.getInt("id"), rs.getInt("idVipAccount"), rs.getString("username"), rs.getString("email"), rs.getString("phone"),
                        rs.getString("password"), rs.getInt("voucher_left"), rs.getDate("registration_date"), rs.getDate("vip_registration_date"), rs.getString("access_right")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Customer getById(int id) {
        ArrayList<Customer> list;
        list = new ArrayList<Customer>();
        String sql = "select id, username, email, phone, password, registration_date, access_right, idVipAccount, voucher_left, vip_registration_date "
                + "FROM Customers WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Customer(rs.getInt("id"), rs.getInt("idVipAccount"), rs.getString("username"), rs.getString("email"), rs.getString("phone"),
                        rs.getString("password"), rs.getInt("voucher_left"), rs.getDate("registration_date"), rs.getDate("vip_registration_date"), rs.getString("access_right"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public Customer getByUsername(String username) {
        ArrayList<Customer> list;
        list = new ArrayList<Customer>();
        String sql = "select id, username, email, phone, password, registration_date, access_right, idVipAccount, voucher_left, vip_registration_date "
                + "FROM Customers WHERE username = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Customer(rs.getInt("id"), rs.getInt("idVipAccount"), rs.getString("username"), rs.getString("email"), rs.getString("phone"),
                        rs.getString("password"), rs.getInt("voucher_left"), rs.getDate("registration_date"), rs.getDate("vip_registration_date"), rs.getString("access_right"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public boolean updateVip(int idCusomter, int idVip) {
        String sql = "UPDATE Customers SET idVipAccount = ?, vip_registration_date = GETDATE(), voucher_left = ? WHERE id = ?";
        String sqlGetVoucher = "SELECT voucher_quantity FROM VipAccounts WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sqlGetVoucher);
            ps.setInt(1, idVip);
            ResultSet rs = ps.executeQuery();
            int voucherLeft = 0;
            while(rs.next()) {
                voucherLeft = rs.getInt(("voucher_quantity"));
            }
            
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idVip);
            ps.setInt(2, voucherLeft);
            ps.setInt(3, idCusomter);
            int rowSuccess = ps.executeUpdate();
            if (rowSuccess > 0) return true;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
    public boolean resetVip(int idCusomter) {
        String sql = "UPDATE Customers SET idVipAccount = NULL, vip_registration_date = NULL, voucher_left = 0 WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idCusomter);
            int rowSuccess = ps.executeUpdate();
            if (rowSuccess > 0) return true;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
    public int getVoucherPercent(int idVip) {
        String sql = "SELECT voucher_percent FROM VipAccounts Where id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idVip);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("voucher_percent");
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }
    
    public int getDaysLeft(int idCustomer) {
        String sql = "SELECT V.duration - DATEDIFF(day, C.vip_registration_date,  GETDATE()) AS [dayleft] "
                + "FROM Customers C INNER JOIN VipAccounts V ON C.idVipAccount = V.id WHERE C.id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idCustomer);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("dayleft");
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int getUserQuantity() {
        String sql = "SELECT COUNT(id) AS userquantity FROM Customers WHERE access_right = 'user'";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("userquantity");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int getVipUserQuantity() {
        String sql = "SELECT COUNT(id) AS vipuserquantity FROM Customers WHERE vip_registration_date IS NOT NULL";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("vipuserquantity");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public List<Customer> getListSortByDateRegis(boolean desc) {
        ArrayList<Customer> list;
        list = new ArrayList<Customer>();
        String sql = "  SELECT id , username,email,phone,password,registration_date,access_right,idVipAccount ,voucher_left,vip_registration_date "
                + " FROM Customers  ";
        if (desc) {
            sql += "ORDER BY registration_date DESC";
        } else {
            sql += "ORDER BY registration_date ASC";
        }
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Customer(rs.getInt("id"), rs.getInt("idVipAccount"), rs.getString("username"), rs.getString("email"), rs.getString("phone"),
                        rs.getString("password"), rs.getInt("voucher_left"), rs.getDate("registration_date"), rs.getDate("vip_registration_date"), rs.getString("access_right")));

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public String getNameById(int id) {
        String sql = "SELECT username FROM Customers WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString("username");

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<Customer> getListSortByVipRegis(boolean desc) {
        ArrayList<Customer> list;
        list = new ArrayList<Customer>();
        String sql = "  SELECT id , username,email,phone,password,registration_date,access_right,idVipAccount ,voucher_left,vip_registration_date "
                + " FROM Customers  ";
        if (desc) {
            sql += "ORDER BY vip_registration_date DESC";
        } else {
            sql += "ORDER BY vip_registration_date ASC";
        }
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Customer(rs.getInt("id"), rs.getInt("idVipAccount"), rs.getString("username"), rs.getString("email"), rs.getString("phone"),
                        rs.getString("password"), rs.getInt("voucher_left"), rs.getDate("registration_date"), rs.getDate("vip_registration_date"), rs.getString("access_right")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public boolean updateVoucherQuantity(int idCustomer, int newVoucherQuantity) {
        String sql = "UPDATE Customers SET voucher_left= ? WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newVoucherQuantity);
            ps.setInt(2, idCustomer);
            int rowSuccess = ps.executeUpdate();
            if (rowSuccess > 0) {
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
    public int getVipValue(int id) {
        String sql = "SELECT C.id , voucher_value "
                + "FROM  Customers C , VipAccounts V "
                + "WHERE C.id = ? AND C.idVipAccount = V.id" ;
        int value = 0 ;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                value = rs.getInt("voucher_value");
            }
        } catch (Exception e) {
        }
        return value ;
    }
}
