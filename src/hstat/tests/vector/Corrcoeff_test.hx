package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Corrcoeff_test{
	public function new() { };

    public function test_return_basic_corrcoeff() {
      Assert.equals(Vector.corrcoeff([[1, 2, 3, 4]], [[4, 5, 6, 7]]),
                   1.0000000000000002);
    }
  
}