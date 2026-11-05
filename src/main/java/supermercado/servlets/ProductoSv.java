package supermercado.servlets;

import supermercado.logica.Categoria;
import supermercado.logica.ControladoraLogica;
import supermercado.logica.Producto;
import supermercado.logica.ArticuloCarrito;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ProductoSv")
public class ProductoSv extends HttpServlet {

    ControladoraLogica control = new ControladoraLogica();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String catIdParam = request.getParameter("categoriaId");
        List<Producto> listaProductos;

        if (catIdParam != null && !catIdParam.trim().isEmpty()) {
            try {
                int catId = Integer.parseInt(catIdParam);
                listaProductos = control.traerProductosPorCategoria(catId);
                if (listaProductos == null) {
                    listaProductos = new java.util.ArrayList<>();
                }
            } catch (NumberFormatException e) {
                listaProductos = control.traerProductos();
            }
        } else {
            listaProductos = control.traerProductos();
        }

        List<Categoria> listaCategorias = control.traerCategoria(); 
        List<ArticuloCarrito> listaCarrito = control.traerArticulosCarrito();

        request.setAttribute("listaProductos", listaProductos);
        request.setAttribute("listaCategorias", listaCategorias);
        request.setAttribute("listaCarrito", listaCarrito);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String precioStr = request.getParameter("precio");
        String catIdStr = request.getParameter("categoriaId");

        if (nombre != null && precioStr != null && catIdStr != null) {
            double precio = Double.parseDouble(precioStr);
            int catId = Integer.parseInt(catIdStr);

            // Buscar la categoría por su ID (en singular)
            Categoria cat = control.traerCategoria(catId);

            if (cat != null) {
                Producto prod = new Producto();
                prod.setNombre(nombre);
                prod.setPrecio(precio);
                prod.setCategoria(cat);

                control.crearProducto(prod);
            }
        }

        response.sendRedirect("ProductoSv");
    }
}