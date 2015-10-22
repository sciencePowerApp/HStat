package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Percentile_test{
    public function test_30th_percentile_of_the_list_in_the_range() {
      Assert.equals(Vector.percentile([1, 2, 3, 4], 0.3), 1.9);

    public function test_30th_percentile_of_the_list_in_the_range,_unsorted() {
      Assert.equals(Vector.percentile([3, 1, 4, 2], 0.3), 1.9);
    }
  
}