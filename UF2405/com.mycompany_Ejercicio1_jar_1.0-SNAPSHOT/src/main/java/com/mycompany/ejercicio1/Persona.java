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
public Persona(int idPersona){
     this.idPersona = idPersona;};

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
    this.fechaAlta = LocalDate.now();
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
    this.fechaAlta = LocalDate.now();
    this.fechaBaja = fechaBaja;
    this.activo = activo;
    this.esProveedor = true;
    
    System.out.println("Se ha creado un nuevo proveedor con el constructor "
            + "de proveedor. Con nombre "+ this.nombre);
};
//private static final Set<Integer> idsUsadosNotificaciones = new HashSet();  Añade una lista tipo SET que no admite duplicados
    
    //Constructor:

    //public Notificacion(int idNotificacion ...) throws Exception {  // Es el principio de cualquier constructor, que añade una comprobación para que los ID sean unicos, 
        //if (idsUsadosNotificaciones.contains(idNotificacion)) {
       //     throw new Exception("La Notificacion no se pudo crear, ya que el ID " + idNotificacion + " ya está en uso.");
       // }

// getters y setters


    public int getIdPersona() {
        return idPersona;
    }
    

    public void setIdPersona(int idPersona) {
        int auxiliar = this.getIdPersona();
        this.idPersona = idPersona;
        
        System.out.println("Hecho, id persona: "+ auxiliar + " cambiado a "+ this.idPersona);
        
        
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        String auxiliar = this.getNombre();
        this.nombre = nombre;
        System.out.println("Hecho, nombre: "+ auxiliar + " cambiado a "+ this.nombre);
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
         String auxiliar = this.getNombre();
        this.email = email;
        System.out.println("Hecho, email: "+ auxiliar + " cambiado a "+ this.email);
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
         String auxiliar = this.getNombre();
        this.telefono = telefono;
        System.out.println("Hecho, telefono: "+ auxiliar + " cambiado a "+ this.telefono);
    }

    public boolean isEsPersonaFisica() {
        return esPersonaFisica;
    }

    public void setEsPersonaFisica(boolean esPersonaFisica) {
        this.esPersonaFisica = esPersonaFisica;
         if(esPersonaFisica){System.out.println("Hecho, efectivamente, Es persona física");}
         else { System.out.println("Hecho, es persona jurídica");}
    }

    public LocalDate getFechaAlta() {
        return fechaAlta;
    }

    public void setFechaAlta(LocalDate fechaAlta) {
         LocalDate auxiliar = this.getFechaAlta();
        this.fechaAlta = fechaAlta;
        System.out.println("Hecho, Fecha de Alta: "+ auxiliar + " cambiado a "+ this.fechaAlta);
    }

    public LocalDate getFechaBaja() {
        return fechaBaja;
    }

    public void setFechaBaja(LocalDate fechaBaja) {
        LocalDate auxiliar = this.getFechaBaja();
        this.fechaBaja = fechaBaja;
        System.out.println("Hecho, Fecha de Baja: "+ auxiliar + " cambiado a "+ this.fechaBaja);
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
         if(activo){System.out.println("Hecho, efectivamente, Está Activo");}
         else { System.out.println("Hecho, Desactivado");}
    }

    public boolean isEsProveedor() {
        return esProveedor;
    }

    public void setEsProveedor(boolean esProveedor) {
        if(esProveedor){System.out.println("Hecho, efectivamente, Es persona física");}
         else { System.out.println("Hecho, es persona jurídica");}
    }

    
    // Métodos de persona.
    
    
}


