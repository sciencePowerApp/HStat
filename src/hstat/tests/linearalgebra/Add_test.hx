package hstat.tests.linearalgebra;
import hstat.HStat.Matrix;
import hstat.Linearalgebra;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Add_test
{

	public function new() 
	{
		
	}
	
	public function test_matrix() {
	
		var l:Linearalgebra;
		Assert.isTrue(true);
		
		var a:Matrix = [[1, 2, 3]];
		var b:Matrix = [[4, 5, -6]]; 
		
		trace(Linearalgebra.add(a, b));
		Assert.equals(Linearalgebra.add(a, b)[0].toString() , [5, 7, -3].toString());
		
	}
	
	public function test_list() {

      var A:Matrix = [[1, 2, 3]];
      Assert.equals(Linearalgebra.add(A, [[100.0]])[0].toString(),[101, 102, 103].toString());
    }
	
	
}