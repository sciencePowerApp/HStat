package hstat.tests.linearalgebra;
import hstat.HStat.Matrix;
import hstat.Linearalgebra;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Basic_test
{

	public function new() 
	{
		
	}
	
	public function test_add_list() {
		var l:Linearalgebra;
		Assert.isTrue(true);
		
		var A:Matrix = [[1, 2, 3]];
		var B:Matrix = [[4, 5, -6]]; 
		
		Assert.equals(Linearalgebra.add(A, B)[0].toString() , [5, 7, -3].toString());
		
	}
	
	public function test_add_val() {

      var A:Matrix = [[1, 2, 3]];
      Assert.equals(Linearalgebra.add(A, [[100.0]])[0].toString(),[101, 102, 103].toString());
    }
	
	
	public function test_subtract_list() {
		var A:Matrix = [[1, 2, 3]];
		var B:Matrix = [[4, 5, -6]]; 
         Assert.equals(Linearalgebra.subtract(A, B )[0].toString() , [-3, -3, 9].toString());
		
	}
	
	public function test_subtract_val() {

      var A:Matrix = [[1, 2, 3]];
      Assert.equals(Linearalgebra.subtract(A, [[100.0]])[0].toString(),[-99,-98,-97].toString());
    }
	
	public function test_divide_val() {

      var A:Matrix = [[10, 20, 30]];
      Assert.equals(Linearalgebra.divide(A, [[10.0]])[0].toString(), [1, 2, 3].toString());
    }
	
	
	public function test_multiply_list() {
	
		var l:Linearalgebra;
		Assert.isTrue(true);
		
		var A:Matrix = [[1, 2],[3,4]];
		var B:Matrix = [[1,0],[0,1]]; 
		

		Assert.equals(Linearalgebra.multiply(A, B).toString() , [[1,2],[3,4]].toString());
		
	}
	
	public function test_multiply_val() {

      var A:Matrix = [[1, 2, 3]];
      Assert.equals(Linearalgebra.multiply(A, [[5.0]])[0].toString(),[5,10,15].toString());
    }
	
	public function test_dotProduct() {
	
	 var A:Matrix = [[1, 2, 3]];
     var B:Matrix = [[5, -2, 10]];
     Assert.equals(Linearalgebra.dot(A,B), 31);
	}
	
	public function test_pow() {
	   var A:Matrix = [[1, 2],[3,4]];
       Assert.equals(Linearalgebra.pow(A,[[2]]).toString(), [[1, 4], [9, 16]].toString());	
	}
	
	public function test_exp() {
	   var A:Matrix = [[ -1, 0], [1, 2]];
       Assert.equals(Linearalgebra.exp(A).toString(), [[Math.exp(-1), 1], [2.718281828459045, Math.exp(2)]].toString());	
	}
	
		public function test_log() {
	   var A:Matrix = [[1, 2.718281828459045], [Math.exp(5), Math.exp(10)]];
       Assert.equals(Linearalgebra.log(A).toString(), [[0, 1], [5, 10]].toString());	
	}
	
		public function test_abs() {
	   var A:Matrix = [[1, -1, 0, -10]];
       Assert.equals(Linearalgebra.abs(A).toString(), [[1, 1, 0, 10]].toString());	
	}
	
	
}