/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package home.afm.ejercicios3;
import java.util.*;
import java.io.*;

import home.afm.ejercicios3.EstructurasComplejas.*;

/**
 *
 * @author mama
 */
public class Ejercicios3 {


//Ejercicio 4: Estructuras
//
//Crea una clase Coche que contenga los siguientes atributos: marca (String), modelo (String), año (int).

public class Coche {
    private  String marca;
    private  String modelo;
    private  int anyo;
    
//Implementa un constructor que inicialice estos valores.    
    
    public Coche (String modelo, String marca, int anyo){
        this.modelo = modelo;
        this.marca  = marca;
        this.anyo   = anyo;
    }
 //Escribe métodos getter y setter para cada atributo.

        public  String getMarca() {
            return marca;
        }

        public  String getModelo() {
            return modelo;
        }

        public int getAnyo() {
            return anyo;
        }

        public  void setMarca(String marca) {
            this.marca = marca;
        }

        public  void setModelo(String modelo) {
            this.modelo = modelo;
        }

        public  void setAnyo(int anyo) {
            this.anyo = anyo;
        }
    
        
        
}




//Ejercicio 8: Uso de Constructores y Destructores
//
//Modifica la clase Persona para añadir un constructor que acepte un nombre y una edad como parámetros, e imprima esos valores al crear un objeto.
//Crea varios objetos Persona en el método main() y muestra sus valores.
//Explica por qué Java no tiene destructores explícitos y cómo la recolección de basura se encarga de liberar los recursos cuando un objeto ya no es accesible.
public static void main(String[] args) throws IOException {
       //Ejercicio 1: Datos Simples . Declara variables en Java para los siguientes tipos de datos simples:
//Un número entero (int) con valor 100.
int numero = 100;
//Un número real (double) con valor 3.14.
double real = 3.14;
//Un valor lógico (boolean) que represente verdadero.
boolean logico = true;
//Un carácter (char) que contenga la letra 'A'.
char letra = 'A';
//Una cadena de caracteres (String) con el texto "Hola Mundo".
String hola = "hola muindo!";
//Declara una referencia (puntero) a un objeto String y asigna una nueva cadena "Referencia de Memoria".
String Objeto = "adskfjañkjhsf";
String Objeto2 = Objeto;
//Imprime los valores de todas las variables en la consola.
 
        System.out.println(numero);
        System.out.println(real);
        System.out.println(logico);
        System.out.println(letra);
        System.out.println(hola);
        System.out.println(Objeto2);
        
  //Ejercicio 2: Arrays
//
//Declara un array de números enteros con tamaño 5 y asigna los valores 10, 20, 30, 40 y 50.
Integer[] numeros = {10,20,30,40,50};
numeros[0] = 11;



//Imprime cada valor del array utilizando un bucle for.
for(int i=0;i < numeros.length; i++){
    System.out.println("En el array unidireccional,la posicion " + i + " tiene el numero " + numeros[i]);
}
//Crea un array bidimensional de enteros de tamaño 2x2 e inicializa sus elementos con los valores de tu elección. Imprime sus valores.
//      
        
  int [][] Array= {{1,2},{3,4}};
  for(int i=0;i < Array.length; i++) {
      for(int j=0;j < Array[i].length; j++){
          
          System.out.println("\nEn el Array bidireccional, la posicion " + i + " tiene el numero " + Array[i][j]);
      }
}
    
    //Ejercicio 3: Listas Enlazadas, Pilas y Colas
//
//Crea una lista enlazada de objetos String y añade tres nombres de personas. Luego, imprime cada nombre en la consola.
LinkedList<String> enlazada = new LinkedList<>();

enlazada.add(0, "paco");
enlazada.add(1, "joseluis");
enlazada.add(2, "maricarmen");
enlazada.add("luisa");
enlazada.set(0,"carlos");
        
System.out.println("le nombre de la lista enlazada son: "+ enlazada);



//Implementa una pila utilizando la clase Stack de Java. Añade tres números a la pila, realiza una operación de "pop" y luego muestra el número en la parte superior de la pila.
Stack<Integer> pila = new Stack();

pila.push(1);
pila.add(2);
pila.add(3);
        System.out.println(pila);  // 1, 2, 3 
pila.pop(); // salta el ultimo numero de la lista:  1, 2 
        System.out.println(pila);
pila.push(5); // debería ponerlo en la posicion 3: 5, 1, 2
pila.addFirst(4);  // deberia ponerlo en la posicion 0 : 4, 1, 2, 5

  // espero que Pila sea 5, 1, 2, 4 

        System.out.println(pila);

// espero que el primer item en "salir" sea 5

        System.out.println(pila.peek());


//Implementa una cola utilizando la clase Queue (por ejemplo, con LinkedList). Añade tres cadenas de texto a la cola, elimina el primer elemento y muestra el siguiente.
//
    Queue<String> cola= new LinkedList<>();
    
cola.add("Eeepa");
cola.add("aupa");
cola.add("Au");

        System.out.println(cola); // printa la cola espero eeepa, aupa, au
 
cola.remove();

        System.out.println(cola); // printa la cola espero aupa, au.
        System.out.println(cola.peek()); // printa el siguiente elemento ( primer elemento de " la lista") Espero aupa




//Crea un objeto de la clase Coche, inicialízalo con tus valores, y muestra la información del coche en la consola.
// 
 
   // ---------- /// ESTO NO SE HACE !!! NUNCA !!!  CADA CLASE EN UN ARCHIVO UNICO Y SEPARADO!!! --------------
   // Ejercicios3 ejercicios3 = new Ejercicios3();
   // Ejercicios3.Coche furgoneta = ejercicios3.new Coche("transit","ford",2022);
 
 //furgoneta.getMarca();
 
//Ejercicio 5: Ficheros
//
//Crea un programa que cree un fichero de texto llamado datos.txt y escribe en él la cadena "Este es un archivo de prueba".
String fichero = "datos.txt";

       
escribeFichero(fichero,"Este es un archivo de prueba");

leeFichero(fichero);
//Lee el contenido del fichero y muéstralo en la consola.


//Asegúrate de manejar posibles excepciones relacionadas con la lectura y escritura de archivos.
//

//Ejercicio 6: Otras Estructuras Complejas
//
//Implementa una tabla hash utilizando HashMap en Java. Añade tres pares clave-valor, donde las claves sean nombres de personas y los valores sean sus edades. Imprime todos los pares clave-valor en la consola.

HashMap<String,Integer> TablaHash = new HashMap<>();

TablaHash.put("maria", 30);
TablaHash.put("Joseluis", 45);
TablaHash.put("paco",23);
    System.out.println("/nValores de la tabla hash");
for( String clave : TablaHash.keySet()){
    System.out.println("La clave es " + clave+ " y el valor " + TablaHash.get (clave));

}

//Crea un árbol binario básico. Implementa una clase Nodo con un valor entero y referencias a nodos izquierdo y derecho. Inserta manualmente valores en el árbol y luego imprime el valor de la raíz, el nodo izquierdo y el nodo derecho.

NodoArbol raiz = new NodoArbol(10);
raiz.izquierdo= new NodoArbol(5);
raiz.derecho = new NodoArbol(20);

    System.out.println("/nArbol binario");
    System.out.println("Raiz" + raiz.valor);
    System.out.println("nodo Izquierdo " + raiz.izquierdo.valor);
    System.out.println("nodo derecho "+ raiz.derecho.valor);



//Crea un grafo utilizando una lista de adyacencia en Java. Añade cuatro nodos y algunas aristas entre ellos. Implementa un recorrido BFS (búsqueda en amplitud) y muestra el orden de los nodos visitados.
//

Grafo grafo = new Grafo(4);

grafo.agregarArista(0, 1);
grafo.agregarArista(0, 2);
grafo.agregarArista(1, 2);
grafo.agregarArista(2, 1);
grafo.agregarArista(2, 3);
grafo.agregarArista(3, 3);


    System.out.println("/nRecorrido BFS del grafo desde el nodo 2");
    grafo.recorridoBSF(2);
    
    
    

    
    
    } ///// AQUI ACABA MAIN y el ejercicio !!!!!!

//Ejercicio 7: Mecanismos de Gestión de Memoria
//
//Crea una clase Persona que tenga un constructor que imprima "Objeto creado" cuando se construya un objeto.
//Implementa un método finalize() que imprima "Recolección de basura" cuando el objeto sea destruido por el Garbage Collector.
//Crea una instancia de la clase Persona y luego establece la referencia a null. Llama a System.gc() para sugerir al Garbage Collector que recoja el objeto. Imprime un mensaje indicando cuándo se ha terminado de ejecutar el programa.
//Explica qué ocurre con los objetos inalcanzables y cómo funciona la recolección de basura en Java.
//








 public static void escribeFichero(String nombreFichero, String contenido) throws IOException{
     try ( BufferedWriter escritor = new BufferedWriter(new FileWriter(nombreFichero))){
         
         escritor.write(contenido);
         System.out.println("Fichero creado y escrito con " + contenido);
     } catch (IOException e) {
         System.err.println("Ocurrió un error" + e.getMessage());
     }
 }
 
 public static void leeFichero(String nombreFichero) throws IOException{
     try ( BufferedReader lector = new BufferedReader(new FileReader(nombreFichero))){
         String linea;
         
         System.out.println("/n Contenido del fichero ");
         
         while((linea = lector.readLine()) != null) {
         
             System.out.println(linea);
         }
         
     } catch (IOException e) {
         System.err.println("Ocurrió un error" + e.getMessage());
     }
 }
 
//Lee el contenido del fichero y muéstralo en la consola.
//Asegúrate de manejar posibles excepciones relacionadas con la lectura y escritura de archivos.
//
 
 
 
 

    }
    
    
    
    

