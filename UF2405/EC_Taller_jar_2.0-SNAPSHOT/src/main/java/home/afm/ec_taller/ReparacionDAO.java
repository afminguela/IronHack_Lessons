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
public class ReparacionDAO {

    
    
     
   // Métodos CRUD DE REPARACION
    
    public static void insertReparacion(Reparacion reparacion) throws SQLException {
        String sql = "INSERT INTO reparacion (idReparacion, descripcion, costo, vehiculo) VALUES (?, ?, ?,?)";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reparacion.getIdReparacion());
            pstmt.setString(2, reparacion.getDescripcion());
            pstmt.setDouble(3, reparacion.getCosto());
            pstmt.setInt(4, reparacion.getVehiculo().getIdVehiculo());
            pstmt.executeUpdate();
        }
    }

    public static Reparacion buscarReparacionPorId(int idReparacion) throws SQLException {
        String sql = "SELECT * FROM Reparacion R INNER JOIN Vehiculo V ON V.id_Vehiculo = R.vehiculo WHERE id_Reparacion = ?";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idReparacion);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Reparacion reparacion = new Reparacion();
                    Vehiculo vehiculo =new Vehiculo();
                    reparacion.setIdReparacion(rs.getInt("idReparacion"));
                    reparacion.setDescripcion(rs.getString("descripcion"));
                    reparacion.setCosto(rs.getDouble("costo"));
                    vehiculo.setMatricula(rs.getString("matricula"));
                    vehiculo.setMarca(rs.getString("marca"));
                    vehiculo.setModelo(rs.getString("modelo"));
                    vehiculo.setIdVehiculo(rs.getInt("id_Vehiculo"));
                    conn.close();
                    return reparacion;
                    
                }
            }
        } catch (SQLException e) { System.out.println("El update ha fallado: " + e.getMessage());
        }    
        
        
        return null;
    }
    
    public static void actualizarReparacion(Reparacion reparacion) throws SQLException {
        String sql = "UPDATE Reparacion SET id_Reparacion = ?, descripcion = ?, costo = ?, vehiculo =?";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, reparacion.getIdReparacion());
            pstmt.setString(2, reparacion.getDescripcion());
            pstmt.setDouble(3, reparacion.getCosto());
            pstmt.setInt(4, reparacion.getVehiculo().getIdVehiculo());
            pstmt.executeUpdate(sql);
            
            }catch (SQLException e) { System.out.println("El update ha fallado: " + e.getMessage());
        }
               
        
    }

    public static void borrarReparacion(int idReparacion) throws SQLException {
        String sql = "DELETE FROM Reparacion WHERE id_Reparacion = ?";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, idReparacion);
            
            pstmt.executeUpdate(sql);
            
            }catch (SQLException e) { System.out.println("El Borrado ha fallado: " + e.getMessage());
        }
    }
    
    public static void listarReparaciones() throws SQLException {
    
        String sql = "SELECT * FROM Reparacion R INNER JOIN Vehiculo V ON V.id_Vehiculo = R.vehiculo";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            try (ResultSet rs = pstmt.executeQuery()) {
                int counter = 0;
                while (rs.next()) {
                    Reparacion reparacion = new Reparacion();
                    Vehiculo vehiculo =new Vehiculo();
                    
                    reparacion.setIdReparacion(rs.getInt("idReparacion"));
                    reparacion.setDescripcion(rs.getString("descripcion"));
                    reparacion.setCosto(rs.getDouble("costo"));
                    vehiculo.setMatricula(rs.getString("matricula"));
                    vehiculo.setMarca(rs.getString("marca"));
                    vehiculo.setModelo(rs.getString("modelo"));
                    vehiculo.setIdVehiculo(rs.getInt("id_Vehiculo"));
                    
                    System.out.println(counter + "- ID: " + reparacion.getIdReparacion() + " , descripcion: " + reparacion.getDescripcion() + " , Costo: " + reparacion.getCosto() +" , Vehiculo, matricula: " + vehiculo.getMatricula() + ", Modelo "+ vehiculo.getModelo()+ ", Marca: "+ vehiculo.getMarca());
                    counter++;
                    
                    
                }
            }finally {conn.close();}
        } catch (SQLException e) { System.out.println("El update ha fallado: " + e.getMessage());
        }       }
    
    public static int contarReparaciones() throws SQLException{
        int totalReparaciones = 0;
        String sql = "SELECT COUNT(*) AS total FROM Reparacion";
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    totalReparaciones = rs.getInt("total");
                    System.out.println("el numero total de reapraciones es: " + totalReparaciones);
                }
        } catch (SQLException e){
            System.out.println("Error al contar reparaciones " + e.getMessage());
            throw e;
        } return totalReparaciones;
    }
}
    
    
    

