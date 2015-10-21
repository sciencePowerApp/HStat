package hstat.tests.distribution;

import hstat.Distribution.Binomial;
import utest.Assert;

/**
 * ...
 * @author 
 */
class Binomial_test
{

	public function new() { }

	
	public function test_pdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Binomial.pdf(10, 25, 0.5), 0.09741664,tol);
      Assert.floatEquals(Binomial.pdf(50, 1000, 0.05), 0.05778798,tol);
    }
	
    //Checked against r's pbinom(k, n, p)
    public function test_cdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Binomial.cdf(10, 25, 0.5), 0.2121781,tol);
      Assert.floatEquals(Binomial.cdf(50, 1000, 0.05), 0.537529,tol);
    }
	
	
	
	
}