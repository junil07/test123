package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TestMgr {
	
	private DBConnectionMgr pool;
	
	public TestMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
}
