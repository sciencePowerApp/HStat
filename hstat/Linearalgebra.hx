package hstat;
import hstat.HStat;
import hstat.HStat.Matrix;

/**
 * ...
 * @author 
 */

//as it is a total pain in the ars#
class Argument {
	
	var m:Matrix;
	public var D1:Bool; //1 dimensional
	var val:Float;
	
	public function new(_m:Matrix) {
		m = _m;
		if (m[0].length == 1) {
			D1 = true;
			val = m[0][0];
		}
		else D1 = false;
	}
	
	public function get(row:Float, col:Float):Float {
		if (D1) {
			return val;
		}
		return m[Std.int(row)][Std.int(col)];
	}
}
 
 
class Linearalgebra
{

	public function new() { }

	public static function add(arr:Matrix, arg:Matrix):Matrix {
		var a:Argument = new Argument(arg);

		return HStat.map(arr, 
			function(value:Float, row:Float, col:Float):Float {
				return value + a.get(row,col); 
			});
    }
	

	
	public static function subtract(arr:Matrix, arg:Matrix):Matrix {
		var a:Argument = new Argument(arg);

		return HStat.map(arr, 
			function(value:Float, row:Float, col:Float):Float {
				return value - a.get(row,col); 
			});
    }

	
	public static function divide(arr:Matrix, arg:Matrix):Matrix {
		var a:Argument = new Argument(arg);

		return HStat.map(arr, 
			function(value:Float, row:Float, col:Float):Float {
				return value / a.get(row,col); 
			});
    }


  // matrix multiplication
  //AW taken from JS version here http://rosettacode.org/wiki/Matrix_multiplication#JavaScript
  public static function multiply(arr:Matrix, arg:Matrix) {
    if (arg[0].length == 1) {
	    var a:Argument = new Argument(arg);

		return HStat.map(arr, 
			function(value:Float, row:Float, col:Float):Float {
				return value * a.get(row,col); 
			});
	}
	else if(arr[0].length != arg.length) {
        throw "error: incompatible sizes";
    }
	var sum:Float;
    var result:Matrix = new Matrix();
    for (i in 0...arr.length) {
        result[i] = new Array<Float>();
        for (j in 0...arg[0].length) {
            sum = 0;
            for (k in 0 ... arr[0].length) {
                sum += arr[i][k] * arg[k][j];
            }
            result[i][j] = sum;
        }
    }
    return result; 

  }
  
  

  // Returns the dot product of two matricies
  public static function dot(arr:Matrix, arg:Matrix):Float {

    // convert column to row vector
    var left:Matrix = (arr[0].length == 1 && arr.length != 1) ? HStat.transpose(arr) : arr;
    var right:Matrix = (arg[0].length == 1 && arg.length != 1) ? HStat.transpose(arg) : arg;
    var sum:Float = 0;
	
	
    for (row in 0... left.length) {

      sum = 0;
      for (col in 0... left[0].length)
      sum += left[row][col] * right[row][col];
    }
    return sum;
  }
  
  

  // raise every element by a scalar
  public static function pow(arr, arg) {
	  var a:Argument = new Argument(arg);

		return HStat.map(arr, 
			function(value:Float, row:Float, col:Float):Float {
				return Math.pow(value , a.get(row,col)); 
			});
  }

  // exponentiate every element
  public static function exp(arr) {
		return HStat.map(arr, 
			function(value:Float, row:Float, col:Float):Float {
				return Math.exp(value); 
			});
  }

  // generate the natural log of every element
  public static function log(arr) {

		return HStat.map(arr, 
			function(value:Float, row:Float, col:Float):Float {
				return Math.log(value); 
			});
  }

  // generate the absolute values of the vector
  public static function abs(arr) {

		return HStat.map(arr, 
			function(value:Float, row:Float, col:Float):Float {
				return Math.abs(value); 
			});
  }

  // computes the p-norm of the vector
  // In the case that a matrix is passed, uses the first row as the vector
  public static function norm(arr:Matrix , p:Float=2):Float {
    var nnorm:Float = 0;
    // vector norm
    for (i in 0... arr[0].length) {
      nnorm += Math.pow(Math.abs(arr[0][i]), p);
    }
    return Math.pow(nnorm, 1 / p);
  }

