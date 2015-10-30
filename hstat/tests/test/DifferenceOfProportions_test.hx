package hstat.tests.test;
import utest.Assert;
/**
 * ...
 * @author 
 */
class DifferenceOfProportions_test
{

	public function new() 
	{
		
	}
	
	
	 public function test_oneSided() {
      var p = Test.oneSidedDifferenceOfProportions(.12, 500, .14, 1000);

	  Assert.isTrue(p > 0.14);
      Assert.isTrue(p < 0.15);

      p = Test.oneSidedDifferenceOfProportions(.5, 134, .51, 101);
      Assert.isTrue(p > 0.43);
      Assert.isTrue(p < 0.44);
    }
	
	
	public function test_twoSided() {
      var p = Test.twoSidedDifferenceOfProportions(.12, 500, .14, 1000);
      Assert.isTrue(p > 0.28);
      Assert.isTrue(p < 0.29);

      p = Test.twoSidedDifferenceOfProportions(.5, 134, .51, 101);
      Assert.isTrue(p > 0.87);
      Assert.isTrue(p < 0.88);
    }
	
}