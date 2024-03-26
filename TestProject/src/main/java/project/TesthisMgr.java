package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TesthisMgr {
	
	private DBConnectionMgr pool;
	
	public TesthisMgr() {
		pool = DBConnectionMgr.getInstance();
	}
}
