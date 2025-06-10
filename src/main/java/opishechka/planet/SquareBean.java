package opishechka.planet;

import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.management.MBeanServer;
import javax.management.ObjectName;
import java.io.Serializable;
import java.lang.management.ManagementFactory;
import javax.annotation.PostConstruct;

@ManagedBean(name = "squareBean")
@ApplicationScoped
public class SquareBean implements SuperInterfacePlanet, Serializable {
	private double square = 2. * 2. / 2 * 1.5 + Math.PI * 2. * 2. / 4;

	@PostConstruct
	public void registerMBean() {
		try {
			MBeanServer mbs = ManagementFactory.getPlatformMBeanServer();
			ObjectName name = new ObjectName("opishechka.planet:type=squareBean");
			mbs.registerMBean(this, name);
		} catch (Exception e) {
			System.err.println("Failed to register MBean: squareBean");
		}
	}

	@Override
	public void calculateSquare(double r) {
		this.square = r * r / 2 * 1.5 + Math.PI * r * r / 4;
	}

	@Override
	public double getSquare() {
		return square;
	}

	@Override
	public void setSquare(double square) {
		this.square = square;
	}
}
