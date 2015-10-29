package hstat;
import hstat.HStat.Matrix;

/**
 * ...
 * @author 
 */
class Vector
{

	public function new() 
	{}
	
		

	public static function ascNum(a:Float, b:Float):Float { return a - b; }

	public static function clip(arg, min:Float, max:Float):Float {
	  return Math.max(min, Math.min(arg, max));
	}


	// sum of an array
	public static function sum(arr:Matrix):Float {
	  var sum:Float = 0;
	  var i = arr[0].length;
	  while (--i >= 0)
		sum += arr[0][i];
	  return sum;
	}


	// sum squared
	public static function sumsqrd(arr:Matrix):Float {
	  var sum:Float = 0;
	  var i = arr[0].length;
	  while (--i >= 0)
		sum += arr[0][i] * arr[0][i];
	  return sum;
	}


	// sum of squared errors of prediction (SSE)
	public static function sumsqerr(arr:Matrix):Float {
	  var mean = mean(arr);
	  var sum:Float = 0;
	  var i = arr[0].length;
	  var tmp;
	  while (--i >= 0) {
		tmp = arr[0][i] - mean;
		sum += tmp * tmp;
	  }
	  return sum;
	}

	// sum of an array in each row
	public static function sumrow(arr:Matrix):Float {
	  var sum:Float = 0;
	  var i = arr[0].length;
	  while (--i >= 0)
		sum += arr[0][i];
	  return sum;
	}

	// product of an array
	public static function product(arr:Matrix):Float{
	  var prod:Float = 1;
	  var i = arr[0].length;
	  while (--i >= 0)
		prod *= arr[0][i];
	  return prod;
	}


	// minimum value of an array
	public static function min(arr:Matrix):Float {
	  var low:Float = arr[0][0];
	  var i = 0;
	  while (++i < arr[0].length)
		if (arr[0][i] < low)
		  low = arr[0][i];
	  return low;
	}


	// maximum value of an array
	public static function max(arr:Matrix):Float {
	  var high:Float = arr[0][0];
	  var i = 0;
	  while (++i < arr[0].length)
		if (arr[0][i] > high)
		  high = arr[0][i];
	  return high;
	}


	// mean value of an array
	public static function mean(arr:Matrix):Float {
	  return sum(arr) / arr[0].length;
	}


	// mean squared error (MSE)
	public static function meansqerr(arr:Matrix):Float {
	  return sumsqerr(arr) / arr[0].length;
	}


	// geometric mean of an array
	public static function geomean(arr:Matrix):Float {
	  return Math.pow(product(arr), 1 / arr[0].length);
	}


	public static function sortAsc(arr:Matrix):Matrix {
		arr[0].sort(function(a:Float, b:Float):Int {
					if (a == b) return 0; 
					else if (a > b) return 1;
					return -1;
                 });
		return arr;
	}
	
	
	// median of an array
	//https://stackoverflow.com/questions/25305640/find-median-values-from-array-in-javascript-8-values-or-9-values
	public static function median(arr:Matrix):Float {
	  var arrlen = arr[0].length;
	  var m = sortAsc(arr);

	  
	var middle = Math.floor((m[0].length - 1) / 2); // NB: operator precedence
    if (m[0].length % 2 == 1) {
        return m[0][middle];
    } else {
        return (m[0][middle] + m[0][middle + 1]) / 2.0;
    }
	}


	// cumulative sum of an array
	public static function cumsum(arr:Matrix):Matrix {
		return HStat.cumreduce(arr, function (a, b, c) { return a + b; },false);
	}


	// cumulative product of an array
	public static function cumprod(arr:Matrix):Matrix {
	return HStat.cumreduce(arr, function(a, b, c) { return a * b; },false);
	}


	// successive differences of a sequence
	public static function diff(arr:Matrix):Matrix {
	  var diffs = new Matrix();
	  diffs[0] = new Array<Float>();
	  var arrLen = arr[0].length;

	  for (i in 1 ... arrLen)
		diffs[0].push(arr[0][i] - arr[0][i - 1]);
	  return diffs;
	}


	// mode of an array
	// if there are multiple modes of an array, return all of them
	// is this the appropriate way of handling it?
	public static function mode(arr:Matrix):Matrix {
	  var _arr = sortAsc(arr);
	  var count = 1;
	  var maxCount = 0;
	  var numMaxCount = 0;
	  var mode_arr = new Matrix();
	  mode_arr[0] = new Array<Float>();
	  
	
	  for (i in 0...arr[0].length) {
		if (_arr[0][i] == _arr[0][i + 1]) {
		  count++;
		} else {
		  if (count > maxCount) {
			mode_arr[0] = [_arr[0][i]];
			maxCount = count;
			numMaxCount = 0;
		  }
		  // are there multiple max counts
		  else if (count == maxCount) {
			mode_arr[0].push(_arr[0][i]);
			numMaxCount++;
		  }
		  // resetting count for new value in array
		  count = 1;
		}
	  }

	  return mode_arr;
	}


	// range of an array
	public static function range(arr:Matrix):Float {
	  return max(arr) - min(arr);
	}

	// variance of an array
	// flag = true indicates sample instead of population
	public static function variance(arr:Matrix, flag:Bool = false):Float {
	  return sumsqerr(arr) / (arr[0].length - (flag ? 1 : 0));
	}


	// standard deviation of an array
	// flag = true indicates sample instead of population
	public static function stdev(arr:Matrix, flag:Bool = false):Float {
	  return Math.sqrt(variance(arr, flag));
	}


	// mean deviation (mean absolute deviation) of an array
	public static function meandev(arr:Matrix):Float {
	  var devSum:Float = 0;
	  var _mean:Float = mean(arr);
	  var i = arr[0].length;
	  while (--i >=0){
		devSum += Math.abs(arr[0][i] - _mean);
	  }
	  return devSum / arr[0].length;
	}


