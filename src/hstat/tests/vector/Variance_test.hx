package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Variance_test{
	public function new() { };

    public function test_return_basic_variance() {
      Assert.equals(Vector.variance([1, 2, 3, 4]), 1.25);
	}

    public function test_return_basic_variance_using_sample() {
      Assert.equals(Vector.variance([1, 2, 3, 4, 5], true), 2.5);
	}

  /*  public function test_variance_from_instance() {
      Assert.equals(jStat([1, 2, 3, 4]).variance(), 1.25);

    public function test_variance_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).variance(), [1, 1]);
    }

    public function test_topic() {
      jStat([1, 2, 3, 4]).variance(this.callback);

    public function test_variance_callback(val, stat) {
      Assert.equals(val, 1.25);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).variance(this.callback);

    public function test_variance_matrix_cols_callback(val, stat) {
      Assert.equals(val, [1, 1]);
    }*/
  
}