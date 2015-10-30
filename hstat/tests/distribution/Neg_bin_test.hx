package hstat.tests.distribution;
import hstat.Distribution.Negbin;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Neg_bin_test
{

	public function new() 
	{	
	}
	
	public function test_pdf()  {
      var k = 10; // number of failures
      var r = 5; // threshold number of successes
      var p = 0.25; // probability of a success
      Assert.floatEquals(Negbin.pdf(k, r, p), 0.05504866037517786);
    }
 

	public function test_cdf() {
      var k = 10; // number of failures
      var r = 5; // threshold number of successes
      var p = 0.25; // probability of a success
      Assert.floatEquals(Negbin.cdf(k, r, p), 0.3135140584781766);
    }
  
	
}