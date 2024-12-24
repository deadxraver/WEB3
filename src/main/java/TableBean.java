import javax.enterprise.context.RequestScoped;
import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.Serializable;

@ManagedBean(name = "tableBean")
@ApplicationScoped
public class TableBean implements Serializable {
	@ManagedProperty(value = "#{points}")
	private PointsStorageBean pointsStorageBean;

	public PointsStorageBean getPointsStorageBean() {
		return pointsStorageBean;
	}

	public void setPointsStorageBean(PointsStorageBean pointsStorageBean) {
		this.pointsStorageBean = pointsStorageBean;
	}

	public void addDot(Dot dot) {
		pointsStorageBean.addResult(dot);
	}
}