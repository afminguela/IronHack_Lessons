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
    
    
    // --------------------------------   Metodos sobre Clientes               -------------- 
    
    
    // Clientes; registrar uno nuevo
    
    public static void registrarCliente(Cliente cliente){  
         clientes.add(cliente);
         System.out.println("Añadido " + cliente.getNombre() +" a la lista del Taller");
        
    }
    
    // Clientes; Dar de baja 
    
    public  void bajaCliente(int idCliente){
        if(clientes.isEmpty()){
                System.out.println("\n No hay clientes para mostrar");}
        else{
            for(Cliente cliente: clientes ){
                if (cliente.getIdPersona() == idCliente){
                        clientes.remove(cliente);
                        System.out.println("El cliente: " + cliente.getNombre() +"se ha dado debaja con éxito de la lista del Taller");
                } else{ System.out.println("El cliente no existe");}
        }
    }}
   // Clientes; mostrar info  
    
    public static void mostrarInfo(int idCliente){
        for( Cliente cliente: clientes){
            if (cliente.getIdPersona() == idCliente){
                cliente.mostrarInfo(idCliente);
            }else{ System.out.println("El cliente no existe");}
        }
        
    }
    
    // Clientes; listar clientes
    public void listarClientes() {
        int counter = 0;
        
            if(clientes.isEmpty()){
                System.out.println("\n No hay clientes para mostrar");}
            else{
                System.out.println("\n Listado de Clientes");
            for (Cliente r : clientes) {
            counter++;
            
            System.out.print( counter);
            System.out.print(" - IdCliente: "+ r.getIdPersona());
            System.out.print(" - Nombre: "+ r.getNombre());
            System.out.print( " - Telefono:  "+ r.getTelefono());
                System.out.println("\n");
            }
        } 
    }
    
    // Clientes; Buscar cliente por id
    public static Cliente buscarClientesporId(int idCliente){      
        for(Cliente cliente: clientes){
            if (cliente.getIdPersona() == idCliente){
                return cliente;
            } 
                              
        }
            return null;
        
    }    
     
   //----------------Metodos sobre vehiculos  ------------------
    // Vehiculos; Registrar vehiculo
    
    public static void registrarVehiculo(Vehiculo vehiculo){
        
       vehiculos.add(vehiculo);
       System.out.println("Añadido " + vehiculo.getMatricula() +" a la lista del Taller");
              
    };
    
     // Vehiculos; dar de baja vehiculo
    public static void bajaVehiculo(String matricula){

       Vehiculo auxiliar = buscarVehiculoporMatricula(matricula);  // uso la funcion buscar por matricula y luego la funcion mostrar
       
       if (auxiliar !=null){
                vehiculos.remove(auxiliar);
                System.out.println("dado de baja el cliente: " + auxiliar.getMatricula() +" de la lista del Taller");
            } else System.out.println("El vehiculo no existe"); 
       }
    
    
     // Vehiculos; mostrar vehiculo
    
    
    
    public static void mostrarInfoVehiculo(String matricula){
       
       Vehiculo auxiliar = buscarVehiculoporMatricula(matricula);  // uso la funcion buscar por matricula y luego la funcion mostrar
       if (auxiliar !=null)
       {auxiliar.mostrarInfoVehiculo();} 
       else {System.out.println("El vehiculo no existe"); }

    }
        
    //Vehiculo; Añadir propietario a vehiculo.
    
    public static void addPropietarioVehiculo(String matricula, int idCliente){
        Vehiculo Vauxiliar = null;
        
        Vauxiliar = buscarVehiculoporMatricula(matricula);
        
        if(Vauxiliar == null){ System.out.println("El Vehiculo no existe");  // Si no está
         return;
        }
        
        Cliente cauxiliar = buscarClientesporId(idCliente); //ejecutamos buscar cliente y guardamos para reutilizar
        
        if (cauxiliar != null){
        cauxiliar.addVehiculoCliente(Vauxiliar);     // añadimos cliente al vehiculo
            System.out.println("Vehiculo asignado");
         } else{ System.out.println("El Cliente no existe");}
        
    }
    
// Vehiculos; buscar vehiculo por matricula
    
    public static Vehiculo buscarVehiculoporMatricula(String matricula){
    for(Vehiculo vehiculo: vehiculos){                // buscamos el vehiculo por la matricula
            if(vehiculo.getMatricula().equalsIgnoreCase(matricula)){
                return vehiculo;
                
            }           
        } return null;
    }
    //----------------   Metodos sobre Reparaciones  -------------------------------------------------------------------- 
    
    
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
        
    
    //Reparaciones; imprime todas las reparaciones realizadas.
    
    public void listarReparaciones() {
        int counter = 0;
        
            if(reparaciones.isEmpty()){
                System.out.println("\n No hay reparaciones para mostrar");}
            else{
                System.out.println("\n Listado de Reparaciones");
            for (Reparacion r : reparaciones) {
            counter++;
            System.out.println("\n");
            System.out.print( counter);
            System.out.print("- "+ r.getVehiculo().getMatricula());
            System.out.print( " - "+ r.getDescripcion());
            }
        } 
    }
    
  
    
    //Reparaciones;  número total de reparaciones registradas.
    
    
    public static int contarReparaciones() {
        
        System.out.println("El numero de reparaciones totales del taller  ha sido: "+ reparaciones.size());
        return reparaciones.size();
       
    }
    
    
    
    
}
