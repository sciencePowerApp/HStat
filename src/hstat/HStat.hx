package hstat;

import thx.Types;

 
class HStat
{

public function new() {}
	
public static function  create_1(rows:Int, func:Float->Float->Float):Array<Dynamic> {

	  return create(rows, rows, func);
	
}
	
	
public static function  create(rows:Int, cols:Int, func:Float->Float->Float):Array<Array<Float>> {
  var res = new Array<Array<Float>>();
  var i, j;

  for (i in 0...rows) {
    res[i] = new Array<Float>();
    for(j in 0...cols)
      res[i][j] = func(i, j);
  }

  return res;
}
	
	
public static function isNumber(num:Dynamic):Bool {
		throw "";
		return Std.is(num, Float);	
	}
	
	
public static function isArray(arg:Dynamic):Bool {
		throw "";
		//should really have NumberArray check
		return Types.toString(arg) == "Array";
	}	
	

public static function map_arr(_arr:Array<Float>, func:Float->Float->Float->Float, toAlter:Bool):Array<Float> {
		return map([_arr], func, toAlter)[0];
	}
	
public static function map(_arr:Array<Array<Float>>, func:Float->Float->Float->Float , toAlter:Bool):Array<Array<Float>> {
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





// Converts the jStat matrix to vector.
public static function toVector(arr:Array<Array<Float>>):Array<Float> {
	var arr2:Array<Float> = new Array<Float>();

	for (col in 0...arr.length) {
		for(row in 0...arr[0].length){
			arr2[arr.length] = arr[col][row];
		}
	}
	
  return arr2;
}


// Returns the number of rows in the matrix.
public static function rows(arr:Array<Array<Float>>):Int {
	var len:Int = arr.length;
	if (len == 0) len = 1;
	return len;
  }


// Returns the number of columns in the matrix.
public static function cols(arr:Array<Array<Float>>):Int {
var len:Int = arr[0].length;
	if (len == 0) len = 1;
	return len;
}


// Returns the dimensions of the object { rows: i, cols: j }
public static function dimensions(arr:Array<Array<Float>>):Map<String,Int> {
	return ['rows' => rows(arr), 'cols' => cols(arr)];
}


// Returns a specified row as a vector
public static function row_arr(arr:Array<Array<Float>>, index:Int):Array<Float> {
  return arr[index];
}


// Returns the specified column as a vector
public static function cols_arr(arr:Array<Array<Float>>, index:Int):Array<Float> {
  var column = new Array<Float>();
  for (i in 0... arr.length)
    column[i] = arr[i][index];
  return column;
}


// Returns the diagonal of the matrix
public static function diag(arr:Array<Array<Float>>):Array<Float> {
  var nrow = rows(arr);
  var res = new Array<Float>();
  for (row in 0... nrow)
    res[row] = arr[row][row];
  return res;
}


// Returns the anti-diagonal of the matrix
public static function antidiag(arr:Array<Array<Float>>):Array<Float> {
  var nrow = rows(arr) - 1;
  var res = new Array<Float>();
  var i:Int = 0;
  while (nrow >= 0) {
	nrow--;
	i++;
    res[i] = arr[i][nrow];
  }
  return res;
}


public function transpose_arr(arr:Array<Float>):Array<Float> {
	return transpose([arr])[0];
}

// Transpose a matrix or array.
public static function transpose(arr:Array<Array<Float>>):Array<Array<Float>> {
  var obj = [];
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


public static function cumreduce_arr(arr:Array<Float>, func:Float -> Float -> Float -> Float, toAlter:Bool) {
	return cumreduce([arr],func, toAlter)[0];
}


public static function cumreduce(arr:Array<Array<Float>>, func:Float -> Float -> Float -> Float, toAlter:Bool) {
  var row:Int, nrow:Int, ncol:Int, res:Array<Dynamic>, col:Int;

  nrow = arr.length;
  ncol = arr[0].length;
  res = toAlter ? arr : new Array<Float>();

  for (row in 0... nrow) {
    // if the row doesn't exist, create it
    if (!res[row])
      res[row] = new Array<Float>();
    if (ncol > 0)
      res[row][0] = arr[row][0];
    for (col in 1... ncol)
      res[row][col] = func(res[row][col-1], arr[row][col], null);
  }
  return res;
}


// Destructively alter an array.
public static function alter_arr(arr:Array<Float>, func:Float -> Float->Float->Float) {
  return map_arr(arr, func, true);
}

// Destructively alter an array.
public static function alter(arr:Array<Array<Float>>, func:Float -> Float->Float->Float) {
  return map(arr, func, true);
}


public static function retZero(i:Float,j:Float, k:Float):Float { return 0; }


// Generate a rows x cols matrix of zeros.
public static function zeros(rows:Int, cols:Int):Array<Array<Float>> {
  //if (!isNumber(cols))
    //cols = rows;
  return create(rows, cols, retZero);
}


public static function retOne(i:Float, j:Float, k:Float ):Float { return 1; }


// Generate a rows x cols matrix of ones.
public static function ones(rows, cols):Array<Array<Float>> {
  //if (!isNumber(cols))
    //cols = rows;
  return create(rows, cols, retOne);
}


// Generate a rows x cols matrix of uniformly random numbers.
public static function rand(rows:Int, cols:Int):Array<Array<Float>> {
  if (!isNumber(cols))
    cols = rows;
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
public static function symmetric(arr:Array<Array<Float>>):Bool {
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


// Set all values to zero.
public static function clear_arr(arr:Array<Float>):Array<Float> {
  return alter_arr(arr, retZero);
}

// Set all values to zero.
public static function clear(arr:Array<Array<Float>>):Array<Array<Float>> {
  return alter(arr, retZero);
}


// Generate sequence.
public static function seq(min, max, length, func) {
    func = false;

  var arr = [];
  var hival = calcRdx(min, max);
  var step = (max * hival - min * hival) / ((length - 1) * hival);
  var current = min;
  var cnt = 0;

  // Current is assigned using a technique to compensate for IEEE error.
  // TODO: Needs better implementation.
  while (current <= max){
        {
			cnt++;
			current = (min * hival + step * hival * cnt) / hival;
			arr.push((func ? func(current, cnt) : current));
		}
    
  }

  return arr;
}







}