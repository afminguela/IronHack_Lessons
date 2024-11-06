/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.tallerappspring;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class Vehiculo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private static Long idVehiculo;
    private static String matricula;
    private static String marca;
    private static String modelo;
    private static Long propietario;
    
    int counter = 0;
    // contructor

    public Vehiculo(String matricula, String marca, String modelo) {
        this.matricula = matricula;
        this.marca = marca;
        this.modelo = modelo;
        
    }
    
    public Vehiculo() {
        // para rellenar con SQL SOLO!!
    }
    
    public Vehiculo(String matricula, String marca, String modelo, Long propietario) {
        this.matricula = matricula;
        this.marca = marca;
        this.modelo = modelo;
        this.propietario = propietario;
        
        
        
        
        
        
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
    
    public Long getPropietario() {
        return propietario; 
    }
    
    public Long getIdVehiculo() {
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
    
    public void setIdVehiculo(Long idVehiculo){
        
            this.idVehiculo = idVehiculo;
        
        }
    }
    
    
  

   