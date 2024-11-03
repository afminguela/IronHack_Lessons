/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.practica_threads_socket;

import java.util.*;
import java.time.*;
import java.lang.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class SumaHIlo extends Thread implements Runnable {
    private int num1;
    private int num2;
    private Lock lock = new ReentrantLock();
    
    public SumaHIlo(int num1, int num2){
        this.num1 = num1;
        this.num2 = num2;
    }
    
    @Override 
    public void run(){
        lock.lock(); // bloquea el uso de los recursos ( hay que declararlo primero como atributo)
        try{
                int sumaNum = num1 + num2;
                System.out.println(sumaNum);
            } 
        finally { 
                lock.unlock();
                }
    }

}
