package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Mode_test{
    public function test_return_basic_mode() {
      Assert.equals(Vector.mode([1, 2, 3, 3]), 3);

    public function test_mode_from_instance() {
      Assert.equals(jStat([1, 2, 3, 3]).mode(), 3);

    public function test_mode_matrix_cols() {
      Assert.equals(jStat([[1, 2], [1, 4]]).mode(), [1, [2, 4]]);
    }

    public function test_topic() {
      jStat([1, 2, 3, 3]).mode(this.callback);

    public function test_mode_callback(val, stat) {
      Assert.equals(val, 3);
    }

    public function test_topic() {
      jStat([[1, 2], [1, 4]]).mode(this.callback);

    public function test_mode_matrix_cols_callback(val, stat) {
      Assert.equals(val, [1, [2, 4]]);


    public function test_topic() {
      
}