package hstat;


class Distribution
{

}

class NekoCorrection {
	public static function exp(val:Float):Float{
		if (val == Math.NEGATIVE_INFINITY) return 0;
		else if (val == Math.POSITIVE_INFINITY) return Math.POSITIVE_INFINITY;
		return  Math.exp(val);
	}	
}


class Beta{

///////////////////

// extend beta function with static methods

	 public static function pdf(x:Float, alpha:Float, beta:Float):Float {
    // PDF is zero outside the support
    if (x > 1 || x < 0)
      return 0;
    // PDF is one for the uniform case
    if (alpha == 1 && beta == 1)
      return 1;

    if (alpha < 512 || beta < 512) {
      return (Math.pow(x, alpha - 1) * Math.pow(1 - x, beta - 1)) /
          Special.betafn(alpha, beta);
    } else {
      return Math.exp((alpha - 1) * Math.log(x) +
                      (beta - 1) * Math.log(1 - x) -
                      Special.betaln(alpha, beta));
    }
  }

  public static function cdf(x:Float, alpha:Float, beta:Float):Float {  
	var mod:Float = x > 1?1:0;
	return (x > 1 || x < 0) ? mod : Special.ibeta(x, alpha, beta);
  }

  public static  function inv(x, alpha, beta):Float {
    return Special.ibetainv(x, alpha, beta);
  }

  public static function mean(alpha, beta):Float {
    return alpha / (alpha + beta);
  }

  public static function median(alpha:Float, beta:Float):Float {
    return Special.ibetainv(0.5, alpha, beta);
  }

  public static function mode(alpha:Float, beta:Float):Float {
    return (alpha - 1 ) / ( alpha + beta - 2);
  }

  // return a random sample
  public static function sample(alpha:Float, beta:Float):Float {
    var u = Special.randg(alpha, null, null);
    return u / (u + Special.randg(beta, null,null));
  }

  public static function variance(alpha:Float, beta:Float):Float {
    return (alpha * beta) / (Math.pow(alpha + beta, 2) * (alpha + beta + 1));
  }


}


class CentralF{


	public static function pdf(x:Float, df1:Float, df2:Float):Float {
    var p, q, f:Float;

    if (x < 0)
      return 0;

    if (df1 <= 2) {
      if (x == 0 && df1 < 2) {
        return Math.POSITIVE_INFINITY;
      }
      if (x == 0 && df1 == 2) {
        return 1;
      }
      return Math.sqrt((Math.pow(df1 * x, df1) * Math.pow(df2, df2)) /
                       (Math.pow(df1 * x + df2, df1 + df2))) /
                       (x * Special.betafn(df1/2, df2/2));
    }

    p = (df1 * x) / (df2 + x * df1);
    q = df2 / (df2 + x * df1);
    f = df1 * q / 2.0;
    return f * Binomial.pdf((df1 - 2) / 2, (df1 + df2 - 2) / 2, p);
  }

  public static function cdf(x:Float, df1:Float, df2:Float):Float {
    if (x < 0) return 0;
    return Special.ibeta((df1 * x) / (df1 * x + df2), df1 / 2, df2 / 2);
  }

  public static function inv(x:Float, df1:Float, df2:Float):Float {
    return df2 / (df1 * (1 / Special.ibetainv(x, df1 / 2, df2 / 2) - 1));
  }

  public static function mean(df1:Float, df2:Float):Null<Float> {
    return (df2 > 2) ? df2 / (df2 - 2) : null;
  }
 
  public static function mode(df1:Float, df2:Float):Null<Float> {
    return (df1 > 2) ? (df2 * (df1 - 2)) / (df1 * (df2 + 2)) : null;
  }

  // return a random sample
  public static function sample(df1:Float, df2:Float):Float {
    var x1 = Special.randg(df1 / 2,null,null) * 2;
    var x2 = Special.randg(df2 / 2,null,null) * 2;
    return (x1 / df1) / (x2 / df2);
  }

  public static  function variance(df1:Float, df2:Float):Null<Float> {
    if (df2 <= 4)
      return null;
    return 2 * df2 * df2 * (df1 + df2 - 2) /
        (df1 * (df2 - 2) * (df2 - 2) * (df2 - 4));
  }
}

class Cauchy {

  public static function pdf(x:Float, local:Float, scale:Float):Float {
    return (scale / (Math.pow(x - local, 2) + Math.pow(scale, 2))) / Math.PI;
  }

