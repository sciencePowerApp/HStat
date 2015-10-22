package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Sum_test{
    public function test_return_basic_sum() {
      Assert.equals(Vector.sum([1, 2, 3]), 6);

    public function test_sum_from_instance() {
      Assert.equals(jStat([1, 2, 3]).sum(), 6);

    public function test_sum_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).sum(), [4, 6]);

    public function test_sum_full_matrix() {
      Assert.equals(jStat([[1, 2], [3, 4]]).sum(true), 10);
    }

    public function test_topic() {
      jStat([1, 2, 3]).sum(this.callback);

    public function test_sum_callback(val, stat) {
      Assert.equals(val, 6);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).sum(this.callback);

    public function test_sum_matrix_cols_callback(val, stat) {
      Assert.equals(val, [4, 6]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).sum(true, this.callback);

    public function test_sum_full_matrix_callback(val, stat) {
      Assert.equals(val, 10);
    }
  
}