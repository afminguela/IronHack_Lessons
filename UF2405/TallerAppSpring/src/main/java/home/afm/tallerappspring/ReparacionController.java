/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package home.afm.tallerappspring;
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

@RequestMapping("/api/clientes") // el end point de la API
public class ReparacionController {
   
    @Autowired  // indica donde está el repositorio
    private ReparacionRepository reparacionRepository;  // esta clase nos da metodos predefinidos por spring bindByid, bindbyId...
    
    
    @GetMapping
    public List<Reparacion> getAllReparaciones() {
        // Llama al método findAll() del repositorio para obtener todos los pedidos
        return reparacionRepository.findAll();
    }
    

    @PostMapping
    public Reparacion createReparacion(@RequestBody Reparacion reparacion) {   // en el cuerpo de la peticion mandamos un objeto de tipo objeto
        return reparacionRepository.save(reparacion);  // el metodo viene predefinido por el framework
    }
    
    
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Void> deletePedido(@PathVariable Long id) {
        if (reparacionRepository.existsById(id)) { // si existe por el ID, borralo por el id.
            reparacionRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    
    
    
    
    
    
}
