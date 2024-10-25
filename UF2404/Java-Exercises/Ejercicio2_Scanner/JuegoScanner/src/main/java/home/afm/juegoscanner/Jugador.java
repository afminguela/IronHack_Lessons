/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.juegoscanner;

import java.util.*;
import java.time.*;

/**
 *
 * @author mama
 */
public class Jugador {
    private String nombre;
    private static int intentos;
    
    
    
    
    public Jugador(String nombre, int intentos){
            this.nombre = nombre;
            this.intentos = intentos;
            
                    

    
    }

    public String getNombre() {
        return nombre;
    }

    public static int getIntentos() {
        return intentos;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public static void setIntentos(int intentos) {
        Jugador.intentos = intentos;
    }
    
    public static void restarIntento(){
        intentos--;
    }

}
