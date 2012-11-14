public class Test{

	public static void forTest(){
		int x = 0;
		for(int i=0; i < 3; i++){
			x += i;
		}
		
		return;
	}
	
	
	public static void caseTest(){
		int x = 3;
		
		switch(x){
			case 1: break;
			case 2: break;
			default: break;
		}
	}
	
	
	public static void whileTest(){

		int x = 110;
		
		while(x > 0)
			x--;
	}
	
	public static void main(String[] args){
	
		int x = 3;
		
		if(x == 3){
			x = 2;
		}else{
			x = 3;
		}
			
			
	}
	
}