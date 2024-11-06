/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_2405dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class ClienteDAO {
// Método para agregar un nuevo cliente a la base de datos
    public static void crearCliente(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO cliente (nombre, correo) VALUES (?, ?)";
        try (Connection c = DataBaseConnection.getConnection();
            PreparedStatement pstmt = c.prepareStatement(sql)) {
            
            pstmt.setString(1, cliente.getNombre());
            pstmt.setString(2, cliente.getCorreo());
            
            pstmt.executeUpdate();
            
            
            System.out.println("Cliente agregado correctamente.");
            c.close();
        } catch (SQLException e) {
            System.out.println("Error al agregar Cliente: " + e.getMessage());
        } 
    }
    
    

    // Método para obtener un cliente por su ID
    public static Cliente obtenerClientePorId(int idC) {
        String sql = "SELECT * FROM Cliente WHERE idC = ?";
        try (   Connection c = DataBaseConnection.getConnection();
                PreparedStatement pstmt = c.prepareStatement(sql)) {
            pstmt.setInt(1, idC);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Cliente(rs.getLong("idC"),rs.getString("nombre"), rs.getString("correo"));
            }
            
            c.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener Cliente: " + e.getMessage());
        }
        return null;
    }

    // Método para actualizar un cliente existente
    public static void actualizarCliente(Cliente cl) {
        String sql = "UPDATE Cliente SET nombre = ?, correo = ? WHERE idC = ?";
        try (   Connection c = DataBaseConnection.getConnection();
                PreparedStatement pstmt = c.prepareStatement(sql)) {
            pstmt.setString(1, cl.getNombre());
            pstmt.setString(2, cl.getCorreo());
            pstmt.setLong(3, cl.getIdC());
            int filasAfectadas = pstmt.executeUpdate();
            if (filasAfectadas == 1) {
                System.out.println("Cliente actualizado correctamente.");
            } else {
                System.out.println("No se pudo actualizar el CLiente.");
            }
            c.close();
        } catch (SQLException e) {
            System.out.println("Error al actualizar cliente: " + e.getMessage());
        }
    }

    // Método para eliminar un cliente de la base de datos
    public static void eliminarCliente(long idC) {
        String sql = "DELETE FROM Cliente WHERE idC = ?";
        try (Connection c = DataBaseConnection.getConnection();
                PreparedStatement pstmt = c.prepareStatement(sql)) {
            pstmt.setLong(1, idC);
            long filasAfectadas = pstmt.executeUpdate();
            if (filasAfectadas == 1) {
                System.out.println("Cliente eliminado correctamente.");
            } else {
                System.out.println("No se pudo eliminar el cliente.");
            } c.close();
        } catch (SQLException e) {
            System.out.println("Error al eliminar el Cliente: " + e.getMessage());
        }
    }
    
}
