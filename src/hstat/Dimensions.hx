package hstat;

class Dimensions{
    
    public static function getDimensions<T>(a:Array<T>):Dimension_type{
        if (Std.is( a[0], Float )) return List;
        return Matrix;     
    }
}

enum Dimension_type {	
    List;
    Matrix;
}