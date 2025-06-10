import javax.management.MXBean;

@MXBean
public interface SuperInterfaceMirov {
	void registerMBean();

	void update(boolean hit);

	int getMissesInRow();

	void setMissesInRow(int missesInRow);

	String getMsg();

	void setMsg(String msg);
}
