/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.util.*;
import java.time.*;

/**
 *
 * @author mama
 */
public class Cliente extends Persona {     // la clase Cliente extiende la clase abstracta persona que tiene 
                                           // los atributos idPersona generado automaticamente por un contador, nombre y telefono.
        private List<Vehiculo> Vehiculos;   // añade una lista de vehiculos
    
       
        
    // Constructor    
     public Cliente(String nombre, String telefono) {
        super(nombre, telefono);
        this.Vehiculos = new ArrayList<>();
        mostrarInfo(super.idPersona);
        
       
    }       

        
     
    // Getters  

    public List<Vehiculo> getVehiculos() {
        return Vehiculos;
    }

    
    
    // setters
    public void setVehiculos(List<Vehiculo> Vehiculos) {
        this.Vehiculos = Vehiculos;
    }
    
     
    // métodos
     
    
    // Muestra la info del Cliente
    @Override
    public void mostrarInfo(int idCliente) {
        if(this.getIdPersona() == idCliente){
         System.out.println("\nEl Cliente " + this.getIdPersona() + " se llama  " + this.getNombre()+ " y su telefono es " + this.getTelefono());
        } else { System.out.println("\nCliente no encontrado");}
    }
    
    
    // añade un Vehiculo a la lista de vehiculos en cliente
    public void addVehiculoCliente(Vehiculo vehiculo){
           
            this.Vehiculos.add(vehiculo);
            System.out.println("\n Se ha Añadido el vehiculo con matricula: "+ vehiculo.getModelo() + " a la lista del Cliente "+ this.getNombre());
    }
    
    // elimina un vehiculo de la lista del cliente
    public void removeVehiculoCliente(Vehiculo vehiculo){
           
            this.Vehiculos.remove(vehiculo);
            System.out.println("\n Se ha quitado el vehiculo: "+ vehiculo.getModelo() + " a la lista del Cliente " + this.getNombre());
    }
    
    
    
}
