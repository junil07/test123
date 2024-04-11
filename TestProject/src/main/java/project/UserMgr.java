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
	
	
	//user테이블 리스트 출력
	public Vector<UserBean> getUserList(String keyField, String keytext, int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<UserBean> ulist = new Vector<UserBean>();
		try {
			con = pool.getConnection();
			if(keytext.trim().equals("") || keytext == null) {
				sql = "select * from user order by user_name asc Limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					UserBean ubean = new UserBean();
					ubean.setUser_id(rs.getString(1));
					ubean.setUser_pw(rs.getString(2));
					ubean.setUser_name(rs.getString(3));
					ubean.setUser_phone(rs.getString(4));
					ubean.setUser_email(rs.getString(5));
					ubean.setUser_point(rs.getInt(6));
					ubean.setUser_grade(rs.getInt(7));
					ulist.add(ubean);
				}
			}else{
				if ("USER_POINT".equals(keyField)) {
					sql = "select * from user where USER_POINT like ? order by user_name asc limit ?, ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keytext);
		            pstmt.setInt(2, start);
		            pstmt.setInt(3, cnt);
		            rs = pstmt.executeQuery();
		            while(rs.next()) {
						UserBean ubean = new UserBean();
						ubean.setUser_id(rs.getString(1));
						ubean.setUser_pw(rs.getString(2));
						ubean.setUser_name(rs.getString(3));
						ubean.setUser_phone(rs.getString(4));
						ubean.setUser_email(rs.getString(5));
						ubean.setUser_point(rs.getInt(6));
						ubean.setUser_grade(rs.getInt(7));
						ulist.add(ubean);
					}
				}else {
					sql = "select * from user where " + keyField + " like ? order by user_name asc limit ?, ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keytext + "%");
		            pstmt.setInt(2, start);
		            pstmt.setInt(3, cnt);
		            rs = pstmt.executeQuery();
		            while(rs.next()) {
						UserBean ubean = new UserBean();
						ubean.setUser_id(rs.getString(1));
						ubean.setUser_pw(rs.getString(2));
						ubean.setUser_name(rs.getString(3));
						ubean.setUser_phone(rs.getString(4));
						ubean.setUser_email(rs.getString(5));
						ubean.setUser_point(rs.getInt(6));
						ubean.setUser_grade(rs.getInt(7));
						ulist.add(ubean);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ulist;
	}

	//단순 총 사용사 파악용
	public int getallcount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from user";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	//페이징 처리를 위한 user테이블의 갯tn
	public int getcountuser(String keyField, String keytext) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int count = 0;
	    try {
	        con = pool.getConnection();
	        if (keytext == null || keytext.trim().isEmpty()) {
	            sql = "SELECT COUNT(*) FROM user";
	            pstmt = con.prepareStatement(sql);
	        } else {
	            if ("USER_POINT".equals(keyField)) {
	                sql = "SELECT COUNT(*) FROM user WHERE " + keyField + " LIKE ?";
	                pstmt = con.prepareStatement(sql);
	                pstmt.setString(1, keytext);
	            } else {
	                sql = "SELECT COUNT(*) FROM user WHERE " + keyField + " LIKE ?";
	                pstmt = con.prepareStatement(sql);
	                pstmt.setString(1, "%" + keytext + "%");
	            }
	        }
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return count;
	}

	
	//관리자 user테이블 수정 - email, 전화번호, 등급
	public void updateuser(String[] user_ids, String[] user_emails, String[] user_phones, String[] user_grades) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user set user_phone = ?, user_email = ?, user_grade = ? where user_id = ?";
			pstmt = con.prepareStatement(sql);
			
			 for (int i = 0; i < user_ids.length; i++) {
	            pstmt.setString(1, user_phones[i]);
	            pstmt.setString(2, user_emails[i]);
	            pstmt.setString(3, user_grades[i]);
	            pstmt.setString(4, user_ids[i]);
	            pstmt.addBatch(); // 일괄 처리(batch processing)를 위해 배치에 추가
	        }
			
			pstmt.executeBatch(); // 배치 실행
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 사용자 삭제
	public void deleteUsers(String[] tuser_ids) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        // 각 사용자의 게시물을 먼저 삭제
	        sql = "DELETE FROM board WHERE board_user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        
	        sql = "DELETE FROM board_comment WHERE board_comment_user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        sql = "DELETE FROM board_likey WHERE BOARD_LIKEY_USER_ID = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        
	        sql = "DELETE FROM buylist WHERE buylist_buyer = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        
	        sql = "DELETE FROM paypost WHERE paypost_user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        
	        sql = "DELETE FROM paypost_comment WHERE paypost_comment_user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        
	        sql = "DELETE FROM paypost_likey WHERE paypost_likey_user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        sql = "DELETE FROM qna WHERE qna_user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        sql = "DELETE FROM qna_comment WHERE QNA_COMMENT_USER_ID = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        
	        sql = "DELETE FROM testhis WHERE TESTHIS_USER_ID = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	        // 그 후에 해당 사용자 삭제
	        sql = "DELETE FROM user WHERE user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        for (int i = 0; i < tuser_ids.length; i++) {
	            pstmt.setString(1, tuser_ids[i]);
	            pstmt.executeUpdate(); // 각각의 DELETE 문을 실행
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}

	// 유저 이름 가져오기 
		public String getName(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String name = "";
			try {
				con = pool.getConnection();
				sql = "SELECT USER_NAME FROM user WHERE USER_ID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while ( rs.next() ) {
					name = rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return name;
		}
		
		
		// 유저 등급 가져오기
		public int getGrade(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int grade = 0;
			try {
				con = pool.getConnection();
				sql = "SELECT USER_GRADE FROM user WHERE USER_ID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while ( rs.next() ) {
					grade = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return grade;
		}

}