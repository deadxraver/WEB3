import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import java.io.Serializable;

@ManagedBean(name = "bean")
@ApplicationScoped
public class FormBean implements Serializable {
	private double x;
	private double y;
	private Double r;

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

	public Double getR() {
		return r;
	}

	public void setR(Double r) {
		this.r = r;
	}

	public String submit() {

		System.out.println("X: " + x + ", Y: " + y + ", R: " + r / 4);
		return null;
	}
}
