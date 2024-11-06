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
import static org.hibernate.criterion.Projections.id;
/**
 * 
 * @author Administrador
 */

@RestController     // esta es nuestra API

@RequestMapping("/api/cpc") // el end point de la API
public class CPCController {
   
    @Autowired  // indica donde está el repositorio
    private CPCRepository cpcRepository;  // esta clase nos da metodos predefinidos por spring bindByid, bindbyId...
    
    
    @GetMapping
    public List<CPC> getAllPedidos() {
        // Llama al método findAll() del repositorio para obtener todos los pedidos
        return cpcRepository.findAll();
    }
    

    @PostMapping
    public CPC createCPC(@RequestBody CPC cpc) {   // en el cuerpo de la peticion mandamos un objeto de tipo objeto
        return cpcRepository.save(cpc);  // el metodo viene predefinido por el framework
    }
    
    
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Void> deleteCPC(@PathVariable Long idC) {
        if (cpcRepository.existsByIdC(idC)) { 
            cpcRepository.deleteByIdC(idC);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    
    
    
    
    
    
}
