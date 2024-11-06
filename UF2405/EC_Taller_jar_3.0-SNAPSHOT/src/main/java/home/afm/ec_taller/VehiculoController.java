/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import home.afm.ec_taller.ControladorBaseDatos;
import java.util.*;
import java.time.*;
import java.sql.*;


/**
 *
 * @author Ana Fernandez Minguela
 */
@RestController
public class VehiculoController {
    
 

//____SELECT___   
    public static void listarVehiculos()throws SQLException{

        String query = "SELECT * FROM Vehiculo;";
        try(Connection conn = ControladorBaseDatos.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query)){

            while(rs.next()){
                int id_Vehiculo = rs.getInt("id_Vehiculo");
                String matricula = rs.getString("matricula");
                String modelo = rs.getString("modelo");
                String marca = rs.getString("marca");
                int propietario = rs.getInt("propietario");
                
                System.out.println("ID: " + id_Vehiculo + " , Matricula: " + matricula + " , modelo: " + modelo +" , marca: " + marca + " , propietario: " + propietario );
            }
        }catch(SQLException e){
            System.out.println("ha fallado doy error: " + e.getMessage());
        }
        }

    public void mostrarInfoVehiculoporMatricula(String matricula) throws SQLException{
        String query = "SELECT * FROM Vehiculo V INNER JOIN Cliente C ON V.propietario = C.id_Cliente INNER JOIN Persona P ON P.idpersona  WHERE matricula = ?";
        try(Connection conn = ControladorBaseDatos.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(query)){

            pstmt.setString(1,matricula);

            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                Vehiculo ve = new Vehiculo();
                Cliente cl =  new Cliente();
                
                ve.setIdVehiculo(rs.getInt("id_Vehiculo"));
                ve.setMatricula(rs.getString("matricula"));
                ve.setModelo(rs.getString("modelo"));
                ve.setMarca(rs.getString("marca"));
                cl.setNombre(rs.getString("nombre"));
                
                
                System.out.println("ID: " + ve.getIdVehiculo() + " , Matricula: " + ve.getMatricula() + " , modelo: " + ve.getModelo() +" , marca: " + ve.getMarca() + " , propietario: " + cl.getNombre() );
            }
        }catch(SQLException e){
            System.out.println("Ha fallado la consulta " + e.getMessage());
        }
    }


     public static Vehiculo buscarVehiculoPorMatricula(String matricula ) throws SQLException {
        String sql = "SELECT * FROM Vehiculo V INNER JOIN Cliente C ON V.propietario = C.id_Cliente INNER JOIN Persona P ON P.idpersona  WHERE matricula = ?";
        try (   Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, matricula);
            
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    
                    Vehiculo ve =new Vehiculo();
                    ve.setMatricula(rs.getString("matricula"));
                    ve.setMarca(rs.getString("marca"));
                    ve.setModelo(rs.getString("modelo"));
                    ve.setIdVehiculo(rs.getInt("id_Vehiculo"));
                    conn.close();
                    return ve;
                }
            
               
    
        } catch(SQLException e){
            System.out.println("Ha fallado la consulta " + e.getMessage());
        }
        return null;
    }
    
// _____INSERT_______
     
     public static void insertVehiculo(Vehiculo vehiculo) throws SQLException {
        String query = "INSERT INTO vehiculos(idVehiculo, matricula, modelo, marca, propietario) VALUES (?,?,?,?,null);";
        try(Connection conn = ControladorBaseDatos.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(query)){

            pstmt.setInt(1, vehiculo.getIdVehiculo());
            pstmt.setString(2, vehiculo.getMatricula());
            pstmt.setString(3, vehiculo.getModelo());
            pstmt.setString(4, vehiculo.getMarca());
            
            pstmt.executeUpdate();
            System.out.println("Nuevo vehiculo insertado!");

        }catch(SQLException e){
            System.out.println("Ha fallado la consulta " + e.getMessage());
        throw e;
        }

    
    
}
    
    
    
//_____DELETE_________ 

     public static void borrarVehiculo(String matricula) throws SQLException {
        String sql = "DELETE FROM Vehiculo WHERE matricula = ?";
        try ( Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, matricula);
            
            pstmt.executeUpdate(sql);
             conn.close();  
            }catch (SQLException e) { System.out.println("El Borrado ha fallado: " + e.getMessage());
        }
    }

// _______UPDATE________
     
     public void actualizarVehiculo(int idVehiculo, String matricula, String modelo, String marca, int propietario) throws SQLException {
        String sql = "UPDATE Vehiculo SET id_Vehiculo = ?, matricula = ?, modelo = ?, marca = ?, propietario =?";
        try ( Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, idVehiculo);
            pstmt.setString(2, matricula);
            pstmt.setString(3, modelo);
            pstmt.setString(4, marca);
            pstmt.setInt(5, propietario);
            pstmt.executeUpdate(sql);
            
            }catch (SQLException e) { System.out.println("El update ha fallado: " + e.getMessage());
        }
        }

     
     public static void addVehiculoCliente(int idCliente, String matricula) throws SQLException {
        String query = "UPDATE vehiculo SET propietario = ? where matricula = ?";
        try(Connection conn = ControladorBaseDatos.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(query)){

            pstmt.setInt(1, idCliente);
            pstmt.setString(2, matricula);
            
            pstmt.executeUpdate();
            System.out.println("Nuevo propietario de vehiculo insertado!");
            conn.close();
        }catch(SQLException e){
            System.out.println("Ha fallado la consulta " + e.getMessage());
        }
    }
    
     
     public void eliminarVehiculoDeCliente(String matricula) throws SQLException {
        String sql = "UPDATE vehiculo SET propietario = null where matricula = ?";
       
        try (Connection conn = ControladorBaseDatos.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, matricula);
            
            pstmt.executeUpdate();
            conn.close();
        } catch(SQLException e){
            System.out.println("Ha fallado Eliminar propietario del vehiculo" + e.getMessage());}
}

}
