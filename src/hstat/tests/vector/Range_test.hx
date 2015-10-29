package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Range_test{
	public function new() { };

    public function test_return_basic_range() {
      Assert.equals(Vector.range([[1, 2, 3]]), 2);
	}

   /* public function test_range_from_instance() {
      Assert.equals(jStat([1, 2, 3]).range(), 2);

    public function test_range_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).range(), [2, 2]);
    }

    public function test_topic() {
      jStat([1, 2, 3]).range(this.callback);

    public function test_range_callback(val, stat) {
      Assert.equals(val, 2);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).range(this.callback);

    public function test_range_matrix_cols_callback(val, stat) {
      Assert.equals(val, [2, 2]);
    }*/
  
}