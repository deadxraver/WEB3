import org.junit.Test;
import static org.junit.Assert.*;

public class ResultTest {
  @Test // Let's run some tests
  public void testResult() {
    double x = 1, y = 0, r = 2;
    Result result = new Result(x, y, r);
    assertTrue(String.format("result for {x=%.1f,y=%.1f,r=%.1f} should be true!", x, y, r), result.resultAll());
  }
}
