package hstat.tests.vector;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Sort_test
{

	public function new() 
	{
	}
	
	public function test_sortAsc() {
		Assert.equals(Vector.sortAsc([[2, 1, 3]])[0].toString(), [1, 2, 3].toString());
	}
	
}