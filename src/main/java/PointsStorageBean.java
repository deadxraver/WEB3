import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.inject.Named;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@ManagedBean(name = "points")
@ApplicationScoped
public class PointsStorageBean {
	private final List<Dot> results = new CopyOnWriteArrayList<>();

	public void addResult(Dot dot) {
		results.add(dot);
		System.out.println("added result");
	}

	public List<Dot> getResults() {
		return this.results;
	}
}
