module main

import IO;
import util::ValueUI;

import kevin::UnitInformation;
import Liam::CyclomaticComplexity;

import metrics::TotalLOC;
import metrics::UnitLOC;
import metrics::CC;

public void main() {
	// Pick a project
	//p = |project://HelloWorld|;
	p = |project://smallsql|;

	println("Starting parsing of <p> ...");		
	s_tree = getProjectUnitInformation(p);
	
	// Metric one: Lines of code:
	tloc = getLOCCount(s_tree);
	ret = evaluateLOCMetric(tloc);
	println("Total lines of code: <ret>");
	
	// Complexity per unit: Liam.
	// Do something
	ret = evaluateUnitCCMetric(getCyclometicComplexityList(s_tree));
	println("Cyclometic Complexity per unit: <ret>");
	
	// Code duplication
	// Do something as well
	
	// Unit size
	ret = evaluateUnitLOCMetric(getUnitSizeList(s_tree));
	println("Lines of code per unit distribution: <ret>");

	// Unit testing
	// Last thing
}