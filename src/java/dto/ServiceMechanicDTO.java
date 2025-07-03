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
public class ServiceMechanicDTO {
    
    private String id;
    private String name;
    private String hours;
    private String comment;
    private double rate;
    private String idService;

    public ServiceMechanicDTO(String id, String name, String hours, String comment, double rate, String idService) {
        this.id = id;
        this.name = name;
        this.hours = hours;
        this.comment = comment;
        this.rate = rate;
        this.idService = idService;
    }
    
    
    
    public String getIdService() {
        return idService;
    }

    public void setIdService(String idService) {
        this.idService = idService;
    }
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHours() {
        return hours;
    }

    public void setHours(String hours) {
        this.hours = hours;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }
    
}