  public static function cdf(x:Float, local:Float, scale:Float):Float {
    return Math.atan((x - local) / scale) / Math.PI + 0.5;
  }

  public static function inv(p:Float, local:Float, scale):Float {
    return local + scale * Math.tan(Math.PI * (p - 0.5));
  }

  public static function median(local:Float, scale:Float):Float {
    return local;
  }

  public static function mode(local:Float, scale:Float):Float {
    return local;
  }

  public static function sample(local:Float, scale:Float):Float {
    return Special.randn(null, null) *
        Math.sqrt(1 / (2 * Special.randg(0.5))) * scale + local;
  }
}


class Chisquare {
public static function pdf(x:Float, dof):Float {
    if (x < 0)
      return 0;
	#if neko
		return (x == 0 && dof == 2) ? 0.5 :
        NekoCorrection.exp((dof / 2 - 1) * Math.log(x) - x / 2 - (dof / 2) *
                 Math.log(2) - Special.gammaln(dof / 2));
	#end
	//trace(Math.exp(Math.log(0)),Math.log(x),x);
    return (x == 0 && dof == 2) ? 0.5 :
        Math.exp((dof / 2 - 1) * Math.log(x) - x / 2 - (dof / 2) *
                 Math.log(2) - Special.gammaln(dof / 2));
  }
  
  public static function cdf(x:Float, dof:Float):Float {
    if (x < 0)
      return 0;
    return Special.lowRegGamma(dof / 2, x / 2);
  }
  
  public static function inv(p:Float, dof:Float):Float {
    return 2 * Special.gammapinv(p, 0.5 * dof);
  }
  
  public static function mean(dof:Float):Float {
    return dof;
  }
  
  public static function median(dof:Float):Float {
    return dof * Math.pow(1 - (2 / (9 * dof)), 3);
  }
  
  public static function mode(dof:Float):Float {
    return (dof - 2 > 0) ? dof - 2 : 0;
  }
  
  public static function sample(dof:Float):Float {
    return Special.randg(dof / 2) * 2;
  }
  
  public static function variance(dof:Float):Float {
    return 2 * dof;
  }
}


class Exponential{
	public static function pdf(x:Float, rate:Float):Float {
    return x < 0 ? 0 : rate * Math.exp(-rate * x);
  }

  public static function cdf(x:Float, rate:Float):Float {
    return x < 0 ? 0 : 1 - Math.exp(-rate * x);
  }

  public static function inv(p:Float, rate:Float):Float {
    return -Math.log(1 - p) / rate;
  }

  public static function mean(rate:Float):Float {
    return 1 / rate;
  }

  public static function neduab(rate:Float):Float {
    return (1 / rate) * Math.log(2);
  }

  public static function mode(rate:Float):Float {
    return 0;
  }

  public static function sample(rate:Float):Float {
    return -1 / rate * Math.log(Math.random());
  }

  public static function variance(rate:Float):Float {
    return Math.pow(rate, -2);
  }
}


class Gamma{

	public static function pdf(x:Float, shape:Float, scale:Float):Float {
    if (x < 0)
      return 0;
    return (x == 0 && shape == 1) ? 1 / scale :
            Math.exp((shape - 1) * Math.log(x) - x / scale -
                    Special.gammaln(shape) - shape * Math.log(scale));
  }

public static function cdf(x:Float, shape:Float, scale:Float):Float {
    if (x < 0)
      return 0;
    return Special.lowRegGamma(shape, x / scale);
  }

	public static function inv(p:Float, shape:Float, scale:Float):Float {
    return Special.gammapinv(p, shape) * scale;
  }

  public static function mean(shape:Float, scale:Float):Float {
    return shape * scale;
  }

  public static function mode(shape:Float, scale:Float):Null<Float> {
    if(shape > 1) return (shape - 1) * scale;
    return null;
  }

  public static function sample(shape:Float, scale:Float):Float {
    return Special.randg(shape) * scale;
  }

  public static function variance(shape:Float, scale:Float):Float {
    return shape * scale * scale;
  }
}

