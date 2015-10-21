package hstat.tests.distribution;
import hstat.Distribution.Triangular;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Triangular_test
{

	public function new() 
	{
	}
	
	 //'check pdf calculation, when a < c < b': 
	public function test_pdf1() {
      var tol = 0.0000001;
      Assert.floatEquals(Triangular.pdf(0.5, 1, 11, 5), 0, tol);      // x < a
      Assert.floatEquals(Triangular.pdf(1, 1, 11, 5), 0, tol);        // x = a
      Assert.floatEquals(Triangular.pdf(2.5, 1, 11, 5), 0.075, tol);  // a < x < c
      Assert.floatEquals(Triangular.pdf(5, 1, 11, 5), 0.2, tol);      // x = c
      Assert.floatEquals(Triangular.pdf(6.5, 1, 11, 5), 0.15, tol);   // c < x < b
      Assert.floatEquals(Triangular.pdf(11, 1, 11, 5), 0, tol);       // x = b
      Assert.floatEquals(Triangular.pdf(20, 1, 11, 5), 0, tol);       // b < x
    }
	
    //'check pdf calculation, when a = c < b': 	
	public function test_pdf2() {
      var tol = 0.0000001;
      Assert.floatEquals(Triangular.pdf(-20, -5, 5, -5), 0, tol);     // x < a
      Assert.floatEquals(Triangular.pdf(-5, -5, 5, -5), 0.2, tol);    // x = a = c
      Assert.floatEquals(Triangular.pdf(-2.5, -5, 5, -5), 0.15, tol); // a = c < x < b
      Assert.floatEquals(Triangular.pdf(5, -5, 5, -5), 0, tol);       // x = b
      Assert.floatEquals(Triangular.pdf(10, -5, 5, -5), 0, tol);      // b < x
    }
    //'check pdf calculation, when a < c = b': 
	public function test_pdf3() {
      var tol = 0.0000001;
      Assert.floatEquals(Triangular.pdf(-10, 0, 8, 8), 0, tol);       // x < a
      Assert.floatEquals(Triangular.pdf(0, 0, 8, 8), 0, tol);         // x = a < c = b
      Assert.floatEquals(Triangular.pdf(4, 0, 8, 8), 0.125, tol);     // a = c < x < b
      Assert.floatEquals(Triangular.pdf(8, 0, 8, 8), 0.25, tol);      // x = c = b
      Assert.floatEquals(Triangular.pdf(12, 0, 8, 8), 0, tol);        // b < x
    }
    //'check pdf calculation, when c < a': 
	public function test_pdf4() {
      var tol = 0.0000001;
	  

      Assert.isTrue(Math.isNaN(Triangular.pdf(0, 5, 10, 4)));                  // x < a
      Assert.isTrue(Math.isNaN(Triangular.pdf(7, 5, 10, 4)));                  // a < x < b
      Assert.isTrue(Math.isNaN(Triangular.pdf(12, 5, 10, 4)));                 // b < x
    }
    //'check pdf calculation, when b < c': 
	public function test_pdf5() {
      var tol = 0.0000001;
      Assert.isTrue(Math.isNaN(Triangular.pdf(17, 23, 47, 50)));               // x < a
      Assert.isTrue(Math.isNaN(Triangular.pdf(30, 23, 47, 50)));               // a < x < b
      Assert.isTrue(Math.isNaN(Triangular.pdf(88, 23, 47, 50)));               // b < x
    }
   //'check pdf calculation, when a = b': 
   public function test_pdf6() {
      var tol = 0.0000001;
      Assert.isTrue(Math.isNaN(Triangular.pdf(-17, -10, -10, -10)));           // x < a
      Assert.isTrue(Math.isNaN(Triangular.pdf(-10, -10, -10, -10)));           // a = x = b
      Assert.isTrue(Math.isNaN(Triangular.pdf(0, -10, -10, -10)));             // b < x
    }
    // checked against R's ptriang(q, min=-1, mode=0, max=1, lower.tail=TRUE, log.p=FALSE) from package 'mc2d':
    //   install.packages("mc2d")
    //   library("mc2d")
    //   options(digits=10)
    //   ptriang(c(0, 1, 3, 5, 7, 11, 13), 1, 5, 11)
    //   ptriang(c(-10, -5, 0, 5, 10), -5, -5, 5)
    //   ptriang(c(-1, 0, 4, 8, 10), 0, 8, 8)
    //   ptriang(6, 5, 4, 10)
    //   ptriang(30, 23, 50, 47)
    //   ptriang(-10, -10, -10, -10) # NOTE: This returns: [1] 1, but we don't allow a = b = c!
    //'check cdf calculation, when a < c < b': 
	public function test_cdf1() {
      var tol = 0.0000001;
      Assert.floatEquals(Triangular.cdf(0, 1, 11, 5), 0, tol);
      Assert.floatEquals(Triangular.cdf(1, 1, 11, 5), 0, tol);
      Assert.floatEquals(Triangular.cdf(3, 1, 11, 5), 0.1, tol);
      Assert.floatEquals(Triangular.cdf(5, 1, 11, 5), 0.4, tol);
      Assert.floatEquals(Triangular.cdf(7, 1, 11, 5), 0.7333333333, tol);
      Assert.floatEquals(Triangular.cdf(11, 1, 11, 5), 1, tol);
      Assert.floatEquals(Triangular.cdf(13, 1, 11, 5), 1, tol);
    }
    //check cdf calculation, when a = c < b': 
	public function test_cdf2() {
      var tol = 0.0000001;
      Assert.floatEquals(Triangular.cdf(-10, -5, 5, -5), 0, tol);
      Assert.floatEquals(Triangular.cdf(-5, -5, 5, -5), 0, tol);
      Assert.floatEquals(Triangular.cdf(0, -5, 5, -5), 0.75, tol);
      Assert.floatEquals(Triangular.cdf(5, -5, 5, -5), 1, tol);
      Assert.floatEquals(Triangular.cdf(10, -5, 5, -5), 1, tol);
    }
    //'check cdf calculation, when a < c = b': 
	public function test_cdf3() {
      var tol = 0.0000001;
      Assert.floatEquals(Triangular.cdf(-1, 0, 8, 8), 0, tol);
      Assert.floatEquals(Triangular.cdf(0, 0, 8, 8), 0, tol);
      Assert.floatEquals(Triangular.cdf(4, 0, 8, 8), 0.25, tol);
      Assert.floatEquals(Triangular.cdf(8, 0, 8, 8), 1, tol);
      Assert.floatEquals(Triangular.cdf(10, 0, 8, 8), 1, tol);
    }
    //'check cdf calculation, when c < a': 
	public function test_cdf4() {
      var tol = 0.0000001; 
      Assert.isTrue(Math.isNaN(Triangular.cdf(6, 5, 10, 4)));
    }
    //'check cdf calculation, when b < c': 
	public function test_cdf5() {
      var tol = 0.0000001;
      Assert.isTrue(Math.isNaN(Triangular.cdf(30, 23, 47, 50)));
    }
	
    //'check cdf calculation, when a = b': 
	public function test_cdf6() {
      var tol = 0.0000001;
      Assert.isTrue(Math.isNaN(Triangular.cdf(-10, -10, -10, -10)));
    }
  

    // checked against R's qtriang(p, min=-1, mode=0, max=1, lower.tail=TRUE, log.p=FALSE) from package 'mc2d':
    //   install.packages("mc2d")
    //   library("mc2d")
    //   options(digits=10)
    //   qtriang(c(0, 0.25, 0.5, 0.75, 1), 1, 5, 11)
    //   qtriang(c(0, 0.5, 1), -5, -5, 5)
    //   qtriang(c(0, 0.5, 1), 0, 8, 8)
    //   qtriang(c(0, 0.5, 1), 5, 4, 10)
    //   qtriang(c(0, 0.5, 1), 23, 50, 47)
    //   qtriang(c(0, 0.5, 1), -10, -10, -10) # NOTE: This returns: [1] 1 1 1, but we don't allow a = b = c!
    //'check inv calculation, when a < c < b': 
	public function test_inv1() {
      var tol = 0.0000001;
      Assert.floatEquals(Triangular.inv(0, 1, 11, 5), 1, tol);
      Assert.floatEquals(Triangular.inv(0.25, 1, 11, 5), 4.162277660, tol);
      Assert.floatEquals(Triangular.inv(0.5, 1, 11, 5), 5.522774425, tol);
      Assert.floatEquals(Triangular.inv(0.75, 1, 11, 5), 7.127016654, tol);
      Assert.floatEquals(Triangular.inv(1, 1, 11, 5), 11, tol);
    }
    //'check inv calculation, when a = c < b': 
	public function test_inv2() {
      var tol = 0.0000001;
      Assert.floatEquals(Triangular.inv(0, -5, 5, -5), -5, tol);
      Assert.floatEquals(Triangular.inv(0.5, -5, 5, -5), -2.071067812, tol);
      Assert.floatEquals(Triangular.inv(1, -5, 5, -5), 5, tol);
    }
    //'check inv calculation, when a < c = b': 
	public function test_inv3() {
      var tol = 0.0000001;
      Assert.floatEquals(Triangular.inv(0, 0, 8, 8), 0, tol);
      Assert.floatEquals(Triangular.inv(0.5, 0, 8, 8), 5.656854249, tol);
      Assert.floatEquals(Triangular.inv(1, 0, 8, 8), 8, tol);
    }
    //'check inv calculation, when c < a': 
	public function test_inv4() {
      var tol = 0.0000001;
      Assert.isTrue(Math.isNaN(Triangular.inv(0, 5, 10, 4)));
      Assert.isTrue(Math.isNaN(Triangular.inv(0.5, 5, 10, 4)));
      Assert.isTrue(Math.isNaN(Triangular.inv(1, 5, 10, 4)));
    }
    //'check inv calculation, when b < c': 
	public function test_inv5() {
      var tol = 0.0000001;
      Assert.isTrue(Math.isNaN(Triangular.inv(0, 23, 47, 50)));
      Assert.isTrue(Math.isNaN(Triangular.inv(0.5, 23, 47, 50)));
      Assert.isTrue(Math.isNaN(Triangular.inv(1, 23, 47, 50)));
    }
    //'check inv calculation, when a = b': 
	public function test_in6() {
      var tol = 0.0000001;
      Assert.isTrue(Math.isNaN(Triangular.inv(0, -10, -10, -10)));
      Assert.isTrue(Math.isNaN(Triangular.inv(0.5, -10, -10, -10)));
      Assert.isTrue(Math.isNaN(Triangular.inv(1, -10, -10, -10)));
    }
	
}