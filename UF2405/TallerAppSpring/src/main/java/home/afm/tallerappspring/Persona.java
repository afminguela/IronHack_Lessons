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
public class Persona {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // para decir que el valor ID es autoincremental como en SQL ( pued3es no ponerlo en el SQL)
    @Column(name = "id_Persona")  
    private Long idPersona; // nombre debe coincidr con el nombre de la columna
    private String nombre ;
    private String telefono;
    

    // Constructor vacío
    public Persona() {
    }

    // Constructor con parámetros
    public Persona(String nombre, String telefono) {
        this.nombre = nombre;
        this.telefono = telefono;
    }

    // Getters y setters
    
    
    public Long getIdPersona() {
        return idPersona;
    }

    public String getNombre() {
        return nombre;
    }

    public String getTelefono() {
        return telefono;
    }
    
    
    public void setIdPersona(Long idPersona) {
        this.idPersona = idPersona;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    

    
    
    
    /*    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int idPedido;
    private int idUsuario;
    private int idTarjeta;
    private int cantidad_pedido;
    private double precioTotalPedido;
    private Timestamp estadoProcesando;
    private Timestamp estadoEnviado;
    private Timestamp estadoRecibido;
    private Timestamp estadoCancelado;
    private String fechaPedido;
    private String fechaEntrega;

    public Cliente() {
    }

    public int getIdPedido() {
        return idPedido;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public int getIdTarjeta() {
        return idTarjeta;
    }

    public int getCantidad_pedido() {
        return cantidad_pedido;
    }

    public double getPrecioTotalPedido() {
        return precioTotalPedido;
    }

    public Timestamp getEstadoProcesando() {
        return estadoProcesando;
    }

    public Timestamp getEstadoEnviado() {
        return estadoEnviado;
    }

    public Timestamp getEstadoRecibido() {
        return estadoRecibido;
    }

    public Timestamp getEstadoCancelado() {
        return estadoCancelado;
    }

    public String getFechaPedido() {
        return fechaPedido;
    }

    public String getFechaEntrega() {
        return fechaEntrega;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public void setIdTarjeta(int idTarjeta) {
        this.idTarjeta = idTarjeta;
    }

    public void setCantidad_pedido(int cantidad_pedido) {
        this.cantidad_pedido = cantidad_pedido;
    }

    public void setPrecioTotalPedido(double precioTotalPedido) {
        this.precioTotalPedido = precioTotalPedido;
    }

    public void setEstadoProcesando(Timestamp estadoProcesando) {
        this.estadoProcesando = estadoProcesando;
    }

    public void setEstadoEnviado(Timestamp estadoEnviado) {
        this.estadoEnviado = estadoEnviado;
    }

    public void setEstadoRecibido(Timestamp estadoRecibido) {
        this.estadoRecibido = estadoRecibido;
    }

    public void setEstadoCancelado(Timestamp estadoCancelado) {
        this.estadoCancelado = estadoCancelado;
    }

    public void setFechaPedido(String fechaPedido) {
        this.fechaPedido = fechaPedido;
    }

    public void setFechaEntrega(String fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }
    
    
    
   /* 
    public static void anadirProductoPedido(int id_pedido, int id_promocion, int id_producto, int cantidad){
        PedidoDAO.anadirProcuctoPedido(id_pedido, id_promocion, id_producto, cantidad);
        System.out.println("Producto con id: " + id_producto + " a�adido al pedido con id: " + id_pedido + " con la promoci�n id: " + id_promocion + " con la cantidad de " + cantidad + " productos.");
        
    }
    
    
    public static int calcularCantidadPedido(int id_pedido){
        return PedidoDAO.calcularCantidadPedido(id_pedido);
    }
    
    public static double calcularPrecioPedido(int id_pedido){
        return PedidoDAO.calcularPrecioPedido(id_pedido);

    }
    
    
    public static void procesarPedido(int id_pedido){
        PedidoDAO.procesarPedido(id_pedido);
    }
    */

   
}

