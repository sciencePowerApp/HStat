package hstat.tests.special;
import utest.Assert;

/**
 * ...
 * @author 
 */
class Gammap_test
{

	public function new() { }

	public function test() {
	
	  var tol = 0.000001;
      Assert.floatEquals(Special.gammap(5, 5), 13.4281611,tol);
      Assert.floatEquals(Special.gammap(5, 4), 8.90791355,tol);
      Assert.floatEquals(Special.gammap(5, 7), 19.8482014,tol);
	  
		
	}
	
}