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
	
	
	public function test_pnrom_list1() {
      var A:Matrix = [[3, 4]];
      Assert.floatEquals(Linearalgebra.norm(A), 5);
	  
      var B:Matrix = [[-3, 4]];
      Assert.floatEquals(Linearalgebra.norm(A), 5);
    }
	
    public function test_pnorm_list2() {
      var A:Matrix = [[1, 2, 3]];
      Assert.floatEquals(Linearalgebra.norm(A,1), 6);
    }
	
    public function test_pnorm_matrix() {
      var A:Matrix = [[3, 4], [1, 2]];
      Assert.floatEquals(Linearalgebra.norm(A), 5);
    }
	
	public function test_angle() {

      var piOverFour = 0.7853981633974484;
      var tol = 0.00000001;
      var A:Matrix = [[0, 1]];
      var B :Matrix= [[2, 2]];
      Assert.floatEquals(Linearalgebra.angle(A,B), piOverFour,tol);
    
	}
	
	public function test_aug() {
	  var A:Matrix = [[1, 2], [3, 4]];
      var B:Matrix = [[5], [6]];
      Assert.equals(Linearalgebra.aug(A, B).toString(), [[1, 2, 5], [3, 4, 6]].toString());
	}
	
	public function test_aug2() {
	  var A:Matrix = [[1, 2], [3, 4]];
      var B:Matrix = [[5, 6], [7, 8]];
      var cloneA = Vector.copy(A);
      var cloneB = Vector.copy(B);
      Assert.equals(Linearalgebra.aug(A, B).toString(), [[1, 2, 5, 6], [3, 4, 7, 8]].toString());
      Assert.equals(A.toString(), cloneA.toString());
      Assert.equals(B.toString(), cloneB.toString());
	}
	
	public function test_inv() {
	 //sanity: inv of ident is ident
      var A:Matrix = [[1, 0, 0], [0, 1, 0], [0, 0, 1]];
      var B:Matrix = [[1, 0, 0], [0, 1, 0], [0, 0, 1]];
      Assert.equals(Linearalgebra.inv(A).toString(), B.toString());
	}
	
	public function test_det() {
	  var A:Matrix = [[1, 2, 3], [4, 5, -6], [7, -8, 9]];
      Assert.equals(Linearalgebra.det(A), -360);
	}
	
	public function test_gaus_elimination1() {
	  var A:Matrix = [[1, -3, 1], [2, -8, 8], [-6, 3, -15]];
      var B:Matrix = [[4], [-2], [9]];
      var tol = 0.000001;
      var result = Linearalgebra.gauss_elimination(A, B);
      Assert.floatEquals( result[0][0], 3, tol);
      Assert.floatEquals( result[0][1], -1, tol);
      Assert.floatEquals( result[0][2], -2, tol);
	}
	
	public function test_gaus_elimination2() {
	  var A:Matrix = [[1, 1], [3, -2]];
      var B:Matrix = [[3], [4]];
      var tol = 0.000001;
      var result = Linearalgebra.gauss_elimination(A, B);
      Assert.floatEquals(result[0][0], 2, tol);
      Assert.floatEquals(result[0][1], 1, tol);
	}
	
	public function test_gaus_elimination3() {
	  var A:Matrix = HStat.identity(4);
      var B:Matrix = [[1], [2], [3], [4]];
      var result = Linearalgebra.gauss_elimination(A, B);
      var tol = 0.000001;
      Assert.floatEquals(result[0][0], 1, tol);
      Assert.floatEquals(result[0][1], 2, tol);
      Assert.floatEquals(result[0][2], 3, tol);
      Assert.floatEquals(result[0][3], 4, tol);
	}
	
	public function test_gaus_elimination4() {
	  var A:Matrix = [[1,1,1,1],[0,1,1,1],[0,0,1,1],[0,0,0,1]];
      var B:Matrix = [[10], [9], [7], [4]];
      var result:Matrix = Linearalgebra.gauss_elimination(A, B);
      var tol = 0.000001;
      Assert.floatEquals(result[0][3], 4, tol);
      Assert.floatEquals(result[0][2], 3, tol);
      Assert.floatEquals(result[0][1], 2, tol);
      Assert.floatEquals(result[0][0], 1, tol);
	}
	
}