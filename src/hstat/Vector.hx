package hstat;
import hstat.Dimensions.Matrix;

/**
 * ...
 * @author 
 */
class Vector
{

	public function new() 
	{}
	
		

	public static function ascNum(a, b) { return a - b; }

	public static function clip(arg, min, max) {
	  return Math.max(min, Math.min(arg, max));
	}


	// sum of an array
	public static function sum(m:Matrix):Float {
	  var sum:Float = 0;
	  var arr = m.get_row(0);
	  var i = arr.length;
	  while (--i >= 0)
		sum += arr[i];
	  return sum;
	}


	// sum squared
	public static function sumsqrd(m:Matrix):Float {
	  var sum:Float = 0;
	  var arr = m.get_row(0);
	  var i = arr.length;
	  while (--i >= 0)
		sum += arr[i] * arr[i];
	  return sum;
	}


	// sum of squared errors of prediction (SSE)
	public static function sumsqerr(m:Matrix):Float {
	  var arr = m.get_row(0);
	  var mean = mean(arr);
	  var sum:Float = 0;
	  var i = arr.length;
	  var tmp;
	  while (--i >= 0) {
		tmp = arr[i] - mean;
		sum += tmp * tmp;
	  }
	  return sum;
	}

	// sum of an array in each row
	public static function sumrow(m:Matrix):Float {
	  var arr = m.get_row(0);
	  var sum:Float = 0;
	  var i = arr.length;
	  while (--i >= 0)
		sum += arr[i];
	  return sum;
	}

	// product of an array
	public static function product(m:Matrix):Float {
	  var arr = m.get_row(0);	
	  var prod:Float = 1;
	  var i = arr.length;
	  while (--i >= 0)
		prod *= arr[i];
	  return prod;
	}


	// minimum value of an array
	public static function min(m:Matrix):Float {
	  var arr = m.get_row(0);
	  var low:Float = arr[0];
	  var i = 0;
	  while (++i < arr.length)
		if (arr[i] < low)
		  low = arr[i];
	  return low;
	}


	// maximum value of an array
	public static function max(m:Matrix):Float {
	var arr = m.get_row(0);
	  var high:Float = arr[0];
	  var arr = m.get_row(0);
	  var i = 0;
	  while (++i < arr.length)
		if (arr[i] > high)
		  high = arr[i];
	  return high;
	}


	// mean value of an array
	public static function mean(m:Matrix):Float {
	  var arr = m.get_row(0);
	  return sum(arr) / arr.length;
	}


	// mean squared error (MSE)
	public static function meansqerr(m:Matrix):Float {
		var arr = m.get_row(0);
	  return sumsqerr(arr) / arr.length;
	}


	// geometric mean of an array
	public static function geomean(m:Matrix):Float {
		var arr = m.get_row(0);
	  return Math.pow(product(arr), 1 / arr.length);
	}


	public static function sortAsc(m:Matrix):Matrix {
		var arr = m.get_row(0);
		arr.sort(function(a:Float, b:Float):Int {
					if (a == b) return 0; 
					else if (a > b) return 1;
					return -1;
                 });
		for (i in 0...arr.length) {
			m.set(i, 0, arr[i]);
		}
		return m;
	}
	
	
	// median of an array
	//https://stackoverflow.com/questions/25305640/find-median-values-from-array-in-javascript-8-values-or-9-values
	public static function median(m:Matrix):Float {
		var arr = m.get_row(0);
		var arrlen = arr.length;
		var m:Matrix  = sortAsc(arr);


		var middle = Math.floor((arr.length - 1) / 2); // NB: operator precedence
		if (arr.length % 2 == 1) {
			return arr[middle];
		} 
		
        return (arr[middle] + m.get(0,middle + 1)) / 2.0;
    
	}


	// cumulative sum of an array
	public static function cumsum(m:Matrix):Matrix {
		return HStat.cumreduce(m, function (a, b, c) { return a + b; },false);
	}


