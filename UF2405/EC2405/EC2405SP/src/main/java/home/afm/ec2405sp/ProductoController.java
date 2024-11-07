/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package home.afm.ec2405sp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
/**
 * 
 * @author Administrador
 */

@RestController     // esta es nuestra API

@RequestMapping("/api/productos") // el end point de la API
public class ProductoController {
   
    @Autowired  // indica donde está el repositorio
    private ProductoRepository productoRepository;  // esta clase nos da metodos predefinidos por spring bindByid, bindbyId...
    
    
    @GetMapping("/listarProductos")
    public  List<Producto> listarProductos() {
        // Llama al método findAll() del repositorio para obtener todos los pedidos
        return productoRepository.findAll();
    }
    
    @GetMapping("/buscar/{id}")
    public Optional<Producto> buscarProductoPorID(@PathVariable Long idP){
            return productoRepository.findById(idP);
                    }
    @PostMapping
    public Producto createProducto(@RequestBody Producto p) {   // en el cuerpo de la peticion mandamos un objeto de tipo objeto
        return productoRepository.save(p);  // el metodo viene predefinido por el framework
    }
    
    
    @DeleteMapping("/eliminar/{id}")
    public void deleteProducto(@PathVariable Long idP) {
       
            productoRepository.deleteById(idP);
            
    }
    
    
    
    
    
    
    
}
