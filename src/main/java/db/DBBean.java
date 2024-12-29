package db;

import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.io.Serializable;
import java.util.List;

@ManagedBean(name = "dbBean")
@ApplicationScoped
public class DBBean implements Serializable {

	private EntityManagerFactory entityManagerFactory;
	private EntityManager entityManager;
	List<Dot> points;

	public DBBean() {
		entityManagerFactory = Persistence.createEntityManagerFactory("Dot");
		entityManager = entityManagerFactory.createEntityManager();
		loadFromDB();
	}

	public void loadFromDB() {
		try {
			entityManager.getTransaction().begin();
			points = entityManager.createQuery("SELECT p FROM Dot p", Dot.class).getResultList();
			entityManager.getTransaction().commit();
			System.out.println("added point");
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
			System.err.println("failed to load");
		}
	}

	public void addDot(Dot dot) {
		try {
			entityManager.getTransaction().begin();
			entityManager.persist(dot);
			entityManager.getTransaction().commit();
			loadFromDB();
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
			System.err.println("failed to add");
		}
	}

	public void clear(){
		try {
			entityManager.getTransaction().begin();
			entityManager.createQuery("DELETE FROM Dot").executeUpdate();
			entityManager.getTransaction().commit();
			points.clear();
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
			System.err.println("failed to clear");
		}
		points.clear();
		System.out.println("cleared");
	}

	public void close() {
		if (entityManager != null) {
			entityManager.close();
		}
		if (entityManagerFactory != null) {
			entityManagerFactory.close();
		}
	}

	public List<Dot> getPoints() {
		return points;
	}

	public void setPoints(List<Dot> points) {
		this.points = points;
	}
}
