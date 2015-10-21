package hstat.tests.distribution;
import hstat.Distribution.Kumaraswamy;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Kumaraswamy_test
{

	public function new() {}
	


    // Checked against R's dkumar(p, shape1, shape2, log=FALSE) in package VGAM
    //   install.packages("VGAM")
    //   library("VGAM")
    //   options(digits=10)
    //   dkumar(c(-5, 5), 2, 2)
public function test_pdf() {
      var tol = 0.0000001;
      // outside support
      Assert.floatEquals(Kumaraswamy.pdf(-5, 2, 2), 0, tol);
      Assert.floatEquals(Kumaraswamy.pdf(5, 2, 2), 0, tol);
    }
  

    // Checked against R's
    // qkumar(p, shape1, shape2, lower.tail=TRUE, log.p=FALSE) in package VGAM
    //   install.packages("VGAM")
    //   library("VGAM")
    //   options(digits=10)
    //   qkumar(c(0, 0.5, 1), 0.5, 0.5)
    //   qkumar(c(0, 0.5, 1), 0.8, 1)
    //   qkumar(c(0, 0.5, 1), 1, 0.4)
    //   qkumar(c(0, 0.5, 1), 0.6, 1.2)
    //   qkumar(c(0, 0.5, 1), 1, 1)
    //   qkumar(c(0, 0.5, 1), 2, 1)
    //   qkumar(c(0, 0.5, 1), 1.5, 1.5)
    //   qkumar(c(0, 0.5, 1), 7, 25)
public function test_inv() {
      var tol = 0.0000001;
      // 'U'-shaped distribution
      Assert.floatEquals(Kumaraswamy.inv(0, 0.5, 0.5), 0, tol);
      Assert.floatEquals(Kumaraswamy.inv(0.5, 0.5, 0.5), 0.5625, tol);
      Assert.floatEquals(Kumaraswamy.inv(1, 0.5, 0.5), 1, tol);

      // 'L'-shaped distribution
      Assert.floatEquals(Kumaraswamy.inv(0, 0.8, 1), 0, tol);
      Assert.floatEquals(Kumaraswamy.inv(0.5, 0.8, 1), 0.4204482076, tol);
      Assert.floatEquals(Kumaraswamy.inv(1, 0.8, 1), 1, tol);

      // reversed-'L'-shaped distribution
      Assert.floatEquals(Kumaraswamy.inv(0, 1, 0.4), 0, tol);
      Assert.floatEquals(Kumaraswamy.inv(0.5, 1, 0.4), 0.8232233047, tol);
      Assert.floatEquals(Kumaraswamy.inv(1, 1, 0.4), 1, tol);

      // sideways-'S'-shaped distribution
      Assert.floatEquals(Kumaraswamy.inv(0, 0.6, 1.2), 0, tol);
      Assert.floatEquals(Kumaraswamy.inv(0.5, 0.6, 1.2), 0.2533532737, tol);
      Assert.floatEquals(Kumaraswamy.inv(1, 0.6, 1.2), 1, tol);

      // flat distribution
      Assert.floatEquals(Kumaraswamy.inv(0, 1, 1), 0, tol);
      Assert.floatEquals(Kumaraswamy.inv(0.5, 1, 1), 0.5, tol);
      Assert.floatEquals(Kumaraswamy.inv(1, 1, 1), 1, tol);

      // '/'-shaped distribution
      Assert.floatEquals(Kumaraswamy.inv(0, 2, 1), 0, tol);
      Assert.floatEquals(Kumaraswamy.inv(0.5, 2, 1), 0.7071067812, tol);
      Assert.floatEquals(Kumaraswamy.inv(1, 2, 1), 1, tol);

      // inverted-'U'-shaped distribution
      Assert.floatEquals(Kumaraswamy.inv(0, 1.5, 1.5), 0, tol);
      Assert.floatEquals(Kumaraswamy.inv(0.5, 1.5, 1.5), 0.5154248709, tol);
      Assert.floatEquals(Kumaraswamy.inv(1, 1.5, 1.5), 1, tol);

      // peaked distribution
      Assert.floatEquals(Kumaraswamy.inv(0, 7, 25), 0, tol);
      Assert.floatEquals(Kumaraswamy.inv(0.5, 7, 25), 0.5979941923, tol);
      Assert.floatEquals(Kumaraswamy.inv(1, 7, 25), 1, tol);
    }
  


    // Checked against R's dkumar(p, shape1, shape2, log=FALSE) in package VGAM
    //   install.packages("VGAM")
    //   library("VGAM")
    //   options(digits=10)
    //   dkumar(c(0, 0.5, 1), 0.5, 0.5)
    //   dkumar(c(0, 0.5, 1), 0.8, 1) # Note: Incorrectly returns NaN for x = 1!
    //   dkumar(c(0, 0.5, 1), 1, 0.4) # Note: Incorrectly returns NaN for x = 0!
    //   dkumar(c(0, 0.5, 1), 0.6, 1.2)
    //   dkumar(c(0, 0.5, 1), 1.3, 0.5)
    //   dkumar(c(0, 0.5, 1), 1, 1) # Note: Incorrectly returns NaN for x = 0 and x = 1!
    //   dkumar(c(0, 0.5, 1), 2, 1) # Note: Incorrectly returns NaN for x = 1!
    //   dkumar(c(0, 0.5, 1), 1, 1.5) # Note: Incorrectly returns NaN for x = 0!
    //   dkumar(c(0, 0.5, 1), 1.5, 1.5)
    //   dkumar(c(0, 0.5, 1), 7, 25)
public function test_pdf2() {
      var tol = 0.0000001;
      // 'U'-shaped distribution
      Assert.equals(Kumaraswamy.pdf(0, 0.5, 0.5), Math.POSITIVE_INFINITY);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 0.5, 0.5), 0.6532814824, tol);
      Assert.equals(Kumaraswamy.pdf(1, 0.5, 0.5), Math.POSITIVE_INFINITY);

      // 'L'-shaped distribution
      Assert.equals(Kumaraswamy.pdf(0, 0.8, 1), Math.POSITIVE_INFINITY);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 0.8, 1), 0.918958684, tol);
      Assert.floatEquals(Kumaraswamy.pdf(1, 0.8, 1), 0.8, tol);

      // reversed-'L'-shaped distribution
      Assert.floatEquals(Kumaraswamy.pdf(0, 1, 0.4), 0.4, tol);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 1, 0.4), 0.6062866266, tol);
      Assert.equals(Kumaraswamy.pdf(1, 1, 0.4), Math.POSITIVE_INFINITY);

      // sideways-'S'-shaped distribution
      Assert.equals(Kumaraswamy.pdf(0, 0.6, 1.2), Math.POSITIVE_INFINITY);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 0.6, 1.2), 0.7657783992, tol);
      Assert.floatEquals(Kumaraswamy.pdf(1, 0.6, 1.2), 0, tol);

      // sideways-'Z'-shaped distribution
      Assert.floatEquals(Kumaraswamy.pdf(0, 1.3, 0.5), 0, tol);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 1.3, 0.5), 0.6851052165, tol);
      Assert.equals(Kumaraswamy.pdf(1, 1.3, 0.5), Math.POSITIVE_INFINITY);

      // flat distribution
      Assert.floatEquals(Kumaraswamy.pdf(0, 1, 1), 1, tol);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 1, 1), 1, tol);
      Assert.floatEquals(Kumaraswamy.pdf(1, 1, 1), 1, tol);

      // '/'-shaped distribution
      Assert.floatEquals(Kumaraswamy.pdf(0, 2, 1), 0, tol);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 2, 1), 1, tol);
      Assert.floatEquals(Kumaraswamy.pdf(1, 2, 1), 2, tol);

      // '\'-shaped distribution
      Assert.floatEquals(Kumaraswamy.pdf(0, 1, 1.5), 1.5, tol);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 1, 1.5), 1.060660172, tol);
      Assert.floatEquals(Kumaraswamy.pdf(1, 1, 1.5), 0, tol);

      // inverted-'U'-shaped distribution
      Assert.floatEquals(Kumaraswamy.pdf(0, 1.5, 1.5), 0, tol);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 1.5, 1.5), 1.279186452, tol);
      Assert.floatEquals(Kumaraswamy.pdf(1, 1.5, 1.5), 0, tol);

      // peaked distribution
      Assert.floatEquals(Kumaraswamy.pdf(0, 7, 25), 0, tol);
      Assert.floatEquals(Kumaraswamy.pdf(0.5, 7, 25), 2.265208101, tol);
      Assert.floatEquals(Kumaraswamy.pdf(1, 7, 25), 0, tol);
    }


    // Checked against R's pkumar(q, shape1, shape2, lower.tail = TRUE, log.p = FALSE) in package VGAM
    //   install.packages("VGAM")
    //   library("VGAM")
    //   options(digits=10)
    //   pkumar(c(0, 0.5, 1), 0.5, 0.5)
    //   pkumar(c(0, 0.5, 1), 0.8, 1) # Note: Incorrectly returns NaN for x = 1!
    //   pkumar(c(0, 0.5, 1), 1, 0.4) # Note: Incorrectly returns NaN for x = 0!
    //   pkumar(c(0, 0.5, 1), 0.6, 1.2)
    //   pkumar(c(0, 0.5, 1), 1.3, 0.5)
    //   pkumar(c(0, 0.5, 1), 1, 1) # Note: Incorrectly returns NaN for x = 0 and x = 1!
    //   pkumar(c(0, 0.5, 1), 2, 1) # Note: Incorrectly returns NaN for x = 1!
    //   pkumar(c(0, 0.5, 1), 1, 1.5) # Note: Incorrectly returns NaN for x = 0!
    //   pkumar(c(0, 0.5, 1), 1.5, 1.5)
    //   pkumar(c(0, 0.5, 1), 7, 25)
	//	 pkumar(c(-5, 5), 2, 2)
