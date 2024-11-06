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
public class ClienteController {

     
// Método para insertar un cliente en BBDD
    
    public static void insertCliente(Cliente cliente) throws SQLException {
    String sql = "INSERT INTO Persona (nombre, telefono) VALUES (?, ?);"
            + "INSERT INTO Cliente (id_Cliente, id_Persona) VALUES (?,?);";
    try ( Connection conn = ControladorBaseDatos.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, cliente.getNombre());
        pstmt.setString(2, cliente.getTelefono());
        pstmt.setInt(3, cliente.getIdCliente());
        pstmt.setInt(4, cliente.getIdPersona());
        pstmt.executeUpdate();
        System.out.println("Cliente insertado con éxito");
    } catch (SQLException e) {
        System.out.println("Ha fallado la inserción de cliente: " + e.getMessage());
        throw e; 
    
    }
}

// ________SELECT _________

    public static Cliente buscarClientePorId(int idCliente) throws SQLException {
        String sql = "SELECT * FROM cliente WHERE id_Persona = ?";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idCliente);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setIdPersona(rs.getInt("id_Persona"));
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setIdCliente(rs.getInt("idCliente"));
                    return cliente;
                    
                }
            }finally {conn.close();}
        } catch(SQLException e){System.out.println("Busqueda ha fallado " + e.getMessage());}
        return null;
    }
    
    
    public static Cliente listarClientes() throws SQLException {
        String sql = "SELECT * FROM cliente";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            try (ResultSet rs = pstmt.executeQuery()) {
                int counter = 0;
               while (rs.next()) {
                   
                    Cliente cliente = new Cliente();
                    cliente.setIdPersona(rs.getInt("id_Persona"));
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setIdCliente(rs.getInt("id_Cliente"));
                    
                    System.out.println(counter + "- ID: " + cliente.getIdPersona() + " , nombre: " + cliente.getNombre() + " , Telefono: " + cliente.getTelefono() +" , idPersona: " + cliente.getIdPersona());
                    counter++;
                    
                }
            }finally {conn.close();}
        } catch(SQLException e){System.out.println("Busqueda ha fallado " + e.getMessage());}
        return null;
    }
// ________Update ______
    
    public static void actualizarCliente(Cliente cliente) throws SQLException {
        String sql = "UPDATE Cliente SET id_Cliente = ?, id_Persona =?;"
                + "UPDATE persona SET nombre = ?, telefono = ? WHERE id_Persona = ? ";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, cliente.getIdCliente());
            pstmt.setString(2, cliente.getNombre());
            pstmt.setString(3, cliente.getTelefono());
            pstmt.setInt(4, cliente.getIdPersona());
            pstmt.setInt(5, cliente.getIdPersona());
            pstmt.executeUpdate(sql);
           
             
            }catch (SQLException e) { System.out.println("El update ha fallado: " + e.getMessage());
        }  
        
    }
// _______DELETE______
    
    public static void borrarCliente(Cliente cliente) throws SQLException {
        String sql = "DELETE FROM Cliente WHERE idCliente = ?;"
                + "DELETE FROM persona WHERE idPersona = ?";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, cliente.getIdCliente());
            pstmt.setInt(1, cliente.getIdPersona());
            pstmt.executeUpdate(sql);
            
            }catch (SQLException e) { System.out.println("El Borrado ha fallado: " + e.getMessage());
        }finally {
               
        }
    }

    
   

              
    }


    

