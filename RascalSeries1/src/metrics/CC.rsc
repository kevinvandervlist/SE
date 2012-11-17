module metrics::CC

import util::Math;
import List;

import metrics::RelativeRanking;

/* Evaluate the Cyclometic Complexity metrics per unit.
 *  
 * Threshholds are from paper again:
 */

public str evaluateUnitCCMetric(list[int] x) {
	int simple = 10;
	int moderate = 20;
	int complex = 50;
	
	rating = ("simple": 0, "moderate": 0, "complex": 0, "untestable": 0);
	t = toReal(size(x));
	
	for(i <- x) {
		if(i <= simple) {
			rating["simple"] += 1;
		} else if (i <= moderate) {
			rating["moderate"] += 1;
		} else if (i <= complex) {
			rating["complex"] += 1;
		} else {
			rating["untestable"] += 1;
		}
	}
	
	map[str, int] distribution = ("simple": percent(rating["simple"], t), 
					"moderate": percent(rating["moderate"], t), 
					"complex": percent(rating["complex"], t), 
					"untestable": percent(rating["untestable"], t));
					
	str s = "Simple: <distribution["simple"]>% [<rating["simple"]>]";
	str m = "More complex: <distribution["moderate"]>% [<rating["moderate"]>]";
	str c = "Complex: <distribution["complex"]>% [<rating["complex"]>]";
	str u = "Untestable: <distribution["untestable"]>% [<rating["untestable"]>]";
	
	str r = getRelativeRiskCC(distribution);
							
	return "<r> \n\t[<s>, <m>, <c>, <u>]";
}