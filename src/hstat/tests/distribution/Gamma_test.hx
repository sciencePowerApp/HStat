package hstat.tests.distribution;
import hstat.Distribution.Gamma;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Gamma_test
{

	public function new() { }

	/*'check instance and static pdf method': function () {
      var shape = 5;
      var scale = 1;
      var gamma = jStat.gamma(shape, scale);
      var xValues = [-1, 0, 1];
      var x;
      for (var i = 0; i < xValues.length; i++) {
        x = xValues[i];
        pStatic = jStat.gamma.pdf(x, shape, scale);
        pInstance = gamma.pdf(x);
        if (isNaN(pStatic)) {
          assert(isNaN(pInstance));
        } else {
          assert(pStatic === pInstance,
                 'Gamma pdf evaluated at ' +
                   x + ' should be equal for instance and static methods.');
        }
      }
    }*/

    // Checked against R's dgamma(x, shape, rate = 1, scale = 1/rate, log = FALSE)
    //   options(digits=10)
    //   dgamma(2, 1, scale=1)
    //   dgamma(5, 10, scale=2)
    //   dgamma(18, 22, scale=0.8)
    //   dgamma(-5, 7, scale=10)
	  public function test_pdf() {
      var tol = 0.000001;
      Assert.floatEquals(Gamma.pdf(2, 1, 1), 0.1353352832,tol);
      Assert.floatEquals(Gamma.pdf(5, 10, 2), 0.000431450369,tol);
      Assert.floatEquals(Gamma.pdf(18, 22, 0.8), 0.1029848021,tol);
      Assert.floatEquals(Gamma.pdf(-5, 7, 10), 0,tol);
    }

    //Checked against R's pgamma(q, shape, rate = 1/scale)
    //That is, jStat.gamma.cdf(5, 10, 2) == pgamma(5, 10, 1/2)
    public function test_cdf() {
      var tol = 0.000001;
      Assert.floatEquals(Gamma.cdf(2, 1, 1), 0.8646647,tol);
      Assert.floatEquals(Gamma.cdf(5, 10, 2), 0.0002773,tol);
      Assert.floatEquals(Gamma.cdf(18, 22, 0.8), 0.5701725,tol);
      Assert.floatEquals(Gamma.cdf(-1, 5, 5), 0,tol);
    }

    //Checked against R's qgamma(p, shape, rate = 1/scale)
    //That is, jStat.gamma.inv(0.86, 10, 2) == qgamma(0.86, 10, 1/2)
	public function test_inv() {
      var tol = 0.00001;
      Assert.floatEquals(Gamma.inv(0.86, 10, 2), 26.83397,tol);
      Assert.floatEquals(Gamma.inv(0.57, 22, 0.8), 17.99833,tol);
    }
	
}