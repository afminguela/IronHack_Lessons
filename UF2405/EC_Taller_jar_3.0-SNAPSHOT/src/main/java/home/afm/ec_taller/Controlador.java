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
public class Controlador {

    // --------------------------  Se queda de repo de código . ------------------
    
//    public static void menuClientes(Scanner scanner, Taller taller) {
//        while (true) {
//            System.out.println("\nMenú de Clientes:");
//            System.out.println("1. Añadir cliente");
//            System.out.println("2. Mostrar cliente");
//            System.out.println("3. Dar de baja cliente");
//            System.out.println("4. Listar Clientes Activos");
//            System.out.println("5. Regresar al menu anterior");
//            
//            System.out.print("\n¿Que quieres hacer? : ");
//            int opcionCliente = scanner.nextInt();
//            scanner.nextLine(); 
//
//            switch (opcionCliente) {
//                case 1:
//                    añadirCliente(scanner, taller);
//                    break;
//                case 2:
//                    mostrarCliente(scanner, taller);
//                    break;
//                case 3:
//                    darBajaCliente(scanner, taller);
//                    break;
//                case 4:
//                    listarClientesActivos(taller);
//                    break;
//                case 5:
//                    return;
//                default:
//                    System.out.println("Opción inválida. Por favor, intente nuevamente.");
//            }
//        }
//    }

//    public static void menuVehiculos(Scanner scanner, Taller taller) {
//        while (true) {
//            System.out.println("\nMenú de Vehículos:");
//            System.out.println("1. Añadir vehículo");
//            System.out.println("2. Mostrar vehículo");
//            System.out.println("3. Dar de baja vehículo");
//            System.out.println("4. Asignar propietario al vehículo");
//            System.out.println("5. Regresar al menu anterior");
//            
//            System.out.print("\n¿Que quieres hacer? : ");
//            int opcionVehiculo = scanner.nextInt();
//            scanner.nextLine(); 
//
//            switch (opcionVehiculo) {
//                case 1:
//                    añadirVehiculo(scanner, taller);
//                    break;
//                case 2:
//                    mostrarVehiculo(scanner, taller);
//                    break;
//                case 3:
//                    darBajaVehiculo(scanner,taller);
//                    break;
//                case 4:
//                    asignarPropietarioVehiculo(scanner, taller);
//                    break;
//                case 5:
//                    return;
//                default:
//                    System.out.println("Opción inválida. Por favor, intente nuevamente.");
//            }
//        }
//    }

//    public static void menuReparaciones(Scanner scanner, Taller taller) {
//        while (true) {
//            System.out.println("\nMenú de Reparaciones:");
//            System.out.println("1. Realizar reparación");
//            System.out.println("2. Eliminar reparación");
//            System.out.println("3. Listar reparaciones activas");
//            System.out.println("4. Contar reparaciones totales");
//            System.out.println("5. Regresar al menu anterior");
//            
//            System.out.print("\n¿Que quieres hacer? : ");
//            int opcionReparacion = scanner.nextInt();
//            scanner.nextLine(); 
//
//            switch (opcionReparacion) {
//                case 1:
//                    realizarReparacion(scanner, taller);
//                    break;
//                case 2:
//                    eliminarReparacion(scanner,taller);
//                    break;
//                case 3:
//                    listarReparacionesActivas(taller);
//                    break;
//                case 4:
//                    contarReparacionesTotales(taller);
//                    break;
//                case 5:
//                    return;
//                default:
//                    System.out.println("Opción inválida. Por favor, intente nuevamente.");
//            }
//        }
//    }

   
    


//// --------- Menu clientes --------
//    
//    private static void añadirCliente(Scanner scanner, Taller taller) {
//        System.out.print("Escribe el nombre del cliente: ");
//        String nombre = scanner.nextLine().trim();
//        System.out.print("Escribe el telefono del cliente: ");
//        String telefono = scanner.nextLine().trim();
//        
//        taller.registrarCliente(new Cliente(nombre, telefono));
//        System.out.println("\nCliente añadido con éxito.");
//    }
//
//    private static void mostrarCliente(Scanner scanner, Taller taller) {
//        System.out.print("Escribe número del cliente para mostrar información: ");
//        int idCliente = scanner.nextInt();
//        scanner.nextLine(); 
//        
//        taller.mostrarInfo(idCliente); // la función está en clase cliente, se accede desde una funcion puente en Taller
//    }
//
//    private static void darBajaCliente(Scanner scanner, Taller taller) {
//        System.out.print("Escribe número del cliente para dar de baja: ");
//        int numeroCliente = scanner.nextInt(); 
//        taller.bajaCliente(numeroCliente);
//        
//       
//    }
//
//    private static void listarClientesActivos(Taller taller) {
//        taller.listarClientes();
//    }
    
