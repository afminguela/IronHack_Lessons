/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.ejercicio1;

import java.util.*;
import java.time.*;
/**
 *
 * @author mama
 */
public class Inventario {
    
    private static List<Categoria> categorias = new ArrayList<>();  // Static es para no tener que 
    private static List<Producto> productos = new ArrayList<>();                                                                // instanciar un inventario. 
    private static List<Usuario> usuarios = new ArrayList<>();  
    private static List<Rol> roles = new ArrayList<>();
    private static List<Proveedor> proveedores = new ArrayList<>();
    
    public Inventario() {
        
    }
    
    // metodos
    // añade Categoria listado de categorias 
    public static void addCategoria(Categoria categoria){  
        categorias.add(categoria);
    }
    // añade producto al inventario
    public static void addProductoInventario(Producto producto){  
        productos.add(producto);
    } 
    
    // añade Usuario a la lista de usuarios
    public static void addUsuarios(Usuario usuario){  
        usuarios.add(usuario);
    }
    // añade rol a la lista de roles
    public static void addRoles(Rol rol){  
        roles.add(rol);
    }
    
    // añade proveedor a la lista de proveedores
    public static void addProveedores(Proveedor proveedor){  
        proveedores.add(proveedor);
    }
    
    // ## Filtros de productos
    // Filtro por categoría
    public static void listarProductosCategoria(String nombre){
    for(Categoria categoria : categorias){
        if(categoria.getNombre().equalsIgnoreCase(nombre)){ 
            System.out.println("Productos listados de la categoria: " + categoria.getNombre());
            categoria.obtenerProductosDeCategoria();
        
        }       
    }
    
    }
    
          
    // Filtro por Nombre 
    public static void listarProductosNombre(String nombre){
        int counter=0;
        System.out.println("Productos encontrados cuyo nombre coicide con '"+ nombre+"': ");
        for(Producto producto: productos){
            if(producto.getNombre().equalsIgnoreCase(nombre)){
                counter++;
                System.out.print( counter +"- "+producto.getNombre());
                
            } 
        }
    }
    
    // filtro por proveedor
    
    public static void listarProductosProveedor(String nombreProveedor){
            System.out.println("Producto encontrado cuyo proveedor coincide con '"+ nombreProveedor+"': " );

            int counter=0;
    for (Producto producto : productos) {
        
        if (producto.getProveedor().getNombre().equalsIgnoreCase(nombreProveedor)) {
            counter++;
            System.out.println(counter + "- "+ producto.getNombre());
            
        }
    }
}

    
    // Filtro por disponibilidad
    public static void listarProductosDisponibilidad(boolean disponibilidad){ // pasarla si true
                            System.out.println("\nProductos encontrados con cuya disponibilidad coincide: " );
            int counter=0;
            for(Producto producto: productos){
              
            if(producto.isDisponibilidad() == disponibilidad){
                counter++;
                System.out.println(counter + "- "+ producto.getNombre());
            }
        }
    }
    
    // Filtro por fecha de caducidad
    public static void listarProductosFechaCaducidad(LocalDate fecha){ 
        System.out.println("\nProductos encontrados con la fecha de caducidad indicada: ");
        int counter=0;
        for(Producto producto: productos){
            if(fecha.equals(producto.getFechaCaducidad())){
                counter++;
                System.out.println(counter+"- "+ producto.getNombre());
            }
        }
    }
    
    // Filtro por rango de precios
    public static void listarProductosRangoPrecio(float precioMax, float precioMin) {
        int counter =0;
        System.out.println("\nProductos encontrados dentro del rango de precios: ");
        
        for (Producto producto : productos) {
            if (precioMin <= producto.getPrecio() && producto.getPrecio() <= precioMax) {
                counter++;
                System.out.println(counter +"- "+ producto.getNombre());
        }
    }
}
    
    // consulta stock
    public static void consultaStock(String Nombre){
                for(Producto i : productos){
            if(Nombre.equalsIgnoreCase(i.getNombre())){
            System.out.println("\nEl stock de " + Nombre + " es " + i.getStock());
        };
    };
    
    };   
    
// Valor Total Inventario
public static float valorTotalInventario(){
        float precioTotal = 0;
            for (Producto producto : productos){
              precioTotal += (producto.getPrecio()* producto.getStock());
            }
            System.out.println("\nEl valor total del Inventario es  " + precioTotal);
            return precioTotal;
    };
    
       
}
