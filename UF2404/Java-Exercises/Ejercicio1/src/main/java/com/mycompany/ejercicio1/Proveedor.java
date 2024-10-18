/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.ejercicio1;


import java.time.LocalDate;
import java.util.*;

/**
 *
 * @author mama
 */
public class Proveedor extends Persona {
    
    private String password;
    private List<Producto> productos ;  // declaras la variable para hacer una lista 
    
    
    

    // constructores 
    
    public Proveedor(String password, int idPersona){
        super(idPersona);
        this.password = password;
        Inventario.addProveedores(this);
    }
    
    public Proveedor(
            String password, int idPersona, String nombre, String email, String telefono, LocalDate fechaAlta, LocalDate fechaBaja, boolean activo) {
        super(idPersona, nombre, email, telefono, fechaAlta, fechaBaja, activo);
        this.password = password;
        Inventario.addProveedores(this);
    }

    public Proveedor(int idPersona) {
        super(idPersona);
        Inventario.addProveedores(this);
    }
    public Proveedor( 
            int idPersona, 
            String nombre, 
            String email, 
            String telefono, 
            boolean esPersonaFisica, 
            LocalDate fechaAlta, 
            LocalDate fechaBaja, 
            boolean activo, 
            boolean esProveedor,
            String password 
           
    ) {
        super(idPersona, nombre, email, telefono, esPersonaFisica = false, 
                fechaAlta, fechaBaja, activo, esProveedor = true);
        this.password = password;
        this.productos = new ArrayList<>(); // creamos la lista donde añadir productos para cada proveedor
        
        Inventario.addProveedores(this);
    }

    //getters
    
    public String getPassword(){
        String algoritmo = "asf3445ds6644sdf"; 
        String password2 = this.password.replace(algoritmo, "");
        System.out.println(password2);
        return password2 ;
    }   

    public List<Producto> getProductos() {  // esto lista los productos de este proveedor??? se supone que si
        return productos;
    }

    
    //setters
    
    public void setPassword(String password){
        String algoritmo = "asf3445ds6644sdf";
        this.password = algoritmo + password + algoritmo ; 
        System.out.println("Hecho, password nuevo");
    }

    

     
    
    // métodos 
    
    public void addProductoProveedor(Producto producto){
            Proveedor auxiliar = producto.getProveedor();
            this.productos.add(producto);
            System.out.println("Se ha Añadido ñadido "+ producto.getNombre() + " a la lista del proveedor " + auxiliar.getNombre());
    }
    
    
    

}   
