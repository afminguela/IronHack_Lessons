/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec2405sp;

import java.sql.SQLException;
import java.sql.SQLException;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
/**
/**
 *
 * @author Ana Fernandez Minguela
 */
@Entity
public class Producto {
        
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)    
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
       
            this.idP = idP;
        
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
  
        
}
