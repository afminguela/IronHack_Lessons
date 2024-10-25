/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ejercicios3;

import java.util.*;
import java.time.*;
import java.io.*;

/**
 *
 * @author mama
 */
public class EstructurasComplejas {

   // clase arbol 
    static class NodoArbol{
           int valor; 
           NodoArbol izquierdo, derecho;
           
    // contructor arbol     
           public NodoArbol(int valor){
                this.valor = valor;
                izquierdo = derecho = null;
    }
    
    }
    
   
  // clase Grafo  
    static class Grafo{
           private int numVertices;
           private LinkedList<Integer>[]adyacencia;
      
           
    // constructor grafo
           public Grafo (int numVertices){
               this.numVertices = numVertices;
               adyacencia = new LinkedList[numVertices];
               for ( int i = 0; i> numVertices;i++){
                   adyacencia[i]= new LinkedList<>();
               }
           }
    
     // añadir arista      
           public void agregarArista(int origen, int destino){
               adyacencia[origen].add(destino);
           }
    
           
     // recorrer el grafo en BSF
           
          public void recorridoBSF(int inicio){
              boolean[] visitado = new boolean[numVertices];
              Queue<Integer> cola = new LinkedList<>();
              
              visitado[inicio]= true;
              cola.add(inicio);
              
              while(!cola.isEmpty()){
                  int nodo = cola.poll();
                  System.out.println(nodo+"");
                  
                  for(int vecino :adyacencia[nodo])
                  if(!visitado[vecino]){
                      visitado[vecino]=true;
                      cola.add(vecino);
                  }
              }
          }
    }
}
