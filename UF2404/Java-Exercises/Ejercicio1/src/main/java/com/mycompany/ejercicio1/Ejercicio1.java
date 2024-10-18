/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.ejercicio1;
import java.time.*;
import java.util.*;
/**
 *
 * @author mama
 */
public class Ejercicio1 {

    public static void main(String[] args) {
       System.out.println("Bienvenido al ERP ");
       
       
/////////////////////////////////////////////////////BASE /////////////////////////////////////////////////       
       // crear inventario
       
       Inventario Almacen = new Inventario();
       // crear Categorias
       
       Categoria Alimentacion = new Categoria(1, "alimentacion",null);
       Categoria Verduras = new Categoria(2, "Verduras",Alimentacion);
       Categoria Lacteos = new Categoria(3, "Lácteos",Alimentacion);
       Categoria Drogueria = new Categoria(4, "Drogueria",null);
       Categoria Limpieza = new Categoria(5, "Limpieza",Drogueria);
       Categoria Perfumeria = new Categoria(6, "Perfumeria",Drogueria);
       
       // crear roles
       Rol Admin = new Rol(1, "Administrador",Arrays.asList("Crear","modificar","Borrar"));
       Rol Curri = new Rol(1,"Currito",Arrays.asList("Crear","modificar"));
       Rol Cliente = new Rol (3,"cliente",Arrays.asList("Leer"));
       Rol proveedor = new Rol (4,"proveedor",null);
      // crear tres usuarios
       Usuario Ana = new Usuario(1,"ana","ana@mail.com", "1234545", true, LocalDate.of(2024,10,15), null, true, false, "12345",Admin);
       Usuario Mari = new Usuario(2,"mari","mari@mail.com", "5678976", true, null, null, false, false, "12345",Curri);
       Usuario Jose = new Usuario(3,"jose","jose@mail.com", "3356754", true, null, null, false, false, "12345",Cliente);

      // crear dos proveedores
      
      Proveedor Unilever =new Proveedor(1,"Unilever","unilever@mail.com","1234545",true,null,null,true,true,"12345");
      Proveedor Bonarea =new Proveedor(2,"Bon Area","Bonarear@mail.com","343646734",true,null,null,true,true,"56789");

      // crear 10 productos
      
      Producto Leche = new Producto(1,"leche",Lacteos,1,50,null,LocalDate.of(2024,11,18),Bonarea);
      
      Producto Patatas = new Producto(2,"Patatas",Verduras,2,40,null, LocalDate.of(2024, 10, 31),Bonarea);
      
      Producto Lechuga = new Producto(3,"Lechuga",Verduras,1,57,null, LocalDate.of(2024, 10, 31),Bonarea);
      
      Producto Mantequilla = new Producto(4,"Mantequilla",Lacteos,1,50,null,LocalDate.of(2024,10,20),Unilever);
       
      Producto Jabon_Ropa = new Producto(5,"Jabon de la Ropa",Limpieza,6,25,null,LocalDate.of(2026,11,18),Unilever); 
       
      Producto Friegasuelos = new Producto(6,"Friegasuelos",Limpieza,3,3,null,LocalDate.of(2026,11,18),Unilever); 
      
      Producto Bicarbonato = new Producto(7,"Bicarbonato Industrial",Limpieza,1,12,null,LocalDate.of(2028,11,18),Bonarea); 
      
      Producto Colonia = new Producto(8,"Colonia de bebé",Perfumeria,15,25,null,LocalDate.of(2027,12,21),Unilever);      
      
      Producto Pasta_dientes = new Producto(9,"Pasta de Dientes",Perfumeria,4,2,null,LocalDate.of(2026,12,18),Unilever); 
 
        System.out.println("\nMETODOS de INVENTARIO");
/////////////////////////////////////////////////////// Metodos de Inventario
 
      Almacen.valorTotalInventario();
       
      Almacen.listarProductosNombre("patata");
      
      Almacen.listarProductosProveedor("unilever");
      
      Almacen.listarProductosDisponibilidad(true);
      
      Almacen.listarProductosFechaCaducidad(LocalDate.of(2024,10,31));
      
      Almacen.listarProductosRangoPrecio(5, 1);
      
      Almacen.consultaStock("pasta de dientes");
      
        
        
        
    }

    public Ejercicio1() {
    }

    
}
