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
public class ProductoDAO {

    
    // Método para agregar un producto a la base de datos
    public static void crearProducto(Producto p) throws SQLException {
        String sql = "INSERT INTO Producto (nombre, precio) VALUES (?, ?)";
        try (Connection c = DataBaseConnection.getConnection();
            PreparedStatement pstmt = c.prepareStatement(sql)) {
            
            pstmt.setString(1, p.getNombre());
            pstmt.setDouble(2, p.getPrecio());
            
            pstmt.executeUpdate();
            
            
            System.out.println("Producto agregado correctamente.");
            c.close();
        } catch (SQLException e) {
            System.out.println("Error al agregar Producto: " + e.getMessage());
        } 
    }

    // Método para obtener un producto por su ID
    public static Producto obtenerProductoPorId(int idP) {
        String sql = "SELECT * FROM Producto WHERE idP = ?";
        try (   Connection c = DataBaseConnection.getConnection();
                PreparedStatement pstmt = c.prepareStatement(sql)) {
            pstmt.setInt(1, idP);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Producto(rs.getLong("idP"),rs.getString("nombre"), rs.getDouble("precio"));
            }
            
            c.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener Producto: " + e.getMessage());
        }
        return null;
    }

    // Método para actualizar un producto existente
    public static void actualizarProducto(Producto p) {
        String sql = "UPDATE Producto SET nombre = ?, precio = ? WHERE idP = ?";
        try (   Connection c = DataBaseConnection.getConnection();
                PreparedStatement pstmt = c.prepareStatement(sql)) {
            pstmt.setString(1, p.getNombre());
            pstmt.setDouble(2, p.getPrecio());
            pstmt.setLong(3, p.getIdP());
            int filasAfectadas = pstmt.executeUpdate();
            if (filasAfectadas == 1) {
                System.out.println("Producto actualizado correctamente.");
            } else {
                System.out.println("No se pudo actualizar el Producto.");
            }
            c.close();
        } catch (SQLException e) {
            System.out.println("Error al actualizar producto: " + e.getMessage());
        }
    }

    // Método para eliminar un producto de la base de datos
    public static void eliminarProducto(long idP) {
        String sql = "DELETE FROM Cliente WHERE idC = ?";
        try (Connection c = DataBaseConnection.getConnection();
                PreparedStatement pstmt = c.prepareStatement(sql)) {
            pstmt.setLong(1, idP);
            long filasAfectadas = pstmt.executeUpdate();
            if (filasAfectadas == 1) {
                System.out.println("Producto eliminado correctamente.");
            } else {
                System.out.println("No se pudo eliminar el producto.");
            } c.close();
        } catch (SQLException e) {
            System.out.println("Error al eliminar el producto: " + e.getMessage());
        }
    }
    
   // Método para Añadir Producto a la cesta. 
    public static void añadirCesta(Cliente cliente, Producto producto) throws SQLException {
        String sql = "INSERT INTO CPC (idC, idP) VALUES (?, ?)";
        try (Connection c = DataBaseConnection.getConnection();
            PreparedStatement pstmt = c.prepareStatement(sql)) {
            
            pstmt.setLong(1, cliente.getIdC());
            pstmt.setLong(2, producto.getIdP());
            
            pstmt.executeUpdate();
            
            
            System.out.println("Producto agregado a la cesta del cliente correctamente.");
            c.close();
        } catch (SQLException e) {
            System.out.println("Error al agregar Producto: " + e.getMessage());
        } 
    }
}
