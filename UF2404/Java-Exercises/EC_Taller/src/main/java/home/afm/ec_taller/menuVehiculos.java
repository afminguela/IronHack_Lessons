/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.util.*;
import java.time.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class menuVehiculos {
public static void menuVehiculos(Scanner scanner, Taller taller) {
        while (true) {
            System.out.println("\nMenú de Vehículos:");
            System.out.println("1. Añadir vehículo");
            System.out.println("2. Mostrar vehículo");
            System.out.println("3. Dar de baja vehículo");
            System.out.println("4. Asignar propietario al vehículo");
            System.out.println("5. Regresar al menu anterior");
            
            System.out.print("\n¿Que quieres hacer? : ");
            int opcionVehiculo = scanner.nextInt();
            scanner.nextLine(); 

            switch (opcionVehiculo) {
                case 1:
                    añadirVehiculo(scanner, taller);
                    break;
                case 2:
                    mostrarVehiculo(scanner, taller);
                    break;
                case 3:
                    darBajaVehiculo(scanner,taller);
                    break;
                case 4:
                    asignarPropietarioVehiculo(scanner, taller);
                    break;
                case 5:
                    return;
                default:
                    System.out.println("Opción inválida. Por favor, intente nuevamente.");
            }
        }
    }

// metodos de las funciones del menu

private static void añadirVehiculo(Scanner scanner, Taller taller) {
        System.out.print("Escribe la matrícula del vehículo: ");
        String matricula = scanner.nextLine().trim();
        System.out.print("Escribe la marca del vehículo: ");
        String marca = scanner.nextLine().trim();
        System.out.print("Escribe la modelo del vehículo: ");
        String modelo = scanner.nextLine().trim();
        
        taller.registrarVehiculo(new Vehiculo(matricula, marca, modelo));
        System.out.println("\nVehículo añadido con éxito.");
    }

    
    private static void mostrarVehiculo(Scanner scanner, Taller taller) {
        System.out.print("Escribe la matrícula del vehículo para mostrar información: ");
        String matricula = scanner.nextLine().trim();
        
        taller.mostrarInfoVehiculo(matricula);
    }

    
    private static void darBajaVehiculo(Scanner scanner,Taller taller) {
        System.out.print("Escribe la matrícula del vehículo para dar de baja: ");
        String matricula = scanner.nextLine().trim(); 
        taller.bajaVehiculo(matricula);
        
    }

    
    private static void asignarPropietarioVehiculo(Scanner scanner, Taller taller) {
        System.out.print("Escribe la matrícula del vehículo: ");
        String matricula = scanner.nextLine().trim();
        System.out.print("Escribe el número del cliente propietario: ");
        int numeroCliente = scanner.nextInt();
        scanner.nextLine(); 
        
        taller.addPropietarioVehiculo(matricula, numeroCliente);
        System.out.println("\nPropietario asignado con éxito.");
    }

    
}
