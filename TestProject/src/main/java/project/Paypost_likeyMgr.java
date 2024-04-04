package project;

public class Paypost_likeyMgr {
DBConnectionMgr pool;
	
	public Paypost_likeyMgr() {
		pool = DBConnectionMgr.getInstance();
		System.out.println("성공완");
	}
	
	
}
