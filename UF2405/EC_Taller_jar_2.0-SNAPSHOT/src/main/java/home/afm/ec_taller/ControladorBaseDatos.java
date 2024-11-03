/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.util.*;
import java.time.*;
import java.sql.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class ControladorBaseDatos {
    private static final String URL = "jdbc:mysql://localhost:3306/Taller";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";
    private Connection conexion;
    
    
    public static Connection getConnection() throws SQLException {
        
        try{ 
            Connection conexion = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conexion realizada con éxito");
        } catch (SQLException e){ 
            System.out.println("Error de Conexión" + e.getMessage());
            
            throw e;
        
        } return DriverManager.getConnection(URL, USER, PASSWORD);
        
    }
    
    public void cerrarConexion() throws  SQLException{
            
        if (conexion != null &&!conexion.isClosed()){
            conexion.close();
        }
    }
    
}
