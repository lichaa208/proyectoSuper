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

        String prodIdStr = request.getParameter("productoId");
        String cantidadStr = request.getParameter("cantidad");

        if (prodIdStr != null && cantidadStr != null) {
            int prodId = Integer.parseInt(prodIdStr);
            int cantidad = Integer.parseInt(cantidadStr);

            Producto prod = control.traerProducto(prodId);

            if (prod != null) {
                ArticuloCarrito art = new ArticuloCarrito();
                art.setProducto(prod);
                art.setCantidad(cantidad);

                control.crearArticuloCarrito(art);
            }
        }

        response.sendRedirect("CarritoSv");
    }
}