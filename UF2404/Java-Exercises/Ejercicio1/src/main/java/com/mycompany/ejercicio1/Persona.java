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
public class Persona {
    private int idPersona ;
    String nombre;
    private String email;
    private String telefono;
    private boolean esPersonaFisica;
    private LocalDate fechaAlta;
    private LocalDate fechaBaja;
    private boolean activo;
    private boolean esProveedor;
    
// constructores
public Persona(){};

public Persona(int idPersona,
    String nombre,
    String email,
    String telefono,
    boolean esPersonaFisica,
    LocalDate fechaAlta,
    LocalDate fechaBaja,
    boolean activo,
    boolean esProveedor
        
        ){
    this.idPersona = idPersona;
    this.nombre = nombre;
    this.email = email;
    this.telefono = telefono;
    this.esPersonaFisica = esPersonaFisica;
    this.fechaAlta = fechaAlta;
    this.fechaBaja = fechaBaja;
    this.activo = activo;
    this.esProveedor = esProveedor;
    
    System.out.println("Se ha creado una nueva persona con el constructor "
            + "completo. Con nombre "+ this.nombre);
};
// crea un proveedor
public Persona(int idPersona,
    String nombre,
    String email,
    String telefono,
    LocalDate fechaAlta,
    LocalDate fechaBaja,
    boolean activo
    
        
    ){
    this.idPersona = idPersona;
    this.nombre = nombre;
    this.email = email;
    this.telefono = telefono;
    this.esPersonaFisica = false;
    this.fechaAlta = fechaAlta;
    this.fechaBaja = fechaBaja;
    this.activo = activo;
    this.esProveedor = true;
    
    System.out.println("Se ha creado un nuevo proveedor con el constructor "
            + "de proveedor. Con nombre "+ this.nombre);
};

// getters y setters


    public int getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
        
        System.out.println("Hecho");
        
        
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
         System.out.println("Hecho");
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
         System.out.println("Hecho");
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
         System.out.println("Hecho");
    }

    public boolean isEsPersonaFisica() {
        return esPersonaFisica;
    }

    public void setEsPersonaFisica(boolean esPersonaFisica) {
        this.esPersonaFisica = esPersonaFisica;
         System.out.println("Hecho");
    }

    public LocalDate getFechaAlta() {
        return fechaAlta;
    }

    public void setFechaAlta(LocalDate fechaAlta) {
        this.fechaAlta = fechaAlta;
         System.out.println("Hecho");
    }

    public LocalDate getFechaBaja() {
        return fechaBaja;
    }

    public void setFechaBaja(LocalDate fechaBaja) {
        this.fechaBaja = fechaBaja;
         System.out.println("Hecho");
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
         System.out.println("Hecho, activo");
    }

    public boolean isEsProveedor() {
        return esProveedor;
    }

    public void setEsProveedor(boolean esProveedor) {
        this.esProveedor = esProveedor;
         System.out.println("Hecho");
    }

    
    // Métodos de persona.
    
    
}


