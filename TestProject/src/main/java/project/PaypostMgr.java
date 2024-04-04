package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class PaypostMgr {
	
	private DBConnectionMgr pool;
	
	public PaypostMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 포인트 이용내역 - 이용한 게시글 제목 추출
	public String showPaypostTitle(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String paypostTitle = "";
		try {
			con = pool.getConnection();
			sql = "SELECT paypost_title FROM paypost WHERE PAYPOST_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				paypostTitle = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return paypostTitle;
	}
	
	public static void main(String[] args) {
		/*
		PaypostMgr mgr = new PaypostMgr();
		String test = mgr.showPaypostTitle(2);
		
		System.out.println(test);
		*/
		
	}
	
	
}
