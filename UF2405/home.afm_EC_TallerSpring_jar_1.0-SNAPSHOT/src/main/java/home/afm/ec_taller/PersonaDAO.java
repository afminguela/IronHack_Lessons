/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.time.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class PersonaDAO {

    // Método para agregar una nueva persona a la base de datos
    public void agregarPersona(Persona persona) {
        String sql = "INSERT INTO personas (nombre, telefono) VALUES (?, ?)";
        try (Connection conn = ControladorBaseDatos.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, persona.getNombre());
            pstmt.setString(2, persona.getTelefono());
            //pstmt.setInt(3, persona.getIdPersona());
            pstmt.executeUpdate();
            
            
            System.out.println("Persona agregada correctamente.");
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error al agregar persona: " + e.getMessage());
        } 
    }

    // Método para obtener una persona por su ID
    public Cliente obtenerPersonaPorId(int idPersona) {
        String sql = "SELECT * FROM personas WHERE idPersona = ?";
        try (   Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idPersona);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Cliente(rs.getString("nombre"), rs.getString("telefono"));
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener persona: " + e.getMessage());
        }
        return null;
    }

    // Método para actualizar una persona existente
    public void actualizarPersona(Persona persona) {
        String sql = "UPDATE personas SET nombre = ?, telefono = ? WHERE id_persona = ?";
        try (   Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, persona.getNombre());
            pstmt.setString(2, persona.getTelefono());
            pstmt.setInt(3, persona.getIdPersona());
            int filasAfectadas = pstmt.executeUpdate();
            if (filasAfectadas == 1) {
                System.out.println("Persona actualizada correctamente.");
            } else {
                System.out.println("No se pudo actualizar la persona.");
            }
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error al actualizar persona: " + e.getMessage());
        }
    }

    // Método para eliminar una persona de la base de datos
    public void eliminarPersona(int idPersona) {
        String sql = "DELETE FROM personas WHERE id_persona = ?";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idPersona);
            int filasAfectadas = pstmt.executeUpdate();
            if (filasAfectadas == 1) {
                System.out.println("Persona eliminada correctamente.");
            } else {
                System.out.println("No se pudo eliminar la persona.");
            } conn.close();
        } catch (SQLException e) {
            System.out.println("Error al eliminar persona: " + e.getMessage());
        }
    }
    
}
