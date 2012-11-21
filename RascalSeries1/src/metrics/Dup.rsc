module metrics::Dup

import util::Math;

public str evaluateDupmetric(int dup, int tot) {
	// Configurable threshholds. These are copied from <paper>
	percentage = percent(dup, tot);
	
	
	int verygood = 3;
	int good = 5;
	int normal = 10;
	int bad = 20;
	
	if(percentage <= verygood) {
		return "***** (5) [<percentage>]";
	} else if (percentage <= good) {
		return "****  (4) [<percentage>]";
	} else if (percentage <= normal) {
		return "***   (3) [<percentage>]";
	} else if (percentage <= bad) {
		return "**    (2) [<percentage>]";
	} else {
		return "*     (1) [<percentage>]";
	}
}