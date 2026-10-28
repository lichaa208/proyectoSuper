package supermercado.logica;


import jakarta.persistence.Basic;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import java.io.Serializable;

	@Entity
	public class ArticuloCarrito implements Serializable {
		
		@Id
		@GeneratedValue(strategy = GenerationType.AUTO)
		private int id;
		
		@Basic
		private int cantidad;
		private double subtotal;
		@ManyToOne
		@JoinColumn(name = "producto_id")
		private Producto producto;
		
		public ArticuloCarrito() {
			
	    }
		
		public ArticuloCarrito(int cantidad, double subtotal) {
			this.cantidad = cantidad;
			this.subtotal = subtotal;

		}

		public int getId() {
			return id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public int getCantidad() {
			return cantidad;
		}

		public void setCantidad(int cantidad) {
			this.cantidad = cantidad;
		}

		public double getSubtotal() {
			return subtotal;
		}

		public void setSubtotal(double subtotal) {
			this.subtotal = subtotal;
		}

		public Producto getProducto() {
			return producto;
		}

		public void setProducto(Producto producto) {
			this.producto = producto;
		}

		@Override
		public String toString() {
			return "Carrito : \n" + id + ", \nArticulo " + producto + ", \nCantidad " + cantidad + ", \nSubTotal $" + subtotal;
		}
		
		
		
		
		
		
		
		
		
		
	
	
	
}
