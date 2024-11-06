/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_2405dao;

import java.sql.SQLException;
import java.util.*;
import java.time.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class Producto {
        private Long idP;
        private String nombre;
        private double precio;
        long counter = 0;
    
    // Constructores

    public Producto(Long idP, String nombre, double precio) {
        setIdP(idP);
        this.nombre = nombre;
        this.precio = precio;
        
    }
     
    
    public Producto(String nombre, double precio) throws SQLException {
        this.idP = counter;
        this.nombre = nombre;
        this.precio = precio;
        ProductoDAO.crearProducto(this);
        counter ++;
    }

    public Producto() {
    }

    // getters ----------------
    public Long getIdP() {
        return idP;
    }

    public String getNombre() {
        return nombre;
    }

    public double getPrecio() {
        return precio;
    }

    // setters ---------------
    public void setIdP(Long idP) {
        if(idP==0){
        
           this.idP = counter;
           counter++;
        } else{
            this.idP = idP;
        }
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }
    
    // toString ---------------
    @Override
    public String toString() {
        return "Producto{" + "idP=" + idP + ", nombre=" + nombre + ", precio=" + precio + '}';
    }
    

public static Producto crearProducto(String nombre, Double precio) throws SQLException{
        Producto producto1 = new Producto(nombre, precio);
        
        return producto1;    
    } 
    
    public static void actualizarProducto(Producto producto) throws SQLException{
        ProductoDAO.actualizarProducto(producto);
    }
    
    public static  void eliminarProducto(int idP)throws SQLException{
        ProductoDAO.eliminarProducto(idP);
    }
    
    public static Producto obtenerProductoPorId(int idP){
        Producto producto1 = ProductoDAO.obtenerProductoPorId( idP);
            return producto1;
    }
     
    public static void añadirCesta(Cliente cliente, Producto producto)throws SQLException{
        ProductoDAO.añadirCesta(cliente, producto);
    
    }
        
        
}
