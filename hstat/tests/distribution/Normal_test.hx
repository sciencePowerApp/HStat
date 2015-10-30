package hstat.tests.distribution;
import hstat.Distribution.Normal;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Normal_test
{

	public function new() { }

	public function test_pdf() {
      var tol = 0.000001;
	  
      Assert.floatEquals(Normal.pdf(0, 0, 1.0), 0.3989423,tol);
      Assert.floatEquals(Normal.pdf(5, 10, 3.0), 0.03315905,tol);
      Assert.floatEquals(Normal.pdf(-1, 1, 0.5), 0.00026766,tol);
    }

	public function test_invCalc() {
      var tol = 0.000001;
      Assert.floatEquals(Normal.inv(0.3989423, 0, 1.0), -0.2560858,tol);
      Assert.floatEquals(Normal.inv(0.05, 10, 3.0), 5.065439,tol);
      Assert.floatEquals(Normal.inv(0.65, -2, .5), -1.80734,tol);
	  Assert.isTrue(true);
    }
	
}