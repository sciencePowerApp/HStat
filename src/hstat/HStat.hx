package hstat;

import thx.Types;

 
class HStat
{


	public function new() 
	{
		
	}
	
	static public function isFunction(arg:Dynamic) {
	
	  return Reflect.isFunction(arg);
	}
	
	
	// Generate a rows x cols matrix according to the supplied function.
	public static function  create(rows:Int, cols:Dynamic, func:Dynamic->Dynamic->Dynamic):Array<Dynamic> {
	  var res = [];
	  var i:Int, j:Int;

	  if (isFunction(cols)) {
		func = cols;
		cols = rows;
	  }

	  for (i in 0 ... rows) {
		res[i] = [];
		for (j in 0...cols)
		  res[i][j] = func(i, j);
	  }

	  return res;
	};
	
	
	public static function zeros(rows:Int, cols:Int):Dynamic {

	  if (!isNumber(cols))	cols = rows;
	  
	  return create(rows, cols, retZero);
	};
	
	public static function isNumber(num:Dynamic):Bool {
		return Std.is(num, Float);	
	}
	
	
	public static function isArray(arg:Dynamic):Bool {
		//should really have NumberArray check
		return Types.toString(arg) == "Array";
	}	
	

	
	public static function alter(arr, func) {
		return map(arr, func, true);
	};
	
	public static function map(_arr:Array<Dynamic>, func, toAlter:Bool) {
	  var row, nrow:Int, ncol:Int, res, col;
	  var arr:Array<Dynamic>;
	  
	  if (!isArray(_arr[0]))	arr = [_arr];
	  else arr = _arr;

	  nrow = arr.length;
	  ncol = arr[0].length;
	  res = toAlter ? arr : [];

	  for (row in 0... nrow) {
		// if the row doesn't exist, create it
		if (!res[row])
		  res[row] = new Array();
		for (col in 0... ncol)
		  res[row][col] = func(arr[row][col], row, col);
	  }

	  return res.length == 1 ? res[0] : res;
	};
	
	public static function retZero(a:Dynamic,b:Dynamic) { return 0; }

	
	
	
	// sum of an array
	public static function sum(arr:Array<Float>):Float {
	
		var total:Float = 0;
		for (val in arr) {
			total += val;
		}
		return total;

	}




}