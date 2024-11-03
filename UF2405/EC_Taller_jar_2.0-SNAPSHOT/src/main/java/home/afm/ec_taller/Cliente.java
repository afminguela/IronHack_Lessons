/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.sql.SQLException;
import java.util.*;
import java.time.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author mama
 */
public class Cliente extends Persona {     // la clase Cliente extiende la clase abstracta persona que tiene 
        private int idCliente ;                                // los atributos idPersona generado automaticamente por un contador, nombre y telefono.
        private List<Vehiculo> Vehiculos;   // añade una lista de vehiculos
    
       int counter = 0;
        
    // Constructor    
     public Cliente(String nombre, String telefono) {
        super(nombre, telefono);
        this.idCliente = counter;
        this.Vehiculos = new ArrayList<>();
        mostrarInfo(super.idPersona);
        counter++;
       
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
        }
        
    }

    public void addVehiculoCliente(PersonaDAO personaDAO, Vehiculo vehiculo) {
        Persona persona = personaDAO.obtenerPersonaPorId(getIdCliente());
        
    }

    public void removeVehiculoCliente(PersonaDAO personaDAO, Vehiculo vehiculo) {
        personaDAO.obtenerPersonaPorId(getIdCliente());
        
    }

    void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    void setNombre(String nombre) {
        super.nombre= nombre;
    }

    void setTelefono(String string) {
}
    }

    void setIdCliente(int aInt) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    void setIdcliente(int aInt) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

        
    public void insertCliente(Cliente cliente)throws SQLException {
            try {
                ClienteDAO.insertCliente(cliente);
            } catch (SQLException e) {
                System.out.println("Ha fallado el insert msg de cliente " + e.getMessage()); }
    }
    
}
