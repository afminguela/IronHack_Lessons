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

@RequestMapping("/api/vehiculos") // el end point de la API
public class VehiculoController {
   
    @Autowired  // indica donde está el repositorio
    private VehiculoRepository vehiculoRepository;  // esta clase nos da metodos predefinidos por spring bindByid, bindbyId...
    
    
    @GetMapping
    public List<Vehiculo> getAllPedidos() {
        // Llama al método findAll() del repositorio para obtener todos los pedidos
        return vehiculoRepository.findAll();
    }
    

    @PostMapping
    public Vehiculo createPedido(@RequestBody Vehiculo vehiculo) {   // en el cuerpo de la peticion mandamos un objeto de tipo objeto
        return vehiculoRepository.save(vehiculo);  // el metodo viene predefinido por el framework
    }
    
    
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Void> deletePedido(@PathVariable Long id) {
        if (vehiculoRepository.existsById(id)) { // si existe por el ID, borralo por el id.
            vehiculoRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    
    
    
    
    
    
}
