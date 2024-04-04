package project;

public class ManagerMgr {
	
	private DBConnectionMgr pool;
	
	public ManagerMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
}
