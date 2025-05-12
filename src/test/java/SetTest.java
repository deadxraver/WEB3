import org.junit.Test;
import static org.junit.Assert.*;

public class SetTest {
  @Test
  public void testSetGet() {
    double x = 0.0;
    FormBean formBean = new FormBean();
    formBean.setX(x);
    assertEquals("Value passed to set() and got from get() do not match!", x, formBean.getX(), 0.0);
  }
}
