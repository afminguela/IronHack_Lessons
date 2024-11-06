/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.sql.SQLException;
import java.util.*;
import java.util.*;
import java.time.*;
import home.afm.ec_taller.Vehiculo.*;

/**
 *
 * @author Ana Fdez Minguela
 */
public class Reparacion {
        private int idReparacion;
        private static Vehiculo vehiculo;
        private static String descripcion;
        private double costo;
        int counter = 0;
        
    // constructor que incluye constructor de vehiculo. 
    public Reparacion(String matricula, String marca, String modelo, String descripcion, double costo) throws SQLException {
        this.idReparacion = counter;
        this.vehiculo = new Vehiculo(matricula,marca, modelo);
        this.descripcion = descripcion;
        this.costo= costo;
        insertReparacion(this);
        counter++;
        
        
        
    }

    public Reparacion() {  // para los DAO
       
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
    
         
    

    public void setIdReparacion(int idReparacion) {
       if(idReparacion==0){
        
           this.idReparacion = counter;
        } else{
            this.idReparacion = idReparacion;
        }
    }
    
    public static void insertReparacion(Reparacion reparacion)throws SQLException{
            try {
                ReparacionDAO.insertReparacion(reparacion);
            } catch (SQLException e) {
                System.out.println("Ha fallado el insert de la reparacion " + e.getMessage()); }
    }   
 
 public static Reparacion buscarReparacionporId(int idReparacion) throws SQLException{
            try {
                ReparacionDAO.buscarReparacionPorId(idReparacion);
            } catch (SQLException e) {
                System.out.println("Ha fallado borrar cliente" + e.getMessage()); }
            return null;
            
    }   
 
 public static void borrarReparacion(int idReparacion) throws SQLException {
            try {
                ReparacionDAO.borrarReparacion(idReparacion);
            } catch (SQLException e) {
                System.out.println("Ha fallado borrar cliente" + e.getMessage()); }
      
 
}
 public static void listarReparaciones()  {
 
     try{
         ReparacionDAO.listarReparaciones();
     } catch (SQLException e) {
                System.out.println("Ha fallado borrar cliente" + e.getMessage()); }
 }
 
}
