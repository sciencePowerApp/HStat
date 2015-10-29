package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Quantiles_test{
	public function new() { };

    public function test_return_basic_quantiles() {
      Assert.equals(Vector.quantiles([[1, 2, 3, 4, 5, 6]],
                                       [[0.25, 0.5, 0.75]]).toString(),
                                       [1.9375, 3.5, 5.0625].toString());
	}

    /*public function test_quantiles_from_instance() {
      Assert.equals(jStat([1, 2, 3, 4, 5, 6]).quantiles([0.25, 0.5, 0.75]),
                       [1.9375, 3.5, 5.0625]);

    public function test_quantiles_matrix_cols() {
      Assert.equals(
          jStat([[1, 2], [3, 4], [5, 6]]).quantiles([0.25, 0.5, 0.75]),
          [[1.375, 3, 4.625], [2.375, 4, 5.625]]);*/

    public function test_quantiles_normal_dist() {
      var arr = [-2.57313203,  9.84802638,  6.13625057,  8.41780777,
                 1.06749265, 2.1530631,  4.46082094,  8.26291053,
                 -9.28064583,  0.13434825];

        var quantiles = [0.1, 0.3, 0.5, 0.8];
        var results = Vector.quantiles([arr], [quantiles]);
        var expected = [-6.59764031,  0.55426323,  3.30694202,  8.35197644];
        var i;

        for (i in 0... quantiles.length) {
          Assert.floatEquals( results[0][i], expected[i]);
        }
	}

	/*
	 * unclear how the below becomes a gamma dist
    public function test_quantiles_gamma_dist() {
      var arr = [6.20504472,   7.18983495,   6.29331634,   7.72493799,
        6.44628893,   7.73877221,   8.26542627,   7.00870595,
        6.72238426,   7.09363385,   6.60325838,   5.90180641,
        5.79957376,  13.07687722,   6.65942804,   6.75392592,
        6.41813748,   7.97086739,   9.36773336];

        var quantiles = [0.83, 0.1, 0.3, 0.5, 0.8];
        var results = Vector.quantiles(arr, quantiles);
        var expected = [8.06983917, 5.99884267,
                        6.47140404, 6.75392592, 7.91516455];

        for (i in 0...quantiles.length)
          Assert.floatEquals(results[i], expected[i]);
    }

    public function test_topic() {
      jStat([1, 2, 3, 4, 5, 6]).quantiles([0.25, 0.5, 0.75], this.callback);

    public function test_quantiles_callback(val, stat) {
      Assert.equals(val, [1.9375, 3.5, 5.0625]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4], [5, 6]]).quantiles([0.25, 0.5, 0.75],
                                                this.callback);

    public function test_quantiles_matrix_cols_callback(val, stat) {
      Assert.equals(val, [[1.375, 3, 4.625], [2.375, 4, 5.625]]);
    }*/
  
}