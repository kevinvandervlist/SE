module kevin::UnitLOC

import IO;
import lang::java::jdt::Java;
import lang::java::jdt::JDT;
import lang::java::jdt::JavaADT;
import util::ValueUI;
import util::Math;
import Node;
import Set;
import List;

/**
 * Return a tuple containing information for a certain Unit.
 * @param location The location of the unit
 * @param name The name of the unit.
 * @param body The body of the unit.
 *
 * Line numbers retrieved from all AstNodes that are in the given unit body.
 * 
 * @return tuple[loc a, str b, int c, list[int] d]
 * Explanation:
 * a: The loc location of the unit in question. 
 * b: The name of the unit.
 * c: The number of <i>actual</i> lines containing a statement in any way.
 * d: A list containing all the line numbers that contain at least one statement. 
 */
 
alias unit = tuple[	loc location, 
					str name, 
					int LOC, 
					list[int] LOCLines];

private unit parseUnit(loc location, str name, AstNode body) {
	lineset = {location.begin.line, location.end.line};

	visit(body) {
		case AstNode a:
			lineset += {a@location.begin.line, a@location.end.line};
	}
	ll = sort(lineset);
	return <location, name, size(ll), ll>; 
}

/* Return a set containing tuples of class information. 
 * The tuple contain:
 * 1) str - The name of the class
 * 2) loc - Location
 * 3) int - The number of lines <i>outside</i> unit blocks
 * 4) list[int] - The lines that contain code
 * 5) int - The total lines of code of the units grouped together.
 * 6) int - The number of units in the file
 * 7) set[units] - The set with the units in the file 
 */
 
 alias classUnit = rel[	str name, 
 						loc location, 
 						int classLOC, 
 						list[int] classLOCLines, 
 						int totalLOC, 
 						int unitCount, 
 						rel[loc location, str name, int LOC, list[int] LOCLines] units];

public classUnit getProjectUnitInformation(loc project) {
	asts = createAstsFromProject(project);
	
	files = {};
	
	for(x <- asts) {
	
		classloc = {};
		classname = "";
		units = {};
		
		visit(x) {
			case p: packageDeclaration(_, _): 
				classloc += {p@location.begin.line, p@location.end.line};
				
			case i: importDeclaration(_, _, _): 
				classloc += {i@location.begin.line, i@location.end.line};
			
			case c: typeDeclaration(_, _, str class, str name, _, _, _, _): {
				classloc += {c@location.begin.line, c@location.end.line};
				classname = name;
			}
			
			case f: fieldDeclaration(_, _, t, _):
				classloc += {t@location.begin.line, t@location.end.line};
				
			case m: methodDeclaration(_, _, _, _, str name, _, _, some(body)):
				units += parseUnit(m@location, name, body);
			
			case i: methodDeclaration(_, _, _, _, str name, _, _, none()): 
				classloc += {i@location.begin.line, i@location.end.line};
		}
		
		s_classloc = sort(classloc);
		
		// Create a sum of LOC of all units
		unitsum = toInt(sum([ n | <_, _, int n, _> <- units]));
		
		result = <	classname, 
					x@location, 
					size(s_classloc), 
					s_classloc, 
					unitsum, 
					size(units), 
					units>;
		
		// Add it to the set of results
		files += result;
	}
	return files;
}

/*
 * Return the total lines of code, given the input of getProjectUnitInformation()
 * @param The project unit info
 * @return int The total LOC.
 */ 

public int getLOCCount(x) {
	return toInt(sum([ l,u | <_ , _, int l, _, int u, _, _> <- x]));
}

/*
 * Return a list consisting of all the lengths of the units
 * @param The project unit info
 * @return list[int] with all unit lengths. 
 */
public list[int] getUnitSizeList(x) {
	return [ u.LOC | z <- x<units>, u <- z];
}