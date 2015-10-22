package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Sumsqerr_test{
    public function test_return_basic_sumsqerr() {
      Assert.equals(Vector.sumsqerr([1, 2, 3]), 2);

    public function test_sumsqerr_from_instance() {
      Assert.equals(jStat([1, 2, 3]).sumsqerr(), 2);

    public function test_sumsqerr_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).sumsqerr(), [2, 2]);
    }

    public function test_topic() {
      jStat([1, 2, 3]).sumsqerr(this.callback);

    public function test_sumsqerr_callback(val, stat) {
      Assert.equals(val, 2);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).sumsqerr(this.callback);

    public function test_sumsqerr_matrix_cols_callback(val, stat) {
      Assert.equals(val, [2, 2]);
    }
  
}