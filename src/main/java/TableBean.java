import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.Serializable;

@ManagedBean(name = "table-bean")
@RequestScoped
public class TableBean implements Serializable {
	@Inject
	PointsStorageBean pointsStorageBean;

	public void addDot(Dot dot) {
		pointsStorageBean.addResult(dot);
	}
}
