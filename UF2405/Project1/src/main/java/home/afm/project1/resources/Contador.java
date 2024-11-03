/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.project1.resources;

import java.util.*;
import java.time.*;
import jakarta.servlet.ServletException; //4
import jakarta.servlet.annotation.WebServlet;//1
import jakarta.servlet.http.HttpServlet; //2
import jakarta.servlet.http.HttpServletRequest;// 3
import jakarta.servlet.http.HttpServletResponse;// 3
import java.io.IOException; //4 
/**
 *
 * @author Ana Fernandez Minguela
 */
@WebServlet("/contador") //1
public class Contador extends HttpServlet{ //2
   @Override
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException {
    
    // Obtenemos el número del request
    String numeroString = request.getParameter("numero");
    int numero = Integer.parseInt(numeroString); // 
    // variable declarada = Tipo al que vas a convertir.metodo-para-convertir-en-algo(variable a convertir) 
    
// Incrementamos el número en uno
    
    int resultado = ++numero;
    
    // Configuramos la respuesta
    response.setContentType("text/plain");
    response.getWriter().write(String.valueOf(resultado)); // convierte un integer en string
}

}
