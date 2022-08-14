/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fptuni.prj301.assignment.dbmanager;

import com.fptuni.prj301.assignment.model.Item;
import com.fptuni.prj301.assignment.model.UserSession;
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
public class AccessManager {

    public UserSession login(String username, String password) {
        String sql = "SELECT username, password, access_right FROM Customers WHERE username = ? and password = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                UserSession us = new UserSession();
                us.setUsername(username);
                us.setLoginDate(new Date());
                us.setAccessRight(rs.getString("access_right"));
                List<Item> cart = new ArrayList<>();
                us.setCart(cart);
                return us;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean signup(String username, String password, String email, String phone) {
        String sql = "INSERT INTO Customers (username, password, email, phone) "
                + "VALUES(?, ?, ?, ?)";
        int rowAffected = 0;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, phone);
            rowAffected = ps.executeUpdate();
            if (rowAffected > 0) return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
        return false;
    }
    
    public boolean checkUsername(String userName) {
        String sql = "SELECT username FROM Customers WHERE username = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return false;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return true;
    }

    public boolean checkPhone(String phone) {
        String sql = "SELECT phone FROM Customers WHERE phone = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return false;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return true;
    }

    public boolean checkEmail(String email) {
        String sql = "SELECT email FROM Customers WHERE email = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return false;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return true;
    }
}
