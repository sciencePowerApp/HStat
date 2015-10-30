package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Sumrow_test{
	public function new() { };

    public function test_return_basic_sumrow() {
      Assert.equals(Vector.sumrow([[1, 2, 3]]), 6);
	}

    /*public function test_sumrow_from_instance() {
      Assert.equals(jStat([1, 2, 3]).sumrow(), 6);

    public function test_sumrow_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).sumrow(), [3, 7]);

    public function test_sumrow_full_matrix() {
      Assert.equals(jStat([[1, 2], [3, 4]]).sumrow(true), 10);
    }

    public function test_topic() {
      jStat([1, 2, 3]).sumrow(this.callback);

    public function test_sumrow_callback(val, stat) {
      Assert.equals(val, 6);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).sumrow(this.callback);

    public function test_sumrow_matrix_cols_callback(val, stat) {
      Assert.equals(val, [3, 7]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).sumrow(true, this.callback);

    public function test_sumrow_full_matrix_callback(val, stat) {
      Assert.equals(val, 10);
    }*/
  
}