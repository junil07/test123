package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class QuestionMgr {
	private DBConnectionMgr pool;
	
	public QuestionMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
}
