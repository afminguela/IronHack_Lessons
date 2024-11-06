/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.util.*;
import java.time.*;

/**
 *
 * @author mama
 */
abstract class  Persona {
     public static int idPersona;
     public static String nombre;
     public static String telefono;
     int counter = 0;

    public Persona(String nombre, String telefono) {
        this.nombre = nombre;
        this.telefono = telefono;
        this.idPersona = counter;
        counter++;
    }
    
   public Persona(){}

    public String getNombre() {
        return nombre;
    }

    public String getTelefono() {
        return telefono;
    }
    
    public int getIdPersona(){
        return idPersona;
    }
     
    public abstract void mostrarInfo(int idPersona);          

    
     
    
}
