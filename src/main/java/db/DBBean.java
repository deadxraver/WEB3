package db;

import db.Dot;

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

	public DBBean() {
		entityManagerFactory = Persistence.createEntityManagerFactory("Dot");
		entityManager = entityManagerFactory.createEntityManager();
		loadFromDB();
	}

	public void loadFromDB() {
		try {
			entityManager.getTransaction().begin();
			List<Dot> points = entityManager.createQuery("SELECT p FROM Dot p", Dot.class).getResultList();
			entityManager.getTransaction().commit();
			System.out.println("Загружено точек: " + points.size());
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public void addDot(Dot dot) {
		try {
			entityManager.getTransaction().begin();
			entityManager.persist(dot);
			entityManager.getTransaction().commit();
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public void close() {
		if (entityManager != null) {
			entityManager.close();
		}
		if (entityManagerFactory != null) {
			entityManagerFactory.close();
		}
	}
}
