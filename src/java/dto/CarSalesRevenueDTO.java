/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.util.List;

/**
 *
 * @author lengu
 */
public class CarSalesRevenueDTO {
    private int year;
    private String revenue;
    private List<String> model;

    public CarSalesRevenueDTO(int year, String revenue, List<String> model) {
        this.year = year;
        this.revenue = revenue;
        this.model = model;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getRevenue() {
        return revenue;
    }

    public void setRevenue(String revenue) {
        this.revenue = revenue;
    }

    public List<String> getModel() {
        return model;
    }

    public void setModel(List<String> model) {
        this.model = model;
    }
    
    
    
    
}
