package supermercado.persistencia;

import supermercado.logica.Categoria;
import supermercado.logica.Producto;
import supermercado.logica.ArticuloCarrito;
import java.util.List;

public class ControladoraPersistencia {
	

	
	ProductoJpaController productoJpa = new ProductoJpaController();

	
	CategoriaJpaController categoriaJpa = new CategoriaJpaController();
	
	
	ArticuloCarritoJpaController itemCarrito = new ArticuloCarritoJpaController();
	
    //-----------------------------------------------------
	
	public void crearCategoria(Categoria cat) {
		categoriaJpa.crear(cat);
	}
	
	public void eliminarCategoria(int id) throws Exception {
        categoriaJpa.destroy(id);
    }
	
	public void editarCategoria(Categoria cat) throws Exception {
		categoriaJpa.edit(cat);
    }

    public Categoria listarCategoria(int id) {
        return categoriaJpa.buscarUno(id);
    }

    public List<Categoria> listarCategorias() {
        return categoriaJpa.buscarTodos();
    }
    
    //-------------------------------------------------
	
    public void crearProducto(Producto prod) {
    	productoJpa.crear(prod);
    }

    public void eliminarProducto(int id) throws Exception {
    	productoJpa.destroy(id);
    }

    public void editarProducto(Producto prod) throws Exception {
    	productoJpa.edit(prod);
    }

    public Producto listarProducto(int id) {
        return productoJpa.buscarUno(id);
    }

    public List<Producto> listarProductos() {
        return productoJpa.buscarTodos();
    }
    
    public List<Producto> listarProductosPorCategoria(int catId) {
        return productoJpa.buscarPorCategoria(catId);
    }
    
    
    //----------------------------------------------------------
    public void crearArticuloCarrito(ArticuloCarrito art) {
    	itemCarrito.crear(art);
    }

    public void eliminarArticuloCarrito(int id) throws Exception {
    	itemCarrito.destroy(id);
    }

    public void editarArticuloCarrito(ArticuloCarrito art) throws Exception {
    	itemCarrito.edit(art);
    }

    public ArticuloCarrito listarArticuloCarrito(int id) {
        return itemCarrito.buscarUno(id);
    }

    public List<ArticuloCarrito> listarArticulosCarrito() {
        return itemCarrito.buscarTodos();
    }
	
}
