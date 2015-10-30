package hstat;

import thx.Types;

typedef Matrix = Array<Array<Float>>;

class HStat
{

public function new() {}
	
	
public static function  create(rows:Int, cols: Null <Int> = null, func:Float->Float->Float):Matrix {
  if (cols == null) cols = rows;
  var res = new Matrix();
  var i, j;

  for (i in 0...rows) {
    res[i] = new Array<Float>();
    for(j in 0...cols)
      res[i][j] = func(i, j);
  }

  return res;
}
	
	

public static inline function check1D(m:Matrix):Void {
	if (m.length > 1) throw "Matrix error. Was expected 1D matrix";
}



public static function map(_arr:Matrix, func:Float->Float->Float->Float , ?toAlter:Bool = false):Matrix {

	var row, nrow:Int, ncol:Int, res, col;
	  var arr = _arr;

	  nrow = arr.length;
	  ncol = arr[0].length;
	  res = toAlter ? arr : [];

	  for (row in 0... nrow) {
		// if the row doesn't exist, create it
		if (res[row] == null)
		  res[row] = new Array<Float>();
		for (col in 0... ncol)
		  res[row][col] = func(arr[row][col], row, col);
	  }

	  return res;
}

	
	

	



inline public static function log10e():Float {
return 0.4342944819032518;
}



public static function calcRdx(n:Float, m:Float):Float {
  var val = n > m ? n : m;
  
  return Math.pow(10,
                  17 - ~~(Math.log(((val > 0) ? val : -val)) * log10e()));
}



public static function toVector(arr:Matrix):Matrix {
	var arr2:Matrix = new Matrix();

	for (col in 0...arr.length) {
		for(row in 0...arr[0].length){
			arr2[0][arr2.length] = arr[col][row];
		}
	}
	
  return arr2;
}


// Returns the number of rows in the matrix.
public static function rows(arr:Matrix):Int {
	var len:Int = arr.length;
	if (len == 0) len = 1;
	return len;
  }


// Returns the number of columns in the matrix.
public static function cols(arr:Matrix):Int {
var len:Int = arr[0].length;
	if (len == 0) len = 1;
	return len;
}


// Returns the dimensions of the object { rows: i, cols: j }
public static function dimensions(arr:Matrix):Map<String,Int> {
	return ['rows' => rows(arr), 'cols' => cols(arr)];
}


// Returns a specified row as a vector
public static function row_arr(arr:Matrix, index:Int):Matrix {
  return [arr[index]];
}


// Returns the specified column as a vector
public static function cols_arr(arr:Matrix, index:Int):Matrix {
  var column = new Array<Float>();
  for (i in 0... arr.length)
    column[i] = arr[i][index];
  return [column];
}


// Returns the diagonal of the matrix
public static function diag(arr:Matrix):Matrix {
  var nrow = rows(arr);
  var res = new Array<Float>();
  for (row in 0... nrow)
    res[row] = arr[row][row];
  return [res];
}


// Returns the anti-diagonal of the matrix
public static function antidiag(arr:Matrix):Matrix {
  var nrow = rows(arr) - 1;
  var res = new Array<Float>();
  var i:Int = 0;
  while (nrow >= 0) {
	nrow--;
	i++;
    res[i] = arr[i][nrow];
  }
  return [res];
}



// Transpose a matrix or array.
public static function transpose(arr:Matrix):Matrix {
  var obj:Matrix = [];
  var objArr, rows, cols, j, i;

  rows = arr.length;
  cols = arr[0].length;

  for (i in 0...cols) {
    objArr = new Array<Float>();
    for (j in 0...rows)
      objArr[j] = arr[j][i];
    obj.push(objArr);
  }


  return obj;
}




public static function cumreduce(arr:Matrix, func:Float -> Float -> Float -> Float, toAlter:Bool):Matrix  {
  var row:Int, nrow:Int, ncol:Int, res:Matrix, col:Int;

  nrow = arr.length;
  ncol = arr[0].length;
  res = toAlter ? arr : new Matrix();

  for (row in 0... nrow) {
    // if the row doesn't exist, create it
    if (res.length-1<row )	res[row] = new Array<Float>();
    
	if (ncol > 0)	res[row][0] = arr[row][0];
    
	for (col in 1... ncol)
      res[row][col] = func(res[row][col-1], arr[row][col], Math.NEGATIVE_INFINITY);
  }

  return res;
}


// Destructively alter an array.
public static function alter(arr:Matrix, func:Float -> Float->Float->Float):Matrix  {
  return map(arr, func, true);
}





// Generate a rows x cols matrix of zeros.
public static function zeros(rows:Int, cols:Int):Matrix {
  //if (!isNumber(cols))
    //cols = rows;
  return create(rows, cols, retZero);
}

public static function retZero(i:Float,j:Float):Float { return 0; }
public static function retOne(i:Float, j:Float):Float { return 1; }


// Generate a rows x cols matrix of ones.
public static function ones(rows, cols):Matrix {
  //if (!isNumber(cols))
    //cols = rows;
  return create(rows, cols, retOne);
}


// Generate a rows x cols matrix of uniformly random numbers.
public static function rand(rows:Int, ?cols:Null<Int> = null):Matrix {
  if (cols == null) cols = rows;
  return create(rows, cols, _rand);
}

public static function _rand(i:Float, j:Float):Float {
	return Math.random();
}


public static function retIdent(i:Float , j:Float):Int {
	return i == j ? 1 : 0; 
	}


// Generate an identity matrix of size row x cols.
public static function identity(rows:Int, cols:Int = -1) {
  if (cols == -1) cols = rows;
  cols = rows;
  return create(rows, cols, retIdent);
}


// Tests whether a matrix is symmetric
public static function symmetric(arr:Matrix):Bool {
  var issymmetric = true;
  var size = arr.length;
  var row, col;

  if (arr.length != arr[0].length)
    return false;

  for (row in 0...size) {
    for (col in 0...size)
      if (arr[col][row] != arr[row][col])
        return false;
  }

  return true;
}

public static function retZero3 (a:Float, b:Float, c:Float):Float {
	return 0;
}



// Set all values to zero.
public static function clear(arr:Matrix):Matrix {
  return alter(arr, retZero3);
}


// Generate sequence.
public static function seq(min:Float, max:Float, length:Int, func:Float -> Float -> Float = null) {

  var arr = [];
  var hival = calcRdx(min, max);
  var step = (max * hival - min * hival) / ((length - 1) * hival);
  var current:Float = min;
  var cnt:Int = 0;

  // Current is assigned using a technique to compensate for IEEE error.
  // TODO: Needs better implementation.
  while (current <= max){
        {
			cnt++;
			current = (min * hival + step * hival * cnt) / hival;
			arr.push((func !=null ? func(current, cnt) : current));
		}
    
  }

  return arr;
}







}