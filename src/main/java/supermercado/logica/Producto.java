package supermercado.logica;

import jakarta.persistence.Basic;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import java.io.Serializable;

// Agregar anotación
@Entity
public class Producto implements Serializable {

// Agregar anotación
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

// Agregar anotación
	@Basic
	private String nombre;
	private double precio;
	private int stock;

	@ManyToOne
	@JoinColumn(name = "categoria_id")
	private Categoria categoria;

	public Producto() {
	}

	public Producto(String nombre, double precio, int stock) {
		this.nombre = nombre;
		this.precio = precio;
		this.stock = stock;

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public double getPrecio() {
		return precio;
	}

	public void setPrecio(double precio) {
		this.precio = precio;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	@Override
	public String toString() {
		return "Categoria : \n" + id + ", \nnombre " + nombre + ", \nPrecio " + precio + ", \nStock" + stock;
	}
}
