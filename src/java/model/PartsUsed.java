/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author ttrrang
 */
public class PartsUsed {
    private int serviceTicketID;
    private int partID;
    private int numberUsed;
    private double price;

    public PartsUsed() {
    }

    public PartsUsed(int serviceTicketID, int partID, int numberUsed, double price) {
        this.serviceTicketID = serviceTicketID;
        this.partID = partID;
        this.numberUsed = numberUsed;
        this.price = price;
    }

    public int getServiceTicketID() {
        return serviceTicketID;
    }

    public void setServiceTicketID(int serviceTicketID) {
        this.serviceTicketID = serviceTicketID;
    }

    public int getPartID() {
        return partID;
    }

    public void setPartID(int partID) {
        this.partID = partID;
    }

    public int getNumberUsed() {
        return numberUsed;
    }

    public void setNumberUsed(int numberUsed) {
        this.numberUsed = numberUsed;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
