package hstat.tests.special;
import utest.Assert;

/**
 * ...
 * @author 
 */
class LowRegGamma_test
{

	public function new() { }

	public function test() {
	
	  var tol = 0.000001;
      Assert.floatEquals(tol, Special.lowRegGamma(5, 5), 0.5595067);
      Assert.floatEquals(tol, Special.lowRegGamma(4, 5), 0.7349741);
      Assert.floatEquals(tol, Special.lowRegGamma(11, 10), 0.4169602);
	  
	}
	
}