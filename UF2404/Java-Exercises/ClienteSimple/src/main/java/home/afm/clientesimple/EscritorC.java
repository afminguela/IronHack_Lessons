/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.clientesimple;

import java.util.*;
import java.time.*;
import java.io.*;
import java.net.*;
/**
 *
 * @author Ana Fernandez Minguela
 */

  public class EscritorC extends Thread {
    private BufferedReader in;
    private PrintWriter out;

    public EscritorC(Socket socket) throws IOException {
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

