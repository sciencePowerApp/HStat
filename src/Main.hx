package;

//import hstat.Core;

import hstat.tests.Tests;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author 
 */
class Main extends Sprite 
{

	public function new() 
	{
		super();


		#if debug
			var tests:Tests = new Tests();
		#end
	}

}