  // computes the angle between two vectors in rads
  // In case a matrix is passed, this uses the first row as the vector
  public static function angle(arr:Matrix, arg:Matrix):Float {
    return Math.acos(dot(arr, arg) / (Linearalgebra.norm(arr) * Linearalgebra.norm(arg)));
  }

  // augment one matrix by another
  // Note: this function returns a matrix, not a jStat object
  public static function aug(a:Matrix, b:Matrix):Matrix {
    var newarr = Vector.copy(a);
    
	for (i in 0... b.length) {
		for (j in 0...b[0].length) {
			newarr[i].push(b[i][j]);
		}
    }
  
    return newarr;
  }

  // The inv() function calculates the inverse of a matrix
  // Create the inverse by augmenting the matrix by the identity matrix of the
  // appropriate size, and then use G-J elimination on the augmented matrix.
  public static function inv(a:Matrix):Matrix {
    var rows = a.length;
    var cols = a[0].length;
    var b = HStat.identity(rows, cols);
    var c = Linearalgebra.gauss_jordan(a, b);
    var result = [];
    var i = 0;
    var j;

    //We need to copy the inverse portion to a new matrix to rid G-J artifacts
    for (i in 0... rows) {
      result[i] = [];
      for (j in cols... c[0].length)
        result[i][j - cols] = c[i][j];
    }
    return result;
  }

  // calculate the determinant of a matrix
  public static function det(a:Matrix):Float {
    var alen:Int = a.length,
    alend:Int = alen * 2,
    vals = new Array<Float>(),
    rowshift:Int = alen - 1,
    colshift:Int = alend - 1,
    mrow:Int = rowshift - alen + 1,
    mcol:Int = colshift,
    i:Int = 0,
    result:Float = 0,
    j:Int;
    // check for special 2x2 case
    if (alen == 2) {
      return a[0][0] * a[1][1] - a[0][1] * a[1][0];
    }
    for (i in 0... alend) {
      vals[i] = 1;
    }
    for (i in 0... alen) {
      for (j in 0... alen) {
        vals[(mrow < 0) ? mrow + alen : mrow ] *= a[i][j];
        vals[(mcol < alen) ? mcol + alen : mcol ] *= a[i][j];
        mrow++;
        mcol--;
      }
      mrow = --rowshift - alen + 1;
      mcol = --colshift;
    }
    for (i in 0... alen) {
      result += vals[i];
    }
    for (i in alen ... alend) {
      result -= vals[i];
    }
    return result;
  }

  public static function gauss_elimination(a:Matrix, b:Matrix):Matrix {
    var i:Int = 0,
    j:Int = 0,
    n:Int = a.length,
    m:Int = a[0].length,
    factor:Float = 1,
    sum:Float = 0,
    x:Array<Float> = new Array<Float>(),
    pivot:Float, temp:Float, k:Int;
    var _a:Matrix = Linearalgebra.aug(a, b);
	var maug:Int = _a[0].length;
	
    for (i in 0...n) {
		
      pivot = _a[i][i];
      j = i;
      for (k in i + 1... m) {
		  
        if (pivot < Math.abs(_a[k][i])) {
          pivot = _a[k][i];
          j = k;
        }
      }
      if (j != i) {
		  
        for(k in 0... maug) {
          temp = _a[i][k];
          _a[i][k] = _a[j][k];
          _a[j][k] = temp;
        }
      }
      for (j in i + 1... n) {
        factor = _a[j][i] / _a[i][i];
        for (k in  i... maug) {
          _a[j][k] = _a[j][k] - factor * _a[i][k];
        }
      }
    }

	i = n;
    while (--i >= 0) {
      sum = 0;
	  
      for (j in i + 1...n) {
        sum = sum + x[j] * _a[i][j];

      }
      x[i] =(_a[i][maug - 1] - sum) / _a[i][i];
    }
	
	
	
    return [x];
  }
  


