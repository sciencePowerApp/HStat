package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Stdev_test{
    public function test_return_basic_stdev() {
      Assert.equals(Vector.stdev([1, 2, 3, 4]), 1.118033988749895);

    public function test_return_basic_stdev_using_sample() {
      Assert.equals(Vector.stdev([1, 2, 3, 4, 5], true), 1.5811388300841898);

    public function test_stdev_from_instance() {
      Assert.equals(jStat([1, 2, 3, 4]).stdev(), 1.118033988749895);

    public function test_stdev_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).stdev(), [1, 1]);
    }

    public function test_topic() {
      jStat([1, 2, 3, 4]).stdev(this.callback);

    public function test_stdev_callback(val, stat) {
      Assert.equals(val, 1.118033988749895);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).stdev(this.callback);

    public function test_stdev_matrix_cols_callback(val, stat) {
      Assert.equals(val, [1, 1]);
    }
  
}