/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.ejercicio1;

import java.time.LocalDate;

/**
 *
 * @author mama
 */
public class Usuario extends Persona {
    private String password;
    private String Rol;
    
   

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
            String Rol
    ) {
        super(idPersona, nombre, email, telefono, esPersonaFisica, 
                fechaAlta, fechaBaja, activo, esProveedor);
        this.password = password;
        this.Rol = Rol;
        
               
    };

    // Getters 
    
    public String getPassword(){
        String algoritmo = "asf3445ds6644sdf"; 
        String password2 = this.password.replace(algoritmo, "");
        System.out.println(password2);
        return password2 ;
    }    
    
    public String getRol(){
        return Rol;
    }
    
    // setters
    
    public void setPassword(String password){
        String algoritmo = "asf3445ds6644sdf";
        this.password = algoritmo + password + algoritmo ;
        System.out.println("Hecho, password nuevo");
    }
    
    public void setRol(String Rol){
        this.Rol = Rol;
    }
        
    
    //metodos 
    
    public void iniciarSesion(){
        super.setActivo(true);
        //System.out.println("Sesion Iniciada, Bienvenido " + super.getNombre());
        // return true;
      
            if(super.isActivo()){
               System.out.println("Sesion iniciada");
            } else { 
                System.out.println("por favor inicie sesion");
               }
    
    }
        
    
    public boolean cerrarSesion(){
        super.setActivo(false);
        System.out.println("Sesion Cerrada, Bienvenido " + super.getNombre());
        return false;
        
    }
    
    public Reporte generarReporte(int idReporte){
    
        System.out.println(Reporte.idReporte);
    }
    
    
    public Rol asignarRol(int IdUsuario, Rol idRol){
    
        Usuario.setRol(Rol idRol)
    }
    
    
    }



