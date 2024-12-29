package db;

import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;


import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@ManagedBean(name = "persistenceManager")
@ApplicationScoped
public class PersistenceManager {

	private EntityManagerFactory emf;

	public PersistenceManager(){
		emf = this.updateEntityManagerFactory();
	}

	public EntityManagerFactory updateEntityManagerFactory() {
		if (emf == null) {
			try (InputStream input = PersistenceManager.class.getClassLoader().getResourceAsStream("db.properties")) {
				Properties properties = new Properties();
				if (input == null) {
					throw new IllegalArgumentException("Sorry, unable to find db.properties");
				}
				properties.load(input);

				Map<String, String> persistenceProps = new HashMap<>();
				persistenceProps.put("jakarta.persistence.jdbc.user", properties.getProperty("db.username"));
				persistenceProps.put("jakarta.persistence.jdbc.password", properties.getProperty("db.password"));

				emf = Persistence.createEntityManagerFactory("Dot", persistenceProps);
			} catch (IOException ex) {
				ex.printStackTrace();
				throw new RuntimeException("Failed to load database configuration", ex);
			}
		}
		return emf;
	}

	public EntityManagerFactory getEmf() {
		return emf;
	}
}
