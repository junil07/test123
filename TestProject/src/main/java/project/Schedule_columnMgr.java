package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class Schedule_columnMgr {
	
	private DBConnectionMgr pool;
	
	public Schedule_columnMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 시험 일정 가져오기
	public Vector<Schedule_columnBean> getExamSchedule(int fknum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Schedule_columnBean> vlist = new Vector<Schedule_columnBean>();
		try {
			con = pool.getConnection();
			sql = "";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
}
