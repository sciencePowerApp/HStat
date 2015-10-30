package hstat.tests.distribution;
import hstat.Distribution.Pareto;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Pareto_test
{

	public function new() 
	{	}
	
	    // Checked against R's dpareto(x, df) in package VGAM
    //   install.packages("VGAM")
    //   library("VGAM")
    //   options(digits=10)
    //   dpareto(c(0, 1, 2), 1, 1)
    //   dpareto(c(-1, 1, 4), 1, 2)
    //   dpareto(c(1, 2, 10), 2, 2)
	public function test_pdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Pareto.pdf(0, 1, 1), 0, tol);
      Assert.floatEquals(Pareto.pdf(1, 1, 1), 1, tol);
      Assert.floatEquals(Pareto.pdf(2, 1, 1), 0.25, tol);

      Assert.floatEquals(Pareto.pdf(-1, 1, 2), 0, tol);
      Assert.floatEquals(Pareto.pdf(1, 1, 2), 2, tol);
      Assert.floatEquals(Pareto.pdf(4, 1, 2), 0.03125, tol);

      Assert.floatEquals(Pareto.pdf(1, 2, 2), 0, tol);
      Assert.floatEquals(Pareto.pdf(2, 2, 2), 1, tol);
      Assert.floatEquals(Pareto.pdf(10, 2, 2), 0.008, tol);
    }
  
  

    // Checked against R's qpareto(x, df) in package VGAM
    //   install.packages("VGAM")
    //   library("VGAM")
    //   options(digits=10)
    //   qpareto(c(0, 0.5, 1), 1, 1)
    //   qpareto(c(0, 0.5, 1), 1, 2)
    //   qpareto(c(0, 0.5, 1), 2, 2)
 public function test_inv() {
      var tol = 0.0000001;
      Assert.floatEquals(Pareto.inv(0, 1, 1), 1, tol);
      Assert.floatEquals(Pareto.inv(0.5, 1, 1), 2, tol);
      Assert.equals(Pareto.inv(1, 1, 1), Math.POSITIVE_INFINITY);

      Assert.floatEquals(Pareto.inv(0, 1, 2), 1, tol);
      Assert.floatEquals(Pareto.inv(0.5, 1, 2), 1.414213562, tol);
      Assert.equals(Pareto.inv(1, 1, 2), Math.POSITIVE_INFINITY);

      Assert.floatEquals(Pareto.inv(0, 2, 2), 2, tol);
      Assert.floatEquals(Pareto.inv(0.5, 2, 2), 2.828427125, tol);
      Assert.equals(Pareto.inv(1, 2, 2), Math.POSITIVE_INFINITY);
    }

	
    // Checked against R's ppareto(q, scale = 1, shape, lower.tail = TRUE, log.p = FALSE) in package VGAM
    //   install.packages("VGAM")
    //   library("VGAM")
    //   options(digits=10)
    //   ppareto(c(0, 1, 2), 1, 1)
    //   ppareto(c(-1, 1, 4), 1, 2)
    //   ppareto(c(1, 2, 10), 2, 2)
	public function test_cdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Pareto.cdf(0, 1, 1), 0, tol);
      Assert.floatEquals(Pareto.cdf(1, 1, 1), 0, tol);
      Assert.floatEquals(Pareto.cdf(2, 1, 1), 0.5, tol);

      Assert.floatEquals(Pareto.cdf(-1, 1, 2), 0, tol);
      Assert.floatEquals(Pareto.cdf(1, 1, 2), 0, tol);
      Assert.floatEquals(Pareto.cdf(4, 1, 2), 0.9375, tol);

      Assert.floatEquals(Pareto.cdf(1, 2, 2), 0, tol);
      Assert.floatEquals(Pareto.cdf(2, 2, 2), 0, tol);
      Assert.floatEquals(Pareto.cdf(10, 2, 2), 0.96, tol);
    }
	
}