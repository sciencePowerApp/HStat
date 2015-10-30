package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Geomean_test{
	public function new() { };

    public function test_return_basic_geomean() {
      Assert.floatEquals(Vector.geomean([[1, 2, 3]]), 1.8171205928321397);
	}
	  
   /* public function test_geomean_from_instance() {
      Assert.equals(jStat([1, 2, 3]).geomean(), 1.8171205928321397);

    public function test_geomean_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).geomean(),
                       [1.7320508075688772, 2.8284271247461903]);

    public function test_geomean_full_matrix() {
      Assert.equals(jStat([[1, 2], [3, 4]]).geomean(true), 2.2133638394006434);
    }

    public function test_topic() {
      jStat([1, 2, 3]).geomean(this.callback);

    public function test_geomean_callback(val, stat) {
      Assert.equals(val, 1.8171205928321397);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).geomean(this.callback);

    public function test_geomean_matrix_cols_callback(val, stat) {
      Assert.equals(val, [1.7320508075688772, 2.8284271247461903]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).geomean(true, this.callback);

    public function test_geomean_full_matrix_callback(val, stat) {
      Assert.equals(val, 2.2133638394006434);
    }*/
  
}