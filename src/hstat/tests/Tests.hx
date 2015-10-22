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
import hstat.tests.special.Gammafn_test;
import hstat.tests.special.Gammap_test;
import hstat.tests.special.General_test;
import hstat.tests.special.LowRegGamma_test;
import hstat.tests.test.DifferenceOfProportions_test;
import hstat.tests.test.Ztest_test;
import openfl.system.System;
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
		
		//Special
		runner.addCase(new Gammafn_test());
		runner.addCase(new Gammap_test());
		runner.addCase(new LowRegGamma_test());
		runner.addCase(new General_test());
		
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

		//Tests
		runner.addCase(new Ztest_test());
		runner.addCase(new DifferenceOfProportions_test());
		
		
		Report.create(runner, NeverShowSuccessResults, AlwaysShowHeader);
		
		runner.onComplete.add(function(h) { 
			System.exit(0);
		} );
		
		
		runner.run();
	}
	
}