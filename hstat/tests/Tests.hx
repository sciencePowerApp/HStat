package hstat.tests;

import hstat.tests.distribution.Beta_test;
import hstat.tests.distribution.Central_f_test;
import hstat.tests.distribution.Chisquare_test;
import hstat.tests.distribution.Gamma_test;
import hstat.tests.distribution.Hypergeometric_test;
import hstat.tests.distribution.Inverse_gamma_test;
import hstat.tests.distribution.Kumaraswamy_test;
import hstat.tests.distribution.Lognormal_test;
import hstat.tests.distribution.Neg_bin_test;
import hstat.tests.distribution.Noncentralt_test;
import hstat.tests.distribution.Normal_test;
import hstat.tests.distribution.Binomial_test;
import hstat.tests.distribution.Pareto_test;
import hstat.tests.distribution.Student_t_test;
import hstat.tests.distribution.Triangular_test;
import hstat.tests.distribution.Uniform_test;
import hstat.tests.linearalgebra.Basic_test;
import hstat.tests.special.Gammafn_test;
import hstat.tests.special.Gammap_test;
import hstat.tests.special.General_test;
import hstat.tests.special.LowRegGamma_test;
import hstat.tests.test.DifferenceOfProportions_test;
import hstat.tests.test.Ztest_test;
import hstat.tests.vector.Coeffvar_test;
import hstat.tests.vector.Corrcoeff_test;
import hstat.tests.vector.Covariance_test;
import hstat.tests.vector.Cumprod_test;
import hstat.tests.vector.Cumsum_test;
import hstat.tests.vector.Diff_test;
import hstat.tests.vector.Geomean_test;
import hstat.tests.vector.Histogram_test;
import hstat.tests.vector.Kurtosis_test;
import hstat.tests.vector.Max_test;
import hstat.tests.vector.Mean_test;
import hstat.tests.vector.Meandev_test;
import hstat.tests.vector.Meansqerr_test;
import hstat.tests.vector.Meddev_test;
import hstat.tests.vector.Median_test;
import hstat.tests.vector.Min_test;
import hstat.tests.vector.Mode_test;
import hstat.tests.vector.Percentile_of_score_test;
import hstat.tests.vector.Percentile_test;
import hstat.tests.vector.Product_test;
import hstat.tests.vector.Quantiles_test;
import hstat.tests.vector.Quartiles_test;
import hstat.tests.vector.Range_test;
import hstat.tests.vector.Skewness_test;
import hstat.tests.vector.Sort_test;
import hstat.tests.vector.Stdev_test;
import hstat.tests.vector.Sum_test;
import hstat.tests.vector.Sumrow_test;
import hstat.tests.vector.Sumsqerr_test;
import hstat.tests.vector.Sumsqrd_test;
import hstat.tests.vector.Variance_test;
import utest.Runner;
import utest.ui.Report;
import utest.ui.common.HeaderDisplayMode;

/**
 * ...
 * @author 
 */
class Tests
{

	public function new() 
	{
		var runner = new Runner();
		

		
		//Distributions
		runner.addCase(new Beta_test());
		runner.addCase(new Normal_test());
		runner.addCase(new Binomial_test());
		runner.addCase(new Central_f_test());
		runner.addCase(new Chisquare_test());
		runner.addCase(new Gamma_test());
		runner.addCase(new Hypergeometric_test());
		runner.addCase(new Inverse_gamma_test());
		runner.addCase(new Kumaraswamy_test());
		runner.addCase(new Lognormal_test());
		runner.addCase(new Neg_bin_test());
		runner.addCase(new Noncentralt_test());
		runner.addCase(new Pareto_test());
		runner.addCase(new Student_t_test());
		runner.addCase(new Triangular_test());
		runner.addCase(new Uniform_test());
		
		//Linear algebra
		runner.addCase(new Basic_test());
		
		
		//Special
		runner.addCase(new Gammafn_test());
		runner.addCase(new Gammap_test());
		runner.addCase(new LowRegGamma_test());
		runner.addCase(new General_test());

		//Tests
		runner.addCase(new Ztest_test());
		runner.addCase(new DifferenceOfProportions_test());
		
		
		//Vector
		runner.addCase(new Coeffvar_test());
		runner.addCase(new Corrcoeff_test());
		runner.addCase(new Covariance_test());
		runner.addCase(new Cumprod_test());
		runner.addCase(new Cumsum_test());
		runner.addCase(new Diff_test());
		runner.addCase(new Geomean_test());
		runner.addCase(new Histogram_test());
		runner.addCase(new Kurtosis_test());
		runner.addCase(new Max_test());
		runner.addCase(new Mean_test());
		runner.addCase(new Meandev_test());
		runner.addCase(new Meansqerr_test());
		runner.addCase(new Meddev_test());
		runner.addCase(new Median_test());
		runner.addCase(new Min_test());
		runner.addCase(new Mode_test());
		runner.addCase(new Percentile_of_score_test());
		runner.addCase(new Percentile_test());
		runner.addCase(new Product_test());
		runner.addCase(new Quantiles_test());
		runner.addCase(new Quartiles_test());
		runner.addCase(new Range_test());
		runner.addCase(new Skewness_test());
		runner.addCase(new Sort_test());
		runner.addCase(new Stdev_test());
		runner.addCase(new Sum_test());
		runner.addCase(new Sumrow_test());
		runner.addCase(new Sumsqerr_test());
		runner.addCase(new Sumsqrd_test());
		runner.addCase(new Variance_test());

		
		
		
		
		Report.create(runner, NeverShowSuccessResults, AlwaysShowHeader);
		
		runner.onComplete.add(function(h) { 
			Sys.exit(0);
		} );
		
		
		runner.run();
	}
	
}