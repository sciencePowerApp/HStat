package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Meansqerr_test{
    public function test_return_basic_meansqerr() {
      Assert.equals(Vector.meansqerr([1, 2, 3, 4]), 1.25);

    public function test_meansqerr_from_instance() {
      Assert.equals(jStat([1, 2, 3, 4]).meansqerr(), 1.25);

    public function test_meansqerr_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).meansqerr(), [1, 1]);
    }

    public function test_topic() {
      jStat([1, 2, 3, 4]).meansqerr(this.callback);

    public function test_meansqerr_callback(val, stat) {
      Assert.equals(val, 1.25);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).meansqerr(this.callback);

    public function test_meansqerr_matrix_cols_callback(val, stat) {
      Assert.equals(val, [1, 1]);
    }
  
}