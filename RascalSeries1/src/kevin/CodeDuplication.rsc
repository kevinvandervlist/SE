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
	return toInt(size(LOCLineset(n)));
}

/**
 * Return a set of lines of code that are part of an AstNode.
 */

private set[int] LOCLineset(AstNode n) {
	lineset = {n@location.begin.line, n@location.end.line};
	
	visit(n) {
		case AstNode a:
			lineset += {a@location.begin.line, a@location.end.line};
	}
	return lineset;
}

/**
 * Return whether a given node 'part' is part of a of the 
 * 'full' tree/node.
 */
private bool partOf(AstNode full, AstNode part) {
	return (/full := part) && (full != part);
}

/**
 * Return whether a node 'part' is contained within a set of nodes 
 */
private bool partOfBlocks(set[AstNode] buf, AstNode part) {
	for(x <- buf) {
		if(partOf(x, part)) {
			return true;
		}
	}
	return false;
}

/* 
 * Current issues: 'child' nodes of a duplicate still sufficing the depth contstraint still
 * are added to the duplicate collecion. Fixable with top-down visiting?
 * They do have to be removed though.
 */ 

public int getCodeDuplicationLineCount(loc project, int depth) {
	asts = createAstsFromProject(project);
	
	map[AstNode, list[block]] codeblocks = ();
	
	/* Find nodes of the trees
	 * Do a top-down-break, with failing.
	 * This can done because at a certain level in the tree (started at the top), all subnodes of 
	 * a match will always be a subtree, and therefore not interesting at all.
	 * For a previous (manual way) of doing it, where subnodes were pruned at the end, see: 
	 * https://github.com/kevinvandervlist/SE/commit/d15ba1c54f636df80ddb638b2228038ab622734f
	 * This is WAAAAAAAAAAAY slower. 
	 */
	for(x <- asts) {
		top-down-break visit(x) {
			case AstNode a: if(getLineDepth(a, depth)) {
				if(a in codeblocks) {
					codeblocks[a] = codeblocks[a] + [<a@location, countLOC(a), a>];
				} else {
					codeblocks[a] = [<a@location, countLOC(a), a>];
					fail;
				}
			} else {
				fail;
			}
		}
	}

	// Filter the list to retain only duplicate nodes (e.g. have > 1 occurence).
	list[list[block]] dups = [ codeblocks[k] | k <- codeblocks, size(codeblocks[k]) > 1];
	
	// Possibly remove the head of each of the dups.
	// This is because you could argue that the first occurence is not a duplicate after all.
	//dups = [ tail(x) | x <- dups];
	
	// Create a sum of LOC of all duplicate parts.
	return toInt(sum([ x.LOC | d <- dups, x <- d]));
}