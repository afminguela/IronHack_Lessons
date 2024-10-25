/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package home.afm.juegoscanner;

import java.util.*;


/**
 *
 * @author mama
 */
public class JuegoScanner {
    private Jugador jugador;
    private Adivinador adivinador;
    private Scanner scanner;

    public JuegoScanner() {
        scanner = new Scanner(System.in);
        adivinador = new Adivinador();
      
    }  
    public void iniciar() {
        System.out.println("Bienvenido al juego de adivinanza!");
        System.out.print("Por favor, ingresa tu nombre: ");
        String nombre = scanner.nextLine();
        System.out.print("por favor, ingresa el numero de intentos: ");
        int intentos = scanner.nextInt();
        jugador = new Jugador(nombre,intentos);

        System.out.println("Hola " + jugador.getNombre() + "! Tienes que adivinar un número entre 1 y 100.");
        System.out.println("Tienes " + jugador.getIntentos() + " intentos.");

        jugar();
    }

private void jugar() {
        while (jugador.getIntentos() > 0) {
            System.out.print("Introduce tu intento: ");
            int intento = scanner.nextInt();
            jugador.restarIntento();

            if (adivinador.esCorrecta(intento)) {
                System.out.println("¡Felicidades! Has adivinado el número secreto: " + adivinador.getNumeroSecreto());
                return;
            } else {
                System.out.println(adivinador.darPista(intento));
                System.out.println("Intentos restantes: " + jugador.getIntentos());
            }
        }

        System.out.println("Lo siento, has agotado tus intentos. El número secreto era: " + adivinador.getNumeroSecreto());
    

}


    public static void main(String[] args) {
        JuegoScanner juego = new JuegoScanner();
        juego.iniciar();
    }
}










        
        
      

