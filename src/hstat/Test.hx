package hstat;
import hstat.Distribution.CentralF;
import hstat.Distribution.Normal;
import hstat.Distribution.Studentt;


/**
 * ...
 * @author 
 */
class Test
{
  // 2 different parameter lists:
  // (value, mean, sd)
  // (value, array, flag)
  
  	public static function zscore_val_mean_sd(val:Float,mean:Float, sd:Float):Float {
		return (val - mean) / sd;
    }
  
	public static function zscore_val_arr_flag(val:Float, array:Array<Float>, flag:Bool):Float {
    return (val - Vector.mean(array) / Vector.stdev(array, flag));
  }


  
  
  public static function ztest_value_array_sides_flag(val:Float, arr:Array<Float>, sides:Int, flag:Bool=false):Float {
	  
	  var z = zscore_val_arr_flag(val, arr, flag);
        return (sides == 1) ?
          (Normal.cdf(-Math.abs(z),0,1)) :
          (Normal.cdf(-Math.abs(z),0,1)* 2);
  }
  
  
  public static function ztest_val_mean_sd_sides(value:Float, mean:Float, sd:Float, sides:Int):Float {
	  var z = zscore_val_mean_sd(value,mean,sd);
      return (sides == 1) ?
        (Normal.cdf(-Math.abs(z), 0, 1)) :
        (Normal.cdf(-Math.abs(z), 0, 1)*2); 
  }
  
  public static function ztest_zscores_sides(zscore:Float, sides:Int):Float { 
        return (sides == 1) ?
          (Normal.cdf(-Math.abs(zscore),0,1)) :
          (Normal.cdf(-Math.abs(zscore),0,1)* 2);
  }
	  

  
  
/*  
  
think below is for oop

  function zscore_val_flag(value, flag) {
    return (value - this.mean()) / this.stdev(flag);
  }


	public static function ztest(value:Float, sides:Int, flag:Int):Float {
    var zscore = Math.abs(zscore_val_flag(value, flag));
    return (sides == 1) ?
      (Normal.cdf(-zscore, 0, 1)) :
      (Normal.cdf(-zscore, 0, 1) * 2);
  }*/

  
  
  
  

// T Statistics

  // 2 parameter lists
  // (value, mean, sd, n)
  // (value, array)
  public static function tscore_val_mean_sd_n(val:Float, mean:Float, sd:Float, n:Int) {
    return (val - mean) / (sd / Math.sqrt(n));
  }
  
   public static function tscore_val_arr(val:Float, arr:Array<Float>) {
   
    return (val - Vector.mean(arr) /  (Vector.stdev(arr, true) / Math.sqrt(arr.length)));
  }

  // 3 different paramter lists:
  // (value, mean, sd, n, sides)
  // (tscore, n, sides)
  // (value, array, sides)
  public static function ttest_val_mean_sd_n_sides (value:Float, mean:Float, sd:Float, n:Int, sides:Int) {
   
      var tscore = Math.abs(value - mean / (sd / Math.sqrt(n)));
      return (sides == 1) ?
        (Studentt.cdf(-tscore, sd-1)) :
        (Studentt.cdf(-tscore, sd-1)*2);
   
  }

    public static function ttest_tscore_n_sides(tscore:Float, n:Int, sides:Int) {
   

      var tscore = Math.abs(tscore);
      return (sides == 1) ?
        (Studentt.cdf(-tscore, n-1)) :
        (Studentt.cdf(-tscore, n-1) * 2);
    }
	
   
  
    public static function ttest_val_arr_sides(value:Float, array:Array<Float>, sides:Int) {
    
    var tscore = Math.abs(tscore_val_arr(value, array));
    return (sides == 1) ?
      (Studentt.cdf(-tscore, array.length-1)) :
      (Studentt.cdf(-tscore, array.length-1) * 2);
  }
  
    

  //public static function tscore_val_mean_sd_n(value:Float, mean:Float, sd:Float, n:Int) {
  //  return (value - mean / (sd / Math.sqrt(n)));
  //}

  public static function ttest(tscore, sides) {
    return (sides == 1) ?
      (1 -Studentt.cdf(tscore, sides-1)) :
      (Studentt.cdf(-Math.abs(tscore), sides-1)*2);
  }

// F Statistics
  // Paramter list is as follows:
  // or it is an array of arrays
  // array of arrays conversion
 
