/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package home.afm.ec2405sp;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.*;
import java.util.*;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Ana fdez Minguela
 */
@Repository
public interface ProductoRepository extends JpaRepository<Producto, Long>  { 
    
}


