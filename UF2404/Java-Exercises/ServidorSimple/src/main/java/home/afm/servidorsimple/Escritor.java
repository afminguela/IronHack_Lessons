/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.servidorsimple;

import java.util.*;
import java.time.*;
import java.io.*;
import java.net.*;

/**
 *
 * @author Ana Fernandez Minguela
 */
public class Escritor extends Thread {
    private BufferedReader in;
    private PrintWriter out;

    public Escritor(Socket socket) throws IOException {
        in = new BufferedReader(new InputStreamReader(System.in));
        out = new PrintWriter(socket.getOutputStream(), true);
    }

    @Override
    public void run() {
        Scanner scanner = new Scanner(System.in);
        try {
            while (true) {
                String mensaje = scanner.nextLine();
                if (mensaje.equalsIgnoreCase("FIN")) break;
                out.println(mensaje);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
 

