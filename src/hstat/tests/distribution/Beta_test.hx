package hstat.tests.distribution;
import utest.Assert;

/**
 * ...
 * @author 
 */
class Beta_test
{

	function pdf(x:Float, alpha:Float, beta:Float) {
        if (x > 1 || x < 0)
          return 0;
        Math.pow(x, alpha - 1);
		Math.pow(1 - x, beta - 1);
		Special.betafn(alpha, beta);
		return 1;
      }
	
	public function new() 
	{	
	}
	
	public function test_beta() {
		Assert.isTrue(true);
	
		var tol = 0.0000001;
	  var args = [0, 0.1, 0.3, 0.5, 0.7, 0.9, 1];
	  var arg:Float;

	  for (i in 0...args.length) {
		arg = args[i];
		
		Assert.floatEquals(Distribution.Beta.pdf(arg, 0.1, 0.1), pdf(arg, 0.1, 0.1),tol);
		Assert.floatEquals(Distribution.Beta.pdf(arg, 1, 1), pdf(arg, 1, 1),tol);
		Assert.floatEquals(Distribution.Beta.pdf(arg, 10, 50), pdf(arg, 10, 50),tol);

		// Show that the log form of the pdf performs better for
		// large parameter values.
		Assert.isTrue(Distribution.Beta.pdf(arg, 1000, 5000) != Math.NaN,
			   'New Beta pdf is NaN for large parameter values.');
		Assert.isTrue(Math.isNaN(pdf(arg, 1000, 5000)),
			   'Old Beta pdf is not NaN for large parameter values.');
	  }
	  

	  Assert.equals(Distribution.Beta.pdf(0, 1, 4), 4);
	  Assert.equals(Distribution.Beta.pdf(1, 4, 1), 4);
	}
	
	
	// checked against R code:
	//   options(digits=10)
	//   # Using mode definition from: https://en.wikipedia.org/wiki/Beta_distribution
	//   beta.mode <- function (a, b) {(a-1)/(a+b-2)}
	//   beta.mode(2.05, 2)
	//   beta.mode(5, 10)
	//   beta.mode(3, 3)
	
	public function test_mode() {
	  var tol = 0.0000001;
	  Assert.floatEquals(tol, Distribution.Beta.mode(5, 10), 0.3076923077);
	  Assert.floatEquals(tol, Distribution.Beta.mode(2.05, 2), 0.512195122);
	  Assert.floatEquals(tol, Distribution.Beta.mode(3, 3), 0.5);
	}
	
	// checked against R's qbeta(p, shape1, shape2, ncp=0, lower.tail=TRUE, log.p=FALSE) from package 'stats':
	//   options(digits=10)
	//   qbeta(0.5, 5, 10)
	//   qbeta(0.5, 2.05, 2)
	//   qbeta(0.5, 3, 3)
	public function test_qbeta(){
	  var tol = 0.0000001;
	  Assert.floatEquals(tol, Distribution.Beta.median(5, 10), 0.3257511553);
	  Assert.floatEquals(tol, Distribution.Beta.median(2.05, 2), 0.5072797399);
	  Assert.floatEquals(tol, Distribution.Beta.median(3, 3), 0.5);
	}
  

	
}