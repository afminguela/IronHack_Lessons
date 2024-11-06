/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.sql.SQLException;
import java.util.*;

/**
 *
 * @author mama
 */
public class Cliente extends Persona {     // la clase Cliente extiende la clase abstracta persona que tiene 
        private int idCliente ;                                // los atributos idPersona generado automaticamente por un contador, nombre y telefono.
        private List<Vehiculo> Vehiculos;   // añade una lista de vehiculos
        private ClienteDAO clienteDAO;
       int counter = 0;
        
    // Constructor    
     public Cliente(String nombre, String telefono) {
        super(nombre, telefono);
        this.idPersona = super.idPersona;
        this.idCliente = counter;
          
        this.Vehiculos = new ArrayList<>();
        mostrarInfo(super.idPersona);
        counter++;
        insertCliente(this);
       
    }   
     
    public Cliente(){
    
    }

        
     
    // Getters  

    public List<Vehiculo> getVehiculos() {
        return Vehiculos;
    }

    public int getIdCliente(){
        return idCliente;
    }
    
    // setters
    public void setVehiculos(List<Vehiculo> Vehiculos) {
        this.Vehiculos = Vehiculos;
    }
    
     
    // métodos
     
    
    // Muestra la info del Cliente
    @Override
    public void mostrarInfo(int idCliente) {
            try {
                ClienteDAO.buscarClientePorId(idCliente);
                System.out.print(this.getNombre());       
            } catch (SQLException e) {
                System.out.println("La busqueda ha fallado " + e.getMessage());
            }
        
    }

    public static void addVehiculoCliente(int idCliente, String matricula) throws SQLException {
        VehiculoDAO.addVehiculoCliente(idCliente,matricula);
        
    }

    public void removeVehiculoCliente(PersonaDAO personaDAO, Vehiculo vehiculo) {
        personaDAO.obtenerPersonaPorId(getIdCliente());
        
    }

    void setIdPersona(int idPersona) {
        super.idPersona = idPersona;
    }

    void setNombre(String nombre) {
        super.nombre= nombre;
    }

    void setTelefono(String telefono) {
         super.telefono = telefono;
    }

    void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    
        
 public static void insertCliente(Cliente cliente){
            try {
                ClienteDAO.insertCliente(cliente);
            } catch (SQLException e) {
                System.out.println("Ha fallado el insert msg de cliente " + e.getMessage()); }
    }   
 
 public static Cliente buscarClienteporId(int idCliente){
            try {
                ClienteDAO.buscarClientePorId(idCliente);
            } catch (SQLException e) {
                System.out.println("Ha fallado borrar cliente" + e.getMessage()); }
            return null;
            
    }   
 
 public static void borrarCliente(Cliente cliente){
            try {
                ClienteDAO.borrarCliente(cliente);
            } catch (SQLException e) {
                System.out.println("Ha fallado borrar cliente" + e.getMessage()); }
      
 
}
 public static void listarClientes(){
 
     try{
         ClienteDAO.listarClientes();
     } catch (SQLException e) {
                System.out.println("Ha fallado borrar cliente" + e.getMessage()); }
 }
 
}
