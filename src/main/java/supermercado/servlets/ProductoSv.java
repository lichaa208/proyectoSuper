package supermercado.servlets;

import supermercado.logica.Categoria;
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

@WebServlet("/ProductoSv")
public class ProductoSv extends HttpServlet {

    ControladoraLogica control = new ControladoraLogica();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String catIdParam = request.getParameter("categoriaId");
        List<Producto> listaProductos;

        if (catIdParam != null && !catIdParam.trim().isEmpty()) {
            int catId = Integer.parseInt(catIdParam);
            listaProductos = control.traerProductosPorCategoria(catId);
        } else {
            listaProductos = control.traerProductos();
        }

        out.println("=== LISTADO DE PRODUCTOS ===");
        for (Producto p : listaProductos) {
            out.println(p.toString());
        }
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