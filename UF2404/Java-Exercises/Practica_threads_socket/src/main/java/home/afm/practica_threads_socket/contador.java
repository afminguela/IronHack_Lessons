/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.practica_threads_socket;

import java.util.*;
import java.time.*;
import java.lang.*;
import java.util.concurrent.*;


/**
 *
 * @author Ana Fernandez Minguela
 */
public class contador extends Thread {
     private int numInicio; 
    
     public contador(int numInicio){
         this.numInicio = numInicio;
     }
    @Override
    public  void run(){
       for( int i = numInicio ; i <= 5; i++){
           System.out.println(i);
           try {
                Thread.sleep(1000); // Pausa de 1 segundo
            } catch (InterruptedException e) {
                System.out.println("El contador ha sido interrumpido");
                return;
            }
    }
    }}


