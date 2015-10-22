package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Cumsum_test{
    public function test_return_basic_cumsum() {
      Assert.equals(Vector.cumsum([1, 2, 3]), [1, 3, 6]);

    public function test_cumsum_from_instance() {
      Assert.equals(jStat([1, 2, 3]).cumsum(), [1, 3, 6]);

    public function test_cumsum_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).cumsum(), [[1, 4], [2, 6]]);

    public function test_cumsum_matrix_rows() {
      Assert.equals(jStat([[1, 2], [3, 4]]).cumsum(true), [[1, 3], [3, 7]]);
    }

    public function test_topic() {
      jStat([1, 2, 3]).cumsum(this.callback);

    public function test_cumsum_callback(val, stat) {
      Assert.equals(val, [1, 3, 6]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).cumsum(this.callback);

    public function test_cumsum_matrix_cols_callback(val, stat) {
      Assert.equals(val, [[1, 4], [2, 6]]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).cumsum(true, this.callback);

    public function test_cumsum_matrix_rows_callback(val, stat) {
      Assert.equals(val, [[1, 3], [3, 7]]);
    }
  
}