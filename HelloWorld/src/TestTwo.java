/**
 * This is a test for a multiline comment
 * @author kevin
 *
 */
public class TestTwo implements ITestTwo {
	private int cnt = 0;
	
	// Blah
	public TestTwo(int q) {
		this.cnt = q;
	}

	public int getCnt() {
		return this.cnt;
	}
	
	public void setCnt(int w) {
		this.cnt = w;
	}
	
	// This is a stupid complex function
	public int getCnt(int q) {
		if(q > this.cnt) {
			if(q > 10) {
				return this.cnt;
			}
		} else {
			return q;
		}
		if(true) {
			return -1;
		}
		return 0;
	}
}
