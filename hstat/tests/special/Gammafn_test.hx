package hstat.tests.special;
import utest.Assert;

/**
 * ...
 * @author 
 */

using hstat.Special; 
 
class Gammafn_test
{

	public function new() 
	{
		
	}
	
	public function test() {	
		var tol = 0.000001;
		Assert.floatEquals(Special.gammafn(0.00001), 99999.422794,tol);
		Assert.floatEquals(Special.gammafn(0.2), 4.590843,tol);
		Assert.equals(Special.gammafn(10), 362880);	
		Assert.equals(Special.gammafn(1), 1);
	}
	
}