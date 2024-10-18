/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.ejercicio1;

import java.time.*;

/**
 *
 * @author mama
 */
public class Producto {
     private int idProducto;
     private String Nombre;
     private Categoria categoria;
     private float precio;
     private int stock;
     private LocalDate fechaAdquisicion;
     private LocalDate fechaCaducidad ;
     private Proveedor proveedor;
     private boolean disponibilidad;
     
     
     // constructor

    public Producto(int idProducto, String Nombre, Categoria categoria, float precio,
            int stock, LocalDate fechaAdquisicion, LocalDate fechaCaducidad, 
            Proveedor proveedor) {
        this.idProducto = idProducto;
        this.Nombre = Nombre;
        this.categoria = categoria;
        this.precio = precio;
        this.stock = stock;
        this.fechaAdquisicion = LocalDate.now();
        this.fechaCaducidad = fechaCaducidad;
        this.proveedor = proveedor;
        
        if(this.stock > 0){
            this.disponibilidad = true;
        }else{
            this.disponibilidad = false;
        }
        
        this.proveedor.addProductoProveedor(this); // le asociamos un proveedor
        Inventario.addProductoInventario(this); // le asociamos a un inventario
        
    }
     
     
     
     // getters
     
     

    public int getIdProducto() {
        return idProducto;
    }

    public String getNombre() {
        return Nombre;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public float getPrecio() {
        return precio;
    }

    public int getStock() {
        return stock;
    }

    public LocalDate getFechaAdquisicion() {
        return fechaAdquisicion;
    }

    public LocalDate getFechaCaducidad() {
        return fechaCaducidad;
    }

    public Proveedor getProveedor() {
        return proveedor;
    }

    public boolean isDisponibilidad() {
        return disponibilidad;
    }
 
//setters
     
     
    public void setIdProducto(int idProducto) {
        int auxiliar = this.getIdProducto();
        this.idProducto = idProducto;
        System.out.println("Hecho, idProducto: "+ auxiliar + " cambiado a "+ this.idProducto);
    }

    public void setNombre(String Nombre) {
        String auxiliar = this.getNombre();
        this.Nombre = Nombre;
        System.out.println("Hecho, nombre: "+ auxiliar + " cambiado a "+ this.Nombre);
    }

    public void setCategoria(Categoria categoria) {
        Categoria auxiliar = this.getCategoria();
        this.categoria = categoria;
        System.out.println("Hecho, Categoria: "+ auxiliar + " cambiado a "+ this.categoria);
    }

    public void setPrecio(float precio) {
        float auxiliar = this.getPrecio();
        this.precio = precio;
        System.out.println("Hecho, precio: "+ auxiliar + " cambiado a "+ this.precio);
    }

    public void setStock(int stock) {
        int auxiliar = this.getStock();
        this.stock = stock;
        System.out.println("Hecho, Stock: "+ auxiliar + " cambiado a "+ this.stock);
    }

    public void setFechaAdquisicion(LocalDate fechaAdquisicion) {
        LocalDate auxiliar = fechaAdquisicion;
        this.fechaAdquisicion = fechaAdquisicion;
        System.out.println("Hecho, Fecha de adquisicion: "+ auxiliar + " cambiado a "+ this.fechaAdquisicion);
    }

    public void setFechaCaducidad(LocalDate fechaCaducidad) {
        LocalDate auxiliar = this.getFechaCaducidad();
        this.fechaCaducidad = fechaCaducidad;
        System.out.println("Hecho, Fecha de Caducidad: "+ auxiliar + " cambiado a "+ this.fechaCaducidad);
    }

    public void setProveedor(Proveedor proveedor) {
        Proveedor auxiliar = this.getProveedor();
        this.proveedor = proveedor;
        System.out.println("Hecho, Proveedor: "+ auxiliar + " cambiado a "+ this.proveedor);
    }

    public void setDisponibilidad(boolean disponibilidad) {
        boolean auxiliar = this.isDisponibilidad();
        this.disponibilidad = disponibilidad;
        System.out.println("Hecho, disponibilidad: "+ auxiliar + " cambiado a "+ this.disponibilidad);
        
    }
    
    
    //metodos 
    
    // Añade al stock
      public void sumarStock(int cantidad){
            this.stock =+ cantidad;
            System.out.println("El stock de " + this.getNombre() + " se ha actualizado a " + this.stock+ " sumándole " + cantidad);
    }
      
      // resta del stock
      public void restarStock(int cantidad){
          this.stock =- cantidad;
          System.out.println("El stock de " + this.getNombre() + " se ha actualizado a " + this.stock+ " restándole " + cantidad);
    }
      
      // te dice si al producto le quedan menos de 5 dias para caducar ( rsponde si o no
      public boolean productoProximoCaducar(){
          LocalDate hoy = LocalDate.now();
          LocalDate caducidad = this.getFechaCaducidad();
          if (caducidad.isAfter(hoy)&& caducidad.isBefore(hoy.plusDays(5))){
              System.out.println("El producto "+ this.getNombre() + "está a punto de caducar");
               return true; }
          else {
          return false;}
          
    }
      // te dice si del producto quedan menos de 5 unidades.
      public void BajoStock(){
          if( this.stock > 5){
              System.out.println("El producto " + this.getNombre() + " tiene stock menor de 5");}
    }
      
}
