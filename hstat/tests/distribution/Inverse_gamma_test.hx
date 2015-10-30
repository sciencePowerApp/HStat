package hstat.tests.distribution;
import hstat.Distribution.Invgamma;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Inverse_gamma_test
{

	public function new() 
	{
		
	}
	
	
	public function pdf_test() {
      var tol = 0.000001;
      Assert.floatEquals(Invgamma.pdf(0.5, 1, 1), 0.5413411329, tol);
      Assert.floatEquals(Invgamma.pdf(0.25, 10, 2), 3.970461353, tol);
      Assert.floatEquals(Invgamma.pdf(0.95, 18, 10), 0.1998306597, tol);
      Assert.floatEquals(Invgamma.pdf(-5, 2, 4), 0, tol);
    }

    //Checked against R's pigamma(q, shape, scale), which R calls alpha, beta
    //from the pscl package
    public function test_cdf() {
      var tol = 0.000001;
      Assert.floatEquals(Invgamma.cdf(0.5, 1, 1), 0.1353353, tol);
      Assert.floatEquals(Invgamma.cdf(0.25, 10, 2), 0.7166243, tol);
      Assert.floatEquals(Invgamma.cdf(0.95, 18, 10), 0.9776673, tol);
      Assert.floatEquals(Invgamma.cdf(-5, 5, 20), 0, tol);
    }

    //Checked against R's qigamma(p, shape, rate = 1/scale)
    //from the pscl package
    public function test_inv() {
      var tol = 0.00001;
      Assert.floatEquals(Invgamma.inv(0.135, 1, 1), 0.4993806, tol);
      Assert.floatEquals(Invgamma.inv(0.716, 10, 2), 0.2498429, tol);
    }
  }
	
