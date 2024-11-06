/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package home.afm.ec_2405dao;

import java.sql.SQLException;

/**
 *
 * @author mama
 */
public class EC_2405DAO {

    public static void main(String[] args) throws SQLException {
        
        System.out.println("\n_*_*_*_*_*_*_*_*_*_*_*_*_*Inicio del programa*_*_*_*_*_*_*_*_*_*_*_*_*_ ");
        
        System.out.println("\n_*_*_*_*_*_*_*_*_*_*_*_*_*Operaciones CRUD de Producto*_*_*_*_*_*_*_*_*_*_*_*_*_ ");
        // Ejemplos de operaciones CRUD para Producto
        Producto producto = new Producto( "Laptop", 999.99);
        
        Producto.crearProducto("Castañas",122.33);
        System.out.println("\n --Printa 1 producto ");

        Producto productoObtenido = Producto.obtenerProductoPorId(2);
        System.out.println("producto: " + productoObtenido);
        
        System.out.println("\n --Modifica 1 Producto ");
        productoObtenido.setNombre("patatas");
        System.out.println("nombre cambiado");
        Producto.actualizarProducto(productoObtenido);
        
        System.out.println("producto: " + productoObtenido);
        
        System.out.println("\n --Borra 1 Producto ");
        Producto.eliminarProducto(3);
        
    Producto productoObtenido2 = Producto.obtenerProductoPorId(3);
        System.out.println("producto: " + productoObtenido2);
        
        
 System.out.println("\n_*_*_*_*_*_*_*_*_*_*_*_*_*Operaciones CRUD de Cliente*_*_*_*_*_*_*_*_*_*_*_*_*_ ");
               
        Cliente.crearCliente("carlos","carlos@mail.com");
        Cliente.crearCliente("joseLuis","carlos@mail.com");
        System.out.println("\n --Printa 1 cliente ");

        Cliente clienteObtenido = Cliente.obtenerClientePorId(2);
        System.out.println("cliente: " + clienteObtenido);
        
        System.out.println("\n --Modifica 1 Cliente ");
        clienteObtenido.setNombre("Paco");
        System.out.println("nombre cambiado");
        Cliente.actualizarCliente(clienteObtenido);
        
        System.out.println("cliente: " + clienteObtenido);
        
        System.out.println("\n --Borra 1 Cliente ");
        Cliente.eliminarCliente(3);
        
        Cliente clienteObtenido2 = Cliente.obtenerClientePorId(3);
        System.out.println("cliente: " + clienteObtenido2);
        
        System.out.println("\n --Añade producto a la cesta del cliente"
                + " ");
        Producto.añadirCesta(clienteObtenido, productoObtenido);
    }
    
    
   
    
    
}

