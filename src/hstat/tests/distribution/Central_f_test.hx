package hstat.tests.distribution;
import hstat.Distribution.CentralF;
import utest.Assert;

/**
 * ...
 * @author 
 */
class Central_f_test
{

	public function new() {	}
	
	
	function test_pdf() {
      var tol = 0.0000001;

      var zeroth = CentralF.pdf(0.2, 1, 3);
      Assert.floatEquals(zeroth, 0.722349);

      var first = CentralF.pdf(1, 100, 100);
      Assert.floatEquals(first, 1.989731);

      var second = CentralF.pdf(2.5, 50, 200);
      Assert.floatEquals(second, 0.00003610325);

      var third = CentralF.pdf(0.8, 2, 10);
      Assert.floatEquals(third, 0.4104423);

      var fourth = CentralF.pdf(0.4, 3, 10);
      Assert.floatEquals(fourth, 0.6733766);

      var first_at_zero = CentralF.pdf(0.0, 3, 5);
      Assert.floatEquals(first_at_zero, 0);

      var second_at_zero = CentralF.pdf(0.0, 2, 1);
      Assert.floatEquals(second_at_zero, 1);

      var third_at_zero = CentralF.pdf(0.0, 1, 1);
	  Assert.equals(third_at_zero, Math.POSITIVE_INFINITY);

      // When x < 0 return 0
      //   df(-3, 4, 11)
      Assert.floatEquals(CentralF.pdf(-3, 4, 11), 0);

      // When x = 0, and df1 = 2, return 1
      //   df(0, 2, 15)
      Assert.floatEquals(CentralF.pdf(0, 2, 15), 1);

      // When x = 0, and df1 < 2, return Infinity
      //   df(0, 1, 20)
      Assert.equals(CentralF.pdf(0, 1, 20), Math.POSITIVE_INFINITY);
    }
	
	
	
    // Check against R's pf(q, df1, df2, ncp, lower.tail = TRUE, log.p = FALSE):
    //    options(digits=10)
    //    pf(0.2, 1, 3)
    //    pf(1, 100, 100)
    //    pf(2.5, 50, 200)
    //    pf(0.8, 2, 10)
    //    pf(0.4, 3, 10)
    //    pf(0, 3, 5)
    //    pf(0, 2, 1)
    //    pf(0, 1, 1)
    //    pf(-5, 5, 20)
    function test_cdf() {
      var tol = 0.0000001;
      // Check with x within support (x > 0)
      Assert.floatEquals(CentralF.cdf(0.2, 1, 3), 0.3149623575);
      Assert.floatEquals(CentralF.cdf(1, 100, 100), 0.5);
      Assert.floatEquals(CentralF.cdf(2.5, 50, 200), 0.9999962786);
      Assert.floatEquals(CentralF.cdf(0.8, 2, 10), 0.5238869846);
      Assert.floatEquals(CentralF.cdf(0.4, 3, 10), 0.2439174275);
      // Check with x at edge of support (x = 0)
      Assert.floatEquals(CentralF.cdf(0.0, 3, 5), 0);
      Assert.floatEquals(CentralF.cdf(0.0, 2, 1), 0);
      Assert.floatEquals(CentralF.cdf(0.0, 1, 1), 0);
      // Check with x outside of support (x < 0)
      Assert.floatEquals(CentralF.cdf(-5, 5, 20), 0);
    }
}