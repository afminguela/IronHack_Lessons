/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package home.afm.practica_threads_socket;


import java.util.*;
import java.time.*;
import java.lang.*;
import java.util.concurrent.*;

/**
 *
 * @author mama
 * 
 * Ejercicio 1 "facil" 
 * Crea una clase que extienda Thread.
En el método run, imprime los números del 1 al 5.
Usa Thread.sleep(1000); para hacer una pausa de 1 segundo entre cada número.
En el método main, crea una instancia de este hilo y ejecútalo.
*
* 
*Ejercicio 2: Medio- Define una clase SumaHilo que implemente Runnable.
En el constructor de la clase, recibe dos números enteros.
En el método run, realiza la suma de los dos números y almacénala en una variable local.
En el método main, crea tres instancias de Thread, pasando distintos números para sumar en cada hilo.
Inicia los hilos y asegúrate de que cada hilo imprime su resultado una vez terminada la suma.
 

* 
 */
public class Practica_threads_socket {
    

    public static void main(String[] args) {
        contador patata = new contador(1);
        patata.start();
        
        SumaHIlo hilo1 = new SumaHIlo (1,3);
        SumaHIlo hilo2 = new SumaHIlo (2,3);
        SumaHIlo hilo3 = new SumaHIlo (3,3);
        
        hilo2.setPriority(1);
        
        hilo1.start();
        hilo2.start();
        hilo3.start();
    }
}
