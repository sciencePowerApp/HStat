package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Mean_test{
	public function new() { };

    public function test_return_basic_mean() {
      Assert.equals(Vector.mean([[1, 2, 3]]), 2);
	}

   /* public function test_mean_from_instance() {
      Assert.equals(jStat([1, 2, 3]).mean(), 2);

    public function test_mean_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).mean(), [2, 3]);

    public function test_mean_full_matrix() {
      Assert.equals(jStat([[1, 2], [3, 4]]).mean(true), 2.5);
    }

    public function test_topic() {
      jStat([1, 2, 3]).mean(this.callback);

    public function test_mean_callback(val, stat) {
      Assert.equals(val, 2);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).mean(this.callback);

    public function test_mean_matrix_cols_callback(val, stat) {
      Assert.equals(val, [2, 3]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).mean(true, this.callback);

    public function test_mean_full_matrix_callback(val, stat) {
      Assert.equals(val, 2.5);
    }*/
  
}