/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec2405sp;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
/**
 *
 * @author Ana Fernandez Minguela
 */
@Entity
@Table(name = "CPC")
@IdClass(CPCid.class)
public class CPC implements Serializable{
        
    @Id      
    @Column(name = "idC")
    private Long idC;

    @Id    
    @Column(name = "idP")
    private Long idP;

    public CPC(Long idC, Long idP) {
        this.idC = idC;
        this.idP = idP;
    }

    

    public CPC() {
    }

    public Long getIdC() {
        return idC;
    }

    public void setIdC(Long idC) {
        this.idC = idC;
    }

    public Long getIdP() {
        return idP;
    }

    public void setIdP(Long idP) {
        this.idP = idP;
    }

    @Override
    public String toString() {
        return "CPC{" + "idC=" + idC + ", idP=" + idP + '}';
    }

    
}

    
   