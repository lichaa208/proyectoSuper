package supermercado.persistencia;

import supermercado.logica.ArticuloCarrito;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.Serializable;
import java.util.List;

public class ArticuloCarritoJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public ArticuloCarritoJpaController() {
        emf = Persistence.createEntityManagerFactory("SupermercadoPF");
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void crear(ArticuloCarrito item) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(item);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public ArticuloCarrito buscarUno(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(ArticuloCarrito.class, id);
        } finally {
            em.close();
        }
    }

    public List<ArticuloCarrito> buscarTodos() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT itemcarrito FROM ArticuloCarrito itemcarrito", ArticuloCarrito.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void edit(ArticuloCarrito item) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            item = em.merge(item);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(int id) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            ArticuloCarrito item = em.find(ArticuloCarrito.class, id);
            if (item != null) {
                em.remove(item);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    // Método para borrar todos los registros del carrito de una sola vez
    public void vaciarCarrito() {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.createQuery("DELETE FROM ArticuloCarrito").executeUpdate();
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
}