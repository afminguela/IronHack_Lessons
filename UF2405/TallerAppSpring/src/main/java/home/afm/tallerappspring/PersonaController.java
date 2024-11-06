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

@RequestMapping("/api/personas") // el end point de la API
public class PersonaController {
   
    @Autowired  // indica donde está el repositorio
    private PersonaRepository personaRepository;  // esta clase nos da metodos predefinidos por spring bindByid, bindbyId...
    
    
    @GetMapping
    public List<Persona> getAllPersona() {
        // Llama al método findAll() del repositorio para obtener todos los pedidos
        return personaRepository.findAll();
    }
    

    @PostMapping
    public Persona createPersona(@RequestBody Persona persona) {   // en el cuerpo de la peticion mandamos un objeto de tipo objeto
        return personaRepository.save(persona);  // el metodo viene predefinido por el framework
    }
    
    
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Void> deletePedido(@PathVariable Long idPersona) {
        if (personaRepository.existsById(idPersona)) { // si existe por el ID, borralo por el id.
            personaRepository.deleteById(idPersona);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    
    
    
    
    
    
}
