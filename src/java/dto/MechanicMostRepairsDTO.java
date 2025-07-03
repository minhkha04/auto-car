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
public class MechanicMostRepairsDTO {
    private String name;
    private int total;
    private List<String> service;

    public MechanicMostRepairsDTO(String name, int total, List<String> service) {
        this.name = name;
        this.total = total;
        this.service = service;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<String> getService() {
        return service;
    }

    public void setService(List<String> service) {
        this.service = service;
    }
    
    
    
}
