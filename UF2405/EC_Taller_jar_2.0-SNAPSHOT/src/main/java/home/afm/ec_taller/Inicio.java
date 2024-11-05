/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.sql.SQLException;
import java.util.*;
import java.time.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class Inicio {

    public static void iniciarFiesta() throws SQLException{
    
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
                    menuClientes.menuClientes(scanner, taller);
                    break;
                case 2:
                    menuVehiculos.menuVehiculos(scanner, taller);
                    break;
                case 3:
                    menuReparaciones.menuReparaciones(scanner, taller);
                    break;
                case 4:
                    System.out.println("Gracias por utilizar el sistema.");
                    return;
                default:
                    System.out.println("Opción inválida. Por favor, intente de nuevo.");
            }
        }
    }
}
