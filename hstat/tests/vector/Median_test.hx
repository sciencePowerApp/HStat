package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Median_test{
	public function new() { };

    public function test_return_basic_median() {
      Assert.equals(Vector.median([[1, 2, 3]]), 2);
	}

    /*public function test_median_from_instance() {
      Assert.equals(jStat([1, 2, 3]).median(), 2);

    public function test_median_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).median(), [2, 3]);

    public function test_median_full_matrix() {
      Assert.equals(jStat([[1, 2], [3, 4]]).median(true), 2.5);
    }

    public function test_topic() {
      jStat([1, 2, 3]).median(this.callback);

    public function test_median_callback(val, stat) {
      Assert.equals(val, 2);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).median(this.callback);

    public function test_median_matrix_cols_callback(val, stat) {
      Assert.equals(val, [2, 3]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).median(true, this.callback);

    public function test_median_full_matrix_callback(val, stat) {
      Assert.equals(val, 2.5);
    }*/
  
}