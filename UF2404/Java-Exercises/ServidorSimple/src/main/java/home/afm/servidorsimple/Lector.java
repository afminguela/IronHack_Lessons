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

public class Lector extends Thread {
    private BufferedReader in;
    private PrintWriter out;

    public Lector(Socket socket) throws IOException {
        in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        out = new PrintWriter(socket.getOutputStream(), true);
    }

    @Override
    public void run() {
        try {
            String mensaje;
            while ((mensaje = in.readLine()) != null && !mensaje.equals("FIN")) {
                System.out.println("Servidor: " + mensaje);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
}
