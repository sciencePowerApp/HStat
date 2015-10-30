package hstat.tests.distribution;
import hstat.Distribution.Lognormal;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Lognormal_test
{

	public function new() { }


    // Checked against R's dlnorm(x, meanlog = 0, sdlog = 1, log = FALSE)
    //   options(digits=10)
    //   dlnorm(c(-2, 0, 4), 4, 5)
	public function pdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Lognormal.pdf(-2, 4, 5), 0, tol);
      Assert.floatEquals(Lognormal.pdf(0, 4, 5), 0, tol);
      Assert.floatEquals(Lognormal.pdf(4, 4, 5), 0.01739974114, tol);
    }

    // Checked against R's
    // plnorm(q, meanlog = 0, sdlog = 1, lower.tail = TRUE, log.p = FALSE)
    //   options(digits=10)
    //   plnorm(c(-2, 0, 4), 4, 5)
	public function cdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Lognormal.cdf(-2, 4, 5), 0, tol);
      Assert.floatEquals(Lognormal.cdf(0, 4, 5), 0, tol);
      Assert.floatEquals(Lognormal.cdf(4, 4, 5), 0.3005772067, tol);
    }
	
}