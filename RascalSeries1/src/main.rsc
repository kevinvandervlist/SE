module main

import IO;
import util::ValueUI;

import kevin::UnitLOC;

public void main() {
	x = getProjectUnitInformation(|project://HelloWorld|);
	//x = getProjectUnitInformation(|project://smallsql|);
	
	
	tloc = getLOCCount(x);
	println("<tloc>");
	//r = [ f,l,u | <str f, _, int l, _, int u, _, _> <- x];	//println(r);
	
}