class Invgamma{
public static function pdf(x:Float, shape:Float, scale:Float):Float {
    if (x <= 0)
      return 0;
    return Math.exp(-(shape + 1) * Math.log(x) - scale / x -
                    Special.gammaln(shape) + shape * Math.log(scale));
  }

public static function cdf(x:Float, shape:Float, scale:Float):Float {
    if (x <= 0)
      return 0;
    return 1 - Special.lowRegGamma(shape, scale / x);
  }

public static function inv(p:Float, shape:Float, scale:Float):Float {
    return scale / Special.gammapinv(1 - p, shape);
  }

public static  function mean(shape:Float, scale:Float):Null<Float> {
    return (shape > 1) ? scale / (shape - 1) : null;
  }

 public static  function mode(shape:Float, scale:Float):Float {
    return scale / (shape + 1);
  }

public static function sample(shape:Float, scale:Float):Float {
    return scale / Special.randg(shape);
  }

public static  function variance(shape:Float, scale:Float):Null<Float> {
    if (shape <= 2)
      return null;
    return scale * scale / ((shape - 1) * (shape - 1) * (shape - 2));
  }
}


class Kumaraswamy{

	public static function pdf(x:Float, alpha:Float, beta:Float):Float {
	
	if (x < 0 || x>1)
      return 0;

    if (x == 0 && alpha == 1)
      return beta;
    else if (x == 1 && beta == 1)
      return alpha;
	 
	#if neko
		return NekoCorrection.exp(Math.log(alpha) + Math.log(beta) + (alpha - 1) *
                    Math.log(x) + (beta - 1) *
                    Math.log(1 - Math.pow(x, alpha)));
	#end
	  
    return Math.exp(Math.log(alpha) + Math.log(beta) + (alpha - 1) *
                    Math.log(x) + (beta - 1) *
                    Math.log(1 - Math.pow(x, alpha)));
  }

  public static function cdf(x:Float, alpha:Float, beta:Float):Float {
    if (x < 0)
      return 0;
    else if (x > 1)
      return 1;
    return (1 - Math.pow(1 - Math.pow(x, alpha), beta));
  }

  public static function inv(p:Float, alpha:Float, beta:Float):Float {
    return Math.pow(1 - Math.pow(1 - p, 1 / beta), 1 / alpha);
  }

  public static function mean(alpha, beta):Float {
    return (beta * Special.gammafn(1 + 1 / alpha) *
            Special.gammafn(beta)) / (Special.gammafn(1 + 1 / alpha + beta));
  }

  public static function median(alpha:Float, beta:Float):Float {
    return Math.pow(1 - Math.pow(2, -1 / beta), 1 / alpha);
  }

  public static function mode(alpha:Float, beta:Float):Null<Float> {
    if (!(alpha >= 1 && beta >= 1 && (alpha != 1 && beta != 1)))
      return null;
    return Math.pow((alpha - 1) / (alpha * beta - 1), 1 / alpha);
  }

  public static function variance(alpha:Float, beta:Float):Float {
    throw 'variance not yet implemented';
    // TODO: complete this
  }
}


class Lognormal{


	public static function pdf(x:Float, mu:Float, sigma:Float):Float {
    if (x <= 0)
      return 0;
    return Math.exp(-Math.log(x) - 0.5 * Math.log(2 * Math.PI) -
                    Math.log(sigma) - Math.pow(Math.log(x) - mu, 2) /
                    (2 * sigma * sigma));
  }

  public static function cdf(x:Float, mu:Float, sigma:Float):Float {
    if (x < 0)
      return 0;
    return 0.5 +
        (0.5 * Special.erf((Math.log(x) - mu) / Math.sqrt(2 * sigma * sigma)));
  }

  public static function inv(p:Float, mu:Float, sigma:Float):Float {
    return Math.exp(-1.41421356237309505 * sigma * Special.erfcinv(2 * p) + mu);
  }

  public static function mean(mu:Float, sigma:Float):Float {
    return Math.exp(mu + sigma * sigma / 2);
  }

  public static function median(mu:Float, sigma:Float):Float {
    return Math.exp(mu);
  }

  public static function mode(mu:Float, sigma:Float):Float {
    return Math.exp(mu - sigma * sigma);
  }

  public static function sample(mu:Float, sigma:Float):Float {
    return Math.exp(Special.randn() * sigma + mu);
  }

  public static function variance(mu:Float, sigma:Float):Float {
    return (Math.exp(sigma * sigma) - 1) * Math.exp(2 * mu + sigma * sigma);
  }
}

class Noncentralt{