  public static function anovafscore(arr:Array<Array<Float>>) {
    
    var expVar:Float, sample:Array<Float>, sampMean:Float, sampSampMean:Float, tmpargs:Float, unexpVar:Float, i, j;

    
    // 2 sample case
    if (arr.length == 2) {
      return  Vector.variance(arr[0]) / Vector.variance(arr[1]);
    }
    // Builds sample array
    sample = new Array();
    for (i in 0...arr.length) {
      sample = sample.concat(arr[i]);
    }
    sampMean = Vector.mean(sample);
    // Computes the explained variance
    expVar = 0;
    for (i in 0 ... arr.length) {
      expVar = expVar + arr[i].length * Math.pow(Vector.mean(arr[i]) - sampMean, 2);
    }
    expVar /= (arr.length - 1);
    // Computes unexplained variance
    unexpVar = 0;
    for (i in 0... arr.length) {
      sampSampMean = Vector.mean(arr[i]);
      for (j in 0... arr[i].length) {
        unexpVar += Math.pow(arr[i][j] - sampSampMean, 2);
      }
    }
    unexpVar /= (sample.length - arr.length);
    return expVar / unexpVar;
  }
  
  // 2 different paramter setups
  // (array of arrays)
  public static function anovaftest_arr(arr:Array<Array<Float>>):Float {

    var anovafscore = anovafscore(arr);
    var df1 = arr.length - 1;
    var n:Int = 0;
    for (i in 0... arr.length) {
      n = n + arr[i].length;
    }
    var df2 = n - df1 - 1;
    return 1 - CentralF.cdf(anovafscore, df1, df2);
  }
  
  
    // 2 different paramter setups
  // (array1, array2, array3, ...)
  // (anovafscore, df1, df2)
  public static function anovaftest_float_df1_df2(score:Float, df1:Int, df2:Int) {
    return 1 - CentralF.cdf(score, df1, df2);
    
   
  }

  public static function ftest(fscore, df1, df2) {
    return 1 - CentralF.cdf(fscore, df1, df2);
  }

  
/*  public static function anovaftes() {
    var n = 0;
    var i;
    for (i in 0... this.length) {
      n = n + this[i].length;
    }
    return HStat.ftest(this.anovafscore(), this.length - 1, n - this.length);
  }*/


// Error Bounds
  // 2 different parameter setups
  // (value, alpha, sd, n)
  public static function normalci_val_alpha_sd_n(value:Float, alpha:Float, sd:Float, n:Int):Array<Float> {

    var ans = new Array<Float>();


    var change:Float = Math.abs(Normal.inv(alpha / 2, 0, 1) *
                        sd / Math.sqrt(n));
    
    ans[0] = value - change;
    ans[1] = value + change;
    return ans;
  }
  
// Error Bounds
  // 2 different parameter setups
  // (value, alpha, array)
  public static function normalci_val_alpha_arr(value:Float, alpha:Float, arr:Array<Float>):Array<Float> {
    
    var ans = new Array<Float>();


    var change = Math.abs(Normal.inv(alpha / 2, 0, 1) *
                        Vector.stdev(arr) / Math.sqrt(arr.length));
    
    ans[0] = value - change;
    ans[1] = value + change;
    return ans;
  }  
  
  
  

  // 2 different parameter setups
  // (value, alpha, sd, n)
  public static function tci_val_alpha_sd_n(value:Float, alpha:Float, sd:Float, n:Int) {
    var ans = new Array<Float>();
    var change:Float = Math.abs(Studentt.inv(alpha / 2, sd - 1) *
                        sd / Math.sqrt(n));
    
    ans[0] = value - change;
    ans[1] = value + change;
    return ans;
  }
  
  
    // 2 different parameter setups
  // (value, alpha, array)
  public static function tci_val_alpha_arr(value:Float, alpha:Float, arr:Array<Float>) {
    var ans = new Array<Float>();
    var change:Float = Math.abs(Studentt.inv(alpha / 2, arr.length - 1) *
                        Vector.stdev(arr, true) / Math.sqrt(arr.length));
    
    ans[0] = value - change;
    ans[1] = value + change;
    return ans;
  }

  public static function significant(pvalue, alpha) {
    return pvalue < alpha;
  }

/*
  public static function normalci(value, alpha) {
	  Normal
    return Normalci(value, alpha, this.toArray());
  }
  
  public static function tci(value, alpha) {
 
	  return HStat.tci(value, alpha, this.toArray());
  }*/


// internal method for calculating the z-score for a difference of proportions test
  public static function differenceOfProportions(p1:Float, n1:Float, p2:Float, n2:Float):Float {
  if (p1 > 1 || p2 > 1 || p1 <= 0 || p2 <= 0) {
    throw "Proportions should be greater than 0 and less than 1";
  }
  var pooled = (p1 * n1 + p2 * n2) / (n1 + n2);
  var se = Math.sqrt(pooled * (1 - pooled) * ((1/n1) + (1/n2)));
  return (p1 - p2) / se;
}

public static function oneSidedDifferenceOfProportions(p1:Float, n1:Float, p2:Float, n2:Float):Float {
    var z = differenceOfProportions(p1, n1, p2, n2);
    return ztest_zscores_sides(z, 1);
  }

  public static function twoSidedDifferenceOfProportions(p1:Float, n1:Float, p2:Float, n2:Float):Float {
    var z = differenceOfProportions(p1, n1, p2, n2);
    return ztest_zscores_sides(z, 2);
  }
	
}