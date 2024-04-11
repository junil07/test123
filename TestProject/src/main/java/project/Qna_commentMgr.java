package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class Qna_commentMgr {
	
	private DBConnectionMgr pool;
	
	public Qna_commentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 댓글 불러오기
	public Vector<Qna_commentBean> getComment(int num, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Qna_commentBean> vlist = new Vector<Qna_commentBean>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM qna_comment WHERE COMMENT_QNA_NUM = ? AND QNA_COMMENT_REPLY_POS = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, pos);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				Qna_commentBean bean = new Qna_commentBean();
				bean.setQna_comment_content(rs.getString("QNA_COMMENT_CONTENT"));
				bean.setQna_comment_reply_pos(rs.getInt("QNA_COMMENT_REPLY_POS"));
				bean.setQna_comment_reply_ref(rs.getInt("QNA_COMMENT_REPLY_REF"));
				bean.setQna_comment_reply_depth(rs.getInt("QNA_COMMENT_REPLY_DEPTH"));
				bean.setQna_comment_user_id(rs.getString("QNA_COMMENT_USER_ID"));
				bean.setQna_comment_date(rs.getString("QNA_COMMENT_DATE"));
				bean.setQna_comment_manager_id(rs.getString("QNA_COMMENT_MANAGER_ID"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 댓글 개수 세기
	public int getCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM qna_comment WHERE COMMENT_QNA_NUM = ? AND QNA_COMMENT_REPLY_DEPTH = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	// 부모 댓글 개수 세기
	public int getOriginCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(DISTINCT QNA_COMMENT_REPLY_POS) FROM qna_comment WHERE COMMENT_QNA_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	// 댓글 출력 (이중 for문용)
	public int getrereCount(int num, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM qna_comment WHERE COMMENT_QNA_NUM = ? AND QNA_COMMENT_REPLY_POS = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, pos);
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	// 댓글 쓰기
	public boolean commentInsert(int check, int num, String content, int pos, int ref, String user) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			if ( check == 0 ) { // 그냥 댓글
				con = pool.getConnection();
				sql = "INSERT INTO qna_comment (COMMENT_QNA_NUM, QNA_COMMENT_CONTENT, QNA_COMMENT_REPLY_POS,"
						+ "QNA_COMMENT_REPLY_REF, QNA_COMMENT_REPLY_DEPTH, QNA_COMMENT_USER_ID, QNA_COMMENT_DATE) "
						+ "VALUES (?, ?, ?, 0, 1, ?, now())";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, content);
				pstmt.setInt(3, pos);
				pstmt.setString(4, user);
				if ( pstmt.executeUpdate() > 0 ) flag = true;
			} else if ( check == 1 ) { // 대댓글
				con = pool.getConnection();
				sql = "INSERT INTO qna_comment (COMMENT_QNA_NUM, QNA_COMMENT_CONTENT, QNA_COMMENT_REPLY_POS,"
						+ "QNA_COMMENT_REPLY_REF, QNA_COMMENT_REPLY_DEPTH, QNA_COMMENT_USER_ID, QNA_COMMENT_DATE) "
						+ "VALUES (?, ?, ?, ?, 1, ?, now())";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, content);
				pstmt.setInt(3, pos);
				pstmt.setInt(4, ref);
				pstmt.setString(5, user);
				if ( pstmt.executeUpdate() > 0 ) flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 관리자 댓글 쓰기
	public boolean managercommentInsert(int check, int num, String content, int pos, int ref, String manager) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			if ( check == 0 ) { // 그냥 댓글
				con = pool.getConnection();
				sql = "INSERT INTO qna_comment (COMMENT_QNA_NUM, QNA_COMMENT_CONTENT, QNA_COMMENT_REPLY_POS,"
						+ "QNA_COMMENT_REPLY_REF, QNA_COMMENT_REPLY_DEPTH, QNA_COMMENT_DATE, QNA_COMMENT_MANAGER_ID) "
						+ "VALUES (?, ?, ?, 0, 1, now(), ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, content);
				pstmt.setInt(3, pos);
				pstmt.setString(4, manager);
				if ( pstmt.executeUpdate() > 0 ) flag = true;
			} else if ( check == 1 ) { // 대댓글
				con = pool.getConnection();
				sql = "INSERT INTO qna_comment (COMMENT_QNA_NUM, QNA_COMMENT_CONTENT, QNA_COMMENT_REPLY_POS,"
						+ "QNA_COMMENT_REPLY_REF, QNA_COMMENT_REPLY_DEPTH, QNA_COMMENT_DATE, QNA_COMMENT_MANAGER_ID) "
						+ "VALUES (?, ?, ?, ?, 1, now(), ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, content);
				pstmt.setInt(3, pos);
				pstmt.setInt(4, ref);
				pstmt.setString(5, manager);
				if ( pstmt.executeUpdate() > 0 ) flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	

	// pos에 맞는 댓글 개수 세기 (대댓글 입력용)
	public int getRereply(int num, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(QNA_COMMENT_REPLY_REF) FROM qna_comment WHERE COMMENT_QNA_NUM = ? AND QNA_COMMENT_REPLY_POS = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, pos);
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	// 댓글 삭제 depth 0 이면 삭제된거 1이면 삭제안된거
	public boolean deleteReply(int num, int pos, int ref) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE qna_comment SET QNA_COMMENT_REPLY_DEPTH = 0 WHERE COMMENT_QNA_NUM = ? AND QNA_COMMENT_REPLY_POS = ? AND QNA_COMMENT_REPLY_REF = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, pos);
			pstmt.setInt(3, ref);
			if ( pstmt.executeUpdate() > 0 ) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	// qna글 지우기 전에 fk값으로 된 녀석 다 지우는 용도
	public boolean qnareplyDelete(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "DELETE FROM qna_comment WHERE COMMENT_QNA_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			if ( pstmt.executeUpdate() > 0 ) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
}
