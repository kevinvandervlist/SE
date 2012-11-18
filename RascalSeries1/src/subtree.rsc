module subtree

import IO;
import util::ValueUI;

data CTree = leaf(int N)
			| red(CTree left, CTree right)
			| black(CTree left, CTree right) ;

public void main() {
	a = red(black(leaf(1), red(leaf(2), leaf(3))),black(leaf(4), leaf(5)));
	b = red(black(leaf(7), red(leaf(6), leaf(3))),black(leaf(4), leaf(5)));
	trees = [a, b];

	dup = [	black(leaf(4), leaf(5)), 
			black(leaf(7), red(leaf(6), leaf(3)))];
	
	/*
	 * - Maak een set knopen >= 6
	 * - Maak voor iedere knoop een list met occurences.
	 * - if(> 1) -> duplicate
	 */
	
	l = [ x | t <- trees, x <- t, d <- dup, x := d];
	iprintln(l);
	
	/*
	for(/CTree x := a, x := dup) {
		println(x);	
	}
	*/
}
