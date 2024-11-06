/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.sql.SQLException;
import java.util.*;
import java.time.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class Vehiculo {
    private static int idVehiculo;
    private static String matricula;
    private static String marca;
    private static String modelo;
    private static Cliente propietario;
    
    int counter = 0;
    // contructor

    public Vehiculo(String matricula, String marca, String modelo) {
        this.matricula = matricula;
        this.marca = marca;
        this.modelo = modelo;
        this.idVehiculo=counter;
        counter++;
    }
    
    public Vehiculo() {
        // para rellenar con SQL SOLO!!
    }
    
    public Vehiculo(String matricula, String marca, String modelo, Cliente propietario) {
        this.matricula = matricula;
        this.marca = marca;
        this.modelo = modelo;
        this.propietario = propietario;
        this.idVehiculo= counter;
        
        //this.propietario.addVehiculoCliente(this); //lo asociamos a un cliente
        
        counter++;
        
    }

    
        
    
    // getters
    public String getMarca() {
        return marca;
    }

    public String getModelo() {
        return modelo;
    }
    
    public String getMatricula(){
        return matricula;
    }
    
    public Cliente getPropietario() {
        return propietario; 
    }
    
    public int getIdVehiculo() {
        return idVehiculo;
    }
    
    // Setters
    
    public void setMarca(String marca) {
        this.marca = marca;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    
    public void setIdVehiculo(int idVehiculo){
        if(idVehiculo != 0){
            this.idVehiculo = idVehiculo;
        } else {
            this.idVehiculo = counter;
        }
    }
    
    
    // metodos

    
    // mostrar info vehiculo ( matricula marca modelo y dueño)

//public void mostrarInfoVehiculo(){
//        System.out.println("\nDatos de este vehiculo:  ");
//        System.out.println("Matricula: "+ getMatricula()); 
//        System.out.println("Marca: "+ getMarca()); 
//        System.out.println("Modelo: "+ getModelo()); 
//        System.out.println("Dueño: "+ getPropietario()); 
//}
    

    public static void insertVehiculo(Vehiculo vehiculo){
            try {
                VehiculoController.insertVehiculo(vehiculo);
            } catch (SQLException e) {
                System.out.println("Ha fallado el insert msg de cliente " + e.getMessage()); }
    }
    
    public static Vehiculo buscarVehiculoporMatricula(String matricula){
            try {
                VehiculoController.buscarVehiculoPorMatricula(matricula);
            } catch (SQLException e) {
                System.out.println("Ha fallado borrar cliente" + e.getMessage()); }
            return null;
            
    }   
 
 public static void borrarVehiculo(String matricula){
            try {
                VehiculoController.borrarVehiculo(matricula);
            } catch (SQLException e) {
                System.out.println("Ha fallado borrar cliente" + e.getMessage()); }
      
 
}
 public static void listarVehiculos() {
 
     try{
         VehiculoController.listarVehiculos();
     } catch (SQLException e) {
                System.out.println("Ha fallado borrar cliente" + e.getMessage()); }
 }
 
    
}
