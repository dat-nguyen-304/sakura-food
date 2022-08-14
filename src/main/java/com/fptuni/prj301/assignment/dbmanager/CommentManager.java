/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fptuni.prj301.assignment.dbmanager;

import com.fptuni.prj301.assignment.model.Comment;
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
public class CommentManager {
    public List<Comment> list() {

        ArrayList<Comment> list;
        list = new ArrayList<Comment>();
        String sql = "select id, idFood, idCustomer, content, date FROM Comments";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Comment(rs.getInt("id"), rs.getInt("idFood"), rs.getInt("idCustomer"), rs.getString("content"), rs.getDate("date")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public List<Comment> getByIdFood(int idFood) {
        ArrayList<Comment> list;
        list = new ArrayList<Comment>();
        String sql = "select id, idFood, idCustomer, content, date FROM Comments WHERE idFood = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idFood);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Comment(rs.getInt("id"), rs.getInt("idFood"), rs.getInt("idCustomer"), rs.getString("content"), rs.getDate("date")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public boolean addComment(int idCustomer, int idFood, String content) {
        String sql = "INSERT INTO Comments(idCustomer, idFood, content) VALUES(?, ?, ?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idCustomer);
            ps.setInt(2, idFood);
            ps.setString(3, content);
            int rowSuccess = ps.executeUpdate();
            if (rowSuccess > 0) return true;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
}
