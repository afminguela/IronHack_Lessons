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
    
    // Crea una instancia de Taller.


     //  Registra algunos clientes y vehículos.
    
    // Realiza algunas reparaciones usando Scanner para recibir detalles de entrada.
    
    // Muestra la lista de reparaciones activas.
    
    // muestra los datos de clientes, añade propietario a los vehiculos, cuenta las reparaciones totales
    
    
    public static void main(String[] args) {
    


  
        Taller taller = new Taller("Talleres Manolo");
        Scanner scanner = new Scanner(System.in);
        System.out.println("-+-+-+-+-+-+-+--+ BIENVENIDO A TALLERES MANOLO -+-+-+-+-+-+-+-+-+-");
        while (true) {
            System.out.println("\nOpciones principales:");
            System.out.println("1. Clientes");
            System.out.println("2. Vehículos");
            System.out.println("3. Reparaciones");
            System.out.println("4. Salir");

            System.out.print("Ingrese su opción principal: ");
            int opcionPrincipal = scanner.nextInt();
            scanner.nextLine(); // Consume newline left-over

            switch (opcionPrincipal) {
                case 1:
                    menuClientes(scanner, taller);
                    break;
                case 2:
                    menuVehiculos(scanner, taller);
                    break;
                case 3:
                    menuReparaciones(scanner, taller);
                    break;
                case 4:
                    System.out.println("Gracias por utilizar el sistema.");
                    return;
                default:
                    System.out.println("Opción inválida. Por favor, intente nuevamente.");
            }
        }
    }

    private static void menuClientes(Scanner scanner, Taller taller) {
        while (true) {
            System.out.println("\nMenú de Clientes:");
            System.out.println("1. Añadir cliente");
            System.out.println("2. Mostrar cliente");
            System.out.println("3. Dar de baja cliente");
            System.out.println("4. Regresar");

            int opcionCliente = scanner.nextInt();
            scanner.nextLine(); // Consume newline left-over

            switch (opcionCliente) {
                case 1:
                    añadirCliente(scanner, taller);
                    break;
                case 2:
                    mostrarCliente(scanner, taller);
                    break;
                case 3:
                    darBajaCliente(taller);
                    break;
                case 4:
                    return;
                default:
                    System.out.println("Opción inválida. Por favor, intente nuevamente.");
            }
        }
    }

    private static void menuVehiculos(Scanner scanner, Taller taller) {
        while (true) {
            System.out.println("\nMenú de Vehículos:");
            System.out.println("1. Añadir vehículo");
            System.out.println("2. Mostrar vehículo");
            System.out.println("3. Dar de baja vehículo");
            System.out.println("4. Asignar propietario al vehículo");
            System.out.println("5. Regresar");

            int opcionVehiculo = scanner.nextInt();
            scanner.nextLine(); // Consume newline left-over

            switch (opcionVehiculo) {
                case 1:
                    añadirVehiculo(scanner, taller);
                    break;
                case 2:
                    mostrarVehiculo(scanner, taller);
                    break;
                case 3:
                    darBajaVehiculo(taller);
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

    private static void menuReparaciones(Scanner scanner, Taller taller) {
        while (true) {
            System.out.println("\nMenú de Reparaciones:");
            System.out.println("1. Realizar reparación");
            System.out.println("2. Eliminar reparación");
            System.out.println("3. Listar reparaciones activas");
            System.out.println("4. Contar reparaciones totales");
            System.out.println("5. Regresar");

            int opcionReparacion = scanner.nextInt();
            scanner.nextLine(); // Consume newline left-over

            switch (opcionReparacion) {
                case 1:
                    realizarReparacion(scanner, taller);
                    break;
                case 2:
                    eliminarReparacion(taller);
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

    private static void añadirCliente(Scanner scanner, Taller taller) {
        System.out.print("Ingrese nombre del cliente: ");
        String nombre = scanner.nextLine().trim();
        System.out.print("Ingrese telefono del cliente: ");
        String telefono = scanner.nextLine().trim();
        
        taller.registrarCliente(new Cliente(nombre, telefono));
        System.out.println("Cliente añadido con éxito.");
    }

    private static void mostrarCliente(Scanner scanner, Taller taller) {
        System.out.print("Ingrese número del cliente para mostrar información: ");
        int idCliente = scanner.nextInt();
        scanner.nextLine(); // Consume newline left-over
        
        taller.mostrarInfo(idCliente); // la función está en clase cliente  
    }

    private static void darBajaCliente(Taller taller) {
        System.out.print("Ingrese número del cliente para dar de baja: ");
        int numeroCliente = taller.getClientes().size() + 1; // Asumiendo que los números de cliente son consecutivos y comienzan desde 1
        taller.bajaCliente(numeroCliente);
        System.out.println("Cliente eliminado con éxito.");
    }

    private static void añadirVehiculo(Scanner scanner, Taller taller) {
        System.out.print("Ingrese matrícula del vehículo: ");
        String matricula = scanner.nextLine().trim();
        System.out.print("Ingrese marca del vehículo: ");
        String marca = scanner.nextLine().trim();
        System.out.print("Ingrese modelo del vehículo: ");
        String modelo = scanner.nextLine().trim();
        
        taller.registrarVehiculo(new Vehiculo(matricula, marca, modelo));
        System.out.println("Vehículo añadido con éxito.");
    }

    private static void mostrarVehiculo(Scanner scanner, Taller taller) {
        System.out.print("Ingrese matrícula del vehículo para mostrar información: ");
        String matricula = scanner.nextLine().trim();
        
        taller.mostrarInfoVehiculo(matricula);
    }

    private static void darBajaVehiculo(Taller taller) {
        System.out.print("Ingrese matrícula del vehículo para dar de baja: ");
        String matricula = taller.getVehiculos().get(0).getMatricula(); // Asumiendo que el primer vehículo es el primero en ser eliminado
        taller.bajaVehiculo(matricula);
        System.out.println("Vehículo eliminado con éxito.");
    }

    private static void asignarPropietarioVehiculo(Scanner scanner, Taller taller) {
        System.out.print("Ingrese matrícula del vehículo: ");
        String matricula = scanner.nextLine().trim();
        System.out.print("Ingrese número del cliente propietario: ");
        int numeroCliente = scanner.nextInt();
        scanner.nextLine(); // Consume newline left-over
        
        taller.addPropietarioVehiculo(matricula, numeroCliente);
        System.out.println("Propietario asignado con éxito.");
    }

    private static void realizarReparacion(Scanner scanner, Taller taller) {
        System.out.print("Ingrese matrícula del vehículo: ");
        String matricula = scanner.nextLine().trim();
        System.out.print("Ingrese marca del vehículo: ");
        String marca = scanner.nextLine().trim();
        System.out.print("Ingrese modelo del vehículo: ");
        String modelo = scanner.nextLine().trim();
        System.out.print("Ingrese descripción de la reparación: ");
        String descripcion = scanner.nextLine().trim();
        System.out.print("Ingrese costo de la reparación: $");
        double costo = scanner.nextDouble();
        
        taller.realizarReparacion(new Reparacion(matricula, marca, modelo, descripcion, costo));
        System.out.println("Reparación añadida con éxito.");
    }

    private static void eliminarReparacion(Taller taller) {
        System.out.print("Ingrese número de la reparación para eliminarla: ");
        int idReparacion = taller.getReparaciones().size() + 1; // Asumiendo que los números de reparación son consecutivos y comienzan desde 1
        taller.bajaReparacion(idReparacion);
        System.out.println("Reparación eliminada con éxito.");
    }

    private static void listarReparacionesActivas(Taller taller) {
        taller.listarReparaciones();
    }

    private static void contarReparacionesTotales(Taller taller) {
        System.out.println("Número total de reparaciones: " + taller.contarReparaciones());
    }
}

    1

    

