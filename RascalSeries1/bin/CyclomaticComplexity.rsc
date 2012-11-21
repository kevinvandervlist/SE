module CyclomaticComplexity

//import lang::java::jdt::Java;
//import lang::java::jdt::JDT;
import lang::java::jdt::JavaADT;


/*
@precondition: AstNode n is a method with a non-null implementation
@postcondition: returned number is the cyclomatic complexity of n
*/
public int getCyclomaticComplexity(AstNode n){
	int cc = 1;
	
	visit(n){
		case ifStatement(_, _, _) 	: cc += 1;
		case forStatement(_,_,_,_)	: cc += 1;
		case switchCase(false, _)	: cc += 1; //only when it is not the default case
		case whileStatement(_,_)	: cc += 1;
		//case continueStatement(_)	: cc += 1;
		//case breakStatement(_)	: cc += 1;
	};
	
	return cc;
}


/*
@precondition: 	set[AstNode] nodes is a non-empty set. 
		nodes is a set of methods, classes, packages or compilation units.
@postcondition: returned set of tuples <methodnode, cc> where:
			methodnode is a an AstNode of a method, for which cyclomatic complexity was computed
		 	cc is the corresponding cyclomatic complexity that was computed. 
*/
public rel[AstNode, int] getCyclomaticComplexitiesOfMethods(set[AstNode] nodes){
	rel[AstNode,int] result ={};
	
	for( n <- nodes){
		visit(n){
			case m:methodDeclaration(_, _, _, _,_, _, _, _) : 
				result += <m, getCyclomaticComplexity(m)>; 
		};
	}
	
	return result;
}

//this is a test change
