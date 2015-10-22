package hstat.tests.test;
import hstat.Test;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Ztest_test
{

	public function new() 
	{
	}
	
	
	public function test_ztest() {
      var p = Test.ztest_zscore_mean_sd_sides(1.96, 0, 1, 2);
      Assert.equals(p , 0.049995790296440856);
    }
	
	public function test_zscore() {
      var p = Test.ztest_zscores_sides(1.96, 2);
      Assert.equals(p , 0.049995790296440856);
    }
    public function test_ztest2() {
      var p = Test.ztest_zscore_array_sides_flag(1.96, [1, -1], 2);
      Assert.equals(p , 0.049995790296440856);
    }
	
	
}