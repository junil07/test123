package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class UserMgr {
	
	private DBConnectionMgr pool;
	
	public UserMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 로그인 - 성공 true 실패 false
	public boolean loginChk(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(USER_ID) FROM user WHERE USER_ID = ? AND USER_PW = ?";
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
	
	// 회원가입
	public boolean createAccount(UserBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getUser_pw());
			pstmt.setString(3, bean.getUser_name());
			pstmt.setString(4, bean.getUser_phone());
			pstmt.setString(5, bean.getUser_email());
			pstmt.setInt(6, bean.getUser_point());
			pstmt.setInt(7, 1);
			if ( pstmt.executeUpdate() > 0 ) flag = true;
			else {}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 내 정보 - 사용자 정보 출력
	public Vector<UserBean> showUserInfo(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<UserBean> vlist = new Vector<UserBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM user WHERE USER_ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				UserBean bean = new UserBean();
				bean.setUser_id(rs.getString(1));
				bean.setUser_pw(rs.getString(2));
				bean.setUser_name(rs.getString(3));
				bean.setUser_phone(rs.getString(4));
				bean.setUser_email(rs.getString(5));
				bean.setUser_point(rs.getInt(6));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 내 정보 - 사용자 정보 수정
	public void updateUserInfo(UserBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "";
			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	
	
	
	
	

	/*
	UserMgr mgr = new UserMgr();
	Vector<UserBean> beanbaby;
	beanbaby = mgr.showUserInfo("dyflrqjvm");
	
	for ( int i = 0; i < beanbaby.size(); i++ ) {
		UserBean bean = beanbaby.get(i);
		System.out.println(bean.getUser_email());
		System.out.println(bean.getUser_pw());
		System.out.println(bean.getUser_id());
		System.out.println(bean.getUser_name());
		System.out.println(bean.getUser_phone());
		System.out.println(bean.getUser_point());
	}
	
	*/

	
	
}
