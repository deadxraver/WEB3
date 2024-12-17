import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import java.io.Serializable;

@ManagedBean(name = "bean")
@ViewScoped
public class FormBean implements Serializable {
	private double x;
	private int y;
	private int r;

	// Геттеры и сеттеры
	public double getX() {
		return x;
	}

	public void setX(double x) {
		this.x = x;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

	public int getR() {
		return r;
	}

	public void setR(int r) {
		this.r = r;
	}

	// Метод обработки формы
	public String submit() {
		// Обработайте данные здесь
		System.out.println("X: " + x + ", Y: " + y + ", R: " + r);
		return null; // или навигация на другую страницу
	}
}
