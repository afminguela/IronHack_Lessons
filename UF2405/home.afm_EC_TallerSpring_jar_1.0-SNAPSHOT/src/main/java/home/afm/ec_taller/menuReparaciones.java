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
public class menuReparaciones {
    
     public static void menuReparaciones(Scanner scanner, Taller taller) throws SQLException {
        while (true) {
            System.out.println("\nMenú de Reparaciones:");
            System.out.println("1. Realizar reparación");
            System.out.println("2. Eliminar reparación");
            System.out.println("3. Listar reparaciones activas");
            System.out.println("4. Contar reparaciones totales");
            System.out.println("5. Regresar al menu anterior");
            
            System.out.print("\n¿Que quieres hacer? : ");
            int opcionReparacion = scanner.nextInt();
            scanner.nextLine(); 

            switch (opcionReparacion) {
                case 1:
                    realizarReparacion(scanner, taller);
                    break;
                case 2:
                    eliminarReparacion(scanner,taller);
                    break;
                case 3:
                    listarReparacionesActivas(taller);
                    break;
                case 4:
                    contarReparacionesTotales(taller);
                    break;
                case 5:
                    return;
                default:
                    System.out.println("Opción inválida. Por favor, intente nuevamente.");
            }
        }
    }

// --------- menu Reparaciones ------- 
    
    
    private static void realizarReparacion(Scanner scanner, Taller taller) {
        System.out.print("Escribe la matrícula del vehículo: ");
        String matricula = scanner.nextLine().trim();
        System.out.print("Escribe la marca del vehículo: ");
        String marca = scanner.nextLine().trim();
        System.out.print("Escribe el modelo del vehículo: ");
        String modelo = scanner.nextLine().trim();
        System.out.print("Dame una descripcion de la reparación: ");
        String descripcion = scanner.nextLine().trim();
        System.out.print("Escribe el coste de la reparación: €");
        double costo = scanner.nextDouble();
        
        try {
        Reparacion reparacion = new Reparacion(matricula, marca, modelo, descripcion, costo);
        
        System.out.println("\nReparación añadida con éxito.");
    } catch (Exception e) {
        System.err.println("\nHa ocurrido un error al intentar agregar la reparación: " + e.getMessage());
    
    }
    }

    
    
    private static void eliminarReparacion(Scanner scanner,Taller taller) throws SQLException {
        System.out.print("Ingrese número de la reparación para eliminarla: ");
        int idReparacion =  scanner.nextInt();
        taller.borrarReparacion(idReparacion);
        System.out.println("/nReparación eliminada con éxito.");
    }

    
    
    private static void listarReparacionesActivas(Taller taller) {
        taller.listarReparaciones();
    }

    private static void contarReparacionesTotales(Taller taller) throws SQLException {
        taller.contarReparaciones();
    }
}