    // -------- Menu Vehiculos ------
    
//    private static void añadirVehiculo(Scanner scanner, Taller taller) {
//        System.out.print("Escribe la matrícula del vehículo: ");
//        String matricula = scanner.nextLine().trim();
//        System.out.print("Escribe la marca del vehículo: ");
//        String marca = scanner.nextLine().trim();
//        System.out.print("Escribe la modelo del vehículo: ");
//        String modelo = scanner.nextLine().trim();
//        
//        taller.registrarVehiculo(new Vehiculo(matricula, marca, modelo));
//        System.out.println("\nVehículo añadido con éxito.");
//    }
//
//    
//    private static void mostrarVehiculo(Scanner scanner, Taller taller) {
//        System.out.print("Escribe la matrícula del vehículo para mostrar información: ");
//        String matricula = scanner.nextLine().trim();
//        
//        taller.mostrarInfoVehiculo(matricula);
//    }
//
//    
//    private static void darBajaVehiculo(Scanner scanner,Taller taller) {
//        System.out.print("Escribe la matrícula del vehículo para dar de baja: ");
//        String matricula = scanner.nextLine().trim(); 
//        taller.bajaVehiculo(matricula);
//        
//    }
//
//    
//    private static void asignarPropietarioVehiculo(Scanner scanner, Taller taller) {
//        System.out.print("Escribe la matrícula del vehículo: ");
//        String matricula = scanner.nextLine().trim();
//        System.out.print("Escribe el número del cliente propietario: ");
//        int numeroCliente = scanner.nextInt();
//        scanner.nextLine(); 
//        
//        taller.addPropietarioVehiculo(matricula, numeroCliente);
//        System.out.println("\nPropietario asignado con éxito.");
//    }
//
//    
//    // --------- menu Reparaciones ------- 
//    
//    
//    private static void realizarReparacion(Scanner scanner, Taller taller) {
//        System.out.print("Escribe la matrícula del vehículo: ");
//        String matricula = scanner.nextLine().trim();
//        System.out.print("Escribe la marca del vehículo: ");
//        String marca = scanner.nextLine().trim();
//        System.out.print("Escribe el modelo del vehículo: ");
//        String modelo = scanner.nextLine().trim();
//        System.out.print("Dame una descripcion de la reparación: ");
//        String descripcion = scanner.nextLine().trim();
//        System.out.print("Escribe el coste de la reparación: €");
//        double costo = scanner.nextDouble();
//        
//        try {
//        Reparacion reparacion = new Reparacion(matricula, marca, modelo, descripcion, costo);
//        taller.realizarReparacion(reparacion);
//        System.out.println("\nReparación añadida con éxito.");
//    } catch (Exception e) {
//        System.err.println("\nHa ocurrido un error al intentar agregar la reparación: " + e.getMessage());
//    
//    }
//    }
//
//    
//    
//    private static void eliminarReparacion(Scanner scanner,Taller taller) {
//        System.out.print("Ingrese número de la reparación para eliminarla: ");
//        int idReparacion =  scanner.nextInt();
//        taller.bajaReparacion(idReparacion);
//        System.out.println("/nReparación eliminada con éxito.");
//    }
//
//    
//    
//    private static void listarReparacionesActivas(Taller taller) {
//        taller.listarReparaciones();
//    }
//
//    private static void contarReparacionesTotales(Taller taller) {
//        taller.contarReparaciones();
//    }
}

    

    


    
    
    
