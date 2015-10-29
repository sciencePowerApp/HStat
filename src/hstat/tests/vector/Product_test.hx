package hstat.tests.vector;
import hstat.Vector;
import utest.Assert;

class Product_test{
	public function new() { };

    public function test_return_basic_product() {
      Assert.equals(Vector.product([[1, 2, 3]]), 6);
	}

   /* public function test_product_from_instance() {
      Assert.equals(jStat([1, 2, 3]).product(), 6);

    public function test_product_matrix_cols() {
      Assert.equals(jStat([[1, 2], [3, 4]]).product(), [3, 8]);

    public function test_product_full_matrix() {
      Assert.equals(jStat([[1, 2], [3, 4]]).product(true), 24);
    }

    public function test_topic() {
      jStat([1, 2, 3]).product(this.callback);

    public function test_product_callback(val, stat) {
      Assert.equals(val, 6);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).product(this.callback);

    public function test_product_matrix_cols_callback(val, stat) {
      Assert.equals(val, [3, 8]);
    }

    public function test_topic() {
      jStat([[1, 2], [3, 4]]).product(true, this.callback);

    public function test_product_full_matrix_callback(val, stat) {
      Assert.equals(val, 24);
    }*/
  
}