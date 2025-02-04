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

	private double x = 0;
	private double y = 0;
	private double r = 8;
	private double hiddenX = -1000;
	private double hiddenY = -1000;

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

	public double getHiddenX() {
		return hiddenX;
	}

	public void setHiddenX(double hiddenX) {
		this.hiddenX = hiddenX;
	}

	public double getHiddenY() {
		return hiddenY;
	}

	public void setHiddenY(double hiddenY) {
		this.hiddenY = hiddenY;
	}

	public void submit() {
		double startTime = System.currentTimeMillis();
		String currentTime = LocalDateTime.now().toLocalDate().toString();
		r = r / 4;
		if (hiddenX != -1000 && hiddenY != -1000) {
			System.out.println("X: " + hiddenX + ", Y: " + hiddenY + ", R: " + r);
			if (Validator.validateAll(hiddenX, hiddenY, r)) {
				boolean res = new Result(hiddenX, hiddenY, r).resultAll();
				Dot dot = new Dot(hiddenX, hiddenY, r, res, System.currentTimeMillis() - startTime, currentTime);
				r *= 4;
				System.out.println(dot);
				tableBean.addDot(dot);
			}
			hiddenX = -1000;
			hiddenY = -1000;
			return;
		}
		System.out.println("X: " + x + ", Y: " + y + ", R: " + r);
		if (!Validator.validateAll(x, y, r)) {
			System.err.println("validation failed");
			return;
		}
		boolean res = new Result(x, y, r).resultAll();
		Dot dot = new Dot(x, y, r, res, System.currentTimeMillis() - startTime, currentTime);
		r *= 4;
		System.out.println(dot);
		tableBean.addDot(dot);
	}
}