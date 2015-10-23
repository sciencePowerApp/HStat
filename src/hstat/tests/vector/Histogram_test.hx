package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Histogram_test{
	public function new() { };

    public function test_returns_histogram() {
      Assert.equals(
          Vector.histogram([1, 1, 2, 2, 3, 4, 5, 5, 6, 7, 8],4).toString(), [4, 2, 3, 2].toString());
	}

    /*public function test_histogram_from_instance() {
      Assert.equals(
          jStat([1, 1, 2, 2, 3, 4, 5, 5, 6, 7, 8]).histogram(), [4, 2, 3, 2]);
	}

    public function test_histogram_with_numBins_parameter() {
      Assert.equals(
          jStat([1, 1, 2, 2, 3, 4, 5, 5, 6, 7, 8, 10]).histogram(10),
          [2, 2, 1, 1, 2, 1, 1, 1, 0, 1]);
	}
		  
    public function test_histogram_with_floating_point_values() {
      Assert.equals(
          jStat([0.1, 0.1, 0.3, 0.5]).histogram(3), [2, 1, 1]);
	}*/

    public function test_documentation_values() {
      Assert.equals(Vector.histogram([100, 101, 102, 230, 304, 305, 400], 3).toString(), [3, 1, 3].toString());
    }
  
}