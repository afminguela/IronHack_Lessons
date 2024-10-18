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
    
    //Constructor:

    public Notificacion(int idNotificacion, String mensaje, LocalDate fechaNotificacion, String tipo, Producto producto) throws Exception {
        if (idsUsados.contains(idNotificacion)) {
            throw new Exception("La Notificacion no se pudo crear, ya que el ID " + idNotificacion + " ya está en uso.");
        } else{
        
        this.idNotificacion= idNotificacion;
        this.mensaje = mensaje;
        this.fechaNotificacion = fechaNotificacion;
        this.tipo = tipo;
        this.producto = producto;
        }
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
    
    public void enviarNotificacion(Usuario usuario){
            // ni idea de como hacerlo sin instalar cosas nuevas o investigar...
    }
}