package hstat.tests.distribution;
import hstat.Distribution.Noncentralt;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Noncentralt_test
{

	public function new() 
	{
	}
	
function test_cdf() {
      var tol = 0.0000001;
        Assert.floatEquals(Noncentralt.cdf(-0.5, 3, 2), 0.007800301076444027, tol);
        Assert.floatEquals(Noncentralt.cdf(0.5, 3, 2), 0.06547898556460677, tol);
        Assert.floatEquals(Noncentralt.cdf(7, 3, 2), 0.9527511310481739, tol);

        Assert.floatEquals(Noncentralt.cdf(23, 8, 25), 0.3084615014611897, tol);
        Assert.floatEquals(Noncentralt.cdf(30, 8, 25), 0.695466162732754, tol);

        Assert.floatEquals(Noncentralt.cdf(2, 28, 5), 0.001787373536766708, tol);
        Assert.floatEquals(Noncentralt.cdf(8, 28, 5), 0.9790186262147481, tol);
    }
	
    //Checked against R's dt(x, df, ncp)
function test_pdf() {
      var tol = 0.0000001;
        Assert.floatEquals(Noncentralt.pdf(-0.5, 3, 2), 0.0159905834194889, tol);
        Assert.floatEquals(Noncentralt.pdf(0.5, 3, 2), 0.1296653879954894, tol);
        Assert.floatEquals(Noncentralt.pdf(7, 3, 2), 0.01796331192039574, tol);

        Assert.floatEquals(Noncentralt.pdf(23, 8, 25), 0.06329514733502346, tol);
        Assert.floatEquals(Noncentralt.pdf(30, 8, 25), 0.04088472607966773, tol);

        Assert.floatEquals(Noncentralt.pdf(2, 28, 5), 0.006044279465609167, tol);
        Assert.floatEquals(Noncentralt.pdf(8, 28, 5), 0.02883829067311495, tol);

    }
	
}