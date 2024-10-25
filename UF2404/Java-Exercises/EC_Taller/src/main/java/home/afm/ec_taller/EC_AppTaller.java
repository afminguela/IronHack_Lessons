/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package home.afm.ec_taller;



/**
 *
 * @author mama
 */
import java.util.Scanner;

public class EC_AppTaller {
    
// _*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_ Inicio Programa _*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*      
        public static void main(String[] args) {
    
  
        Taller taller = new Taller("Talleres Manolo");
        Scanner scanner = new Scanner(System.in);
        
        
        System.out.println("-+-+-+-+-+-+-+--+ BIENVENIDO A "+ taller.getNombre() +" -+-+-+-+-+-+-+-+-+-");
        while (true) {
            System.out.println("\nMenu principal:");
            System.out.println("1. Menu Clientes");
            System.out.println("2. Menu Vehículos");
            System.out.println("3. Menu Reparaciones");
            System.out.println("4. Salir");

            System.out.print("\n¿Que quieres hacer? : ");
            int opcionPrincipal = scanner.nextInt();
            scanner.nextLine(); 

            switch (opcionPrincipal) {
                case 1:
                    Controlador.menuClientes(scanner, taller);
                    break;
                case 2:
                    Controlador.menuVehiculos(scanner, taller);
                    break;
                case 3:
                    Controlador.menuReparaciones(scanner, taller);
                    break;
                case 4:
                    System.out.println("Gracias por utilizar el sistema.");
                    return;
                default:
                    System.out.println("Opción inválida. Por favor, intente de nuevo.");
            }
        }
    }

     // *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*  FIN DEL PROGRAMA _*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*    
        
    