public function test_cdf() {
      var tol = 0.0000001;
      // 'U'-shaped distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 0.5, 0.5), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 0.5, 0.5), 0.4588038999, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 0.5, 0.5), 1, tol);

      // 'L'-shaped distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 0.8, 1), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 0.8, 1), 0.5743491775, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 0.8, 1), 1, tol);
      
      // reversed-'L'-shaped distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 1, 0.4), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 1, 0.4), 0.2421417167, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 1, 0.4), 1, tol);

      // sideways-'S'-shaped distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 0.6, 1.2), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 0.6, 1.2), 0.7257468009, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 0.6, 1.2), 1, tol);

      // sideways-'Z'-shaped distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 1.3, 0.5), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 1.3, 0.5), 0.2293679206, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 1.3, 0.5), 1, tol);

      // flat distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 1, 1), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 1, 1), 0.5, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 1, 1), 1, tol);

      // '/'-shaped distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 2, 1), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 2, 1), 0.25, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 2, 1), 1, tol);

      // '\'-shaped distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 1, 1.5), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 1, 1.5), 0.6464466094, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 1, 1.5), 1, tol);

      // inverted-'U'-shaped distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 1.5, 1.5), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 1.5, 1.5), 0.4802446206, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 1.5, 1.5), 1, tol);

      // peaked distribution
      Assert.floatEquals(Kumaraswamy.cdf(0, 7, 25), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(0.5, 7, 25), 0.1780530605, tol);
      Assert.floatEquals(Kumaraswamy.cdf(1, 7, 25), 1, tol);

      // outside support
      Assert.floatEquals(Kumaraswamy.cdf(-5, 2, 2), 0, tol);
      Assert.floatEquals(Kumaraswamy.cdf(5, 2, 2), 1, tol);
    }
  
	
}