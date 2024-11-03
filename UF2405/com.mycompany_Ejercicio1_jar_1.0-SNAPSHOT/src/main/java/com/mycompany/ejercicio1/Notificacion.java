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
public class Notificacion {
    private int idNotificacion;
    private String mensaje;
    private LocalDate fechaNotificacion;
    private String tipo;
    private Producto producto;
       
    private static final Set<Integer> idsUsados = new HashSet(); // el set hace un array sin duplicados.  SHA256()
    private static int contador =1;
    //Constructor:

    public Notificacion(String mensaje, LocalDate fechaNotificacion, String tipo, Producto producto)  {
       
        this.idNotificacion= contador;
        this.mensaje = mensaje;
        this.fechaNotificacion = fechaNotificacion;
        this.tipo = tipo;
        this.producto = producto;
        contador ++;
        idsUsados.add(idNotificacion);
        
        
        
    }
    
    
    // getters
    
    public int getidNotificacion(){
       return idNotificacion;
    }
    
    public String getMensaje(){
        return mensaje;
            }
    
    public LocalDate getFechaNotificacion(){
        return fechaNotificacion;
    }
    
    public String getTipo(){
        return tipo;
    }
    
    public Producto getProducto(){
        return producto;
    }
    
    
    // setters
    
    
    public void setIdNotificacion(int idNotificacion){
        int auxiliar = this.getidNotificacion();
        this.idNotificacion = idNotificacion;
        System.out.println("Hecho, idNotificacion: "+ auxiliar + " cambiado a "+ this.idNotificacion);
    }
    
    public void setMensaje(String mensaje){
        String auxiliar = this.getMensaje();
        this.mensaje = mensaje;
        System.out.println("Hecho, mensaje: "+ auxiliar + " cambiado a "+ this.mensaje);
    }
    
    public void setFechaNotificacion(LocalDate fechaNotificacion){
        LocalDate auxiliar = this.getFechaNotificacion();
            this.fechaNotificacion = fechaNotificacion;    
        System.out.println("Hecho,Fecha de Notificación: "+ auxiliar + " cambiada a "+ this.fechaNotificacion);
    }
    
    
    public void setTipo(String tipo){
        String auxiliar = this.getTipo();
        this.tipo = tipo;
        System.out.println("Hecho, Tipo de Notificacion: "+ auxiliar + " cambiado a "+ this.tipo);
    }
    
    public void setProducto(Producto producto){
        Producto auxiliar = this.getProducto();
        this.producto = producto;
        System.out.println("Hecho, Producto: "+ auxiliar + " cambiado a "+ this.producto);
    }
    
    // métodos:
    
    public static boolean enviarNotificacion(Producto producto){
        
        if (producto.productoProximoCaducar(5)&& producto.BajoStock()){
            Notificacion notificacion = new Notificacion("Producto con bajo stock y proximo a caducar", LocalDate.now(),"completa", producto);
            System.out.println("Notificación Enviada1");
            return true;
        } else if (producto.productoProximoCaducar(5)){
             Notificacion notificacion = new Notificacion("Producto proximo a caducar", LocalDate.now(),"Caducidad", producto);
             System.out.println("Notificación Enviada2");
             return true;
        } else if (producto.BajoStock()){
                Notificacion notificacion = new Notificacion("Producto con bajo stock", LocalDate.now(),"bajo Stock", producto);
                System.out.println("Notificación Enviada3");
                return true;
                }else{ System.out.println("Notificacion no enviada");
            return false;}    
        
        
    }
    
    
}

