package hstat.tests.dataStructures;
import hstat.Dimensions.Matrix;
import utest.Assert;


class Dimensions_test
{

	public function new() { }

	public function test() {
	
		Assert.isTrue(true);
		
		var x:Matrix = [[1,2,3]];
        trace(x + ", 2d? " + x.is2D);
        
        var x:Matrix = [[1.1,2.2,3.3]];
        trace(x + ", 2d? " + x.is2D);
		//trace(x[1]);
        
        var x:Matrix = [[1.1,2,3.3]];
        trace(x + ", 2d? " + x.is2D);
		//trace(x[1]);
        
        var x:Matrix = [[1,2,3],[1,2,3],[1,2,3]];
        trace(x + ", 2d? " + x.is2D);
		//trace(x[1]);
        
        var x:Matrix = [[1,2.2,3],[1.1,2,3],[1,2,3.3]];
        trace(x + ", 2d? " + x.is2D);
		//trace(x[1]);
		
		var x:Matrix = [[1, 2, 3]];
		var y:Matrix = x * 3;
		trace(y);
		
        var x:Matrix = [[1,2,3],[4,5,6],[7,8,9]];
		var y:Matrix = x * 3;
		trace(y);
	}
	
	
}