package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Diff_test{
	public function new() { };

    public function test_return_basic_diff() {
      Assert.equals(Vector.diff([[1, 2, 3]])[0].toString(), [1, 1].toString());
	}  
	  
/*	public function test_diff_from_instance() {
      Assert.equals(jStat([1, 2, 3]).diff(), [1, 1]);
	}

    public function test_diff_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).diff(), [[2], [2]]);
    }

    public function test_topic() {
      jStat([1, 2, 3]).diff(this.callback);
	}

    public function test_diff_callback(val, stat) {
      Assert.equals(val, [1, 1]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).diff(this.callback);
	}

    public function test_diff_matrix_cols_callback(val, stat) {
      Assert.equals(val, [[2], [2]]);
    }*/
  
}