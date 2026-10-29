package supermercado.persistencia;

import supermercado.logica.Categoria;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.Serializable;
import java.util.List;

public class CategoriaJpaController implements Serializable{
	
	// "Fábrica" de conexiones (EntityManagerFactory).
	// Sirve para crear EntityManager, que son los que realmente hablan con la BD.
	private EntityManagerFactory emf = null;

	// En el constructor decimos con qué unidad de persistencia vamos a trabajar.
	// Esa unidad está definida en persistence.xml con el nombre "ejemplojpa".
	public CategoriaJpaController() {
		emf = Persistence.createEntityManagerFactory("SupermercadoPF");
	}

	// Método que crea y devuelve un nuevo "EntityManager".
	// Pensalo como: "dame un empleado que se conecte a la base para trabajar".
	public EntityManager getEntityManager() {
		return emf.createEntityManager();
	}

	// Método para guardar un Artista en la base de datos.
	public void crear(Categoria categ) {
		EntityManager em = null;
		try {
			// Abrimos la conexión (pedimos un empleado).
			em = getEntityManager();
			
			// Iniciamos una transacción: empieza la "promesa".
			em.getTransaction().begin();
			
			// Guardamos el objeto en la base (pero todavía no está confirmado).
			em.persist(categ);
			
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
	public Categoria buscarUno(int id) {
	EntityManager em = getEntityManager();
	try {
	// find busca por clave primaria. Si no existe, devuelve null.
	return em.find(Categoria.class, id);
	} finally {
	em.close();
	}
	}
	// BUSCAR TODOS: devuelve una lista con todos los artistas.
	public List<Categoria> buscarTodos() {
	EntityManager em = getEntityManager();
	try {
	// Consulta JPQL: "traeme todos los objetos Artista"
	return em.createQuery("SELECT c FROM Categoria c", Categoria.class)
	.getResultList();
	} finally {
	em.close();
	}
	}
	public void edit(Categoria cate) throws Exception {
	    EntityManager em = null;
	    try {
	        em = getEntityManager();
	        em.getTransaction().begin();
	        cate = em.merge(cate);
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
	        Categoria catego = em.find(Categoria.class, id);
	        if (catego != null) {
	            em.remove(catego);
	        }
	        em.getTransaction().commit();
	    } finally {
	        if (em != null) {
	            em.close();
	        }
	    }
	}
	
	
	
	
}
