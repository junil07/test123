package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ManagerMgr {
	
	private DBConnectionMgr pool;
	
	public ManagerMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 관리자 로그인 - 성공 true 실패 false
	public boolean ManagerloginChk(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM manager WHERE MANAGER_ID = ? AND MANAGER_PW = TO_BASE64(AES_ENCRYPT(?, 'testkey123'))";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if ( rs.next() && rs.getInt(1) == 1 ) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 내 정보 - 관리자 정보 출력
	public Vector<ManagerBean> showManagerInfo(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ManagerBean> vlist = new Vector<ManagerBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM manager WHERE MANAGER_ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				ManagerBean bean = new ManagerBean();
				bean.setManage_id(rs.getString(1));
				bean.setManage_pwd(rs.getString(2));
				bean.setManage_name(rs.getString(3));
				bean.setManage_phone(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
