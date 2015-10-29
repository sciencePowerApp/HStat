package hstat;
import hstat.Dimensions.Matrix;

typedef Array2D<T> = Array<Array<T>>;
typedef Array1D = Array<Float>;

enum MatrixData {
    Array<Float>(s:Array<Float>);
    Array2D<Float>(s:Array2D<Float>);
}


@:arrayAccess
abstract Matrix(MatrixData) from MatrixData {
	
	inline public function new() {
		this = cast new Array<Array<Float>>();
	}
	
     @:from static function fromIntArray(s:Array<Int>):Matrix {
         return cast s;
     }
    
     @:from static function fromFloatArray(s:Array<Float>):Matrix {
         return cast s;
     }
    
    @:from static function fromIntArray2D(s:Array<Array<Int>>):Matrix {
        return cast s;
    }
    
    @:from static function fromFloatArray2D(s:Array<Array<Float>>):Matrix {
        return cast s;
    }
    
    public function get(x:Int, y:Int):Float {
		if (is2D){
			var arr:Array<Array<Float>> = cast this;
			return cast arr[y][x];
		}
			
		var arr:Array<Float> = cast this;

		return arr[x];	
				
    }
	
	public function addRow():Matrix {
		if (is2D) {
			var x:Array<Array<Float>> = cast this;
			x.push(new Array1D());
			return cast x;
		}

		var x:Array<Float> = cast this;
		var m:Matrix = fromFloatArray(x);
		return cast m;

    }
	
	public function pushToCol(row:Int, val:Float) {
		
		if (is2D) {
				var x:Array<Array<Float>> = cast this;
				x[row].push(val);
			} 
			var x:Array<Float> = cast this;
			if (row == 0) {
			
				x.push(val);
				
			}
			else throw "1D array and requested to push to a row other than zero";
	
		
	}
	
	public function copy():Matrix {
		if (is2D) {
			var x:Array<Array<Float>> = cast this;
			var c:Array<Array<Float>> = new Array<Array<Float>>();
			
			var row:Array<Float>;
			for (i in 0...x.length) {
				for (ii in 0...x[i].length) {
					c[i][ii] = x[i][ii];
				}
			}
			return cast c;
		} 
		var x:Array<Float> = cast this;
		var c:Array<Float> = new Array<Float>();
		for (i in 0...x.length) {
			c[i] = x[i];
		}
		return cast c;
		
	}
	
	public function set( x : Int, y:Int, value : Float ) : Matrix {
		
      if (!is2D) 
			throw "Matrix error. Must be 3D";

		var m:Array<Array<Float>> = cast this;
		
		if (m.length - 1 > y) throw "Matrix error. Not allowed empty columns";
		else if (m.length - 1 == y) m.push( [] );
		
		if(m[y].length - 1 > x) throw "Matrix error. Not allowed empty values in row";

		
		m[x][y] = value;
		return cast m;
		
	}
	
	public function toString():String {
			if (is2D) {
				var x:Array<Array<Float>> = cast this;
				return x.toString();
			} 
			var x:Array<Float> = cast this;
			return x.toString();
		
	}
	
	
    public var is2D(get, never):Bool;
    public inline function get_is2D():Bool {
		var x:Array1D = cast this;
        return Std.is(x[0], Array1D);
    }
	
	public function hasRow(row:Int):Bool{
		if (is2D) {
			var x:Array<Array<Float>> = cast this;
			return x.length-1 >= row;
		}
		var x:Array1D = cast this;
		if (x.length > 0 && row == 1) return true;
		return false;
    }
	
	public var rows(get, never):Int;
    public inline function get_rows():Int {
		var x:Array1D = cast this;
        return x.length;
    }
	

	
	public var cols(get, never):Int;
    public inline function get_cols():Int {
		if (is2D) {
			var x:Array<Array<Float>> = cast this;
			return x[0].length;
		}
		return 1;
    }
	
	@:op(A * B) // example operation
	private function multiply(rhs:Float):Matrix {
		if (is2D) {
			var x:Array<Array<Float>> = cast this;
			for (n1 in 0...x.length) {
				var y:Array<Float> = x[n1];
				for (n2 in 0...y.length) {
					y[n2] *= rhs;
				}
			}
			return cast x;
		} else {
			var x:Array<Float> = cast this;
			for (n1 in 0...x.length) {
				x[n1] *= rhs;
			}
			return cast x;
		}
		throw "Matrix operation error";
		return cast new Array<Float>();
	}
	
	
	
	public function get_row(row:Int):Array<Float> {
		if (is2D) {
			var x:Array<Array<Float>> = cast this;
			if (x.length - 1 >= row)	return x[row];
			else throw "trying to get row " + Std.string(row) + " but no such row.";
		}
		if (row > 0) throw "trying to get row " + Std.string(row) + " but on a 1d matrix.";
		var x:Array<Float> = cast this;
		return x;
	}
}
