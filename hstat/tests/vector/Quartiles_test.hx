package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Quartiles_test{
	public function new() { };

    public function test_return_basic_quartiles() {
      Assert.equals(Vector.quartiles([[1, 2, 3, 4, 5, 6]])[0].toString(), [2, 3, 5].toString());
	}

    /*public function test_quartiles_from_instance() {
      Assert.equals(jStat([1, 2, 3, 4, 5, 6]).quartiles(), [2, 3, 5]);

    public function test_quartiles_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4], [5, 6]]).quartiles(),
                       [[1, 3, 3], [2, 4, 4]]);
    }

    public function test_topic() {
      jStat([1, 2, 3, 4, 5, 6]).quartiles(this.callback);

    public function test_quartiles_callback(val, stat) {
      Assert.equals(val, [2, 3, 5]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4], [5, 6]]).quartiles(this.callback);

    public function test_quartiles_matrix_cols_callback(val, stat) {
      Assert.equals(val, [[1, 3, 3], [2, 4, 4]]);
    }
  */
}