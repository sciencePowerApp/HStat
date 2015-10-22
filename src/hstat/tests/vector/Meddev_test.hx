package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Meddev_test{
    public function test_return_basic_meddev() {
      Assert.equals(Vector.meddev([1, 2, 3, 4]), 1);

    public function test_meddev_from_instance() {
      Assert.equals(jStat([1, 2, 3, 4]).meddev(), 1);

    public function test_meddev_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).meddev(), [1, 1]);
    }

    public function test_topic() {
      jStat([1, 2, 3, 4]).meddev(this.callback);

    public function test_meddev_callback(val, stat) {
      Assert.equals(val, 1);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).meddev(this.callback);

    public function test_meddev_matrix_cols_callback(val, stat) {
      Assert.equals(val, [1, 1]);
    }
  
}