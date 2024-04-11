package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import project.DBConnectionMgr;

public class BoardMgr {

	private DBConnectionMgr pool;

	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// 페이징 처리를 위한 출력
	public Vector<BoardBean> allboardList(String keyField, String keytext, int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			if (keytext.trim().equals("") || keytext == null) {
				sql = "select * from board order by board_num DESC LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					BoardBean bean = new BoardBean();
					bean.setBoard_num(rs.getInt(1));
					bean.setBoard_title(rs.getString(2));
					bean.setBoard_content(rs.getString(3));
					bean.setBoard_date(rs.getString(4));
					bean.setBoard_count(rs.getInt(5));
					bean.setBoard_user_id(rs.getString(6));
					vlist.addElement(bean);
				}
			} else {
				if("title".equals(keyField)) {
					sql="SELECT * FROM board b "
						+ "LEFT OUTER JOIN user u ON b.BOARD_USER_ID = u.USER_ID "
						+ "WHERE b.board_title like ? limit ?, ?";				
				}else if("name".equals(keyField)) {
					sql="SELECT * FROM board b "
						+ "LEFT OUTER JOIN user u ON b.BOARD_USER_ID = u.USER_ID "
						+ "WHERE u.USER_NAME LIKE ? limit ?, ?";
				}
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keytext + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					BoardBean bean = new BoardBean();
					bean.setBoard_num(rs.getInt("board_num"));
					bean.setBoard_title(rs.getString("board_title"));
					bean.setBoard_content(rs.getString("board_content"));
					bean.setBoard_date(rs.getString("board_date"));
					bean.setBoard_count(rs.getInt("board_count"));
					bean.setBoard_user_id(rs.getString("board_user_id"));
					bean.setUser_name(rs.getString("user_name"));
					vlist.addElement(bean);
				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 리스트 출력
	public Vector<BoardBean> boardList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			sql = "select * from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setBoard_num(rs.getInt(1));
				bean.setBoard_title(rs.getString(2));
				bean.setBoard_content(rs.getString(3));
				bean.setBoard_date(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 글 갯수 파악
	public int getTotalCount(String keyField, String keytext) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keytext.trim().equals("") || keytext == null) {
				sql = "SELECT COUNT(*) FROM board";
				pstmt = con.prepareStatement(sql);
			} else {
				if("title".equals(keyField)) {
					sql="SELECT count(*) FROM board WHERE board_title LIKE ?";
				}else if("name".equals(keyField)) {
					sql="SELECT count(*) FROM board b "
						+ "LEFT OUTER JOIN user u ON b.BOARD_USER_ID = u.USER_ID "
						+ "WHERE u.USER_NAME LIKE ?";
				}
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keytext + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next())
				totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// userId로 이름찾기
	public String getUserName(String comment_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userName = null;
		try {
			con = pool.getConnection();
			String sql = "SELECT user_name FROM user WHERE user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, comment_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userName = rs.getString("user_name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userName;
	}

	// listview에서 필요로한 모든 값 리턴
	public BoardBean getlist(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBean bean = new BoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from board where board_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setBoard_num(rs.getInt("board_num"));
				bean.setBoard_title(rs.getString("board_title"));
				bean.setBoard_content(rs.getString("board_content"));
				bean.setBoard_date(rs.getString("board_date"));
				bean.setBoard_count(rs.getInt("board_count"));
				bean.setBoard_user_id(rs.getString("board_user_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	// user테이블에서 등급 출력
	public int getGrade(String comment_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int grade = 0;
		try {
			con = pool.getConnection();
			sql = "select user_grade from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, comment_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				grade = rs.getInt("user_grade");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return grade;
	}

	// userid를 통한 비밀번호 불러오기
	public String getUserPw(String board_userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userPw = null;
		try {
			con = pool.getConnection();
			String sql = "select user_pw from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userPw = rs.getString("user_pw");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userPw;
	}

	// 관리자 게시글 수정
	public void updateboard(String inputTitle, String inputContent, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update board set BOARD_TITLE = ?, BOARD_CONTENT = ? where BOARD_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, inputTitle);
			pstmt.setString(2, inputContent);
			pstmt.setInt(3, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

	// 관리자 게시글 삭제--강사님한테 물어볼것
	public void deleteboard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql1 = "DELETE FROM board_likey WHERE LIKEY_BOARD_NUM = ?";
		String sql2 = "DELETE FROM board_fileupload WHERE FILEUPLOAD_BOARD_NUM = ?";
		String sql3 = "DELETE FROM board_comment WHERE COMMENT_BOARD_NUM = ?";
		String sql4 = "DELETE FROM board WHERE board_num = ?";
		try {
			con = pool.getConnection();

			// 첫 번째 SQL 문 수행
			pstmt = con.prepareStatement(sql1);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt.close();

			// 두 번째 SQL 문 수행
			pstmt = con.prepareStatement(sql2);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt.close();

			// 세 번째 SQL 문 수행
			pstmt = con.prepareStatement(sql3);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt.close();

			// 네 번째 SQL 문 수행
			pstmt = con.prepareStatement(sql4);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

}
