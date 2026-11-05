package supermercado.logica;

import supermercado.persistencia.ControladoraPersistencia;
import java.util.List;

public class ControladoraLogica {

    ControladoraPersistencia controlPersis = new ControladoraPersistencia();

    // ==================== CATEGORIA ====================
    public void crearCategoria(Categoria cat) {
        controlPersis.crearCategoria(cat);
    }

    public Categoria traerCategoria(int id) {
        return controlPersis.listarCategoria(id);
    }

    public void eliminarCategoria(int id) {
        try {
            controlPersis.eliminarCategoria(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void editarCategoria(Categoria cat) {
        try {
            controlPersis.editarCategoria(cat);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Categoria> traerCategoria() {
        List<Categoria> lista = controlPersis.listarCategorias();

        if (lista == null || lista.isEmpty()) {
            crearCategoria(new Categoria("Lácteos"));
            crearCategoria(new Categoria("Bebidas"));
            crearCategoria(new Categoria("Almacén"));

            lista = controlPersis.listarCategorias();
        }

        return lista;
    }

    // ==================== PRODUCTO ====================
    public void crearProducto(Producto prod) {
        controlPersis.crearProducto(prod);
    }

    public void eliminarProducto(int id) {
        try {
            controlPersis.eliminarProducto(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void editarProducto(Producto prod) {
        try {
            controlPersis.editarProducto(prod);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Producto traerProducto(int id) {
        return controlPersis.listarProducto(id);
    }

    public List<Producto> traerProductos() {
        return controlPersis.listarProductos();
    }

    public List<Producto> traerProductosPorCategoria(int catId) {
        return controlPersis.listarProductosPorCategoria(catId);
    }

    // ==================== ARTICULO CARRITO ====================
    public void crearArticuloCarrito(ArticuloCarrito art) {
        controlPersis.crearArticuloCarrito(art);
    }

    public void eliminarArticuloCarrito(int id) {
        try {
            controlPersis.eliminarArticuloCarrito(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void editarArticuloCarrito(ArticuloCarrito art) {
        try {
            controlPersis.editarArticuloCarrito(art);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArticuloCarrito traerArticuloCarrito(int id) {
        return controlPersis.listarArticuloCarrito(id);
    }

    public List<ArticuloCarrito> traerArticulosCarrito() {
        return controlPersis.listarArticulosCarrito();
    }

    // --- MÉTODOS ESPECIALES DEL CARRITO ---

    public void modificarCantidadCarrito(int articuloId, int nuevaCantidad) {
        ArticuloCarrito art = traerArticuloCarrito(articuloId);
        if (art != null && art.getProducto() != null) {
            art.setCantidad(nuevaCantidad);
            art.setSubtotal(art.getProducto().getPrecio() * nuevaCantidad);
            editarArticuloCarrito(art);
        }
    }

    public void vaciarCarrito() {
        controlPersis.vaciarCarrito();
    }
}