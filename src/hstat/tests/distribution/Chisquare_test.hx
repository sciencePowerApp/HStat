package hstat.tests.distribution;
import hstat.Distribution.Chisquare;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Chisquare_test
{

	public function new() { }

	//Checked against R dchisq(x,df)
    public function test_pdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Chisquare.pdf(3.5, 10), 0.03395437);
    }
	
    // Checked against R dchisq(x,df)
    //   dchisq(0, 5)
    //   dchisq(0, 2)
    //   dchisq(0, 1)
    public function test_pdf_at_0() {
      var tol = 0.0000001;
	  
      Assert.floatEquals(Chisquare.pdf(0.0, 5), 0.0,tol);
      Assert.floatEquals(Chisquare.pdf(0.0, 2), 0.5,tol);
      Assert.equals(Chisquare.pdf(0.0, 1), Math.POSITIVE_INFINITY);
    }
	
    public function test_pdf_less_than_0() {
      var tol = 0.0000001;
      Assert.floatEquals(Chisquare.pdf(-10, 8), 0.0,tol);
    }
	
    //Checked against R's pchisq(x, df)
    public function test_cdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Chisquare.cdf(2.5, 8), 0.03826905,tol);
    }
	
    // Checked against R's pchisq(q, df, ncp = 0, lower.tail = TRUE, log.p = FALSE):
    //    pchisq(-5, 21)
	public function test_cdf_x_less_than_0() {
      var tol = 0.0000001;
      Assert.floatEquals(Chisquare.cdf(-5, 21), 0,tol);
    }
	
    //Checked against R's qchisq(x, df)
    public function test_qchisq(){
      var tol = 0.00001;
      Assert.floatEquals(Chisquare.inv(0.95, 10), 18.30704,tol);
      Assert.floatEquals(Chisquare.inv(0.85, 10), 14.53394,tol);
    }
	
}