	// median deviation (median absolute deviation) of an array
	public static function meddev(arr:Matrix):Float {
	  var devSum:Float = 0;
	  var median:Float = median(arr);
	  var i = arr[0].length;
	  while(--i>=0){
		devSum += Math.abs(arr[0][i] - median);
	  }
	  return devSum / arr[0].length;
	}


	// coefficient of variation
	public static function coeffvar(arr:Matrix):Float {
	  return stdev(arr) / mean(arr);
	}


	// quartiles of an array
	public static function quartiles(arr:Matrix):Matrix {
	  var arrlen = arr[0].length;
	  var _arr = sortAsc(arr);
	  
	  var v = new Array<Float>();
	  v[v.length] = _arr[0][ Math.round((arrlen) / 4) - 1 ];
	  v[v.length] = _arr[0][ Math.round((arrlen) / 2) - 1 ];
	  v[v.length] = _arr[0][ Math.round((arrlen) * 3 / 4) - 1 ];

	  return [v];
	}
	
	public static function copyArr(a:Matrix):Matrix {
		var copy:Matrix = new Matrix();
		for (x in 0...a.length) {
			for (y in 0...a[x].length) {
				copy[x][y] = a[x][y];
			}
		}
		return copy;
	}


	// Arbitary quantiles of an array. Direct port of the scipy.stats
	// implementation by Pierre GF Gerard-Marchant.
	public static function quantiles(arr:Matrix, quantilesArray:Matrix, ?alphap:Float , ?betap:Float) {
	  var sortedArray:Matrix = sortAsc(	arr	);
	  var quantileVals:Matrix = new Matrix();
	  quantileVals[0] = new Array<Float>();
	  var n = arr[0].length;
	  var i, p, m, aleph, k, gamma;

	  if (alphap == null)
		alphap = 3 / 8;
	  if (betap == null)
		betap = 3 / 8;

	  for (i in 0... quantilesArray[0].length) {
		p = quantilesArray[0][i];
		m = alphap + p * (1 - alphap - betap);
		aleph = n * p + m;
		k = Math.floor(clip(aleph, 1, n - 1));
		gamma = clip(aleph - k, 0, 1);
		quantileVals[0][i] = (1 - gamma) * sortedArray[0][k - 1] + gamma * sortedArray[0][k];
	  }

	  return quantileVals;
	}

	// Returns the k-th percentile of values in a range, where k is in the
	// range 0..1, exclusive.
	public static function percentile(arr:Matrix, k:Float):Float {
	  var _arr = sortAsc(arr);
	  var realIndex:Float = k * (_arr[0].length - 1);
	  var index:Int = Std.int(realIndex);
	  var frac :Float= realIndex - index;

	  if (index + 1 < _arr[0].length) {
		return _arr[0][index] * (1 - frac) + _arr[0][index + 1] * frac;
	  } else {
		return _arr[0][index];
	  }
	}


	// The percentile rank of score in a given array. Returns the percentage
	// of all values in the input array that are less than (kind='strict') or
	// less or equal than (kind='weak') score. Default is weak.
	public static function percentileOfScore(arr:Matrix, score:Float, strict:Bool = false):Float {
	  var counter = 0;
	  var len = arr[0].length;
	  var value, i;


	  for (i in 0...len) {
		value = arr[0][i];
		if ((strict && value < score) ||
			(!strict && value <= score)) {
		  counter++;
		}
	  }

	  return counter / len;
	}


	// Histogram (bin count) data
	public static function histogram(arr:Matrix, binCount:Int = 4):Matrix {
	  var first = min(arr);
	  var binWidth:Float = (max(arr) - first) / binCount;
	  var len = arr[0].length;
	  var bins = new Matrix();
	  bins[0] = new Array<Float>();
	  var i;

	  for (i in 0...binCount)
		bins[0][i] = 0;
		
	  for (i in 0...len)
		bins[0][Std.int(Math.min(Math.floor(((arr[0][i] - first) / binWidth)), binCount - 1))] += 1;

	  return bins;
	}


	// covariance of two arrays
	public static function covariance(arr1:Matrix, arr2:Matrix):Float {
	  var u = mean(arr1);
	  var v = mean(arr2);
	  var arr1Len = arr1[0].length;
	  var sq_dev = new Matrix();
	  sq_dev[0] = new Array<Float>();
	
	  for (i in 0...arr1Len){
		sq_dev[0].push( (arr1[0][i] - u) * (arr2[0][i] - v)   );
	  }

	  return sum(sq_dev) / (arr1Len - 1);
	}


	// (pearson's) population correlation coefficient, rho
	public static function corrcoeff(arr1:Matrix, arr2:Matrix):Float {
	  return covariance(arr1, arr2) /
		  stdev(arr1, true) /
		  stdev(arr2, true);
	}

	// statistical standardized moments (general form of skew/kurt)
	public static function stanMoment(arr:Matrix, n:Float):Float {
	  var mu:Float = mean(arr);
	  var sigma:Float = stdev(arr);
	  var len:Int = arr[0].length;
	  var skewSum:Float = 0;

	  for (i in 0...len)
		skewSum += Math.pow((arr[0][i] - mu) / sigma, n);

	  return skewSum / arr[0].length;
	}

	// (pearson's) moment coefficient of skewness
	public static function skewness(arr:Matrix) {
	  return stanMoment(arr, 3);
	}

	// (pearson's) (excess) kurtosis
	public static function kurtosis(arr:Matrix) {
	  return stanMoment(arr, 4) - 3;
	}



	
}