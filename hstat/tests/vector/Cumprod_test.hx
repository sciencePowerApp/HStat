package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Cumprod_test{
	public function new() { };

    public function test_return_basic_cumprod() {

      Assert.equals(Vector.cumprod([[1, 2, 3]])[0].toString(), [1, 2, 6].toString());
	}
	  
/*
    public function test_cumprod_from_instance() {
      Assert.equals(jStat([1, 2, 3]).cumprod(), [1, 2, 6]);
	}

    public function test_cumprod_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).cumprod(), [[1, 3], [2, 8]]);

    public function test_cumprod_matrix_rows() {
      Assert.equals(jStat([[1, 2], [3, 4]]).cumprod(true), [[1, 2], [3, 12]]);
    }

    public function test_topic() {
      jStat([1, 2, 3]).cumprod(this.callback);
	}

    public function test_cumprod_callback(val, stat) {
      Assert.equals(val, [1, 2, 6]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).cumprod(this.callback);

    public function test_cumprod_matrix_cols_callback(val, stat) {
      Assert.equals(val, [[1, 3], [2, 8]]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).cumprod(true, this.callback);

    public function test_cumprod_matrix_rows_callback(val, stat) {
      Assert.equals(val, [[1, 2], [3, 12]]);
    }
  */
}