	// cumulative product of an array
	public static function cumprod(m:Matrix):Matrix {
	return HStat.cumreduce(m, function(a, b, c) { return a * b; },false);
	}


	// successive differences of a sequence
	public static function diff(m:Matrix):Matrix {
	  var arr = m.get_row(0);
	  var diffs = new Matrix();
	  var arrLen = arr.length;

	  for (i in 1 ... arrLen)
		diffs.set(i,0,arr[i] - arr[i - 1]);
	  return diffs;
	}


	// mode of an array
	// if there are multiple modes of an array, return all of them
	// is this the appropriate way of handling it?
	public static function mode(m:Matrix):Matrix {
	  var arr = m.get_row(0);
	  var arrLen = arr.length;
	  var m2 = sortAsc(arr);
	  var count = 1;
	  var maxCount = 0;
	  var numMaxCount = 0;
	  var mode_arr = new Matrix();
	  var i;

	  for (i in 0...arrLen) {
		if (m2.get(i,0) == m2.get(i + 1,0)) {
		  count++;
		} else {
		  if (count > maxCount) {
			mode_arr = [[m2.get(i,0)]];
			maxCount = count;
			numMaxCount = 0;
		  }
		  // are there multiple max counts
		  else if (count == maxCount) {
			mode_arr.pushToCol(0,m2.get(0,i));
			numMaxCount++;
		  }
		  // resetting count for new value in array
		  count = 1;
		}
	  }

	  return mode_arr;
	}


	// range of an array
	public static function range(m:Matrix):Float {
		var arr = m.get_row(0);
	  return max(arr) - min(arr);
	}

	// variance of an array
	// flag = true indicates sample instead of population
	public static function variance(m:Matrix, flag:Bool = false):Float {
		var arr = m.get_row(0);
	  return sumsqerr(arr) / (arr.length - (flag ? 1 : 0));
	}


	// standard deviation of an array
	// flag = true indicates sample instead of population
	public static function stdev(m:Matrix, flag:Bool = false):Float {
	var arr = m.get_row(0);	
	  return Math.sqrt(variance(arr, flag));
	}


	// mean deviation (mean absolute deviation) of an array
	public static function meandev(m:Matrix):Float {
		var arr = m.get_row(0);
	  var devSum:Float = 0;
	  var _mean:Float = mean(arr);
	  var i = arr.length;
	  while (--i >=0){
		devSum += Math.abs(arr[i] - _mean);
	  }
	  return devSum / arr.length;
	}


	// median deviation (median absolute deviation) of an array
	public static function meddev(m:Matrix):Float {
		var arr = m.get_row(0);
	  var devSum:Float = 0;
	  var median:Float = median(arr);
	  var i = arr.length;
	  while(--i>=0){
		devSum += Math.abs(arr[i] - median);
	  }
	  return devSum / arr.length;
	}


	// coefficient of variation
	public static function coeffvar(m:Matrix):Float {
		var arr = m.get_row(0);
	  return stdev(arr) / mean(arr);
	}


	// quartiles of an array
	public static function quartiles(m:Matrix):Matrix {
		var arr = m.get_row(0);
	  var arrlen = arr.length;
	  var _arr = sortAsc(arr);
	  var r:Matrix = [[_arr.get(0, Math.round((arrlen) / 4) - 1),
		_arr.get(0, Math.round((arrlen) / 2) - 1) ,
		_arr.get(0, Math.round((arrlen) * 3 / 4) - 1) ]];
	  return r;
		
	}
	
	public static function copyArr(a:Matrix):Matrix {
		return a.copy();
	}


