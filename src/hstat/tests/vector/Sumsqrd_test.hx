package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Sumsqrd_test{
	public function new() { };

    public function test_return_basic_sumsqrd() {
      Assert.equals(Vector.sumsqrd([[1, 2, 3]]), 14);
	}

    /*public function test_sumsqrd_from_instance() {
      Assert.equals(jStat([1, 2, 3]).sumsqrd(), 14);

    public function test_sumsqrd_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).sumsqrd(), [10, 20]);

    public function test_sumsqrd_full_matrix() {
      Assert.equals(jStat([[1, 2], [3, 4]]).sumsqrd(true), 650);
    }

    public function test_topic() {
      jStat([1, 2, 3]).sumsqrd(this.callback);

    public function test_sumsqrd_callback(val, stat) {
      Assert.equals(val, 14);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).sumsqrd(this.callback);

    public function test_sumsqrd_matrix_cols_callback(val, stat) {
      Assert.equals(val, [10, 20]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).sumsqrd(true, this.callback);

    public function test_sumsqrd_full_matrix_callback(val, stat) {
      Assert.equals(val, 650);
    }
  */
}