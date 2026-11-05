package supermercado.servlets;

import supermercado.logica.ArticuloCarrito;
import supermercado.logica.ControladoraLogica;
import supermercado.logica.Producto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/CarritoSv")
public class CarritoSv extends HttpServlet {

    ControladoraLogica control = new ControladoraLogica();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();

        List<ArticuloCarrito> listaArticulos = control.traerArticulosCarrito();

        out.println("=== ARTICULOS EN CARRITO ===");
        for (ArticuloCarrito a : listaArticulos) {
            out.println(a.toString());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "agregar":
                    int prodId = Integer.parseInt(request.getParameter("productoId"));
                    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
                    
                    Producto prod = control.traerProducto(prodId);
                    if (prod != null) {
                        ArticuloCarrito art = new ArticuloCarrito();
                        art.setProducto(prod);
                        art.setCantidad(cantidad);
                        art.setSubtotal(prod.getPrecio() * cantidad);
                        control.crearArticuloCarrito(art);
                    }
                    break;

                case "modificarCantidad":
                    int articuloIdEdit = Integer.parseInt(request.getParameter("articuloId"));
                    int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));
                    control.modificarCantidadCarrito(articuloIdEdit, nuevaCantidad);
                    break;

                case "eliminarItem":
                    int articuloIdElim = Integer.parseInt(request.getParameter("articuloId"));
                    control.eliminarArticuloCarrito(articuloIdElim);
                    break;

                case "vaciar":
                    control.vaciarCarrito();
                    break;
            }
        } else {
            // Manejo por defecto si solo envían productoId
            String prodIdParam = request.getParameter("productoId");
            if (prodIdParam != null) {
                int prodId = Integer.parseInt(prodIdParam);
                Producto prod = control.traerProducto(prodId);
                if (prod != null) {
                    ArticuloCarrito art = new ArticuloCarrito();
                    art.setProducto(prod);
                    art.setCantidad(1);
                    art.setSubtotal(prod.getPrecio());
                    control.crearArticuloCarrito(art);
                }
            }
        }

        // Redirige siempre a ProductoSv para actualizar el modelo
        response.sendRedirect("ProductoSv");
    }
}