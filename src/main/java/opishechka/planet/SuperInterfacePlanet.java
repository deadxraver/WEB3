package opishechka.planet;

import javax.management.MXBean;

@MXBean
public interface SuperInterfacePlanet {
	void registerMBean();

	void calculateSquare(double r);

	double getSquare();

	void setSquare(double square);
}
