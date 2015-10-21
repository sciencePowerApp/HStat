package hstat.tests.distribution;
import hstat.Distribution.Uniform;
import utest.Assert;

/**
 * ...
 * @author 
 */
class Uniform_test
{

	public function new() {}
	
	public function test_pdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Uniform.pdf(10.5, 10, 11), 1.0,tol);
      Assert.floatEquals(Uniform.pdf(6, 0, 10), 0.1,tol);
    }
	
	public function test_cdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Uniform.cdf(7, 0, 10), 0.7,tol);
      Assert.floatEquals(Uniform.cdf(10.5, 10, 11), 0.5,tol);
    }
	
    public function test_inv() {
      var tol = 0.0000001;
      Assert.floatEquals(Uniform.inv(0.5, 10, 11), 10.5,tol);
      Assert.floatEquals(Uniform.inv(0.7, 0, 10), 7.0,tol);
    }
}