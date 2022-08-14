/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fptuni.prj301.assignment.model;

import java.util.Date;
import java.util.List;
/**
 *
 * @author Admin
 */
public class Order {
    private int id;
    private int idCustomer;
    private String address;
    private String phone;
    private String note;
    private int originalPrice;
    private int discount;
    private int finalPrice;
    private Date date;

    public Order() {
    }

    public Order(int id, int idCustomer, String address, String phone, String note, int originalPrice, int discount, int finalPrice, Date date) {
        this.id = id;
        this.idCustomer = idCustomer;
        this.address = address;
        this.phone = phone;
        this.note = note;
        this.originalPrice = originalPrice;
        this.discount = discount;
        this.finalPrice = finalPrice;
        this.date = date;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCustomer() {
        return idCustomer;
    }

    public void setIdCustomer(int idCustomer) {
        this.idCustomer = idCustomer;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(int originalPrice) {
        this.originalPrice = originalPrice;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(int finalPrice) {
        this.finalPrice = finalPrice;
    }
    
    
}
