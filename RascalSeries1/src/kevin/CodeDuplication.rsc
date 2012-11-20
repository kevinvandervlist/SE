module kevin::CodeDuplication

import IO;

import lang::java::jdt::Java;
import lang::java::jdt::JDT;
import lang::java::jdt::JavaADT;
import util::Math;
import util::ValueUI;
import Set;
import List;
import Map;

alias block = tuple[loc location,
					int LOC,
					AstNode astnode];
					
/* 
 * Return true or false, depending on whether a given node has adepth 
 * of >= <depth> below it (including itself).
 */

private bool getLineDepth(AstNode n, int depth) {
	lineset = {n@location.begin.line, n@location.end.line};

	visit(n) {
		case AstNode a:
			lineset += {a@location.begin.line, a@location.end.line};
	}
	return (toInt(size(lineset)) >= depth);
}

/*
 * Count the number of lines of code that are child of a given node.
 */

private int countLOC(AstNode n) {
	lineset = {n@location.begin.line, n@location.end.line};
	
	visit(n) {
		case AstNode a:
			lineset += {a@location.begin.line, a@location.end.line};
	}
	return toInt(size(lineset));
}

/* 
 * Current issues: 'child' nodes of a duplicate still sufficing the depth contstraint still
 * are added to the duplicate collecion. Fixable with top-down visiting?
 * They do have to be removed though.
 */ 

public int getCodeDuplicationLineCount(loc project) {
	asts = createAstsFromProject(project);
	
	map[AstNode, list[block]] codeblocks = ();
	set[AstNode] buf = {};
	
	// Find nodes of the trees
	for(x <- asts) {
		//top-down-break visit(x) {
		top-down visit(x) {
			case AstNode a: if(getLineDepth(a, 6)) {
				if(a in codeblocks) {
					codeblocks[a] = codeblocks[a] + [<a@location, countLOC(a), a>];
				} else {
					// simple: if a not a subtree of buf:
					codeblocks[a] = [<a@location, countLOC(a), a>];
					buf += a;
					// Nice: if a not in a subtree of map:codeblocks:
					// codeblocks[a] = [<a@location, countLOC(a), a>];
				}
			}
		}
	}
	
	// Filter the list to retain only duplicate nodes
	list[list[block]] dups = [ codeblocks[k] | k <- codeblocks, size(codeblocks[k]) > 1];
	
	// Create the total lines of duplicate code
	// How do we count? Discuss with Liam
	
	// Testing
	for(d <- dups) {
		sumloc = [ i.LOC | i <- d];
		info = [<i.location, i.LOC> | i <- d ];
		println("[<size(d)>|(<sum(sumloc)>)]Dup: <info>");	
	}
	
	return 1;
}