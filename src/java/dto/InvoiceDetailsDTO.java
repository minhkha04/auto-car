/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.sql.Date;

/**
 *
 * @author lengu
 */
public class InvoiceDetailsDTO {
    private String invoiceID;
    private Date invoiceDate;
    private String carModel;
    private String carColour;
    private String salesName;
    private double carPrice;


    public InvoiceDetailsDTO(String invoiceID, Date invoiceDate, String carModel, String carColour, String salesName, double carPrice) {
        this.invoiceID = invoiceID;
        this.invoiceDate = invoiceDate;
        this.carModel = carModel;
        this.carColour = carColour;
        this.salesName = salesName;
        this.carPrice = carPrice;
    }

    public double getCarPrice() {
        return carPrice;
    }

    public void setCarPrice(double carPrice) {
        this.carPrice = carPrice;
    }

    
    public String getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(String invoiceID) {
        this.invoiceID = invoiceID;
    }

    public Date getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(Date invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public String getCarModel() {
        return carModel;
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    public String getCarColour() {
        return carColour;
    }

    public void setCarColour(String carColour) {
        this.carColour = carColour;
    }

    public String getSalesName() {
        return salesName;
    }

    public void setSalesName(String salesName) {
        this.salesName = salesName;
    }
    
    
}
