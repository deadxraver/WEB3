package opishechka.planet;

public class Validator {
	private static boolean validateX(double x) {
		return x >= -2 && x <= 2;
	}

	private static boolean validateY(double y) {
		return y >= -5 && y <= 3;
	}

	private static boolean validateR(double r) {
		return r >= 2 && r <= 5;
	}

	public static boolean validateAll(double x, double y, double r) {
		return validateX(x) && validateY(y) && validateR(r);
	}
}
