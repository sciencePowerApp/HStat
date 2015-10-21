package hstat.tests.distribution;
import hstat.Distribution.Hypgeom;
import utest.Assert;
/**
 * ...
 * @author 
 */
class Hypergeometric_test
{

	public function new() {	}
	
	public function pdf(jStat) {
      var tol = 0.0000001;
      // How many 1s were obtained by sampling?
      var successes = [10, 16];
      // How big was the source population?
      var population = [100, 3589];
      // How many 1s were in it?
      var available = [20, 16];
      // How big a sample was taken?
      var draws = [15, 2290];
      // What was the probability of exactly this many 1s?
      // Obtained from the calculator at
      // <http://www.geneprof.org/GeneProf/tools/hypergeometric.jsp>
      var answers = [0.000017532028090435493, 0.0007404996809672229];

      for (i in 0...answers.length) {
        // See if we get the right answer for each calculation.
        var calculated = Hypgeom.pdf(successes[i],
                                           population[i],
                                           available[i],
                                           draws[i]);
        // None of the answers should be NaN
        Assert.isTrue(!Math.isNaN(calculated));
        // And they should all match
        Assert.floatEquals(calculated, answers[i],tol);
      }
	
	}
}