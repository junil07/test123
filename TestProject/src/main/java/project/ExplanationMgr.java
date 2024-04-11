package project;

public class ExplanationMgr {
	
	private DBConnectionMgr pool;
	
	public ExplanationMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
}
