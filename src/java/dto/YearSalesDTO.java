/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author lengu
 */
public class YearSalesDTO {
   private int year;
   private int totalSales;

    public YearSalesDTO(int year, int totalSales) {
        this.year = year;
        this.totalSales = totalSales;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(int totalSales) {
        this.totalSales = totalSales;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 97 * hash + this.year;
        hash = 97 * hash + this.totalSales;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final YearSalesDTO other = (YearSalesDTO) obj;
        if (this.year != other.year) {
            return false;
        }
        if (this.totalSales != other.totalSales) {
            return false;
        }
        return true;
    }
   
   
}
