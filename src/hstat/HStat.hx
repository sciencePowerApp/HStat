package hstat;

import hstat.Dimensions.Matrix;
import thx.Types;

class HStat
{

public function new() {}
	
	
public static function  create(rows:Int, cols: Null <Int> = null, func:Float->Float->Float):Matrix {
  if (cols == null) cols = rows;
  var res = new Matrix();
  var i, j;

  for (i in 0...rows) {
    res.addRow();
    for(j in 0...cols)
      res.set(i, j, func(i, j));
  }

  return res;
}
	
	

	

private static function map(matrix:Matrix, func:Float->Float->Float->Float , ?toAlter:Bool = false):Matrix {
	  

	  var row, nrow:Int, ncol:Int, res, col;

	  var res:Matrix = toAlter ? matrix : [];

	  for (row in 0... matrix.rows) {
		// if the row doesn't exist, create it
		if (res.hasRow(row) == false)
		  res.addRow();
		for (col in 0... matrix.cols)
		  res.set(row, col, func(matrix.get(row,col), row, col) );
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





// Converts the jStat matrix to vector.
public static function toVector(arr:Matrix):Matrix {
	var arr2:Matrix = new Matrix();
	var counter:Int = 0;
	for (col in 0...arr.rows) {
		for(row in 0...arr.cols){
			arr2.set(counter, 0, arr.get(col, row));
			counter++;
		}
	}
	
  return arr2;
}


// Returns the number of rows in the matrix.
public static function rows(arr:Matrix):Int {
	var len:Int = arr.rows;
	if (len == 0) len = 1;
	return len;
  }


// Returns the number of columns in the matrix.
public static function cols(arr:Matrix):Int {
var len:Int = arr.cols;
	if (len == 0) len = 1;
	return len;
}


// Returns the dimensions of the object { rows: i, cols: j }
public static function dimensions(arr:Matrix):Map<String,Int> {
	return ['rows' => rows(arr), 'cols' => cols(arr)];
}


// Returns a specified row as a vector
public static function row_arr(arr:Matrix, row_i:Int):Matrix {
	var row = new Matrix();

	for (col in 0...arr.cols) {
		row.set(col, 0, arr.get(row_i, col));
		
	}
  return row;
}


// Returns the specified column as a vector
public static function cols_arr(arr:Matrix, index:Int):Matrix {
  var column = new Matrix();
  for (i in 0... arr.rows)
    column.set(i, 0, arr.get(i, index));
  return column;
}


// Returns the diagonal of the matrix
public static function diag(arr:Matrix):Matrix {
  var nrow = rows(arr);
  var res = new Matrix();
  for (row in 0... nrow)
    res.set(0,row, arr.get(row,row));
  return res;
}


// Returns the anti-diagonal of the matrix
public static function antidiag(arr:Matrix):Matrix {
  var nrow = rows(arr) - 1;
  var res = new Matrix();
  var i:Int = 0;
  while (nrow >= 0) {
	nrow--;
	i++;
    res.set(i, 0, arr.get(i, nrow));
  }
  return res;
}



// Transpose a matrix or array.
public static function transpose(arr:Matrix):Matrix {
  var obj = new Matrix();
  var objArr, rows, cols, j, i;



  for (i in 0...arr.cols) {
    objArr = new Matrix();
    for (j in 0...arr.rows)
      objArr.set(i, j, arr.get(j,i));
  }


  return obj;
}




public static function cumreduce(arr:Matrix, func:Float -> Float -> Float -> Float, toAlter:Bool) {
  var row:Int, nrow:Int, ncol:Int, res:Matrix, col:Int;

  nrow = arr.rows;
  ncol = arr.cols;
  res = toAlter ? arr : [];

  for (row in 0... nrow) {
    // if the row doesn't exist, create it
    if (!res.hasRow(row))	res.addRow();
    
	if (ncol > 0)	res.set(row, 0,  arr.get(row, 0));
    
	for (col in 1... ncol)
      res.set(row,col, func(res.get(row,col-1), arr.get(row,col), Math.NEGATIVE_INFINITY));
  }

  return res;
}


// Destructively alter an array.
public static function alter_arr(arr:Matrix, func:Float -> Float->Float->Float) {
  return map(arr, func, true);
}

// Destructively alter an array.
public static function alter(arr:Matrix, func:Float -> Float->Float->Float) {
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
public static function identity(rows:Int, cols:Int) {
  //if (!isNumber(cols))
  //  cols = rows;
  return create(rows, cols, retIdent);
}


// Tests whether a matrix is symmetric
public static function symmetric(arr:Matrix):Bool {
  var issymmetric = true;
  var size = arr.rows;
  var row, col;

  if (arr.rows != arr.cols)
    return false;

  for (row in 0...size) {
    for (col in 0...size)
      if (arr.get(col,row) != arr.get(row,col))
        return false;
  }

  return true;
}

public static function retZero3 (a:Float, b:Float, c:Float):Float {
	return 0;
}


// Set all values to zero.
public static function clear_arr(arr:Matrix):Matrix {

  return alter_arr(arr, retZero3);
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