	// Arbitary quantiles of an array. Direct port of the scipy.stats
	// implementation by Pierre GF Gerard-Marchant.
	public static function quantiles(m:Matrix, quantilesArray:Matrix, ?alphap:Float , ?betap:Float) {
	  var sortedArray:Matrix = sortAsc(	m	);
	  var quantileVals:Matrix = new Matrix();
	  var n = m.cols;
	  var i, p, m:Float, aleph:Float, k:Int, gamma:Float;

	  if (alphap == null)
		alphap = 3 / 8;
	  if (betap == null)
		betap = 3 / 8;

	  for (i in 0... quantilesArray.cols) {
		p = quantilesArray.get(i,0);
		m = alphap + p * (1 - alphap - betap);
		aleph = n * p + m;
		k = Math.floor(clip(aleph, 1, n - 1));
		gamma = clip(aleph - k, 0, 1);
		quantileVals.set(i, 0, (1 - gamma) * sortedArray.get(k - 1,0) + gamma * sortedArray.get(k, 0));
	  }

	  return quantileVals;
	}

	// Returns the k-th percentile of values in a range, where k is in the
	// range 0..1, exclusive.
	public static function percentile(m:Matrix, k:Float) {
	  var arr = m.get_row(0);
	  var _arr = sortAsc(m).get_row(0);
	  var realIndex:Float = k * (_arr.length - 1);
	  var index:Int = Std.int(realIndex);
	  var frac :Float= realIndex - index;

	  if (index + 1 < _arr.length) {
		return _arr[index] * (1 - frac) + _arr[index + 1] * frac;
	  } else {
		return _arr[index];
	  }
	}


	// The percentile rank of score in a given array. Returns the percentage
	// of all values in the input array that are less than (kind='strict') or
	// less or equal than (kind='weak') score. Default is weak.
	public static function percentileOfScore(m:Matrix, score:Float, strict:Bool = false):Float {
	  var counter = 0;
	  var arr = m.get_row(0);
	  var len = arr.length;
	  var value, i;


	  for (i in 0...len) {
		value = arr[i];
		if ((strict && value < score) ||
			(!strict && value <= score)) {
		  counter++;
		}
	  }

	  return counter / len;
	}


	// Histogram (bin count) data
	public static function histogram(m:Matrix, binCount:Int = 4):Matrix {
	 var arr = m.get_row(0);
	  var first = min(arr);
	  var binWidth:Float = (max(arr) - first) / binCount;
	  var len = arr.length;
	  var bins = [];
	  var i;

	  for (i in 0...binCount)
		bins[i] = 0;
		
	  for (i in 0...len)
		bins[Std.int(Math.min(Math.floor(((arr[i] - first) / binWidth)), binCount - 1))] += 1;

	  return bins;
	}


	// covariance of two arrays
	public static function covariance(arr1:Matrix, arr2:Matrix) {
	  var u = mean(arr1);
	  var v = mean(arr2);
	  var arr1Len = arr1.cols;
	  var sq_dev = new Matrix();
	  var i;

	  for (i in 0...arr1Len)
		sq_dev.set(i, 0, (arr1.get(i,0) - u) * (arr2.get(i,0) - v));

	  return sum(sq_dev) / (arr1Len - 1);
	}


	// (pearson's) population correlation coefficient, rho
	public static function corrcoeff(arr1:Matrix, arr2:Matrix) {
	  return covariance(arr1, arr2) /
		  stdev(arr1, true) /
		  stdev(arr2, true);
	}

	// statistical standardized moments (general form of skew/kurt)
	public static function stanMoment(m:Matrix, n:Float):Float {
	  var arr = m.get_row(0);
	  var mu:Float = mean(arr);
	  var sigma:Float = stdev(arr);
	  var len:Int = arr.length;
	  var skewSum:Float = 0;

	  for (i in 0...len)
		skewSum += Math.pow((arr[i] - mu) / sigma, n);

	  return skewSum / arr.length;
	}

	// (pearson's) moment coefficient of skewness
	public static function skewness(m:Matrix) {
	  return stanMoment(m, 3);
	}

	// (pearson's) (excess) kurtosis
	public static function kurtosis(m:Matrix):Float {
	  return stanMoment(m, 4) - 3;
	}



	
}