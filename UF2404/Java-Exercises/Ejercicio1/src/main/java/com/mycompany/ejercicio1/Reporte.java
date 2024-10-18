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
        
        
        public Reporte(int idReporte){  // reporte solo con id
            this.idReporte = idReporte;
        }
        
        public void Reporte(int idReporte,LocalDate fechaGeneracion,String formato,
                String titulo, String contenido, Inventario inventario){
            
            this.idReporte = idReporte;
            this.fechaGeneracion = LocalDate.now();
            this.formato = formato;
            this.titulo = titulo;
            this.contenido = contenido;
            
        }

        // Getters
        
    public int getIdReporte() {
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
    public void anyadirProdCaducados(){};
    // incluir productos bajo stock
    public void anyadirBajoStock(){};
    
    
}
