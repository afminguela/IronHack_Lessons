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
public class Taller {
        private final String nombre;
        private static List<Cliente> clientes;
        private static List<Reparacion> reparaciones; 
        private static List<Vehiculo> vehiculos; 
        

        // Constructor de Vehiculo
        
    public Taller(String nombre) {
        this.nombre = nombre;
        clientes = new ArrayList<>();
        reparaciones = new ArrayList<>();
        vehiculos = new ArrayList<>();
          }

        // getters 
    
    
    public String getNombre() {
        return nombre;
    }
    
    public List<Reparacion> getReparaciones(){
        return reparaciones;
    }
   
    public List<Cliente> getClientes(){
        return clientes;
    }
    
    public List<Vehiculo> getVehiculos(){
        return vehiculos;
    }
    
    
    // --------------------------------   Metodos                 -------------- 
    
    
    // Clientes; registrar uno nuevo
    
    public static void registrarCliente(Cliente cliente){  
         clientes.add(cliente);
         System.out.println("Añadido " + cliente.getNombre() +" a la lista del Taller");
        
    }
    
    // Clientes; Dar de baja 
    
    public  void bajaCliente(int idCliente){
        for(Cliente cliente: clientes ){
            if (cliente.getIdPersona() == idCliente){
            clientes.remove(cliente);
            System.out.println("dado de baja el cliente: " + cliente.getNombre() +" de la lista del Taller");
        }
        }
    }
   // Clientes; mostrar info  
    
    public static void mostrarInfo(int idCliente){
        for( Cliente cliente: clientes){
            if (cliente.getIdPersona() == idCliente){
                cliente.mostrarInfo(idCliente);
            }
        }
        
    }
    
    
    // Vehiculos; Registrar vehiculo
    
    public static void registrarVehiculo(Vehiculo vehiculo){
        
       vehiculos.add(vehiculo);
       System.out.println("Añadido " + vehiculo.getMatricula() +" a la lista del Taller");
              
    };
    
     // Vehiculos; dar de baja vehiculo
    public static void bajaVehiculo(String matricula){
       for(Vehiculo vehiculo: vehiculos ){
            if (vehiculo.getMatricula().equalsIgnoreCase(matricula)){
                vehiculos.remove(vehiculo);
                System.out.println("dado de baja el cliente: " + vehiculo.getMatricula() +" de la lista del Taller");
            }
       }
    }
    
     // Vehiculos; mostrar vehiculo
    
    
    
    public static void mostrarInfoVehiculo(String matricula){
        for( Vehiculo vehiculo: vehiculos){
            if (vehiculo.getMatricula().equalsIgnoreCase(matricula)){
                vehiculo.mostrarInfoVehiculo();
            }
        }
    }
        
    //Vehiculo; Añadir propietario a vehiculo.
    
    public static void addPropietarioVehiculo(String matricula, int idCliente){
        Vehiculo Vauxiliar = null;
        
        for(Vehiculo vehiculo: vehiculos){
            if(vehiculo.getMatricula().equalsIgnoreCase(matricula)){
                Vauxiliar = vehiculo;
            }           
        }
        for( Cliente cliente: clientes){
            if (cliente.getIdPersona() == idCliente){
                cliente.addVehiculoCliente(Vauxiliar);
            }
        }
        
        
    
    }
    
    // Reparaciones; Registrar nueva reparacion
    
    public static void realizarReparacion(Reparacion reparacion){  
                reparaciones.add(reparacion);
           System.out.println("\nAñadida reparacion " + reparacion.getDescripcion() +" a la lista del Taller");
    }
    
    // Reparaciones; Dar de baja reparacion
    
    public static void bajaReparacion(int idReparacion){  
        for(Reparacion reparacion: reparaciones){
            if (reparacion.getIdReparacion() == idReparacion) {
           reparaciones.remove(reparacion);
           System.out.println("\nQuitada reparacion " + reparacion.getDescripcion() +" de la lista del Taller");
           }
        }
       
    }
        
    
    //Reparaciones; listarReparaciones() que imprima todas las reparaciones realizadas.
    
    public void listarReparaciones() {
        int counter = 0;
        for (Reparacion r : reparaciones) {
            counter++;
            System.out.println("\n");
            System.out.print( counter);
            System.out.print("- "+ r.getVehiculo().getMatricula());
            System.out.print( " - "+ r.getDescripcion());
        } 
    }
    
    //Reparaciones;  contarReparaciones() que devuelva el número total de reparaciones registradas.
    
    
    public static int contarReparaciones() {
        
        System.out.println("El numero de reparaciones totales del taller  ha sido: "+ reparaciones.size());
        return reparaciones.size();
       
    }
    
    
    
    
}
