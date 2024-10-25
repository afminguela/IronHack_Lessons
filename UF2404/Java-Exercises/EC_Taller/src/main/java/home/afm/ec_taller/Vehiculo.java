/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.util.*;
import java.time.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class Vehiculo {
    private final String matricula;
    private static String marca;
    private static String modelo;
    private static Cliente propietario;

    // contructor

    public Vehiculo(String matricula, String marca, String modelo) {
        this.matricula = matricula;
        this.marca = marca;
        this.modelo = modelo;
    }
    
    
    
    public Vehiculo(String matricula, String marca, String modelo, Cliente propietario) {
        this.matricula = matricula;
        this.marca = marca;
        this.modelo = modelo;
        this.propietario = propietario;
        
        this.propietario.addVehiculoCliente(this); //lo asociamos a un cliente
        
        
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
    
    // Setters
    
    public void setMarca(String marca) {
        this.marca = marca;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }
    
    
    
    // metodos

    
    // mostrar info vehiculo ( matricula marca modelo y dueño)

public void mostrarInfoVehiculo(){
        System.out.println("\nDatos de este vehiculo:  ");
        System.out.println("Matricula: "+ getMatricula()); 
        System.out.println("Marca: "+ getMarca()); 
        System.out.println("Modelo: "+ getModelo()); 
        System.out.println("Dueño: "+ getPropietario()); 
}
    
    
    
    
    
}
