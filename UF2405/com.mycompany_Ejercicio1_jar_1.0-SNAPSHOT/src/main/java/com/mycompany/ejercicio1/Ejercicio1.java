/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.ejercicio1;
import java.time.*;
import java.util.*;
import com.mycompany.ejercicio1.Notificacion;
import static com.mycompany.ejercicio1.Notificacion.enviarNotificacion;
/**
 *
 * @author mama
 */
public class Ejercicio1 {

    public static void main(String[] args) {
       System.out.println("Bienvenido al ERP ");
       
       System.out.println("\n DATOS BASE DE CONSTRUCCION DE ALMACÉN");
/////////////////////////////////////////////////////BASE /////////////////////////////////////////////////       
       // crear inventario
       System.out.println("\nCREAR INVENTARIO:");
       Inventario Almacen = new Inventario();
       // crear Categorias
       System.out.println("\nCREAR CATEGORIAS");
       Categoria Alimentacion = new Categoria(1, "alimentacion",null);
       Categoria Verduras = new Categoria(2, "Verduras",Alimentacion);
       Categoria Lacteos = new Categoria(3, "Lácteos",Alimentacion);
       Categoria Drogueria = new Categoria(4, "Drogueria",null);
       Categoria Limpieza = new Categoria(5, "Limpieza",Drogueria);
       Categoria Perfumeria = new Categoria(6, "Perfumeria",Drogueria);
       
       // crear roles
       System.out.println("\nCREAR ROLES");
       Rol Admin = new Rol(1, "Administrador",Arrays.asList("Crear","modificar","Borrar"));
       Rol Curri = new Rol(1,"Currito",Arrays.asList("Crear","modificar"));
       Rol Cliente = new Rol (3,"cliente",Arrays.asList("Leer"));
       Rol Proveedor = new Rol (4,"proveedor",Arrays.asList(""));
       
      // crear tres usuarios
      
      System.out.println("\nCREAR USUARIOS");
       Usuario Ana = new Usuario(1,"ana","ana@mail.com", "1234545", true, LocalDate.of(2024,10,15), null, true, false, "12345",Admin);
       Usuario Mari = new Usuario(2,"mari","mari@mail.com", "5678976", true, null, null, false, false, "12345",Curri);
       Usuario Jose = new Usuario(3,"jose","jose@mail.com", "3356754", true, null, null, false, false, "12345",Cliente);

      // crear dos proveedores
      
      System.out.println("\nCREAR PROVEEDORES");
      Proveedor Unilever =new Proveedor(1,"Unilever","unilever@mail.com","1234545",true,null,null,true,true,"12345");
      Proveedor Bonarea =new Proveedor(2,"Bon Area","Bonarear@mail.com","343646734",true,null,null,true,true,"56789");

      // crear 10 productos
      System.out.println("\nCREAR PRODUCTOS");
      Producto Leche = new Producto(1,"leche",Lacteos,1,50,null,LocalDate.of(2024,10,28),Bonarea);
      
      Producto Patatas = new Producto(2,"Patatas",Verduras,2,40,null, LocalDate.of(2024, 10, 31),Bonarea);
      
      Producto Lechuga = new Producto(3,"Lechuga",Verduras,1,57,null, LocalDate.of(2024, 10, 31),Bonarea);
      
      Producto Mantequilla = new Producto(4,"Mantequilla",Lacteos,1,50,null,LocalDate.of(2024,10,20),Unilever);
       
      Producto Jabon_Ropa = new Producto(5,"Jabon de la Ropa",Limpieza,6,25,null,LocalDate.of(2026,11,18),Unilever); 
       
      Producto Friegasuelos = new Producto(6,"Friegasuelos",Limpieza,3,3,null,LocalDate.of(2026,11,18),Unilever); 
      
      Producto Bicarbonato = new Producto(7,"Bicarbonato Industrial",Limpieza,1,12,null,LocalDate.of(2028,11,18),Bonarea); 
      
      Producto Colonia = new Producto(8,"Colonia de bebé",Perfumeria,15,25,null,LocalDate.of(2027,12,21),Unilever);      
      
      Producto Pasta_dientes = new Producto(9,"Pasta de Dientes",Perfumeria,4,2,null,LocalDate.of(2026,12,18),Unilever); 
        System.out.println("\n");

        System.out.println("\nMETODOS de INVENTARIO");
/////////////////////////////////////////////////////// Metodos de Inventario
 
      Almacen.valorTotalInventario();
              System.out.println("\n");

      Almacen.listarProductosNombre("patatas");
             System.out.println("\n");

      Almacen.listarProductosProveedor("unilever");
             System.out.println("\n");

      Almacen.listarProductosDisponibilidad(true);
             System.out.println("\n");

      Almacen.listarProductosFechaCaducidad(LocalDate.of(2024,10,31));
             System.out.println("\n");

      Almacen.listarProductosRangoPrecio(5, 1);
       System.out.println("\n");
      Almacen.consultaStock("pasta de dientes");
       System.out.println("\n");
      Almacen.listarProductosCategoria( "Limpieza");
        
       System.out.println("\n");  
        
    //////////////////////////// Métodos de categoria/////////////////
    
    
        System.out.println("\n+-+--+-+-+-+-+-+-+-+-+-+-Métodos CATEGORIA+-+-+-+-+-+-+-+-+-+-");
        
     Limpieza.obtenerProductosDeCategoria();   
     
        System.out.println("\n");
        
     Limpieza.removeProductoCategoria(Leche);
        System.out.println("\n");
        
    Limpieza.addProductoCategoria(Leche);
        System.out.println("\n");
        
    //////////////////////////////////metodos usuario////////////////////
    
    System.out.println("\n-+-+-+-+-+--++-+--+-+MÉTODOS USUARIO+-+-+-+-+-+-+-+-+-");
    
    Mari.iniciarSesion();
        System.out.println("\n");
        
    Ana.cerrarSesion();
        System.out.println("\n");
        
        
        Reporte Informe = null; // creo una variable vacía para poder llamar 
    Informe = Ana.generarReporte( 1);  // la relleno con lo que me da la funcion ( un objeto Reporte)
        System.out.println("\n");
        
        
    Ana.asignarRol( Mari,  Cliente);
        System.out.println("\n");
    
        
    Mari.asignarRol( Mari,  Admin);
        System.out.println("\n");
        
        
    //////////////////////////////////METodos proveedor//////////////////
    
    System.out.println("\n-+-+-+-+-+-+-+-+-+metodos PROVEEDOR - El suyo está OK-+-+-+-+-+-+-+-");
      
    // funciona Comprobada a traves de la funcion constructor de producto
    
    
    //////////////////////////////METODOS ROLES ////////////////////////
    
    System.out.println("\n-+-+-+-+-+-+--+-+-+-+-+-+-+metodos ROLES-+-+-+-+-+-+--+-+-+-+-+-+-");
    System.out.println("\nPermisos de Test de Admin Antes de empezar");
    Admin.getPermisos();
        System.out.println("\n");
    Admin.anyadirPermiso("Crear Reportes");
        System.out.println("\n");
    
    Admin.tienePermiso("Crear");
        System.out.println("\n");
    
    Admin.eliminarPermiso("Crear Reportes");
        System.out.println("\n");
    //////////////////////////////METODOS PRODUCTO ////////////////////////
    
    System.out.println("\n+-+--+-++-+-+-+-+-+--+-+-+-+-+-+-metodos PRODUCTO-++---++-++--+-+-+-+-+-+-+-+-+-+-+-");  

    Leche.sumarStock(23);
        System.out.println("\n");
    
    Leche.restarStock(72);
        System.out.println("\n");
    
    Leche.productoProximoCaducar(6);
        System.out.println("\n");
    
    Leche.BajoStock();
        System.out.println("\n");
    //////////////////////////////METODOS NOTIFICACION ////////////////////////
    
    System.out.println("\n-+-+-+-+-++-+--+-++-+-+-+-+-+-+-metodos NOTIFICACION-+-+-+-+-+-+-+-+-+-+-+-+-+-+-");
     System.out.println("\n");
    enviarNotificacion(Colonia);
    //////////////////////////////METODOS REPORTE ////////////////////////
    
    System.out.println("\n-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-metodos REPORTE+-+-+-+-+-+-+-+-+-+-+-+-+-+-+");
      
    Informe.getIdReporte();
     System.out.println("\n");
    Reporte Informe1 = new Reporte (1);
    //Reporte Informe2 = new Reporte ("SMS","Comprar leche","La leche se nos va a caducar",Almacen);
        
    System.out.println("\n+-+-+-+-+-   FIN TESTS MVP   -+-+-+-+-+-+-+-+-+-+-+-+-+-+-");
    }
         
    public Ejercicio1() {
    }

    
}
