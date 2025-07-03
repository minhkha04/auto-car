/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author lengu
 */
public class Customer {
    private String cusID;
    private String cusName;
    private String phone;
    private String sex;
    private String cusAddress;

    public Customer(String cusID, String cusName, String phone, String sex, String cusAddress) {
        this.cusID = cusID;
        this.cusName = cusName;
        this.phone = phone;
        this.sex = sex;
        this.cusAddress = cusAddress;
    }

    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getCusAddress() {
        return cusAddress;
    }

    public void setCusAddress(String cusAddress) {
        this.cusAddress = cusAddress;
    }
    
    
}