	public static function pdf(x:Float, dof:Float, ncp:Float):Float {
    var tol = 1e-14;
    if (Math.abs(ncp) < tol)  // ncp approx 0; use student-t
      return Studentt.pdf(x, dof);
	

    if (Math.abs(x) < tol) {  // different formula for x == 0
      return Math.exp(Special.gammaln((dof + 1) / 2) - ncp * ncp / 2 -
                      0.5 * Math.log(Math.PI * dof) - Special.gammaln(dof / 2));
    }

    // formula for x != 0
    return dof / x *
        (Noncentralt.cdf(x * Math.sqrt(1 + 2 / dof), dof+2, ncp) -
         Noncentralt.cdf(x, dof, ncp));
  }

  public static function cdf(x:Float, dof:Float, ncp:Float):Float {
    var tol = 1e-14;
    var min_iterations = 200;

    if (Math.abs(ncp) < tol)  // ncp approx 0; use student-t
      return Studentt.cdf(x, dof);

    // turn negative x into positive and flip result afterwards
    var flip = false;
    if (x < 0) {
      flip = true;
      ncp = -ncp;
    }

    var prob = Normal.cdf(-ncp, 0, 1);
    var value = tol + 1;
    // use value at last two steps to determine convergence
    var lastvalue = value;
    var y = x * x / (x * x + dof);
    var j = 0;
    var p = Math.exp(-ncp * ncp / 2);
    var q = Math.exp(-ncp * ncp / 2 - 0.5 * Math.log(2) -
                     Special.gammaln(3 / 2)) * ncp;
    while (j < min_iterations || lastvalue > tol || value > tol) {
      lastvalue = value;
      if (j > 0) {
        p *= (ncp * ncp) / (2 * j);
        q *= (ncp * ncp) / (2 * (j + 1 / 2));
      }
      value = p * Beta.cdf(y, j + 0.5, dof / 2) +
          q * Beta.cdf(y, j+1, dof/2);
      prob += 0.5 * value;
      j++;
    }

    return flip ? (1 - prob) : prob;
  }
}

class Normal{

public static function pdf(x:Float, mean:Float, std:Float):Float {
    return Math.exp(-0.5 * Math.log(2 * Math.PI) -
                    Math.log(std) - Math.pow(x - mean, 2) / (2 * std * std));
  }

public static function cdf(x:Float, mean:Float, std:Float):Float {
    return 0.5 * (1 + Special.erf((x - mean) / Math.sqrt(2 * std * std)));
  }
  
public static function inv(p:Float, mean:Float, std:Float):Float {
    return -1.41421356237309505 * std * Special.erfcinv(2 * p) + mean;
  }

  public static function mean(mean:Float, std:Float):Float {
    return mean;
  }

public static function median(mean:Float, std:Float):Float {
	throw "error?";
    return mean;
  }

public static function mode(mean:Float, std:Float):Float {
	throw "error?";
    return mean;
  }

public static function sample(mean:Float, std:Float):Float {
    return Special.randn() * std + mean;
  }

public static function variance(mean:Float, std:Float):Float {
    return std * std;
  }
}


class Pareto{
public static function pdf(x:Float, scale:Float, shape:Float):Float {
    if (x < scale)
      return 0;
    return (shape * Math.pow(scale, shape)) / Math.pow(x, shape + 1);
  }

public static function cdf(x:Float, scale:Float, shape:Float):Float {
    if (x < scale)
      return 0;
    return 1 - Math.pow(scale / x, shape);
  }

public static function inv(p:Float, scale:Float, shape:Float):Float {
    return scale / Math.pow(1 - p, 1 / shape);
  }

public static function mean(scale:Float, shape:Float):Null<Float> {
    if (shape <= 1)
      return null;
    return (shape * Math.pow(scale, shape)) / (shape - 1);
  }

public static function median(scale:Float, shape:Float):Float {
    return scale * (shape * Math.sqrt(2));
  }

public static function mode(scale:Float, shape:Float):Float {
    return scale;
  }

public static function variance(scale:Float, shape:Float):Null<Float> {
    if (shape <= 2)
      return null;
    return (scale*scale * shape) / (Math.pow(shape - 1, 2) * (shape - 2));
  }
}


