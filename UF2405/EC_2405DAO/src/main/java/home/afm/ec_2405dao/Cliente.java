/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec_2405dao;

import java.sql.SQLException;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class Cliente {
        private Long idC;
        private String nombre;
        private String correo;
        long counter = 0;

    public Cliente(Long idC, String nombre, String correo) throws SQLException {
        setIdC(idC);
        this.nombre = nombre;
        this.correo = correo;
        ClienteDAO.crearCliente(this);
        counter++;
    }

    public Cliente(String nombre, String correo) {
        
        this.nombre = nombre;
        this.correo = correo;
        counter ++;
        
    }
        
        
    

    public Cliente() {
    }

    public Long getIdC() {
        return idC;
    }

    public String getNombre() {
        return nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setIdC(Long idC) {
        if(idC==0){
        
           this.idC = counter;
        } else{
            this.idC = idC;
        }
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    @Override
    public String toString() {
        return "Cliente{" + "idC=" + idC + ", nombre=" + nombre + ", correo=" + correo + '}';
    }
        
        
    public static Cliente crearCliente(String nombre, String correo) throws SQLException{
        ClienteDAO clienteDAO = new ClienteDAO();
        Cliente cliente1 = new Cliente(nombre, correo);
        clienteDAO.crearCliente(cliente1);
        return cliente1;    
    } 
    
    public static void actualizarCliente(Cliente cliente) throws SQLException{
        ClienteDAO.actualizarCliente(cliente);
    }
    
    public static  void eliminarCliente(int idC)throws SQLException{
        ClienteDAO.eliminarCliente(idC);
    }
    
    public static Cliente obtenerClientePorId(int idC){
        Cliente cliente1 = ClienteDAO.obtenerClientePorId( idC);
            return cliente1;
    }
    
    
}
