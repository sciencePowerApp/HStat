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
	
	public function test_erf() {
		Assert.floatEquals(Special.erf(.1), 0.11246291601828506);
		Assert.floatEquals(Special.erf(.5), 0.5204998778130465);
		Assert.floatEquals(Special.erf(-.5),-0.5204998778130465);
	}
	
	public function test_combination() {
		
		Assert.floatEquals(Special.combination(1, 1), 1);
		Assert.floatEquals(Special.combination(2, 2), 1);
		Assert.floatEquals(Special.combination(3, 1), 3);
	}
	
	public function test_factorial() {
		Assert.floatEquals(Special.factorial(2), 2);
		Assert.floatEquals(Special.factorial(4),24);
	}
	
	public function test_factorialln() {
		Assert.floatEquals(Special.factorialln(2), 0.6931471805599443);
		Assert.floatEquals(Special.factorialln(4),3.1780538303479453);
	}
	
	public function test_gammaln() {
		Assert.floatEquals(Special.gammaln(2),-4.440892098500626e-16);
		Assert.floatEquals(Special.gammaln(4),1.7917594692280547);
	}
	
	public function test_combinationln() {
		Assert.floatEquals(Special.combinationln(2, 2), 0);
		Assert.floatEquals(Special.combinationln(3, 3), 0);
		Assert.floatEquals(Special.combinationln(8, 3), 4.025351690735387);
	}
	
	public function test_ibeta() {
		Assert.floatEquals(Special.ibeta(.5,.5,.5), 0.5000000180073509);
	}
	
	public function test_betac() {
		Assert.floatEquals(Special.betacf(.5,.5,.5), 1.5707962702232705);
	}
	
	
	
}