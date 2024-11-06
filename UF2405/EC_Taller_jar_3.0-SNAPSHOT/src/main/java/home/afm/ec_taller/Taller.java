/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import home.afm.ec_taller.Cliente;
import home.afm.ec_taller.ClienteController;
import home.afm.ec_taller.Vehiculo;
import home.afm.ec_taller.VehiculoController;
import java.sql.SQLException;
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
    
    public void registrarCliente(Cliente cliente) throws Exception {  
        try { Cliente aux = cliente;
        cliente.insertCliente( aux );
         System.out.println("Añadido " + aux.getNombre() +" a la lista del Taller");
        } catch(Exception e){ System.out.println("Ha fallado porque" + e.getMessage()); }
    }
    
    // Clientes; Dar de baja 
    
    public static void bajaCliente(int idCliente){
        Cliente aux;
            aux = Cliente.buscarClienteporId(idCliente);
                if ((Cliente.buscarClienteporId(idCliente)) != null){
                    
                    Cliente.borrarCliente(aux);
                        System.out.println("El cliente: " + aux.getNombre() +"se ha dado debaja con éxito de la lista del Taller");
                } else{ System.out.println("El cliente no existe");}
        }
    
   // Clientes; mostrar info  
    
    public static void mostrarInfo(int idCliente){
        Cliente aux;
            aux = Cliente.buscarClienteporId(idCliente);
            
        if ((Cliente.buscarClienteporId(idCliente)) != null){
                aux.mostrarInfo(idCliente);
            }else{ System.out.println("El cliente no existe");}
        }
        
    
    
    // Clientes; listar clientes
    public static void listarClientes() throws SQLException {
        ClienteController.listarClientes();
        } 
    
    
    // Clientes; Buscar cliente por id
//    public static Cliente buscarClientesporId(int idCliente){      
//        for(Cliente cliente: clientes){
//            if (cliente.getIdPersona() == idCliente){
//                return cliente;
//            } 
//                              
//        }
//            return null;
//        
//    }    
     
   //----------------Metodos sobre vehiculos  ------------------
    // Vehiculos; Registrar vehiculo
    
    public static void registrarVehiculo(Vehiculo vehiculo){
      try { Vehiculo aux = vehiculo;
        vehiculo.insertVehiculo( aux );
         System.out.println("Añadido vehiculo " + aux.getMatricula() +" a la lista del Taller");
        } catch(Exception e){ System.out.println("Ha fallado porque" + e.getMessage()); }   
    }
    
     // Vehiculos; dar de baja vehiculo
    public static void bajaVehiculo(String matricula) throws SQLException{

       Vehiculo auxiliar = buscarVehiculoporMatricula(matricula);  // uso la funcion buscar por matricula y luego la funcion mostrar
       
       if (auxiliar !=null){
                VehiculoController.borrarVehiculo(matricula);
                System.out.println("dado de baja el cliente: " + auxiliar.getMatricula() +" de la lista del Taller");
            } else System.out.println("El vehiculo no existe"); 
       }
    
    
     // Vehiculos; mostrar vehiculo
       
    public static void mostrarInfoVehiculo(String matricula) throws SQLException{
       
       VehiculoController.buscarVehiculoPorMatricula(matricula);  // uso la funcion buscar por matricula y luego la funcion mostrar
       
}
    
        
    public static void addPropietarioVehiculo(String matricula, int idCliente) throws SQLException{
        Vehiculo Vauxiliar = new Vehiculo();
        
        Vauxiliar = buscarVehiculoporMatricula(matricula);
        
        if(Vauxiliar == null){ System.out.println("El Vehiculo no existe");  // Si no está
        }
        
        Cliente cauxiliar = new Cliente();
           cauxiliar =  ClienteController.buscarClientePorId(idCliente); //ejecutamos buscar cliente y guardamos para reutilizar
        
        if (cauxiliar != null){
        Cliente.addVehiculoCliente(idCliente, matricula);     // añadimos cliente al vehiculo
            System.out.println("Vehiculo asignado");
         } else{ System.out.println("El Cliente no existe");}
        
    }

// Vehiculos; buscar vehiculo por matricula
    
    public static Vehiculo buscarVehiculoporMatricula(String matricula) throws SQLException{
    return VehiculoController.buscarVehiculoPorMatricula(matricula); 
     }
// Listar todos los vehiculos

     public static void listarVehiculos() throws SQLException{
     VehiculoController.listarVehiculos();
}
    //----------------   Metodos sobre Reparaciones  -------------------------------------------------------------------- 
    
    
// Reparaciones; Registrar nueva reparacion
    
    public static void insertReparacion(Reparacion reparacion){  
                reparaciones.add(reparacion);
           System.out.println("\nAñadida reparacion " + reparacion.getDescripcion() +" a la lista del Taller");
    }
    
    // Reparaciones; Dar de baja reparacion
    
    public static void borrarReparacion(int idReparacion) throws SQLException{  
       Reparacion auxiliar = ReparacionController.buscarReparacionPorId(idReparacion);  // uso la funcion buscar por matricula y luego la funcion mostrar
       
       if (auxiliar !=null){
                ReparacionController.borrarReparacion(idReparacion);
                System.out.println("Eliminada Reparacion ID: " + idReparacion +" de la lista del Taller");
            } else System.out.println("El vehiculo no existe"); 
       } 
       
    
        
    
    //Reparaciones; imprime todas las reparaciones realizadas.
    
    public void listarReparaciones() {
        Reparacion.listarReparaciones();
        
    }
    
  
    
    //Reparaciones;  número total de reparaciones registradas.
    
    
    public static void contarReparaciones() throws SQLException {
       
    ReparacionController.contarReparaciones();    
     
    }
    
    
    
    
}