  public static function gauss_jordan(a:Matrix, b:Matrix):Matrix {
    var m:Matrix = Linearalgebra.aug(a, b);
	var y:Int;
    var h:Int = m.length;
    var w:Int = m[0].length;
	var c:Float;
    // find max pivot
    for (y in 0... h) {
      var maxrow = y;
      for (y2 in y+1 ... h) {
        if (Math.abs(m[y2][y]) > Math.abs(m[maxrow][y]))
          maxrow = y2;
      }
      var tmp = m[y];
      m[y] = m[maxrow];
      m[maxrow] = tmp;
      for (y2 in y+1... h) {
        c = m[y2][y] / m[y][y];
        for (x in y... w) {
          m[y2][x] -= m[y][x] * c;
        }
      }
    }
    // backsubstitute
	y = h-1;
	var x:Int;
    while (--y >= 0) {
      c = m[y][y];
      for (y2 in 0... y) {
		  x = w;
		  //might need to remove y-1
        while (-- x  > y-1) {
          m[y2][x] -= m[y][x] * m[y2][y] / c;
        }
      }
      m[y][y] /= c;
      for (x in h... w) {
        m[y][x] /= c;
      }
    }
    return m;
  }

  /*
  public static function lu(a, b) {
    throw new Error('lu not yet implemented');
  }

  public static function cholesky(a, b) {
    throw new Error('cholesky not yet implemented');
  }

  public static function gauss_jacobi(a:Matrix, b, x, r) {
    var i = 0;
    var j = 0;
    var n = a.length;
    var l = [];
    var u = [];
    var d = [];
    var xv, c, h, xk;
    for (i in 0...n) {
      l[i] = [];
      u[i] = [];
      d[i] = [];
      for (j in 0... n) {
        if (i > j) {
          l[i][j] = a[i][j];
          u[i][j] = d[i][j] = 0;
        } else if (i < j) {
          u[i][j] = a[i][j];
          l[i][j] = d[i][j] = 0;
        } else {
          d[i][j] = a[i][j];
          l[i][j] = u[i][j] = 0;
        }
      }
    }
    h = jStat.multiply(jStat.multiply(jStat.inv(d), jStat.add(l, u)), -1);
    c = jStat.multiply(jStat.inv(d), b);
    xv = x;
    xk = jStat.add(jStat.multiply(h, x), c);
    i = 2;
    while (Math.abs(jStat.norm(jStat.subtract(xk,xv))) > r) {
      xv = xk;
      xk = jStat.add(jStat.multiply(h, xv), c);
      i++;
    }
    return xk;
  }
  /
  public static function gauss_seidel(a, b, x, r) {
    var i = 0;
    var n = a.length;
    var l = [];
    var u = [];
    var d = [];
    var j, xv, c, h, xk;
    for (i in 0... n) {
      l[i] = [];
      u[i] = [];
      d[i] = [];
      for (j in 0... n) {
        if (i > j) {
          l[i][j] = a[i][j];
          u[i][j] = d[i][j] = 0;
        } else if (i < j) {
          u[i][j] = a[i][j];
          l[i][j] = d[i][j] = 0;
        } else {
          d[i][j] = a[i][j];
          l[i][j] = u[i][j] = 0;
        }
      }
    }
    h = jStat.multiply(jStat.multiply(jStat.inv(jStat.add(d, l)), u), -1);
    c = jStat.multiply(jStat.inv(jStat.add(d, l)), b);
    xv = x;
    xk = jStat.add(jStat.multiply(h, x), c);
    i = 2;
    while (Math.abs(jStat.norm(jStat.subtract(xk, xv))) > r) {
      xv = xk;
      xk = jStat.add(jStat.multiply(h, xv), c);
      i = i + 1;
    }
    return xk;
  }

  public static function SOR(a, b, x, r, w) {
    var i = 0;
    var n = a.length;
    var l = [];
    var u = [];
    var d = [];
    var j, xv, c, h, xk;
    for (i in 0... n) {
      l[i] = [];
      u[i] = [];
      d[i] = [];
      for (j in 0... n) {
        if (i > j) {
          l[i][j] = a[i][j];
          u[i][j] = d[i][j] = 0;
        } else if (i < j) {
          u[i][j] = a[i][j];
          l[i][j] = d[i][j] = 0;
        } else {
          d[i][j] = a[i][j];
          l[i][j] = u[i][j] = 0;
        }
      }
    }
    h = jStat.multiply(jStat.inv(jStat.add(d, jStat.multiply(l, w))),
                       jStat.subtract(jStat.multiply(d, 1 - w),
                                      jStat.multiply(u, w)));
    c = jStat.multiply(jStat.multiply(jStat.inv(jStat.add(d,
        jStat.multiply(l, w))), b), w);
    xv = x;
    xk = jStat.add(jStat.multiply(h, x), c);
    i = 2;
    while (Math.abs(jStat.norm(jStat.subtract(xk, xv))) > r) {
      xv = xk;
      xk = jStat.add(jStat.multiply(h, xv), c);
      i++;
    }
    return xk;
  }

  public static function householder(a) {
    var m = a.length;
    var n = a[0].length;
    var i = 0;
    var w = [];
    var p = [];
    var alpha, r, k, j, factor;
    for ( i in 0... m - 1) {
      alpha = 0;
      for (j in i + 1... n)
      alpha += (a[j][i] * a[j][i]);
      factor = (a[i + 1][i] > 0) ? -1 : 1;
      alpha = factor * Math.sqrt(alpha);
      r = Math.sqrt((((alpha * alpha) - a[i + 1][i] * alpha) / 2));
      w = jStat.zeros(m, 1);
      w[i + 1][0] = (a[i + 1][i] - alpha) / (2 * r);
      for (k in i + 2... m) w[k][0] = a[k][i] / (2 * r);
      p = jStat.subtract(jStat.identity(m, n),
          jStat.multiply(jStat.multiply(w, jStat.transpose(w)), 2));
      a = jStat.multiply(p, jStat.multiply(a, p));
    }
    return a;
  }

  // TODO: not working properly.
  public static function QR(a, b) {
    var m = a.length;
    var n = a[0].length;
    var i = 0;
    var w = [];
    var p = [];
    var x = [];
    var j, alpha, r, k, factor, sum;
    for (i in 0... m - 1) {
      alpha = 0;
      for (j in i + 1 ... n)
        alpha += (a[j][i] * a[j][i]);
      factor = (a[i + 1][i] > 0) ? -1 : 1;
      alpha = factor * Math.sqrt(alpha);
      r = Math.sqrt((((alpha * alpha) - a[i + 1][i] * alpha) / 2));
      w = jStat.zeros(m, 1);
      w[i + 1][0] = (a[i + 1][i] - alpha) / (2 * r);
      for (k in i + 2...  m)
        w[k][0] = a[k][i] / (2 * r);
      p = jStat.subtract(jStat.identity(m, n),
          jStat.multiply(jStat.multiply(w, jStat.transpose(w)), 2));
      a = jStat.multiply(p, a);
      b = jStat.multiply(p, b);
    }
	i = m;
    while (--i >= 0) {
      sum = 0;
      for (j in i + 1... n )
      sum = x[j] * a[i][j];
      x[i] = b[i][0] / a[i][i];
    }
    return x;
  }

  public static function jacobi(a) {
    var condition = 1;
    var count = 0;
    var n = a.length;
    var e = jStat.identity(n, n);
    var ev = [];
    var b, i, j, p, q, maxim, theta, s;
    // condition == 1 only if tolerance is not reached
    while (condition == 1) {
      count++;
      maxim = a[0][1];
      p = 0;
      q = 1;
      for (i in 0... n) {
        for (j in 0... n) {
          if (i != j) {
            if (maxim < Math.abs(a[i][j])) {
              maxim = Math.abs(a[i][j]);
              p = i;
              q = j;
            }
          }
        }
      }
      if (a[p][p] == a[q][q])
        theta = (a[p][q] > 0) ? Math.PI / 4 : -Math.PI / 4;
      else
        theta = Math.atan(2 * a[p][q] / (a[p][p] - a[q][q])) / 2;
      s = jStat.identity(n, n);
      s[p][p] = Math.cos(theta);
      s[p][q] = -Math.sin(theta);
      s[q][p] = Math.sin(theta);
      s[q][q] = Math.cos(theta);
      // eigen vector matrix
      e = jStat.multiply(e, s);
      b = jStat.multiply(jStat.multiply(jStat.inv(s), a), s);
      a = b;
      condition = 0;
      for (i in 1... n) {
        for (j in 1... n) {
          if (i != j && Math.abs(a[i][j]) > 0.001) {
            condition = 1;
          }
        }
      }
    }
    for (i in 0... n) ev.push(a[i][i]);
    //returns both the eigenvalue and eigenmatrix
    return [e, ev];
  }

  public static function rungekutta(f, h, p, t_j, u_j, order) {
    var k1, k2, u_j1, k3, k4;
    if (order == 2) {
      while (t_j <= p) {
        k1 = h * f(t_j, u_j);
        k2 = h * f(t_j + h, u_j + k1);
        u_j1 = u_j + (k1 + k2) / 2;
        u_j = u_j1;
        t_j = t_j + h;
      }
    }
    if (order == 4) {
      while (t_j <= p) {
        k1 = h * f(t_j, u_j);
        k2 = h * f(t_j + h / 2, u_j + k1 / 2);
        k3 = h * f(t_j + h / 2, u_j + k2 / 2);
        k4 = h * f(t_j +h, u_j + k3);
        u_j1 = u_j + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
        u_j = u_j1;
        t_j = t_j + h;
      }
    }
    return u_j;
  }

  public static function romberg(f, a, b, order) {
    var i = 0;
    var h = (b - a) / 2;
    var x = [];
    var h1 = [];
    var g = [];
    var m, a1, j, k, I, d;
    while (i < order / 2) {
      I = f(a);
	  j = a;
      for (k in 0... b + 1 ) {
		  j = j + h;
		  x[k] = j;
	  }
      m = x.length;
      for (j in 1... m - 1) {
        I += (((j % 2) != 0) ? 4 : 2) * f(x[j]);
      }
      I = (h / 3) * (I + f(b));
      g[i] = I;
      h /= 2;
      i++;
    }
    a1 = g.length;
    m = 1;
    while (a1 != 1) {
      for (j in 0... a1 - 1)
      h1[j] = ((Math.pow(4, m)) * g[j + 1] - g[j]) / (Math.pow(4, m) - 1);
      a1 = h1.length;
      g = h1;
      h1 = [];
      m++;
    }
    return g;
  }

  public static function richardson(X, f, x, h) {
    function pos(X, x) {
      var i = 0;
      var n = X.length;
      var p;
      for ( i in 0... n)
        if (X[i] == x) p = i;
      return p;
    }
    var n = X.length,
    h_min = Math.abs(x - X[pos(X, x) + 1]),
    i = 0,
    g = [],
    h1 = [],
    y1, y2, m, a, j;
    while (h >= h_min) {
      y1 = pos(X, x + h);
      y2 = pos(X, x);
      g[i] = (f[y1] - 2 * f[y2] + f[2 * y2 - y1]) / (h * h);
      h /= 2;
      i++;
    }
    a = g.length;
    m = 1;
    while (a != 1) {
      for (j in a - 1)
      h1[j] = ((Math.pow(4, m)) * g[j + 1] - g[j]) / (Math.pow(4, m) - 1);
      a = h1.length;
      g = h1;
      h1 = [];
      m++;
    }
    return g;
  }

  public static function simpson(f, a, b, n) {
    var h = (b - a) / n;
    var I = f(a);
    var x = [];
    var j = a;
    var k = 0;
    var i = 1;
    var m;
    for (j in a... b + 1) {
	  j = j + h;
      x[k] = j;
	}
    m = x.length;
    for (i in 1--- m - 1) {
      I += ((i % 2 != 0) ? 4 : 2) * f(x[i]);
    }
    return (h / 3) * (I + f(b));
  }

  public static function hermite(X, F, dF, value) {
    var n = X.length;
    var p = 0;
    var i = 0;
    var l = [];
    var dl = [];
    var A = [];
    var B = [];
    var j;
    for (i in 0...n) {
      l[i] = 1;
      for (j in 0... n) {
        if (i != j) l[i] *= (value - X[j]) / (X[i] - X[j]);
      }
      dl[i] = 0;
      for (j in 0... n) {
        if (i != j) dl[i] += 1 / (X [i] - X[j]);
      }
      A[i] = (1 - 2 * (value - X[i]) * dl[i]) * (l[i] * l[i]);
      B[i] = (value - X[i]) * (l[i] * l[i]);
      p += (A[i] * F[i] + B[i] * dF[i]);
    }
    return p;
  }

 public static function lagrange(X, F, value) {
    var p = 0;
    var i = 0;
    var j, l;
    var n = X.length;
    for ( i in 0... n) {
      l = F[i];
      for (0 in 0...n) {
        // calculating the lagrange polynomial L_i
        if (i != j) l *= (value - X[j]) / (X[i] - X[j]);
      }
      // adding the lagrange polynomials found above
      p += l;
    }
    return p;
  }

  public static function cubic_spline(X, F, value) {
    var n = X.length;
    var i = 0, j;
    var A = [];
    var B = [];
    var alpha = [];
    var c = [];
    var h = [];
    var b = [];
    var d = [];
    for (i in 0... n - 1)
      h[i] = X[i + 1] - X[i];
    alpha[0] = 0;
    for (i in 1... n - 1) {
      alpha[i] = (3 / h[i]) * (F[i + 1] - F[i]) -
          (3 / h[i-1]) * (F[i] - F[i-1]);
    }
    for (i in 1... n - 1) {
      A[i] = [];
      B[i] = [];
      A[i][i-1] = h[i-1];
      A[i][i] = 2 * (h[i - 1] + h[i]);
      A[i][i+1] = h[i];
      B[i][0] = alpha[i];
    }
    c = jStat.multiply(jStat.inv(A), B);
    for (j in 0... n - 1) {
      b[j] = (F[j + 1] - F[j]) / h[j] - h[j] * (c[j + 1][0] + 2 * c[j][0]) / 3;
      d[j] = (c[j + 1][0] - c[j][0]) / (3 * h[j]);
    }
    for (j in 0... j < n) {
      if (X[j] > value) break;
    }
    j -= 1;
    return F[j] + (value - X[j]) * b[j] + jStat.sq(value-X[j]) *
        c[j] + (value - X[j]) * jStat.sq(value - X[j]) * d[j];
  }

  public static function gauss_quadrature() {
    throw new Error('gauss_quadrature not yet implemented');
  }

  public static function PCA(X) {
    var m = X.length;
    var n = X[0].length;
    var flag = false;
    var i = 0;
    var j, temp1;
    var u = [];
    var D = [];
    var result = [];
    var temp2 = [];
    var Y = [];
    var Bt = [];
    var B = [];
    var C = [];
    var V = [];
    var Vt = [];
    for (i in 0... m) {
      u[i] = jStat.sum(X[i]) / n;
    }
    for (i in 0... n) {
      B[i] = [];
      for(j in 0... m) {
        B[i][j] = X[j][i] - u[j];
      }
    }
    B = jStat.transpose(B);
    for (i in 0... m) {
      C[i] = [];
      for (j in 0... m) {
        C[i][j] = (dot([B[i]], [B[j]])) / (n - 1);
      }
    }
    result = jStat.jacobi(C);
    V = result[0];
    D = result[1];
    Vt = jStat.transpose(V);
    for (i in 0... D.length) {
      for (j in i... D.length) {
        if(D[i] < D[j])  {
          temp1 = D[i];
          D[i] = D[j];
          D[j] = temp1;
          temp2 = Vt[i];
          Vt[i] = Vt[j];
          Vt[j] = temp2;
        }
      }
    }
    Bt = jStat.transpose(B);
    for (i in 0... m) {
      Y[i] = [];
      for (j in 0... Bt.length) {
        Y[i][j] = dot([Vt[i]], [Bt[j]]);
      }
    }
    return [X, D, Vt, Y];
  }*/
}
	
