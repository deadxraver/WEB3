import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.management.MBeanServer;
import javax.management.ObjectName;
import java.io.Serializable;
import java.lang.management.ManagementFactory;
import javax.annotation.PostConstruct;

@ManagedBean(name = "missBean")
@ApplicationScoped
public class MissBean implements SuperInterfaceMirov, Serializable {
	private int missesInRow = 0;
	private String msg = "";

	@PostConstruct
	public void registerMBean() {
		try {
			MBeanServer mbs = ManagementFactory.getPlatformMBeanServer();
			ObjectName name = new ObjectName("opishechka.planet:type=missBean");
			mbs.registerMBean(this, name);
		} catch (Exception e) {
			System.err.println("Failed to register MBean: missBean");
		}
	}

	@Override
	public void update(boolean hit) {
		if (hit) this.missesInRow = 0;
		else this.missesInRow++;
		if (missesInRow >= 2) this.msg = "Было более двух промахов подряд!!!";
		else this.msg = "";
	}

	@Override
	public int getMissesInRow() {
		return missesInRow;
	}

	@Override
	public void setMissesInRow(int missesInRow) {
		this.missesInRow = missesInRow;
	}

	@Override
	public String getMsg() {
		return msg;
	}

	@Override
	public void setMsg(String msg) {
		this.msg = msg;
	}
}