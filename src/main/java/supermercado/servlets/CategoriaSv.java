package supermercado.servlets;

import supermercado.logica.Categoria;
import supermercado.logica.ControladoraLogica;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CategoriaSv") // <-- 1. Mapeo estandarizado en minúscula
public class CategoriaSv extends HttpServlet {

    ControladoraLogica controlog = new ControladoraLogica();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String catIdParam = request.getParameter("categoriaId");
        
        if (catIdParam != null && !catIdParam.trim().isEmpty()) {
            response.sendRedirect("ProductoSv?categoriaId=" + catIdParam);
        } else {
            response.sendRedirect("ProductoSv");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");

        if (nombre != null && !nombre.trim().isEmpty()) {
            Categoria cat = new Categoria();
            cat.setNombre(nombre);

            controlog.crearCategoria(cat);
        }

        // Redirige al Servlet de productos para ver el resultado en la tienda
        response.sendRedirect("ProductoSv"); // <-- 2. Redirigir a la tienda
    }
}