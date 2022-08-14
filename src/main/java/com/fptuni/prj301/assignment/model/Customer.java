/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fptuni.prj301.assignment.model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Customer {
    private int id;
    private int idVipAccount;
    private String username;
    private String email;
    private String phone;
    private String password;
    private int voucherLeft;
    private Date registrationDate;
    private Date vipRegistrationDate;
    private String acessRight;

    public Customer() {
    }
    

    public Customer(int id, int idVipAccount, String username, String email, String phone, String password, int voucherLeft, Date registrationDate, Date vipRegistrationDate, String acessRight) {
        this.id = id;
        this.idVipAccount = idVipAccount;
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.voucherLeft = voucherLeft;
        this.registrationDate = registrationDate;
        this.vipRegistrationDate = vipRegistrationDate;
        this.acessRight = acessRight;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdVipAccount() {
        return idVipAccount;
    }

    public void setIdVipAccount(int idVipAccount) {
        this.idVipAccount = idVipAccount;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getVoucherLeft() {
        return voucherLeft;
    }

    public void setVoucherLeft(int voucherLeft) {
        this.voucherLeft = voucherLeft;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public Date getVipRegistrationDate() {
        return vipRegistrationDate;
    }

    public void setVipRegistrationDate(Date vipRegistrationDate) {
        this.vipRegistrationDate = vipRegistrationDate;
    }

    public String getAcessRight() {
        return acessRight;
    }

    public void setAcessRight(String acessRight) {
        this.acessRight = acessRight;
    } 
    
}
