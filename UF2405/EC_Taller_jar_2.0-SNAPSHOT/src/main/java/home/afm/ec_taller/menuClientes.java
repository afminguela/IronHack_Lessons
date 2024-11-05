/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_taller;

import java.sql.SQLException;
import java.util.*;
import java.time.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class menuClientes {

    public static void menuClientes(Scanner scanner, Taller taller) throws SQLException {
        while (true) {
            System.out.println("\nMenú de Clientes:");
            System.out.println("1. Añadir cliente");
            System.out.println("2. Mostrar cliente");
            System.out.println("3. Dar de baja cliente");
            System.out.println("4. Listar Clientes Activos");
            System.out.println("5. Regresar al menu anterior");
            
            System.out.print("\n¿Que quieres hacer? : ");
            int opcionCliente = scanner.nextInt();
            scanner.nextLine(); 

            switch (opcionCliente) {
                case 1:
                    registrarCliente(scanner, taller);
                    break;
                case 2:
                    mostrarCliente(scanner, taller);
                    break;
                case 3:
                    darBajaCliente(scanner, taller);
                    break;
                case 4:
                    listarClientesActivos(taller);
                    break;
                case 5:
                    return;
                default:
                    System.out.println("Opción inválida. Por favor, intente nuevamente.");
            }
        }
    }
    
    // --------- Menu clientes --------
    
    private static void registrarCliente(Scanner scanner, Taller taller) {
        System.out.print("Escribe el nombre del cliente: ");
        String nombre = scanner.nextLine().trim();
        System.out.print("Escribe el telefono del cliente: ");
        String telefono = scanner.nextLine().trim();
        try {
            Cliente cliente1 = new Cliente(nombre, telefono);
                System.out.println("\nCliente añadido con éxito.");}
        catch (Exception e) {
            System.out.println("Ha fallado "+ e.getMessage());  
        }
    }

    private static void mostrarCliente(Scanner scanner, Taller taller) {
        System.out.print("Escribe número del cliente para mostrar información: ");
        int idCliente = scanner.nextInt();
        scanner.nextLine(); 
        
        taller.mostrarInfo(idCliente); // la función está en clase cliente, se accede desde una funcion puente en Taller
    }

    private static void darBajaCliente(Scanner scanner, Taller taller) {
        System.out.print("Escribe número del cliente para dar de baja: ");
        int numeroCliente = scanner.nextInt(); 
        taller.bajaCliente(numeroCliente);
        
       
    }

    private static void listarClientesActivos(Taller taller) throws SQLException {
        taller.listarClientes();
    }
    
}
