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
	// A buffer to keep all visited nodes > depth to prevent inclusion of subnodes.
	set[AstNode] buf = {};
	
	// Find nodes of the trees
	for(x <- asts) {
		//top-down-break visit(x) {
		top-down-break visit(x) {
			case AstNode a: if(getLineDepth(a, depth)) {
				if(a in codeblocks) {
					codeblocks[a] = codeblocks[a] + [<a@location, countLOC(a), a>];
				} else {
					// Obselete because of fail:
					//if(!partOfBlocks(buf, a)) {
					codeblocks[a] = [<a@location, countLOC(a), a>];
					fail;
				}
				// Make sure to add the current node to the buffer of visited top nodes.
			} else {
				fail;
			}
		}
	}

	// Filter the list to retain only duplicate nodes (e.g. have > 1 occurence).
	list[list[block]] dups = [ codeblocks[k] | k <- codeblocks, size(codeblocks[k]) > 1];
	
	// Remove all nodes that are part of another node also in the list.
	/*
	println("Remove subtrees");
	map[AstNode, int] sub = ();
	for(x <- buf) {
		if(partOfBlocks(buf, x)) {
			sub[x] = 0;
		}
	}
	println("End of subtrees");
	dups = dups - sub;
	*/
	// Possibly remove the head of each of the dups.
	// This is because you could argue that the first occurence is not a duplicate after all.
	//dups = [ tail(x) | x <- dups];
	
	// Create a sum of LOC of all duplicate parts.
	println("Total: <sum([ x.LOC | d <- dups, x <- d])>");
	
	
	
	///* Possibility: 
	map[str filepath, set[int] lines] duplines = ();
	
	for(d <- dups) {
		for(b <- d) {
			path = b.location.path;
			if(path in duplines) {
				duplines[path] = duplines[path] + LOCLineset(b.astnode); 			
			} else {
				duplines[path] = LOCLineset(b.astnode);
			}
		}
	}
	temptot = sum([ size(duplines[i]) | i <- duplines]);
	//*/
	// Create the total lines of duplicate code
	// How do we count? Discuss with Liam
	for(d <- dups) {
		l = [ i.LOC | i <- d];
		// Substract the head?
	}	
	// Testing
	for(d <- dups) {
		sumloc = [ i.LOC | i <- d];
		info = [<i.location, i.LOC> | i <- d ];
		println("[<size(d)>|(<sum(sumloc)>)]Dup: <info>");	
	}
	
	return toInt(temptot);
}