class Studentt{

public static function pdf(x:Float, dof:Float):Float {
    dof = dof > 1e100 ? 1e100 : dof;
    return (1/(Math.sqrt(dof) * Special.betafn(0.5, dof/2))) *
        Math.pow(1 + ((x * x) / dof), -((dof + 1) / 2));
  }

public static function cdf(x:Float, dof:Float):Float {
    var dof2 = dof / 2;
    return Special.ibeta((x + Math.sqrt(x * x + dof)) /
                       (2 * Math.sqrt(x * x + dof)), dof2, dof2);
  }

public static function inv(p:Float, dof:Float):Float {
    var x = Special.ibetainv(2 * Math.min(p, 1 - p), 0.5 * dof, 0.5);
    x = Math.sqrt(dof * (1 - x) / x);
    return (p > 0.5) ? x : -x;
  }

public static function mean(dof:Float):Null<Float> {
    return (dof > 1) ? 0 : null;
  }

public static function median(dof:Float):Float {
    return 0;
  }

public static function mode(dof:Float):Float {
    return 0;
  }

public static function sample(dof:Float):Float {
    return Special.randn() * Math.sqrt(dof / (2 * Special.randg(dof / 2)));
  }

public static function variance(dof:Float):Null<Float> {
    return (dof  > 2) ? dof / (dof - 2) : (dof > 1) ? Math.POSITIVE_INFINITY : null;
  }
}



class Weibull{

public static function pdf(x:Float, scale:Float, shape:Float):Float {
    if (x < 0)
      return 0;
    return (shape / scale) * Math.pow((x / scale), (shape - 1)) *
        Math.exp(-(Math.pow((x / scale), shape)));
  }

public static function cdf(x:Float, scale:Float, shape:Float):Float {
    return x < 0 ? 0 : 1 - Math.exp(-Math.pow((x / scale), shape));
  }

public static function inv(p:Float, scale:Float, shape:Float):Float {
    return scale * Math.pow(-Math.log(1 - p), 1 / shape);
  }

public static function mean(scale:Float, shape:Float):Float {
    return scale * Special.gammafn(1 + 1 / shape);
  }

public static function median(scale:Float, shape:Float):Float {
    return scale * Math.pow(Math.log(2), 1 / shape);
  }

public static function mode(scale:Float, shape:Float):Null<Float> {
    if (shape <= 1)
      return null;
    return scale * Math.pow((shape - 1) / shape, 1 / shape);
  }

public static function sample(scale:Float, shape:Float):Float {
    return scale * Math.pow(-Math.log(Math.random()), 1 / shape);
  }

public static function variance(scale:Float, shape:Float):Float {
    return scale * scale * Special.gammafn(1 + 2 / shape) -
        Math.pow(mean(scale, shape), 2);
  }
}


class Uniform{
public static function pdf(x:Float, a, b):Float {
    return (x < a || x > b) ? 0 : 1 / (b - a);
  }

public static function cdf(x:Float, a:Float, b:Float):Float {
    if (x < a)
      return 0;
    else if (x < b)
      return (x - a) / (b - a);
    return 1;
  }

public static function inv(p:Float, a:Float, b:Float):Float {
    return a + (p * (b - a));
  }

public static function mean(a:Float, b:Float):Float {
    return 0.5 * (a + b);
  }

public static function median(a:Float, b:Float):Float {
    return mean(a, b);
  }

public static function mode(a:Float, b:Float):Float {
    throw 'mode is not yet implemented';
  }

public static function sample(a:Float, b:Float):Float {
    return (a / 2 + b / 2) + (b / 2 - a / 2) * (2 * Math.random() - 1);
  }

public static  function variance(a:Float, b:Float):Float {
    return Math.pow(b - a, 2) / 12;
  }
}


class Binomial{
public static function pdf(k:Float, n:Float, p:Float):Float {

    return (p == 0 || p == 1) ?
      ((n * p) == k ? 1 : 0) :
      Special.combination(n, k) * Math.pow(p, k) * Math.pow(1 - p, n - k);
  }

public static function cdf(x:Int, n:Float, p:Float):Float {
    var binomarr = [],
    k = 0;
    if (x < 0) {
      return 0;
    }
    if (x < n) {
      for (k in 0... x+1) {
        binomarr[ k ] = Binomial.pdf(k, n, p);
      }
      return Vector.sum([binomarr]);
    }
    return 1;
  }
}


class Negbin{
public static function pdf(k:Int, r:Float, p:Float):Null<Float> {
   
	if (k != k >>> 0) {
		throw "error?";
		return null;
	}
    if (k < 0)
      return 0;

    return Special.combination(k + r - 1, r - 1) *
        Math.pow(1 - p, k) * Math.pow(p, r);
  }

public static function cdf(x:Int, r:Float, p:Float):Float {
    var sum:Float = 0,
    k = 0;
    if (x < 0) return 0;
    for (k in 0 ... x+1) {
      sum += pdf(k, r, p);
    }
    return sum;
  }
}


