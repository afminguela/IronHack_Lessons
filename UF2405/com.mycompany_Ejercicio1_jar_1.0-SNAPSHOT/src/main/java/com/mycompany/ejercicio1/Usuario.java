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
public class Usuario extends Persona {
    private String password;
    private Rol rol;
    
   

    public Usuario( 
            int idPersona, 
            String nombre, 
            String email, 
            String telefono, 
            boolean esPersonaFisica, 
            LocalDate fechaAlta, 
            LocalDate fechaBaja, 
            boolean activo, 
            boolean esProveedor,
            String password, 
            Rol rol
    ) {
        super(idPersona, nombre, email, telefono, esPersonaFisica, 
                fechaAlta, fechaBaja, activo, esProveedor);
        this.password = password;
        this.rol = rol;
        
        Inventario.addUsuarios(this);
        
               
    };

    // Getters 
    
    public String getPassword(){
        String algoritmo = "asf3445ds6644sdf"; 
        String password2 = this.password.replace(algoritmo, "");
        System.out.println(password2);
        return password2 ;
    }    
    
    public Rol getRol(){
        return rol;
    }
    
    // setters
    
    public void setPassword(String password){
        String algoritmo = "asf3445ds6644sdf";
        this.password = algoritmo + password + algoritmo ; 
        System.out.println("Hecho, se ha cambiado su password con éxito");
    }
    
    public void setRol(Rol rol){
        String auxiliar = this.rol.getNombreRol();
        this.rol = rol;
        System.out.println("Hecho, Rol: "+ auxiliar + " cambiado a "+ this.rol.getNombreRol());
    }
        
    
    //metodos 
    
    public void iniciarSesion(){
        super.setActivo(true);
              
            if(super.isActivo()){
               System.out.println("Sesion iniciada, Bienvenid@ "+ super.getNombre());
            } else { 
                System.out.println("Por favor inicie sesion correctamente");
               }
    
    }
        
    
    public boolean cerrarSesion(){
        super.setActivo(false);
        System.out.println("Sesion Cerrada, Hasta pronto " + super.getNombre());
        return false;
        
    }
    
    public Reporte generarReporte(int idReporte){  // exportar a txt. 
          int auxiliar = idReporte;
        // constructor de reportes
        Reporte Informe = new Reporte(auxiliar);
        System.out.println("El Reporte " +auxiliar + " ha sido creado.");
        return Informe;
    }
    
    public void asignarRol(Usuario usuario, Rol nuevoRol){   // necesario??
        String nomUsuario = usuario.getNombre();
        String rolUsuario = usuario.rol.getNombreRol();
        
        if (this.rol.getNombreRol().equalsIgnoreCase("administrador")){
        usuario.setRol(nuevoRol);
        System.out.println("Confirmado, El usuario " + nomUsuario + " ha cambiado del rol "+ rolUsuario + " al rol " + nuevoRol.getNombreRol() ); 
        } else {
            System.out.println("No tienes el nivel necesario para poder hacer esto.");}
    }
    
    }



