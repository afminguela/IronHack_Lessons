/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package home.afm.servidorsimple;
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
 * @author mama
 */
public class ServidorSimple {

//    public static void main(String[] args) throws IOException {
//        // crea conexion con el servidor
//        ServerSocket servidor = new ServerSocket(1234);
//        System.out.println("Esperando conexion del cliente...");
//        Socket socket = servidor.accept();
//        System.out.println("cliente aceptado");
//        BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
//        PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
//        String mensaje = in.readLine();
//        System.out.println("Mensaje recibido en el servidor: " + mensaje);
//       
//        
//        socket.close();
//        servidor.close();
//    }

    public static void main(String[] args) {
        try {
            ServerSocket serverSocket = new ServerSocket(1234);
            System.out.println("Servidor iniciado. Esperando conexión...");

            Socket socket = serverSocket.accept();
            System.out.println("Conexión aceptada desde " + socket.getInetAddress());

            // Hilo para recibir mensajes del cliente
            Lector lector = new Lector(socket);
            lector.start();

            // Hilo para enviar mensajes al cliente
            Escritor escritor = new Escritor(socket);
            escritor.start();

            lector.join();
            escritor.join();
            socket.close();
            serverSocket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
        

