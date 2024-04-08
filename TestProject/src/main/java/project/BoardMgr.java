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
	public Vector<BoardBean> allboardList(String keyField, String keyWord, int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			if (keyWord.trim().equals("") || keyWord == null) {
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
				sql = "select b.board_num, b.board_title, b.board_content, b.board_date, b.board_count, b.board_user_id, u.user_id from board b join user u on b.board_user_id = u.user_id where "
						+ keyField + " like ? order by board_num desc  limit /?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					BoardBean bean = new BoardBean();
					UserBean ubean = new UserBean();
					bean.setBoard_num(rs.getInt(1));
					bean.setBoard_title(rs.getString(2));
					bean.setBoard_content(rs.getString(3));
					bean.setBoard_date(rs.getString(4));
					bean.setBoard_count(rs.getInt(5));
					bean.setBoard_user_id(rs.getString(6));
					ubean.setUser_name(rs.getString(6));
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
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.trim().equals("") || keyWord == null) {
				sql = "SELECT COUNT(*) FROM board";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "select count(*) from board b join user u on b.board_user_id = u.user_id where " + keyField
						+ " LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
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
	public String getUserName(String board_userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userName = null;
		try {
			con = pool.getConnection();
			String sql = "SELECT user_name FROM user WHERE user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_userid);
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
	public int getUserGrade(String board_userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int userGrade = 0;
		try {
			con = pool.getConnection();
			String sql = "select user_grade from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userGrade = rs.getInt("user_grade");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userGrade;
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
