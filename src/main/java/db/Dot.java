package db;

import javax.persistence.*;

import java.io.Serializable;


@Table(name = "Dot")
@Entity
public class Dot implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	@Column
	private double x;
	@Column
	private double y;
	@Column
	private double r;
	@Column
	private boolean hit;
	@Column(name = "exec_time")
	private double execTime;
	@Column(name = "cur_time")
	private String currentTime;

	public Dot() {
	}

	public Dot(double x, double y, double r, boolean hit, double execTime, String currentTime) {
		this.x = x;
		this.y = y;
		this.r = r;
		this.hit = hit;
		this.execTime = execTime;
		this.currentTime = currentTime;
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

	public boolean isHit() {
		return hit;
	}

	public void setHit(boolean hit) {
		this.hit = hit;
	}

	public double getExecTime() {
		return execTime;
	}

	public void setExecTime(double execTime) {
		this.execTime = execTime;
	}

	public String getCurrentTime() {
		return currentTime;
	}

	public void setCurrentTime(String currentTime) {
		this.currentTime = currentTime;
	}

	@Override
	public String toString() {
		return String.format("x: %f, y: %f, r: %f, hit: %b, execTime: %f, currentTime: %s", x, y, r, hit, execTime, currentTime);
	}
}
