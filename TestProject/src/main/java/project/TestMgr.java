package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class TestMgr {
	
	private DBConnectionMgr pool;
	
	public TestMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public TestBean getTestInfo(String test_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		TestBean tbean = new TestBean();
		try {
			con = pool.getConnection();
			sql = "select * from test where test_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, test_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				tbean.setTest_num(rs.getString(1));
				tbean.setTest_title(rs.getString(2));
				tbean.setTest_year(rs.getString(3));
				tbean.setTest_subject(rs.getString(4));
				tbean.setTest_subnumber(rs.getInt(5));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return tbean;
	}
}
