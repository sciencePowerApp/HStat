package hstat;

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
	public static function sum(arr:Array<Float>):Float {
	  var sum:Float = 0;
	  var i = arr.length;
	  while (--i >= 0)
		sum += arr[i];
	  return sum;
	}


	// sum squared
	public static function sumsqrd(arr:Array<Float>):Float {
	  var sum:Float = 0;
	  var i = arr.length;
	  while (--i >= 0)
		sum += arr[i] * arr[i];
	  return sum;
	}


	// sum of squared errors of prediction (SSE)
	public static function sumsqerr(arr:Array<Float>):Float {
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
	public static function sumrow(arr:Array<Float>):Float {
	  var sum:Float = 0;
	  var i = arr.length;
	  while (--i >= 0)
		sum += arr[i];
	  return sum;
	}

	// product of an array
	public static function product(arr:Array<Float>):Float{
	  var prod:Float = 1;
	  var i = arr.length;
	  while (--i >= 0)
		prod *= arr[i];
	  return prod;
	}


	// minimum value of an array
	public static function min(arr:Array<Float>):Float {
	  var low:Float = arr[0];
	  var i = 0;
	  while (++i < arr.length)
		if (arr[i] < low)
		  low = arr[i];
	  return low;
	}


	// maximum value of an array
	public static function max(arr:Array<Float>):Float {
	  var high:Float = arr[0];
	  var i = 0;
	  while (++i < arr.length)
		if (arr[i] > high)
		  high = arr[i];
	  return high;
	}


	// mean value of an array
	public static function mean(arr:Array<Float>):Float {
	  return sum(arr) / arr.length;
	}


	// mean squared error (MSE)
	public static function meansqerr(arr:Array<Float>) {
	  return sumsqerr(arr) / arr.length;
	}


	// geometric mean of an array
	public static function geomean(arr:Array<Float>) {
	  return Math.pow(product(arr), 1 / arr.length);
	}


	public static function sortAsc(arr:Array<Float>):Array<Float> {
		arr.slice(0).sort(function(a:Float, b:Float):Int {
					if (a == b) return 0; 
					else if (a > b) return 1;
					return -1;
                 });
		return arr;
	}
	
	
	// median of an array
	//https://stackoverflow.com/questions/25305640/find-median-values-from-array-in-javascript-8-values-or-9-values
	public static function median(arr:Array<Float>) {
	  var arrlen = arr.length;
	  var m:Array<Float>  = sortAsc(arr);

	  
	var middle = Math.floor((m.length - 1) / 2); // NB: operator precedence
    if (m.length % 2 == 1) {
        return m[middle];
    } else {
        return (m[middle] + m[middle + 1]) / 2.0;
    }
	}


	// cumulative sum of an array
	public static function cumsum(arr:Array<Float>) {
		HStat.cumreduce_arr(arr, function (a, b, c) { return a + b; },false);
	}


	// cumulative product of an array
	public static function cumprod(arr) {
	return HStat.cumreduce_arr(arr, function(a, b, c) { return a * b; },false);
	}


	// successive differences of a sequence
	public static function diff(arr:Array<Float>) {
	  var diffs = [];
	  var arrLen = arr.length;

	  for (i in 1 ... arrLen)
		diffs.push(arr[i] - arr[i - 1]);
	  return diffs;
	}


	// mode of an array
	// if there are multiple modes of an array, return all of them
	// is this the appropriate way of handling it?
	public static function mode(arr:Array<Float>):Array<Float> {
	  var arrLen = arr.length;
	  var _arr = sortAsc(arr);
	  var count = 1;
	  var maxCount = 0;
	  var numMaxCount = 0;
	  var mode_arr = [];
	  var i;

	  for (i in 0...arrLen) {
		if (_arr[i] == _arr[i + 1]) {
		  count++;
		} else {
		  if (count > maxCount) {
			mode_arr = [_arr[i]];
			maxCount = count;
			numMaxCount = 0;
		  }
		  // are there multiple max counts
		  else if (count == maxCount) {
			mode_arr.push(_arr[i]);
			numMaxCount++;
		  }
		  // resetting count for new value in array
		  count = 1;
		}
	  }

	  return mode_arr;
	}


	// range of an array
	public static function range(arr:Array<Float>):Float {
	  return max(arr) - min(arr);
	}

	// variance of an array
	// flag = true indicates sample instead of population
	public static function variance(arr:Array<Float>, flag:Bool= false):Float {
	  return sumsqerr(arr) / (arr.length - (flag ? 1 : 0));
	}


	// standard deviation of an array
	// flag = true indicates sample instead of population
	public static function stdev(arr:Array<Float>, flag:Bool=false):Float{
	  return Math.sqrt(variance(arr, flag));
	}


	// mean deviation (mean absolute deviation) of an array
	public static function meandev(arr:Array<Float>):Float {
	  var devSum:Float = 0;
	  var mean:Float = mean(arr);
	  var i;
	  for (i in arr.length...0)
		devSum += Math.abs(arr[i] - mean);
	  return devSum / arr.length;
	}


	// median deviation (median absolute deviation) of an array
	public static function meddev(arr:Array<Float>):Float {
	  var devSum:Float = 0;
	  var median:Float = median(arr);
	  var i;
	  for (i in arr.length...0)
		devSum += Math.abs(arr[i] - median);
	  return devSum / arr.length;
	}


	// coefficient of variation
	public static function coeffvar(arr:Array<Float>):Float {
	  return stdev(arr) / mean(arr);
	}


	// quartiles of an array
	public static function quartiles(arr:Array<Float>) {
	  var arrlen = arr.length;
	  var _arr = sortAsc(arr);
	  return [
		_arr[ Math.round((arrlen) / 4) - 1 ],
		_arr[ Math.round((arrlen) / 2) - 1 ],
		_arr[ Math.round((arrlen) * 3 / 4) - 1 ]
	  ];
	}


	// Arbitary quantiles of an array. Direct port of the scipy.stats
	// implementation by Pierre GF Gerard-Marchant.
	public static function quantiles(arr:Array<Float>, quantilesArray:Array<Float>, ?alphap:Float , ?betap:Float) {
	  var sortedArray:Array<Float> = sortAsc(arr);
	  var quantileVals:Array<Float> = new Array<Float>();
	  var n = arr.length;
	  var i, p, m, aleph, k, gamma;

	  if (alphap == null)
		alphap = 3 / 8;
	  if (betap == null)
		betap = 3 / 8;

	  for (i in 0... quantilesArray.length) {
		p = quantilesArray[i];
		m = alphap + p * (1 - alphap - betap);
		aleph = n * p + m;
		k = Math.floor(clip(aleph, 1, n - 1));
		gamma = clip(aleph - k, 0, 1);
		quantileVals[i] = (1 - gamma) * sortedArray[k - 1] + gamma * sortedArray[k];
	  }

	  return quantileVals;
	}

	// Returns the k-th percentile of values in a range, where k is in the
	// range 0..1, exclusive.
	public static function percentile(arr:Array<Float>, k:Float) {
	  var _arr = sortAsc(arr);
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
	public static function percentileOfScore(arr:Array<Float>, score, kind) {
	  var counter = 0;
	  var len = arr.length;
	  var strict = false;
	  var value, i;

	  if (kind == 'strict')
		strict = true;

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
	public static function histogram(arr:Array<Float>, binCount:Int = 4) {
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
	public static function covariance(arr1:Array<Float>, arr2:Array<Float>) {
	  var u = mean(arr1);
	  var v = mean(arr2);
	  var arr1Len = arr1.length;
	  var sq_dev = new Array<Float>();
	  var i;

	  for (i in 0...arr1Len)
		sq_dev[i] = (arr1[i] - u) * (arr2[i] - v);

	  return sum(sq_dev) / (arr1Len - 1);
	}


	// (pearson's) population correlation coefficient, rho
	public static function corrcoeff(arr1:Array<Float>, arr2:Array<Float>) {
	  return covariance(arr1, arr2) /
		  stdev(arr1, true) /
		  stdev(arr2, true);
	}

	// statistical standardized moments (general form of skew/kurt)
	public static function stanMoment(arr:Array<Float>, n:Float):Float {
	  var mu:Float = mean(arr);
	  var sigma:Float = stdev(arr);
	  var len:Int = arr.length;
	  var skewSum:Float = 0;

	  for (i in 0...len)
		skewSum += Math.pow((arr[i] - mu) / sigma, n);

	  return skewSum / arr.length;
	}

	// (pearson's) moment coefficient of skewness
	public static function skewness(arr:Array<Float>) {
	  return stanMoment(arr, 3);
	}

	// (pearson's) (excess) kurtosis
	public static function kurtosis(arr:Array<Float>) {
	  return stanMoment(arr, 4) - 3;
	}



	
}