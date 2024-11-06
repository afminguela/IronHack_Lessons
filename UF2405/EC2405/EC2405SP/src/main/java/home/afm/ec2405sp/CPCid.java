/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package home.afm.ec2405sp;

import java.io.Serializable;
import java.util.Objects;
/**
 *
 * @author Ana Fernandez Minguela
 */

public class CPCid implements Serializable{
        
        
        private Long idC;
        private Long idP;

    public CPCid() {
    }

    public CPCid(Long idC, Long idP) {
        this.idC = idC;
        this.idP = idP;
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
    public int hashCode() {
        int hash = 7;
        hash = 97 * hash + Objects.hashCode(this.idC);
        hash = 97 * hash + Objects.hashCode(this.idP);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final CPCid other = (CPCid) obj;
        if (!Objects.equals(this.idC, other.idC)) {
            return false;
        }
        return Objects.equals(this.idP, other.idP);
    }

    
    
       
        
        

  
}
