/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fptuni.prj301.assignment.model;

/**
 *
 * @author Admin
 */
public class DiscountFood {
    private int id;
    private int idFood;
    private String name;
    private String link;
    private int originPrice;
    private int discountPercent;
    private int discount;
    private int finalPrice;

    public DiscountFood() {
    }

    public DiscountFood(int id, int idFood, String name, String link, int originPrice, int discountPercent, int discount, int finalPrice) {
        this.id = id;
        this.idFood = idFood;
        this.name = name;
        this.link = link;
        this.originPrice = originPrice;
        this.discountPercent = discountPercent;
        this.discount = discount;
        this.finalPrice = finalPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdFood() {
        return idFood;
    }

    public void setIdFood(int idFood) {
        this.idFood = idFood;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public int getOriginPrice() {
        return originPrice;
    }

    public void setOriginPrice(int originPrice) {
        this.originPrice = originPrice;
    }

    public int getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(int discountPercent) {
        this.discountPercent = discountPercent;
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
