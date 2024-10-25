/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.juegoscanner;

import java.util.*;


/**
 *
 * @author mama
 */
public class Adivinador {

    private static int numeroSecreto;
    
    
    public Adivinador(){
        generarNumero();
        
    }
    
    public void generarNumero(){
    Random random = new Random();
    numeroSecreto = random.nextInt(100);
    
    }
    
    
    public String darPista(int intento) {
        if (intento < numeroSecreto) {
            return "El número secreto es mayor.";
        } else if (intento > numeroSecreto) {
            return "El número secreto es menor.";
        } else {
            return "¡Correcto!";
        }
    }

    public boolean esCorrecta(int intento) {
        return intento == numeroSecreto;
    }

    public int getNumeroSecreto() {
        return numeroSecreto;
    }
}
