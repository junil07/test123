package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class Board_commentMgr {
	DBConnectionMgr pool;

	public Board_commentMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// 게시글 별 총 댓글수 카운트
	public int getCountComment(int board_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int countComment = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from board_comment where COMMENT_BOARD_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				countComment = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return countComment;
	}
	
	// 게시글 별 데이터 전체 불러오기
	public Vector<Board_commentBean> getCommentList(int board_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Board_commentBean> comment = new Vector<Board_commentBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM board_comment WHERE COMMENT_BOARD_NUM = ? ORDER BY BOARD_COMMENT_REPLY_POS DESC, BOARD_COMMENT_REPLY_REF ASC, BOARD_COMMENT_REPLY_DEPTH asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Board_commentBean cbean = new Board_commentBean();
				cbean.setBoard_comment_num(rs.getInt(1));
				cbean.setComment_board_num(rs.getInt(2));
				cbean.setBoard_comment_content(rs.getString(3));
				cbean.setBoard_comment_reply_pos(rs.getInt(4));
				cbean.setBoard_comment_reply_ref(rs.getInt(5));
				cbean.setBoard_comment_reply_depth(rs.getInt(6));
				cbean.setBoard_comment_user_id(rs.getString(7));
				cbean.setBoard_comment_date(rs.getString(8));
				comment.addElement(cbean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return comment;
	}
	
	// 대댓글
	public void underComment(String Cpos, String Cref, String Cdepth, String under_comment, String userId, int cnum,
			Board_commentBean cbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			int maxPos = getMaxPos(cbean.getComment_board_num());
			int maxRef = getMaxRef(cnum, Cpos);
			int maxDepth = getMaxdepth(cbean.getComment_board_num());

			int pos = Integer.parseInt(Cpos);
			int ref = Integer.parseInt(Cref);
			int depth = Integer.parseInt(Cdepth);
			int Cnum = cnum;
			String Ccomment = under_comment;
			String CuserId = userId;

			if (ref == 0 && depth == 0) {
				sql = "INSERT INTO board_comment (COMMENT_BOARD_NUM, BOARD_COMMENT_CONTENT, BOARD_COMMENT_REPLY_POS, BOARD_COMMENT_REPLY_REF, BOARD_COMMENT_REPLY_DEPTH, BOARD_COMMENT_USER_ID, BOARD_COMMENT_DATE) VALUES (?, ?, ?, ?, ?, ?, NOW());";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Cnum);
				pstmt.setString(2, Ccomment);
				pstmt.setInt(3, pos);
				pstmt.setInt(4, maxRef + 1);
				pstmt.setInt(5, 1);
				pstmt.setString(6, CuserId);
				// executeUpdate()로 실행
				pstmt.executeUpdate();
			} else if (depth != 0) {
				sql = "INSERT INTO board_comment (COMMENT_BOARD_NUM, BOARD_COMMENT_CONTENT, BOARD_COMMENT_REPLY_POS, BOARD_COMMENT_REPLY_REF, BOARD_COMMENT_REPLY_DEPTH, BOARD_COMMENT_USER_ID, BOARD_COMMENT_DATE) "
						+ "VALUES (?, ?, ?, ?, ?, ?, NOW())";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				pstmt.setString(2, Ccomment);
				pstmt.setInt(3, pos);
				pstmt.setInt(4, ref);
				pstmt.setInt(5, depth + 1);
				pstmt.setString(6, CuserId);
				// executeUpdate()로 실행
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// ResultSet은 사용되지 않으므로 닫을 필요가 없음
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 각 게시글에서 pos중 제일 큰 숫자 출력
	public int getMaxPos(int board_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int MaxPos = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT MAX(BOARD_COMMENT_REPLY_POS) FROM board_comment WHERE COMMENT_BOARD_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				MaxPos = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return MaxPos;
	}

	// 각 게시글에서 ref중 제일 큰 숫자 출력
	public int getMaxRef(int cnum, String Cpos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int MaxRef = 0;
		int pos = Integer.parseInt(Cpos);
		try {
			con = pool.getConnection();
			sql = "SELECT MAX(BOARD_COMMENT_REPLY_REF) FROM board_comment WHERE COMMENT_BOARD_NUM = ? and BOARD_COMMENT_REPLY_POS = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			pstmt.setInt(2, pos);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				MaxRef = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return MaxRef;
	}
	
	// 각 게시글에서 depth중 제일 큰 숫자 출력
	public int getMaxdepth(int list_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int Maxdepth = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT MAX(BOARD_COMMENT_REPLY_DEPTH) FROM board_comment WHERE COMMENT_BOARD_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, list_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Maxdepth = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return Maxdepth;
	}
	
	// 댓글 내용 = "삭제된 내용입니다." 변경 버젼
	public void deleteComment(String Dpos, String Dref, String Ddepth) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int pos = Integer.parseInt(Dpos);
		int ref = Integer.parseInt(Dref);
		int depth = Integer.parseInt(Ddepth);
		try {
			con = pool.getConnection();
			sql = "UPDATE board_comment SET BOARD_COMMENT_CONTENT = '삭제된 내용입니다.'  WHERE BOARD_COMMENT_REPLY_POS = ? AND BOARD_COMMENT_REPLY_REF = ? AND BOARD_COMMENT_REPLY_DEPTH = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pos);
			pstmt.setInt(2, ref);
			pstmt.setInt(3, depth);
			// 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	// 댓글 저장
	public void insertComment(Board_commentBean cbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			int maxPos = getMaxPos(cbean.getComment_board_num());
			PaypostCommentBean pbean = new PaypostCommentBean();
			// 댓글 작성(pos값 증가)
			sql = "INSERT INTO board_comment (COMMENT_BOARD_NUM, BOARD_COMMENT_CONTENT, BOARD_COMMENT_REPLY_POS, BOARD_COMMENT_REPLY_REF, BOARD_COMMENT_REPLY_DEPTH, BOARD_COMMENT_USER_ID, BOARD_COMMENT_DATE) "
					+ "VALUES (?, ?, ?, ?, ?, ?, NOW())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cbean.getComment_board_num());
			pstmt.setString(2, cbean.getBoard_comment_content());
			pstmt.setInt(3, maxPos + 1);
			pstmt.setInt(4, cbean.getBoard_comment_reply_ref());
			pstmt.setInt(5, cbean.getBoard_comment_reply_depth());
			pstmt.setString(6, cbean.getBoard_comment_user_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
