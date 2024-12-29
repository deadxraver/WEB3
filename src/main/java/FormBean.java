import db.Dot;

import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import java.io.Serializable;
import java.time.LocalDateTime;

@ManagedBean(name = "bean")
@ApplicationScoped
public class FormBean implements Serializable {
	@ManagedProperty(value = "#{tableBean}")
	private TableBean tableBean;

	private double x;
	private double y;
	private double r;

	public TableBean getTableBean() {
		return tableBean;
	}

	public void setTableBean(TableBean tableBean) {
		this.tableBean = tableBean;
	}

	public double getX() {
		return x;
	}

	public void setX(double x) {
		this.x = x;
	}

	public double getY() {
		return y;
	}

	public void setY(double y) {
		this.y = y;
	}

	public double getR() {
		return r;
	}

	public void setR(double r) {
		this.r = r;
	}

	public void submit() {
		double startTime = System.currentTimeMillis();
		String currentTime = LocalDateTime.now().toLocalDate().toString();
		r = r / 4;
		System.out.println("X: " + x + ", Y: " + y + ", R: " + r);
		if (!Validator.validateAll(x, y, r)) {
			System.err.println("validation failed");
			return;
		}
		boolean res = new Result(x, y, r).resultAll();
		Dot dot = new Dot(x, y, r, res, System.currentTimeMillis() - startTime, currentTime);
		r *= 4;
		System.out.println(dot.toString());
		tableBean.addDot(dot);
	}
}