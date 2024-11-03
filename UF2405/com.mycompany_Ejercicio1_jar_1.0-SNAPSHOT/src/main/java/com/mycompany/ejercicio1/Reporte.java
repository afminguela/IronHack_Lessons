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
public class Reporte {
        private int idReporte;
        private LocalDate fechaGeneracion;
        private String formato;
        private String titulo;
        private String contenido;
        private Inventario inventario;
        private final Set<Integer> idsUsados = new HashSet(); //* el set hace un array sin duplicados.  SHA256()
        
        // añadir listas de stockbajo y cercacaducuidad
        
        // contador Ids Unicos Automático
        
        private int contadorIds = 1;

        private  int generarIDUnico(){
                while (idsUsados.contains(contadorIds))
                { contadorIds++;
                    } 
                return  contadorIds++;}
        
       //  Constructor 
       
        public Reporte(int idReporte){ //* reporte solo con id se usa en usuario.generarReporte()
            if (idsUsados.contains(idReporte)) {
                System.out.println("La Notificacion no se pudo crear, ya que el ID " + idReporte + " ya está en uso.");
        } else{ 
            this.idReporte = idReporte;
            idsUsados.add(this.idReporte);
        }}
        
        public void Reporte(String formato, // reporte completo Auto
                String titulo, String contenido, Inventario inventario){
            
            this.idReporte = generarIDUnico();
            this.fechaGeneracion = LocalDate.now();
            this.formato = formato;
            this.titulo = titulo;
            this.contenido = contenido; // if condicional para el relleno. 
            idsUsados.add(this.idReporte); //**
        }

        // Getters
        
    public int getIdReporte() {
        System.out.println(this.idReporte);
        return idReporte;
    }

    public LocalDate getFechaGeneracion() {
        return fechaGeneracion;
    }

    public String getFormato() {
        return formato;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getContenido() {
        return contenido;
    }

    public Inventario getInventario() {
        return inventario;
    }

    // Setters
    
    public void setIdReporte(int idReporte) {
        this.idReporte = idReporte;
    }

    public void setFechaGeneracion(LocalDate fechaGeneracion) {
        this.fechaGeneracion = fechaGeneracion;
    }

    public void setFormato(String formato) {
        this.formato = formato;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public void setInventario(Inventario inventario) {
        this.inventario = inventario;
    }
        
        
    // métodos:
    
    // descargar Reporte
    
    
    // incluir productos proximos a caducar en reporte
    public void anyadirProdCaducados(Inventario inventario){
    // Busca el reporte que coincide con el id
    //añade resultado de funcion de producto.proximocaducar
    
    // al listado del reporte que le pasamos prodCAducados.add
    };
    // incluir productos bajo stock
    public void anyadirBajoStock(){};
    
    
    
    
    





}