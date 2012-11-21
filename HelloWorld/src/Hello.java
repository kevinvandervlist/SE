import Abstract.Foo;

public class Hello {
	private int a;
	private int b;
	
	public static void main(String[] args) {
		System.out.println("Hi");
		test(true);
		test(false);
		// Blaahaunthaonsuhaosu
		TestTwo 
		t = 
				new TestTwo(1);
		System.out.println(t.getCnt());
		System.out.println(t.getCnt(5));
		
		/* 
		 * Blah
		 */
		t.setCnt(100);
		System.out.println(t.getCnt(12));
		
		Foo f = new Foo();
		f.abstractFoo();
		f.foo();
	}
	
	private static void test(boolean b) {
		if(b) {
			System.out.println("b = true");
		} else {
			System.out.println("b = false");
		}
	}
}
