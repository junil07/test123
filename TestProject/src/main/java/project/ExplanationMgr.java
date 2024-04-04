package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ExplanationMgr {
	
	private DBConnectionMgr pool;
	
	public ExplanationMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<ExplanationBean> explanationlist(int question_num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ExplanationBean> vlist = new Vector<ExplanationBean>();
		try {
			con = pool.getConnection();
			sql = "select * from explanation where explanation_question_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, question_num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
}
