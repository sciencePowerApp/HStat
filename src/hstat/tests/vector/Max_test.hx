package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Max_test{
	public function new() { };

    public function test_return_basic_max() {
      Assert.equals(Vector.max([[1, 2, 3]]), 3);
	}

  /*  public function test_max_from_instance() {
      Assert.equals(jStat([1, 2, 3]).max(), 3);

    public function test_max_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).max(), [3, 4]);

    public function test_max_full_matrix() {
      Assert.equals(jStat([[1, 2], [3, 4]]).max(true), 4);
    }

    public function test_topic() {
      jStat([1, 2, 3]).max(this.callback);
	}

    public function test_max_callback(val, stat) {
      Assert.equals(val, 3);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).max(this.callback);

    public function test_max_matrix_cols_callback(val, stat) {
      Assert.equals(val, [3, 4]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).max(true, this.callback);

    public function test_max_full_matrix_callback(val, stat) {
      Assert.equals(val, 4);
    }
  */
}