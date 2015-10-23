package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Percentile_of_score_test{
	public function new() { };

    public function test_return_basic_percentile_of_score() {
      Assert.equals(Vector.percentileOfScore([1, 2, 3, 4, 5, 6], 3), 0.5);
      Assert.floatEquals(Vector.percentileOfScore([1, 2, 3, 4, 5, 6], 5),
                     0.83333333333333343);
	}

/*    public function test_return_basic_percentile_of_score() {
      Assert.equals(Vector.percentileOfScore([1, 2, 3, 4, 5, 6], -1), 0.0);

    public function test_return_basic_percentile_of_score() {
      Assert.equals(Vector.percentileOfScore([1, 2, 3, 4, 5, 6], 6), 1.0);

    public function test_return_basic_percentile_of_score_(strict)() {
      Assert.floatEquals(
          tol,
          Vector.percentileOfScore([1, 2, 3, 4, 5, 6], 5, 'strict'),
          0.66666666666666657);

    public function test_percentile_of_score_from_instance() {
      Assert.equals(jStat([1, 2, 3, 4, 5, 6]).percentileOfScore(3), 0.5);

    public function test_percentile_of_score_matrix_cols() {
      var mat = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]];
      Assert.equals(jStat(mat).percentileOfScore(3), [0.5, 0.5]);
    }*/
  
}