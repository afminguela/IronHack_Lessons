/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.util.*;
import java.time.*;
import home.afm.ec_taller.Vehiculo.*;

/**
 *
 * @author mama
 */
public class Reparacion {
        private int idReparacion;
        private static Vehiculo vehiculo;
        private static String descripcion;
        private double costo;
        int counter = 0;
        
    // constructor que incluye constructor de vehiculo. 
    public Reparacion(String matricula, String marca, String modelo, String descripcion, double costo) {
        this.idReparacion = counter;
        this.vehiculo = new Vehiculo(matricula,marca, modelo);
        this.descripcion = descripcion;
        this.costo= costo;
        
        counter++;
        
        
        
    }
    
    
      // Getters

    public Vehiculo getVehiculo() {
        return vehiculo;
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

    public void setVehiculo(Vehiculo vehiculo) {
        this.vehiculo = vehiculo;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setCosto(double costo) {
        this.costo = costo;
    }
    
    // metodos
        
    public static void nombreVehiculo(){
           vehiculo.mostrarInfoVehiculo();
    
    }
}
