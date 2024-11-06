/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.tallerappspring;

import java.sql.SQLException;
import java.util.*;
import java.util.*;
import java.time.*;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


/**
 *
 * @author Ana Fdez Minguela
 */
public class Reparacion {
        
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) 
    @Column(name = "id_Reparacion")
        private int idReparacion;
    @Column(name = "vehiculo")
        private static Long idVehiculo;// lo que tengo de columna 
        private static String descripcion;
        private double costo;
        
        
    // constructor que incluye constructor de vehiculo. 
    public Reparacion(String matricula, String marca, String modelo, String descripcion, double costo) throws SQLException {
        Vehiculo nuevoVehiculo = new Vehiculo(matricula,marca, modelo);
        this.idVehiculo = nuevoVehiculo.getIdVehiculo();
        this.descripcion = descripcion;
        this.costo= costo;
        
       
        
        
    }

    public Reparacion() {  // para los DAO
       
    }
    
    
      // Getters

    public Long getVehiculo() {
        return idVehiculo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public double getCosto() {
        return costo;
    }
    
    public int getIdReparacion(){
        return idReparacion;
    }
    
    // setters 

    public void setVehiculo(Long IdVehiculo) {
        this.idVehiculo = idVehiculo;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setCosto(double costo) {
        this.costo = costo;
    }
    
         
    

    public void setIdReparacion(int idReparacion) {
       
        
          this.idReparacion = idReparacion;
        }
    }
    
    