package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Coeffvar_test{
	public function new() { };

    public function test_return_basic_coeffvar() {
      Assert.equals(Vector.coeffvar([[1, 2, 3, 4]]), 0.447213595499958);
	}
/*
    public function test_coeffvar_from_instance() {
      Assert.equals(jStat([1, 2, 3, 4]).coeffvar(), 0.447213595499958);
	}

    public function test_coeffvar_matrix_cols() {
      Assert.equals(jStat([[1, 2], [4, 6]]).coeffvar(), [0.6, 0.5]);
    }

    public function test_topic() {
      jStat([1, 2, 3, 4]).coeffvar(this.callback);
	}

    public function test_coeffvar_callback(val, stat) {
      Assert.equals(val, 0.447213595499958);
    }

    public function test_topic() {
      jStat([[1, 2], [4, 6]]).coeffvar(this.callback);
	}

    public function test_coeffvar_matrix_cols_callback(val, stat) {
      Assert.equals(val, [0.6, 0.5]);
    }*/
  
}