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
		return "***** (5) [<percentage>% [<dup>]]";
	} else if (percentage <= good) {
		return "****  (4) [<percentage>% [<dup>]]";
	} else if (percentage <= normal) {
		return "***   (3) [<percentage>% [<dup>]]";
	} else if (percentage <= bad) {
		return "**    (2) [<percentage>% [<dup>]]";
	} else {
		return "*     (1) [<percentage>% [<dup>]]";
	}
}