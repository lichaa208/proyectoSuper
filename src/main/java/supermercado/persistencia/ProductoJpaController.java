package supermercado.persistencia;

import supermercado.logica.Producto;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.Serializable;
import java.util.List;

public class ProductoJpaController implements Serializable{
	
	// "Fábrica" de conexiones (EntityManagerFactory).
	// Sirve para crear EntityManager, que son los que realmente hablan con la BD.
	private EntityManagerFactory emf = null;

	// En el constructor decimos con qué unidad de persistencia vamos a trabajar.
	// Esa unidad está definida en persistence.xml con el nombre "ejemplojpa".
	public ProductoJpaController() {
		emf = Persistence.createEntityManagerFactory("SupermercadoPF");
	}

	// Método que crea y devuelve un nuevo "EntityManager".
	// Pensalo como: "dame un empleado que se conecte a la base para trabajar".
	public EntityManager getEntityManager() {
		return emf.createEntityManager();
	}

	// Método para guardar un Artista en la base de datos.
	public void crear(Producto produ) {
		EntityManager em = null;
		try {
			// Abrimos la conexión (pedimos un empleado).
			em = getEntityManager();
			
			// Iniciamos una transacción: empieza la "promesa".
			em.getTransaction().begin();
			
			// Guardamos el objeto en la base (pero todavía no está confirmado).
			em.persist(produ);
			
			// Confirmamos la transacción: ahora sí el objeto queda guardado.
			em.getTransaction().commit();
		} finally {
			// Cerramos la conexión (el empleado ya no hace falta).
			if (em != null) {
				em.close();
			}
		}
	}
	
	// BUSCAR UNO: busca un artista por su id.
	// No hace falta transacción porque no modifica nada en la base.
	public Producto buscarUno(int id) {
	EntityManager em = getEntityManager();
	try {
	// find busca por clave primaria. Si no existe, devuelve null.
	return em.find(Producto.class, id);
	} finally {
	em.close();
	}
	}
	// BUSCAR TODOS: devuelve una lista con todos los artistas.
	public List<Producto> buscarTodos() {
	EntityManager em = getEntityManager();
	try {
	// Consulta JPQL: "traeme todos los objetos Artista"
	return em.createQuery("SELECT p FROM Producto p", Producto.class)
	.getResultList();
	} finally {
	em.close();
	}
	}
	public void edit(Producto Produ) throws Exception {
	    EntityManager em = null;
	    try {
	        em = getEntityManager();
	        em.getTransaction().begin();
	        Produ = em.merge(Produ);
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
	        Producto produ = em.find(Producto.class, id);
	        if (produ != null) {
	            em.remove(produ);
	        }
	        em.getTransaction().commit();
	    } finally {
	        if (em != null) {
	            em.close();
	        }
	    }
	}
	
	public List<Producto> buscarPorCategoria(int categoriaId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Producto p WHERE p.categoria.id = :Id", Producto.class)
                    .setParameter("catId", categoriaId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
	
	
	
	
}

