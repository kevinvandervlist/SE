module metrics::RelativeRanking

/*
 * Again, from the paper
 */

public str getRelativeRiskCC(map[str, int] rating) {
	if(
		(rating["moderate"] <= 25) &&
		(rating["complex"] <= 0) &&
		(rating["untestable"] <= 0)) {
			return "***** (5)";		
	} else if (
		(rating["moderate"] <= 30) &&
		(rating["complex"] <= 5) &&
		(rating["untestable"] <= 0)) {
			return "****  (4)";
	} else if (
		(rating["moderate"] <= 40) &&
		(rating["complex"] <= 10) &&
		(rating["untestable"] <= 0)) {
			return "***   (3)";
	} else if (
		(rating["moderate"] <= 50) &&
		(rating["complex"] <= 15) &&
		(rating["untestable"] <= 5)) {
			return "**    (2)";
	} else {
		return "*     (1)";	
	}
}

public str getRelativeRiskUnitLOC(map[str, int] rating) {
	if(
		(rating["Good"] <= 25) &&
		(rating["Normal"] <= 0) &&
		(rating["Bad"] <= 0)) {
			return "***** (5)";		
	} else if (
		(rating["Good"] <= 30) &&
		(rating["Normal"] <= 5) &&
		(rating["Bad"] <= 0)) {
			return "****  (4)";
	} else if (
		(rating["Good"] <= 40) &&
		(rating["Normal"] <= 10) &&
		(rating["Bad"] <= 0)) {
			return "***   (3)";
	} else if (
		(rating["Good"] <= 50) &&
		(rating["Normal"] <= 15) &&
		(rating["Bad"] <= 5)) {
			return "**    (2)";
	} else {
		return "*     (1)";	
	}
}
