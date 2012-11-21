module metrics::UnitLOC

import metrics::RelativeRanking;

import util::Math;
import List;

/* Evaluate the LOC metrics per unit.
 *  
 * Threshholds are from paper again:
 * 
 * To be eligible for certification at the level of 4 stars, for each programming language
 * used the percentage of lines of code residing in units with more than 20 lines of code
 * should not exceed 50%. The percentage in units with more than 50 lines of code should
 * not exceed 15%. The percentage in units with more than 100 lines should not exceed 2%.
 * SIG: http://www.sig.eu/blobs/Services%20Certificering/SIG%20TUViT%20Evaluation%20Criteria%20Trusted%20Product%20Maintainability%20Version%202.0.pdf
 */

public str evaluateUnitLOCMetric(list[int] x) {
	int good = 20;
	int normal = 50;
	int bad = 100;
	
	rating = ("Very good": 0, "Good": 0, "Normal": 0, "Bad": 0);
	t = toReal(size(x));
	
	for(i <- x) {
		if(i < good) {
			rating["Very good"] += 1;
		} else if (i < normal) {
			rating["Good"] += 1;
		} else if (i < normal) {
			rating["Normal"] += 1;
		} else {
			rating["Bad"] += 1;
		}
	}
	//map[str, real] distribution = ("Very good": (rating["Very good"] / toReal(total) * 100.0));
	//distribution2 = ("Very good": (rating["Very good"] / toReal(total) * 100.0));
	
	map[str, int] distribution = ("Very good": percent(rating["Very good"], t), 
					"Good": percent(rating["Good"], t), 
					"Normal": percent(rating["Normal"], t), 
					"Bad": percent(rating["Bad"], t));
					
	str v = "Very good: <distribution["Very good"]>% [<rating["Very good"]>]";
	str g = "good: <distribution["Good"]>% [<rating["Good"]>]";
	str n = "normal: <distribution["Normal"]>% [<rating["Normal"]>]";
	str b = "bad: <distribution["Bad"]>% [<rating["Bad"]>]";
	
	str r = getRelativeRiskUnitLOC(distribution);
							
	return "<r> \n\t[<v>, <g>, <n>, <b>]";
}