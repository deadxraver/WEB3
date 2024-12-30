public class Result {
	private final double x, y, r;

	public Result(double x, double y, double r) {
		this.x = x;
		this.y = y;
		this.r = r;
	}

	private boolean first() {
		return x >= 0 && y >= 0 && x * x + y * y <= r / 2 * r / 2;
	}

	private boolean second() {
		return false;
	}

	private boolean third() {
		return x <= 0 && y <= 0 && x >= -r && y >= -r / 2;
	}

	private boolean fourth() {
		return x <= 0 && y >= 0 && x / 2 + r / 2 >= y;
	}

	public boolean resultAll() {
		return first() || second() || third() || fourth();
	}
}
