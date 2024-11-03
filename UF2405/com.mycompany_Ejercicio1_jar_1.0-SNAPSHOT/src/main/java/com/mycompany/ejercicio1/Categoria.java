/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.ejercicio1;

import java.util.ArrayList;
import java.util.List;
import java.util.*;
/**
 *
 * @author mama
 */
public class Categoria {
        private int idCategoria;
        private String nombre;
        private Categoria categoriaPadre;
        private List<Producto> productosCategoria ;

        
        // constructor:
    public Categoria(int idCategoria, String nombre, Categoria categoriaPadre) {
        this.idCategoria = idCategoria;
        this.nombre = nombre;
        this.categoriaPadre = categoriaPadre;
        this.productosCategoria = new ArrayList<>();
        Inventario.addCategoria(this);
        if(this.categoriaPadre == null){
        System.out.println("Categoría genérica creada: "+ nombre);}
        else{System.out.println("SubCategoría creada: " + nombre +" padre: " + categoriaPadre.getNombre() );}
        
        
    }
        
      // getters
    
    public int getIdCategoria (){
            return idCategoria;
    }
    
    public String getNombre(){
            return nombre;
    
    }
    
    public Categoria getCategoriaPadre() {
            return categoriaPadre;
    }
    
    // setters
    
    public void setIdCategoria(int idCategoria ) {
            int auxiliar = this.getIdCategoria();
            this.idCategoria = idCategoria;
            System.out.println("Hecho, idCategoria: "+ auxiliar + " cambiado a "+ this.idCategoria);
    }
    
    public void setNombre(String nombre){
        String auxiliar = this.getNombre();
        this.nombre = nombre;
        System.out.println("Hecho, Nombre: "+ auxiliar +" Cambiado a " + this.nombre);
    }
    
    public void setCategoriaPadre (Categoria categoria){
        Categoria auxiliar = this.getCategoriaPadre();
        this.categoriaPadre = categoria;
        System.out.println("Hecho, Categoría padre: " +auxiliar +" Cambiada a "+ this.categoriaPadre);
    }

    //metodos:
    
    // Añadir producto
    public void addProductoCategoria(Producto producto){
            this.productosCategoria.add(producto);
            System.out.println("\n1. El producto "+ producto.getNombre() + " se ha añadido a la categoría " + this.getNombre());
    }
    // listar productos
    public void obtenerProductosDeCategoria() { 
        System.out.println("En la Categoria hay los productos: ");
        for (Producto producto : productosCategoria) {
             System.out.print(producto.getNombre() + ", ");
            }
        }
    // quitar productos  
    public void removeProductoCategoria(Producto producto){
            this.productosCategoria.remove(producto);
            System.out.println("El producto "+ producto.getNombre() + " se ha quitado de la categoría " + this.getNombre());
    }

}

