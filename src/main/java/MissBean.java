import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import java.io.Serializable;

@ManagedBean(name = "missBean")
@ApplicationScoped
public class MissBean implements Serializable {
	private int missesInRow = 0;
	private String msg = "";

	public void update(boolean hit) {
		if (hit) this.missesInRow = 0;
		else this.missesInRow++;
		if (missesInRow >= 2) this.msg = "Было более двух промахов подряд!!!";
		else this.msg = "";
	}

	public int getMissesInRow() {
		return missesInRow;
	}

	public void setMissesInRow(int missesInRow) {
		this.missesInRow = missesInRow;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
}