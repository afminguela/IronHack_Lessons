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
private Connection conexion;
    
    
    public ReparacionDAO (Connection conexion) {
        this.conexion= conexion;
    
    
    }
     
   // Métodos CRUD DE REPARACION
    
    public void insertReparacion(Reparacion reparacion) throws SQLException {
        String sql = "INSERT INTO reparacion (idReparacion, descripcion, costo, vehiculo) VALUES (?, ?, ?,?)";
        try (PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            pstmt.setInt(1, reparacion.getIdReparacion());
            pstmt.setString(2, reparacion.getDescripcion());
            pstmt.setDouble(3, reparacion.getCosto());
            pstmt.setInt(4, reparacion.getVehiculo().getIdVehiculo());
            pstmt.executeUpdate();
        }
    }

    public Reparacion buscarReparacionPorId(int idReparacion) throws SQLException {
        String sql = "SELECT * FROM Reparacion R INNER JOIN Vehiculo V ON V.id_Vehiculo = R.vehiculo WHERE id_Reparacion = ?";
        try (PreparedStatement pstmt = conexion.prepareStatement(sql)) {
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
                    return reparacion;
                }
            }
        } catch (SQLException e) { System.out.println("El update ha fallado: " + e.getMessage());
        }finally {
          conexion.close();     
        }
        
        return null;
    }
    
    public void actualizarReparacion(int idReparacion, String descripcion, double costo, int vehiculo) throws SQLException {
        String sql = "UPDATE Reparacion SET id_Reparacion = ?, descripcion = ?, costo = ?, vehiculo =?";
        try (
                PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            
            pstmt.setInt(1, idReparacion);
            pstmt.setString(2, descripcion);
            pstmt.setDouble(3, costo);
            pstmt.setInt(4, vehiculo);
            pstmt.executeUpdate(sql);
            
            }catch (SQLException e) { System.out.println("El update ha fallado: " + e.getMessage());
        }finally {
          conexion.close();     
        }
    }

     public void borrarReparacion(int idReparacion, String descripcion, double costo, int vehiculo) throws SQLException {
        String sql = "DELETE FROM Reparacion WHERE id_Reparacion = ?";
        try (
                PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            
            pstmt.setInt(1, idReparacion);
            
            pstmt.executeUpdate(sql);
            
            }catch (SQLException e) { System.out.println("El Borrado ha fallado: " + e.getMessage());
        }finally {
               conexion.close();
        }
    }

}
