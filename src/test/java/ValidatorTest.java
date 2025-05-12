import org.junit.Test;
import static org.junit.Assert.*;

public class ValidatorTest {
  @Test
  public void testValidator() {
    double x = 0, y = 0, r = 2;
    assertTrue("{x=" + x + ",y=" + y + ",r=" + r + "} should be valid!!", Validator.validateAll(x, y, r));
  }
}
