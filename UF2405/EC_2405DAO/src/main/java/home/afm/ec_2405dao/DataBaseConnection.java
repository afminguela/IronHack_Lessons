/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_2405dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;
import java.time.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class DataBaseConnection {
        private static final String URL = "jdbc:mysql://localhost:3306/EC2405";
        private static final String USER = "root";
        private static final String PASSWORD = "1234";
        private Connection c;

       public static Connection getConnection() throws SQLException {
        
        try{ 
            Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conexion realizada con éxito");
        } catch (SQLException e){ 
            System.out.println("Error de Conexión" + e.getMessage());
            
            throw e;
        
        } return DriverManager.getConnection(URL, USER, PASSWORD);
        
    }
    
    public void cerrarConexion() throws  SQLException{
            
        if (c != null &&!c.isClosed()){
            c.close();
        }
    } 

    

    
}
    