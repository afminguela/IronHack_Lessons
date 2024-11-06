/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package home.afm.tallerappspring;

import java.sql.*;
import java.sql.Date;/*se usa para manejar fechas y horas*/
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author anto_
 */


@Entity  // le decimos que la clase es una entidad
public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // para decir que el valor ID es autoincremental como en SQL ( pued3es no ponerlo en el SQL)
    @Column(name = "id_Cliente")
    private Long idCliente; // nombre debe coincidr con el nombre de la columna
    @Column(name = "id_Persona")
    private Long idPersona ;
    

    // Constructor vacío
    public Cliente() {
    }

    // Constructor con parámetros
    public Cliente(Long idCliente, Long idPersona ) {
        this.idCliente = idCliente;
        this.idPersona = idCliente;
    }

    // Getters y setters
    public Long getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Long idCliente) {
        this.idCliente = idCliente;
    }

    public Long getIdPersona() {
        return idPersona;
    }

    public void setProducto(long idPersona) {
        this.idPersona = idPersona;
    }

    

    
    
    
    
    
    
    
}   
    
  