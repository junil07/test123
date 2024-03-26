package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class NoticeMgr {
	private DBConnectionMgr pool;
	
	public NoticeMgr() {
		pool = DBConnectionMgr.getInstance();
		System.out.println("성공완");
	}
	
	public void testList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			
			con = pool.getConnection();
			sql = "select * from notice";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getInt(1));
				System.out.println(rs.getString(2));
				System.out.println(rs.getString(3));
				System.out.println(rs.getString(4));
				System.out.println(rs.getInt(5));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	public static void main(String[] args) {
		//NoticeMgr mgr = new NoticeMgr();
		//mgr.testList();
	}
}
