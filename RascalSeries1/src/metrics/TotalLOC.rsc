module metrics::TotalLOC

import util::Math;
import List;

public str evaluateLOCMetric(int c) {
	// Configurable threshholds. These are copied from <paper>
	int verygood = 66000;
	int good = 246000;
	int normal = 665000;
	int bad = 1310000;
	int verybad = 1310000;
	
	if(c <= verygood) {
		return "***** (5) [<c>]";
	} else if (c <= good) {
		return "****  (4) [<c>]";
	} else if (c <= normal) {
		return "***   (3) [<c>]";
	} else if (c <= bad) {
		return "**    (2) [<c>]";
	} else {
		return "*     (1) [<c>]";
	}
}