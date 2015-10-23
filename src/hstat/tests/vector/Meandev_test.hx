package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Meandev_test{
	public function new() { };

    public function test_return_basic_meandev() {
		Assert.equals(Vector.meandev([1, 2, 3, 4]),1);
	}

/*    public function test_meandev_from_instance() {
      Assert.equals(jStat([1, 2, 3, 4]).meandev(), 1);
	}

    public function test_meandev_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).meandev(), [1, 1]);
    }

    public function test_topic() {
      jStat([1, 2, 3, 4]).meandev(this.callback);
	}

    public function test_meandev_callback(val, stat) {
      Assert.equals(val, 1);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).meandev(this.callback);
	}

    public function test_meandev_matrix_cols_callback(val, stat) {
      Assert.equals(val, [1, 1]);
    }*/
  
}