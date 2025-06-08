import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import java.io.Serializable;

@ManagedBean(name = "squareBean")
@ApplicationScoped
public class SquareBean implements Serializable {
	private double square = 2. * 2. / 2 * 1.5 + Math.PI * 2. * 2. / 4;

	public void calculateSquare(double r) {
		this.square = r * r / 2 * 1.5 + Math.PI * r * r / 4;
	}

	public double getSquare() {
		return square;
	}

	public void setSquare(double square) {
		this.square = square;
	}
}
