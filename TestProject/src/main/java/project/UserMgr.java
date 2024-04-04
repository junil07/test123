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
	
	// 사용자 로그인 - 성공 true 실패 false
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
			// INSERT INTO user VALUES('asdf123', '123123', '성진차', '01001010101', 'lkalala@naver.com', 1, 1)
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getUser_pw());
			pstmt.setString(3, bean.getUser_name());
			pstmt.setString(4, bean.getUser_phone());
			pstmt.setString(5, bean.getUser_email());
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 1);
			if ( pstmt.executeUpdate() > 0 ) flag = true;
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
				bean.setUser_grade(rs.getInt(7));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
		
	// 내 정보 - 사용자 정보 수정 아이디 제외
	public boolean updateUserInfo(int check, String a, String idKey) {  // check에 따라 비번, 이메일 등 다르게 넣음
		Connection con = null;											// a는 바꿀 값 idKey는 세션 값 
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if ( check == 1 ) { 				// id  바꿈 근데 안함
			} else if ( check == 2 ) {			// pwd 바꿈
				con = pool.getConnection();
				sql = "UPDATE user SET USER_PW = ? WHERE USER_ID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, a);
				pstmt.setString(2, idKey);
				if ( pstmt.executeUpdate() > 0 ) flag = true;
			} else if ( check == 3 ) {			// 이름 바꿈
				con = pool.getConnection();
				sql = "UPDATE user SET USER_NAME = ? WHERE USER_ID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, a);
				pstmt.setString(2, idKey);
				if ( pstmt.executeUpdate() > 0 ) flag = true;
			} else if ( check == 4 ) {			// 전화번호 바꿈
				con = pool.getConnection();
				sql = "UPDATE user SET USER_PHONE = ? WHERE USER_ID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, a);
				pstmt.setString(2, idKey);
				if ( pstmt.executeUpdate() > 0 ) flag = true;
			} else if ( check == 5 ) {			// 이메일 바꿈
				con = pool.getConnection();
				sql = "UPDATE user SET USER_EMAIL = ? WHERE USER_ID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, a);
				pstmt.setString(2, idKey);
				if ( pstmt.executeUpdate() > 0 ) flag = true;
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 내 정보 - 사용자 정보 수정 - 아이디 중복확인
	public boolean checkDuplicate(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM USER WHERE USER_ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if ( rs.next() ) {
				int count = rs.getInt(1);
				flag = (count == 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 포인트 - choice = 1은 포인트 충전 choice = 2는 포인트 환불
	public boolean pointCharge(String id, int userpoint, int chargepoint, int choice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			if ( choice == 1 ) {
				con = pool.getConnection();
				sql = "UPDATE USER SET USER_POINT = ? + ? WHERE USER_ID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, userpoint);
				pstmt.setInt(2, chargepoint);
				pstmt.setString(3, id);
				if ( pstmt.executeUpdate() == 1 ) flag = true;
			} else if ( choice == 2 ) {
				con = pool.getConnection();
				sql = "UPDATE USER SET USER_POINT = ? - ? WHERE USER_ID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, userpoint);
				pstmt.setInt(2, chargepoint);
				pstmt.setString(3, id);
				if ( pstmt.executeUpdate() == 1 ) flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 포인트에 3 글자마다 쉼표 붙이기
	public String addComma(int num) {
		String numString = String.valueOf(num);
		int length = numString.length();
		StringBuilder result = new StringBuilder();
		
		for (int i = 0; i < length; i++) {
            if ((length - i) % 3 == 0 && i != 0) {
                result.append(",");
            }
            result.append(numString.charAt(i));
        }
		return result.toString();
	}
	
	
	
	/*
	public static void main(String[] args) {
		UserMgr mgr = new UserMgr();
		boolean flag = mgr.pointCharge("dyflrqjvm", 1000, 500);
		System.out.println(flag);
	}
	
	
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
