package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Skewness_test{
	public function new() { };

    public function test_returns_accurate_skewness_value() {
      // from normal distribution in R: > rnorm(12); skewness(set) => -0.03270
      var set =
          [-0.28157961, -0.75577350,  0.61554139,  0.26864022, -0.42703435,
           -0.99927791, -0.07113527, -1.39327183,  0.34871138,  1.17909042,
           -0.22951562,  0.22341714];
      var skew = Vector.skewness(set);

      Assert.isTrue(skew > -0.03271);
      Assert.isTrue(skew < -0.03269);
	}

  /*  public function test_skewness_from_instance() {
      var set =
          [-0.28157961, -0.75577350,  0.61554139,  0.26864022, -0.42703435,
           -0.99927791, -0.07113527, -1.39327183,  0.34871138,  1.17909042,
           -0.22951562,  0.22341714];
      var skew = jStat(set).skewness();

      assert.isTrue(skew > -0.03271);
      assert.isTrue(skew < -0.03269);*/
    
  
}