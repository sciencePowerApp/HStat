package hstat;
import hstat.Distribution.NekoCorrection;

/**
 * ...
 * @author 
 */
class Special
{

// Log-gamma function
public static function gammaln(x:Float) {
  var j = 0;
  var cof = [
    76.18009172947146, -86.50532032941677, 24.01409824083091,
    -1.231739572450155, 0.1208650973866179e-2, -0.5395239384953e-5
  ];
  var ser = 1.000000000190015;
  var xx, y, tmp;
  tmp = (y = xx = x) + 5.5;
  tmp -= (xx + 0.5) * Math.log(tmp);
  for (j in 0... 6)
    ser += cof[j] / ++y;
  return Math.log(2.5066282746310005 * ser / xx) - tmp;
};


// gamma of x
public static  function gammafn(x:Float):Float {
  var p = [-1.716185138865495, 24.76565080557592, -379.80425647094563,
           629.3311553128184, 866.9662027904133, -31451.272968848367,
           -36144.413418691176, 66456.14382024054];
  var q = [-30.8402300119739, 315.35062697960416, -1015.1563674902192,
           -3107.771671572311, 22538.118420980151, 4755.8462775278811,
           -134659.9598649693, -115132.2596755535];
  var fact:Null<Float> = null;
  var n:Int = 0;
  var xden:Float = 0;
  var xnum:Float = 0;
  var y:Float = x;
  var i:Int, z:Float, yi:Float, res:Null<Float> = null, sum:Int, ysq:Int;
  if (y <= 0) {
	 
    res = y % 1 + 3.6e-16;
    if (res != null) {
			//not efficient. See https://groups.google.com/forum/#!topic/haxelang/u_cd2rK4_bw
	  var check:Bool = (Std.int(y) & 1) == 0;
      fact = (check ? 1 : -1) * Math.PI / Math.sin(Math.PI * res);
      y = 1 - y;
    } else {
      return Math.POSITIVE_INFINITY;
    }
  }
 
  yi = y;
  if (y < 1) {
    z = y++;
  } else {
    z = (y -= n = (Std.int(y) | 0) - 1) - 1;
  }
  for (i in 0...8) {
    xnum = (xnum + p[i]) * z;
    xden = xden * z + q[i];
  }
  res = xnum / xden + 1;
  
  if (yi < y) {
    res /= yi;
  } else if (yi > y) {
    for (i in 0...n) {
      res *= y;
      y++;
    }
  }

  if (fact != null) {
    res = fact / res;
  }
  return res;
};


// lower incomplete gamma function, which is usually typeset with a
// lower-case greek gamma as the function symbol
public static  function gammap(a:Float, x:Float) {
  return lowRegGamma(a, x) * gammafn(a);
}


// The lower regularized incomplete gamma function, usually written P(a,x)
public static  function lowRegGamma(a:Float, x:Float) {
  var aln = gammaln(a);
  var ap = a;
  var sum = 1 / a;
  var del = sum;
  var b = x + 1 - a;
  var c = 1 / 1.0e-30;
  var d = 1 / b;
  var h = d;
  var i = 1;
  // calculate maximum number of iterations required for a
  var ITMAX:Int = Std.int(-~(Math.log((a >= 1) ? a : 1 / a) * 8.5 + a * 0.4 + 17));
  var an, endval;

  if (x < 0 || a <= 0) {
    return Math.NaN;
  } else if (x < a + 1) {
    for (i in i...ITMAX) {
      sum += del *= x / ++ap;
    }
    return (sum * Math.exp(-x + a * Math.log(x) - (aln)));
  }

  for (i in i...ITMAX) {
    an = -i * (i - a);
    b += 2;
    d = an * d + b;
    c = b + an / c;
    d = 1 / d;
    h *= d * c;
  }

  return (1 - h * Math.exp(-x + a * Math.log(x) - (aln)));
};

// natural log factorial of n
public static  function factorialln(n:Float) {
  return n < 0 ? Math.NaN : gammaln(n + 1);
};

// factorial of n
public static  function factorial(n:Float) {
  return n < 0 ? Math.NaN : gammafn(n + 1);
};

// combinations of n, m
public static  function combination(n:Float, m:Float) {
  // make sure n or m don't exceed the upper limit of usable values
  return (n > 170 || m > 170)
      ? Math.exp(combinationln(n, m)) : (factorial(n) / factorial(m)) / factorial(n - m);
};


public static  function combinationln(n:Float, m:Float){
  return factorialln(n) - factorialln(m) - factorialln(n - m);
};


// permutations of n, m
public static  function permutation(n:Int, m:Int) {
  return factorial(n) / factorial(n - m);
};


// beta function
public static  function betafn(x:Float, y:Float):Null<Float> {
  // ensure arguments are positive
  if (x <= 0 || y <= 0)
	
    return null;
  // make sure x + y doesn't exceed the upper limit of usable values
  return (x + y > 170)
      ? Math.exp(betaln(x, y))
      : gammafn(x) * gammafn(y) / gammafn(x + y);
};


// natural logarithm of beta function
public static  function betaln(x:Float, y:Float) {
  return gammaln(x) + gammaln(y) - gammaln(x + y);
};


// Evaluates the continued fraction for incomplete beta function by modified
// Lentz's method.
public static  function betacf(x:Float, a:Float, b:Float) {
  var fpmin:Float = 1e-30;
  var m:Int = 1;
  var qab:Float = a + b;
  var qap:Float = a + 1;
  var qam:Float = a - 1;
  var c:Float = 1;
  var d:Float = 1 - qab * x / qap;
  var m2:Int, aa:Float, del:Float, h:Float;

  // These q's will be used in factors that occur in the coefficients
  if (Math.abs(d) < fpmin)
    d = fpmin;
  d = 1 / d;
  h = d;

  for (m in m...100) {
    m2 = 2 * m;
    aa = m * (b - m) * x / ((qam + m2) * (a + m2));
    // One step (the even one) of the recurrence
    d = 1 + aa * d;
    if (Math.abs(d) < fpmin)
      d = fpmin;
    c = 1 + aa / c;
    if (Math.abs(c) < fpmin)
      c = fpmin;
    d = 1 / d;
    h *= d * c;
    aa = -(a + m) * (qab + m) * x / ((a + m2) * (qap + m2));
    // Next step of the recurrence (the odd one)
    d = 1 + aa * d;
    if (Math.abs(d) < fpmin)
      d = fpmin;
    c = 1 + aa / c;
    if (Math.abs(c) < fpmin)
      c = fpmin;
    d = 1 / d;
    del = d * c;
    h *= del;
    if (Math.abs(del - 1.0) < 3e-7)
      break;
  }

  return h;
};


// Returns the inverse of the lower regularized inomplete gamma function
public static  function gammapinv(p:Float, a:Float) {
  var j = 0;
  var a1 = a - 1;
  var EPS = 1e-8;
  var gln = gammaln(a);
  var x, err, t, u, pp, lna1 = Math.NEGATIVE_INFINITY, afac = Math.NEGATIVE_INFINITY;

  if (p >= 1)
    return Math.max(100, a + 100 * Math.sqrt(a));
  if (p <= 0)
    return 0;
  if (a > 1) {
    lna1 = Math.log(a1);
    afac = Math.exp(a1 * (lna1 - 1) - gln);
    pp = (p < 0.5) ? p : 1 - p;
    t = Math.sqrt(-2 * Math.log(pp));
    x = (2.30753 + t * 0.27061) / (1 + t * (0.99229 + t * 0.04481)) - t;
    if (p < 0.5)
      x = -x;
    x = Math.max(1e-3,
                 a * Math.pow(1 - 1 / (9 * a) - x / (3 * Math.sqrt(a)), 3));
  } else {
    t = 1 - a * (0.253 + a * 0.12);
    if (p < t)
      x = Math.pow(p / t, 1 / a);
    else
      x = 1 - Math.log(1 - (p - t) / (1 - t));
  }

  for(i in  j ...12) {
    if (x <= 0)
      return 0;
    err = lowRegGamma(a, x) - p;
  if (a > 1){
		if (afac == Math.NEGATIVE_INFINITY || lna1 == Math.NEGATIVE_INFINITY) throw "";
      t = afac * Math.exp( -(x - a1) + a1 * (Math.log(x) - lna1));
	}
    else
      t = Math.exp(-x + a1 * Math.log(x) - gln);
    u = err / t;
    x -= (t = u / (1 - 0.5 * Math.min(1, u * ((a - 1) / x - 1))));
    if (x <= 0)
      x = 0.5 * (x + t);
    if (Math.abs(t) < EPS * x)
      break;
  }

  return x;
};


// Returns the error function erf(x)
public static  function erf(x:Float) {
  var cof:Array<Float> = [-1.3026537197817094, 6.4196979235649026e-1, 1.9476473204185836e-2,
             -9.561514786808631e-3, -9.46595344482036e-4, 3.66839497852761e-4,
             4.2523324806907e-5, -2.0278578112534e-5, -1.624290004647e-6,
             1.303655835580e-6, 1.5626441722e-8, -8.5238095915e-8,
             6.529054439e-9, 5.059343495e-9, -9.91364156e-10,
             -2.27365122e-10, 9.6467911e-11, 2.394038e-12,
             -6.886027e-12, 8.94487e-13, 3.13092e-13,
             -1.12708e-13, 3.81e-16, 7.106e-15,
             -1.523e-15, -9.4e-17, 1.21e-16,
             -2.8e-17];
  var j = cof.length - 1;
  var isneg = false;
  var d:Float = 0;
  var dd:Float = 0;
  var t, ty:Float, tmp, res;

  if (x < 0) {
    x = -x;
    isneg = true;
  }

  t = 2 / (2 + x);
  ty = 4 * t - 2;

  while(j>0)  {
	 
    tmp = d;
    d = ty * d - dd + cof[j];
    dd = tmp;
	j--;
  }
  #if neko
	res = t * NekoCorrection.exp(-x * x + 0.5 * (cof[0] + ty * d) - dd);
  #else 
	res = t * Math.exp(-x * x + 0.5 * (cof[0] + ty * d) - dd);
  #end
  return isneg ? res - 1 : 1 - res;
};


// Returns the complmentary error function erfc(x)
public static  function erfc(x):Float {
  return 1 - erf(x);
};


// Returns the inverse of the complementary error function
public static  function erfcinv(p:Float):Float {
  var j = 0;
  var x:Float, err, t, pp:Float;
  if (p >= 2)
    return -100;
  if (p <= 0)
    return 100;
  pp = (p < 1) ? p : 2 - p;

  t = Math.sqrt(-2 * Math.log(pp / 2));
  x = -0.70711 * ((2.30753 + t * 0.27061) /
                  (1 + t * (0.99229 + t * 0.04481)) - t);
  while (j++ < 2) {
    err = erfc(x) - pp;
    x += err / (1.12837916709551257 * Math.exp( -x * x) - x * err);
	
  }
  return (p < 1) ? x : -x;
};


// Returns the inverse of the incomplete beta function
public static  function ibetainv(p:Float, a:Float, b:Float):Float {
  var EPS = 1e-8;
  var a1 = a - 1;
  var b1 = b - 1;
  var j = 0;
  var lna, lnb, pp, t, u, err, x:Float, al, h, w, afac;
  if (p <= 0)
    return 0;
  if (p >= 1)
    return 1;
  if (a >= 1 && b >= 1) {
    pp = (p < 0.5) ? p : 1 - p;
    t = Math.sqrt(-2 * Math.log(pp));
    x = (2.30753 + t * 0.27061) / (1 + t* (0.99229 + t * 0.04481)) - t;
    if (p < 0.5)
      x = -x;
    al = (x * x - 3) / 6;
    h = 2 / (1 / (2 * a - 1)  + 1 / (2 * b - 1));
    w = (x * Math.sqrt(al + h) / h) - (1 / (2 * b - 1) - 1 / (2 * a - 1)) *
        (al + 5 / 6 - 2 / (3 * h));
    x = a / (a + b * Math.exp(2 * w));
  } else {
    lna = Math.log(a / (a + b));
    lnb = Math.log(b / (a + b));
    t = Math.exp(a * lna) / a;
    u = Math.exp(b * lnb) / b;
    w = t + u;
    if (p < t / w)
      x = Math.pow(a * w * p, 1 / a);
    else
      x = 1 - Math.pow(b * w * (1 - p), 1 / b);
  }
  afac = -gammaln(a) - gammaln(b) + gammaln(a + b);
  for(j in  j ... 10) {
    if (x == 0 || x == 1)
      return x;
    err = ibeta(x, a, b) - p;
    t = Math.exp(a1 * Math.log(x) + b1 * Math.log(1 - x) + afac);
    u = err / t;
    x -= (t = u / (1 - 0.5 * Math.min(1, u * (a1 / x - b1 / (1 - x)))));
    if (x <= 0)
      x = 0.5 * (x + t);
    if (x >= 1)
      x = 0.5 * (x + t + 1);
    if (Math.abs(t) < EPS * x && j > 0)
      break;
  }
  return x;
};


// Returns the incomplete beta function I_x(a,b)
public static function ibeta(x:Float, a:Float, b:Float):Float {
  // Factors in front of the continued fraction.
  var bt = (x == 0 || x == 1) ?  0 :
    Math.exp(gammaln(a + b) - gammaln(a) -
             gammaln(b) + a * Math.log(x) + b *
             Math.log(1 - x));
			
  if (x < 0 || x > 1){
	throw "illegal parameter?";
  }
  
  if (x < (a + 1) / (a + b + 2))
    // Use continued fraction directly.
    return bt * betacf(x, a, b) / a;
  // else use continued fraction after making the symmetry transformation.

  return 1 - bt * betacf(1 - x, b, a) / b;
};


// Returns a normal deviate (mu=0, sigma=1).
// If n and m are specified it returns a object of normal deviates.
public static  function randn(n:Null<Int> = null, m:Null<Int> = null):Dynamic {
  var u, v, x, y, q, mat;
  if (m  == null) m = n;
  if (n != null) {
	 throw "not implemented yet"; 
    //return create(n, m, function(fakea:Dynamic, fakeb:Dynamic) { return Special.randn(null, null); } );
  }
  do {
    u = Math.random();
    v = 1.7156 * (Math.random() - 0.5);
    x = u - 0.449871;
    y = Math.abs(v) + 0.386595;
    q = x * x + y * (0.19600 * y - 0.25472 * x);
  } while (q > 0.27597 && (q > 0.27846 || v * v > -4 * Math.log(u) * u * u));
  return v / u;
};


// Returns a gamma deviate by the method of Marsaglia and Tsang.
public static  function randg(shape:Null<Float>, n:Null<Float> = null, m:Null<Float> = null):Float {
  var oalph = shape;
  var a1, a2, u, v, x, mat;
  if (m == null)
    m = n;
  if (shape == null)
    shape = 1;
  if (n != null) {
    //mat = HStat.zeros(n,m);
    //mat.alter(function(fakea:Dynamic, fakeb:Dynamic) { return Special.randg(shape, null, null); });
    throw "not impl";
	//eturn mat;
  }
  if (shape < 1)
    shape += 1;
  a1 = shape - 1 / 3;
  a2 = 1 / Math.sqrt(9 * a1);
  do {
    do {
      x = randn(null,null);
      v = 1 + a2 * x;
    } while(v <= 0);
    v = v * v * v;
    u = Math.random();
  } while(u > 1 - 0.331 * Math.pow(x, 4) &&
          Math.log(u) > 0.5 * x*x + a1 * (1 - v + Math.log(v)));
  // alpha > 1
  if (shape == oalph)
    return a1 * v;
  // alpha < 1
  do {
    u = Math.random();
  } while(u == 0);
  return Math.pow(u, 1 / oalph) * a1 * v;
};



	
}