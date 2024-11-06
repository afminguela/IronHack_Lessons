/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec2405sp;

import java.sql.SQLException;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
/**
 *
 * @author Ana Fernandez Minguela
 */
@Entity
public class Cliente {
        
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long idC;
        private String nombre;
        private String correo;
        

    public Cliente(Long idC, String nombre, String correo) throws SQLException {
        setIdC(idC);
        this.nombre = nombre;
        this.correo = correo;
        
        
    }

    public Cliente(String nombre, String correo) {
        
        this.nombre = nombre;
        this.correo = correo;
        
        
    }
        
        
    

    public Cliente() {
    }

    public Long getIdC() {
        return idC;
    }

    public String getNombre() {
        return nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setIdC(Long idC) {
         this.idC = idC;
        }
    

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    @Override
    public String toString() {
        return "Cliente{" + "idC=" + idC + ", nombre=" + nombre + ", correo=" + correo + '}';
    }
  
}
