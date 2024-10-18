/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.ejercicio1;

import java.util.*;
/**
 *
 * @author mama
 */

public class Rol {
    private int idRol;
    private String nombreRol;
    private List<String> permisos = new ArrayList<>(); // lo que va entre <> es el TIPO de dato ya se aun INT o una clase, so empanada!!!
    
    
    // Constructor:
    
    public Rol(int idRol){
         this.idRol = idRol;
         System.out.println("Rol Creado");
         Inventario.addRoles(this);
    }
    
    public Rol(int idRol, String nombreRol, List<String> permisos) {
        this.idRol = idRol;
        this.nombreRol = nombreRol;
        this.permisos = permisos;
        Inventario.addRoles(this);
    }
    // Getters

    public int getIdRol() {
        return idRol;
    }

    public String getNombreRol() {
        return nombreRol;
    }

    public List<String> getPermisos() {
        return permisos;
    }

    // setters:

    public void setIdRol(int idRol) {
        int auxiliar = this.getIdRol();
        this.idRol = idRol;
        System.out.println("Hecho, Rol: "+ auxiliar + " cambiado a "+ this.idRol);
    }

    public void setNombreRol(String nombreRol) {
        String auxiliar = this.getNombreRol();
        this.nombreRol = nombreRol;
        System.out.println("Hecho, nombre del Rol: "+ auxiliar + " cambiado a "+ this.nombreRol);
    }

//    public void setPermisos(List<String> permisos) {
//        List<String> auxiliar = permisos;
//        this.permisos = permisos;
//        System.out.println("Hecho, los permisos: "+ auxiliar + " han cambiado a "+ this.permisos);
//    }
//    
    

    // métodos:
    public void anyadirPermiso(String permiso){
            permisos.add(permiso);
            System.out.println(permiso+" añadido al rol"+ this.getNombreRol());
            
    }
     
    public boolean tienePermiso (String permiso){
               // Comparacion
            boolean permisoAux = false;   
            for (String i : permisos){
                 if (i.equalsIgnoreCase(permiso)){
                 permisoAux = true;
                     System.out.println("Enhorabuena, tienes permiso para "+ permiso);
                 }
                 else {permisoAux = false;
                     System.out.println("Lo sentimos pero " + permiso + " no está incluido en tus permisos, habla con un administrador si crees que deberias tenerlos.");}
            }
            return permisoAux;
    }
    
    public void eliminarPermiso (String permiso){
              //borrar cadena
              String permisoAux = "";   
            for (String i : permisos){
                 if (i.equalsIgnoreCase(permiso)){
                 permisos.remove(permiso);
                 permisoAux = "Permiso "+ permiso +" revocado.";
                 }
                 else {permisoAux = "Ese permiso no existe";}
            }
           System.out.println(permisoAux);
              
    }

}