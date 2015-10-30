package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Covariance_test{
	public function new() { };

    public function test_return_basic_covariance() {
      Assert.equals(Vector.covariance([[1, 2, 3, 4]], [[4, 5, 6, 7]]),
                   1.6666666666666667);
    }
  
}