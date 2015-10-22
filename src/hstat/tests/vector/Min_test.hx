package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Min_test{
    public function test_return_basic_min() {
      Assert.equals(Vector.min([1, 2, 3]), 1);

    public function test_min_from_instance() {
      Assert.equals(jStat([1, 2, 3]).min(), 1);

    public function test_min_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).min(), [1, 2]);

    public function test_min_full_matrix() {
      Assert.equals(jStat([[1, 2], [3, 4]]).min(true), 1);
    }

    public function test_topic() {
      jStat([1, 2, 3]).min(this.callback);

    public function test_min_callback(val, stat) {
      Assert.equals(val, 1);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).min(this.callback);

    public function test_min_matrix_cols_callback(val, stat) {
      Assert.equals(val, [1, 2]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).min(true, this.callback);

    public function test_min_full_matrix_callback(val, stat) {
      Assert.equals(val, 1);
    }
  
}