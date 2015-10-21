package hstat.tests.distribution;
import hstat.Distribution.Studentt;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Student_t_test
{

	public function new() { }

	public function test_pdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Studentt.pdf(0.5, 40), 0.3489195, tol);
      Assert.floatEquals(Studentt.pdf(-1.0, 20), 0.2360456, tol);
    }
	
	public function test_large_pdf() {
      var tol = 0.0000001;
      Assert.floatEquals(Studentt.pdf(0.45, 400), 0.3602198, tol);
      Assert.floatEquals(Studentt.pdf(2.95, 525), 0.005283244, tol);
    }
    //Checked against R's pt(x, df)
	public function test_cdf() {
      var tol = 0.0000001;
      var x = 0.5;
      var df = 40;
      Assert.floatEquals(Studentt.cdf(x, df), 0.6900926, tol);
    }
	
    //Checked against R's qt(x, df)
	public function test_inv() {
      var tol = 0.0000001;
      Assert.floatEquals(Studentt.inv(0.5, 40), 0, tol);
      Assert.floatEquals(Studentt.inv(0.7, 20), 0.5328628, tol);
      Assert.floatEquals(Studentt.inv(0.2, 10), -0.8790578, tol);
    }
	
}