module TutorTest

public list[str] dup(list[str] text){
	m = {};
	return 
		for(s <- text)
			if(s in m)
				append s;
			else
				m += s;
		
}