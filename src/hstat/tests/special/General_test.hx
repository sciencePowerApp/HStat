package hstat.tests.special;
import utest.Assert;

/**
 * ...
 * @author 
 */
class General_test
{

	public function new() { }

	public function test_erfcinv() {
	
		
		Assert.floatEquals(Special.erfcinv(.1), 1.163087153676674);
		Assert.floatEquals(Special.erfcinv(.5),0.47693627620446977);
		Assert.floatEquals(Special.erfcinv(-.5),100);
	}
	
	public function _test_erf() {
		Assert.floatEquals(Special.erf(.1), 0.11246291601828506);
		Assert.floatEquals(Special.erf(.5), 0.5204998778130465);
		Assert.floatEquals(Special.erf(-.5),-0.5204998778130465);
		
		
	}
	
}