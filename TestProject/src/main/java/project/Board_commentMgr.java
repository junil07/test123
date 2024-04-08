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
	public Vector<Board_commentBean> getCommentList(int list_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Board_commentBean> comment = new Vector<Board_commentBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM FROM board_comment WHERE COMMENT_BOARD_NUM = ? ORDER BY BOARD_COMMENT_REPLY_POS DESC, BOARD_COMMENT_REPLY_REF ASC, BOARD_COMMENT_REPLY_DEPTH asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, list_num);
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
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return comment;
	}
}