class Hypgeom{
public static function pdf(k:Int , N:Int, m:Int, n:Int):Null<Float> {
    // Hypergeometric PDF.

    // A simplification of the CDF algorithm below.

    // k = number of successes drawn
    // N = population size
    // m = number of successes in population
    // n = number of items drawn from population

    if (k != k | 0) {
		throw "error?";
		return null;
    } else if(k < 0 || k < m - (N - n)) {
      // It's impossible to have this few successes drawn.
      return 0;
    } else if(k > n || k > m) {
      // It's impossible to have this many successes drawn.
      return 0;
    } else if (m * 2 > N) {
      // More than half the population is successes.

      if(n * 2 > N) {
        // More than half the population is sampled.

        return pdf(N - m - n + k, N, N - m, N - n);
      } else {
        // Half or less of the population is sampled.

        return pdf(n - k, N, N - m, n);
      }

    } else if(n * 2 > N) {
      // Half or less is successes.

      return pdf(m - k, N, m, N - n);

    } else if(m < n) {
      // We want to have the number of things sampled to be less than the
      // successes available. So swap the definitions of successful and sampled.
      return pdf(k, N, n, m);
    } else {
      // If we get here, half or less of the population was sampled, half or
      // less of it was successes, and we had fewer sampled things than
      // successes. Now we can do this complicated iterative algorithm in an
      // efficient way.

      // The basic premise of the algorithm is that we partially normalize our
      // intermediate product to keep it in a numerically good region, and then
      // finish the normalization at the end.

      // This variable holds the scaled probability of the current number of
      // successes.
      var scaledPDF:Float = 1;

      // This keeps track of how much we have normalized.
      var samplesDone = 0;

      for(i in 0 ... k) {
        // For every possible number of successes up to that observed...

        while(scaledPDF > 1 && samplesDone < n) {
          // Intermediate result is growing too big. Apply some of the
          // normalization to shrink everything.

          scaledPDF *= 1 - (m / (N - samplesDone));

          // Say we've normalized by this sample already.
          samplesDone++;
        }

        // Work out the partially-normalized hypergeometric PDF for the next
        // number of successes
        scaledPDF *= (n - i) * (m - i) / ((i + 1) * (N - m - n + i + 1));
      }

      for(samplesDone in 0...n) {
        // Apply all the rest of the normalization
        scaledPDF *= 1 - (m / (N - samplesDone));
      }

      // Bound answer sanely before returning.
      return Math.min(1, Math.max(0, scaledPDF));
    }
  }

public static function cdf(x:Int, N:Int, m:Int, n:Int):Float {
    // Hypergeometric CDF.

    // This algorithm is due to Prof. Thomas S. Ferguson, <tom@math.ucla.edu>,
    // and comes from his hypergeometric test calculator at
    // <http://www.math.ucla.edu/~tom/distributions/Hypergeometric.html>.

    // x = number of successes drawn
    // N = population size
    // m = number of successes in population
    // n = number of items drawn from population

    if(x < 0 || x < m - (N - n)) {
      // It's impossible to have this few successes drawn or fewer.
      return 0;
    } else if(x >= n || x >= m) {
      // We will always have this many successes or fewer.
      return 1;
    } else if (m * 2 > N) {
      // More than half the population is successes.
	  
      if(n * 2 > N) {
        // More than half the population is sampled.

        return cdf(N - m - n + x, N, N - m, N - n);
      } else {
        // Half or less of the population is sampled.

        return 1 - cdf(n - x - 1, N, N - m, n);
      }

    } else if(n * 2 > N) {
      // Half or less is successes.

      return 1 - cdf(m - x - 1, N, m, N - n);

    } else if(m < n) {
      // We want to have the number of things sampled to be less than the
      // successes available. So swap the definitions of successful and sampled.
      return cdf(x, N, n, m);
    } else {
      // If we get here, half or less of the population was sampled, half or
      // less of it was successes, and we had fewer sampled things than
      // successes. Now we can do this complicated iterative algorithm in an
      // efficient way.

      // The basic premise of the algorithm is that we partially normalize our
      // intermediate sum to keep it in a numerically good region, and then
      // finish the normalization at the end.

      // Holds the intermediate, scaled total CDF.
      var scaledCDF:Float = 1;

      // This variable holds the scaled probability of the current number of
      // successes.
      var scaledPDF:Float = 1;

      // This keeps track of how much we have normalized.
      var samplesDone = 0;

      for(i in 0... x) {
        // For every possible number of successes up to that observed...

        while(scaledCDF > 1 && samplesDone < n) {
          // Intermediate result is growing too big. Apply some of the
          // normalization to shrink everything.

          var factor = 1 - (m / (N - samplesDone));

          scaledPDF *= factor;
          scaledCDF *= factor;

          // Say we've normalized by this sample already.
          samplesDone++;
        }

        // Work out the partially-normalized hypergeometric PDF for the next
        // number of successes
        scaledPDF *= (n - i) * (m - i) / ((i + 1) * (N - m - n + i + 1));

        // Add to the CDF answer.
        scaledCDF += scaledPDF;
      }

      for(samplesDone in 0...  n) {
        // Apply all the rest of the normalization
        scaledCDF *= 1 - (m / (N - samplesDone));
      }

      // Bound answer sanely before returning.
      return Math.min(1, Math.max(0, scaledCDF));
    }
  }
}


