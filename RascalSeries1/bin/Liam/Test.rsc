module Liam::Test

import lang::java::jdt::Java;
import lang::java::jdt::JDT;
import lang::java::jdt::JavaADT;
import IO;
import List;



public loc loc_HelloWorld = |project://HelloWorld|;
public loc loc_smallsql = |project://smallsql|;

public set[AstNode] tree1 = createAstsFromProject(loc_HelloWorld);

public EntityRel getSubTypeInformation(loc project){
	fm = extractProject(project);
	return fm@extends + fm@implements;
}

public BindingRel getClasses(loc project){
	fm = extractProject(project);
	return fm@classes;
}

public BindingRel getPackages(loc project){
	fm = extractProject(project);
	return fm@packages;
}


public list[AstNode] getMethodDeclarations(set[AstNode] nodes){
	list[AstNode] result = [];
	
	for( n <- nodes){
		visit(n){
			case x:methodDeclaration(_, _, _, _, _, _, _, _) : println(x); 
		};
	};
	
	return result;
}


public void getTopLevelNodes(set[AstNode] nodes){
	for( n <- nodes){
		println(n);
	}
}

