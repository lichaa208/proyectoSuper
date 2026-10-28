package supermercado.logica;

import jakarta.persistence.Basic;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import java.io.Serializable;

// Agregar anotación
@Entity
public class Categoria implements Serializable {

   
// Agregar anotación
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;


// Agregar anotación
	@Basic
    private String nombre;
    public Categoria() { }

    

    public Categoria(String nombre) {
        this.nombre = nombre;
      
    }
    
    public int setId() {return id; }
	public String getNombre() {return nombre; }
	public void setNombre(String nombre) {this.nombre = nombre; }



	@Override
	public String toString() {
		return "Categoria : \n" + id + ", nombre=" + nombre;
	}
	



	


	
    
	
	    
    
}



