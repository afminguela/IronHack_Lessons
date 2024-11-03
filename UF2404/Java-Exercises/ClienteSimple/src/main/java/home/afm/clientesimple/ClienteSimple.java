/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package home.afm.clientesimple;
import java.util.Scanner;
import java.io.*;
import java.net.*;
/**
 *Objetivo: Crea una aplicación cliente-servidor que permita un chat básico entre el cliente y el servidor en consola.

Instrucciones:

En el servidor, usa ServerSocket para aceptar conexiones en el puerto 1234.
El servidor debe permitir recibir y enviar mensajes al cliente.
En el cliente, usa Socket para conectarte al servidor y permitir que el usuario escriba mensajes en consola.
Implementa dos hilos en cada lado (cliente y servidor) para manejar la entrada y salida de mensajes por separado, permitiendo así un chat bidireccional.
Cada mensaje enviado debe mostrarse en la consola del otro lado (cliente o servidor).
 * @author Ana Fdez Minguela
 */
public class ClienteSimple {

//    public static void main(String[] args) throws IOException {
//        // crea conexion con el servidor
//        Socket socket = new Socket("localhost", 1234);
//        System.out.println("Conexión establecida con el servidor");
//        PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
//        BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
//        String mensaje = "Hola desde el cliente";
//        out.println(mensaje);
//        System.out.println("Mensaje enviado: " + mensaje);
//        socket.close();
//    }
    
    public static void main(String[] args) {
        try {
            Socket socket = new Socket("localhost", 1234);
            System.out.println("Conexión establecida con el servidor");

            // Hilo para recibir mensajes del servidor
            LectorC lector = new LectorC(socket);
            lector.start();

            // Hilo para enviar mensajes al servidor
            EscritorC escritor = new EscritorC(socket);
            escritor.start();

            lector.join();
            escritor.join();
            socket.close();
        } catch (UnknownHostException e) {
            System.err.println("Host desconocido: " + e.toString());
            System.exit(1);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