class Poisson{
public static function pdf(k:Float, l:Float):Float {
    return Math.pow(l, k) * Math.exp(-l) / Special.factorial(k);
  }

public static function cdf(x:Int, l:Float):Float {
    var sumarr = [],
    k = 0;
    if (x < 0) return 0;
    for (k in 0... x+1) {
      sumarr.push(Poisson.pdf(k, l));
    }
    return Vector.sum([sumarr]);
  }

public static function mean(l:Float):Float {
    return l;
  }

public static function variance(l:Float):Float {
    return l;
  }

public static function sample(l:Float):Float {
    var p:Float = 1, k = 0, L = Math.exp(-l);
    do {
      k++;
      p *= Math.random();
    } while (p > L);
    return k - 1;
  }
}

class Triangular{
public static function pdf(x:Float, a:Float, b:Float, c:Float):Float {
    if (b <= a || c < a || c > b) {
      return Math.NaN;
    } else {
      if (x < a || x > b) {
        return 0;
      } else if (x < c) {
          return (2 * (x - a)) / ((b - a) * (c - a));
      } else if (x == c) {
          return (2 / (b - a));
      } else { // x > c
          return (2 * (b - x)) / ((b - a) * (b - c));
      }
    }
  }
  
 public static function cdf(x:Float, a:Float, b:Float, c:Float):Float {
    if (b <= a || c < a || c > b)
      return Math.NaN;
    if (x <= a)
      return 0;
    else if (x >= b)
      return 1;
    if (x <= c)
      return Math.pow(x - a, 2) / ((b - a) * (c - a));
    else // x > c
      return 1 - Math.pow(b - x, 2) / ((b - a) * (b - c));
  }
  
  public static function inv(p:Float, a:Float, b:Float, c:Float):Float {
    if (b <= a || c < a || c > b) {
      return Math.NaN;
    } else {
      if (p <= ((c - a) / (b - a))) {
        return a + (b - a) * Math.sqrt(p * ((c - a) / (b - a)));
      } else { // p > ((c - a) / (b - a))
        return a + (b - a) * (1 - Math.sqrt((1 - p) * (1 - ((c - a) / (b - a)))));
      }
    }
  }
  
  public static function mean(a:Float, b:Float, c:Float):Float {
    return (a + b + c) / 3;
  }
  
  public static function median(a, b, c):Float {
    if (c <= (a + b) / 2) {
      return b - Math.sqrt((b - a) * (b - c)) / Math.sqrt(2);
    } else if (c > (a + b) / 2) {
      return a + Math.sqrt((b - a) * (c - a)) / Math.sqrt(2);
    }
	throw "error?";
	return 0;
  }
  
  public static function mode(a:Float, b:Float, c:Float):Float {
    return c;
  }
  
  public static function sample(a:Float, b:Float, c:Float):Float {
    var u = Math.random();
    if (u < ((c - a) / (b - a)))
      return a + Math.sqrt(u * (b - a) * (c - a));
    return b - Math.sqrt((1 - u) * (b - a) * (b - c));
  }
  
  public static function variance(a:Float, b:Float, c:Float):Float {
    return (a * a + b * b + c * c - a * b - a * c - b * c) / 18;
  }
	
}