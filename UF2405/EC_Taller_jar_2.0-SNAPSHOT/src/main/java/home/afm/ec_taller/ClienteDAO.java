/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.time.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class ClienteDAO {
    private final Connection conexion;
    
    
    public ClienteDAO (Connection conexion) {
        this.conexion= conexion;
    
    
    }
     
   // Método para insertar un cliente en BBDD
    
    public void insertCliente(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO cliente (nombre, telefono, idCliente) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            pstmt.setString(1, cliente.getNombre());
            pstmt.setString(2, cliente.getTelefono());
            pstmt.setInt(3, cliente.getIdCliente());
            pstmt.executeUpdate();
        } catch(SQLException e){ System.out.println("HA fallado la insercion de cliente " + e.getMessage());}
      finally { conexion.close();}
        
        }
        
        

    public Cliente buscarClientePorId(int idCliente) throws SQLException {
        String sql = "SELECT * FROM cliente WHERE idPersona = ?";
        try (PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            pstmt.setInt(1, idCliente);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setIdPersona(rs.getInt("idPersona"));
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setIdCliente(rs.getInt("idCliente"));
                    return cliente;
                }
            }
        } catch(SQLException e){System.out.println("Busqueda ha fallado " + e.getMessage());}
        finally {conexion.close();}
        return null;
    }
    
    public void actualizarCliente(int idCliente, String nombre, String telefono, int idPersona) throws SQLException {
        String sql = "UPDATE Cliente SET idCliente = ?, nombre = ?, telefono = ?, idPersona =?";
        try (
                PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            
            pstmt.setInt(1, idCliente);
            pstmt.setString(2, nombre);
            pstmt.setString(3, telefono);
            pstmt.setInt(4, idPersona);
            pstmt.executeUpdate(sql);
            
            }catch (SQLException e) { System.out.println("El update ha fallado: " + e.getMessage());
        }finally {
             conexion.close();  
        }
    }

    public void BorrarCliente(int idCliente, String nombre, String telefono, int idPersona) throws SQLException {
        String sql = "DELETE FROM Cliente WHERE idCliente = ?";
        try (
                PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            
            pstmt.setInt(1, idCliente);
            
            pstmt.executeUpdate(sql);
            
            }catch (SQLException e) { System.out.println("El Borrado ha fallado: " + e.getMessage());
        }finally {
               
        }
    }

    
    // Método para agregar un vehículo a un cliente
    public void agregarVehiculoACliente(Persona persona, Vehiculo vehiculo) throws SQLException {
        String sql = "INSERT INTO clientes (persona_id, vehiculo_id) VALUES (?, ?)";
        PreparedStatement pstmt = conexion.prepareStatement(sql);
        
        pstmt.setInt(1, persona.getIdPersona());
        pstmt.setInt(2, vehiculo.getIdVehiculo());

        pstmt.executeUpdate();
        pstmt.close();

        // Agregar el vehículo a la lista del cliente
       
    }

    // Método para eliminar un vehículo de un cliente
    public void eliminarVehiculoDeCliente(Persona persona, Vehiculo vehiculo) throws SQLException {
        String sql = "DELETE FROM clientes WHERE persona_id = ? AND vehiculo_id = ?";
       
        try (PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            pstmt.setInt(1, persona.getIdPersona());
            pstmt.setInt(2, vehiculo.getIdVehiculo());
            
            pstmt.executeUpdate();
        } catch(SQLException e){
            System.out.println("Ha fallado Eliminar vehiculo de lista cliente" + e.getMessage());}
     finally { 
                        conexion.close();}
        // Eliminar el vehículo de la lista del cliente
        
    }
} 

    

