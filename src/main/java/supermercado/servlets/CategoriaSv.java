package supermercado.servlets;

import supermercado.logica.Categoria;
import supermercado.logica.ControladoraLogica;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/CategoriaSV")
public class CategoriaSv extends HttpServlet {

    ControladoraLogica controlog = new ControladoraLogica();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();

        List<Categoria> listaCategorias = controlog.traerCategorias();

        out.println("=== LISTADO DE CATEGORIAS ===");
        for (Categoria c : listaCategorias) {
            out.println(c.toString());
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

        response.sendRedirect("CategoriaSv");
    }
}