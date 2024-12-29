import db.DBBean;
import db.Dot;

import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import java.io.Serializable;

@ManagedBean(name = "tableBean")
@ApplicationScoped
public class TableBean implements Serializable {
	@ManagedProperty(value = "#{dbBean}")
	private DBBean dbBean;

	public DBBean getDbBean() {
		return dbBean;
	}

	public void setDbBean(DBBean dbBean) {
		this.dbBean = dbBean;
	}

	public void addDot(Dot dot) {
		dbBean.addDot(dot);
	}
}