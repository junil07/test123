package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class QnaMgr {
	
	private DBConnectionMgr pool;
	
	public QnaMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// QnA 게시판 목록 불러오기
	public Vector<QnaBean> getQnaList(String keyField, String keyWord, int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<QnaBean> vlist = new Vector<QnaBean>();
		try {
			con = pool.getConnection();
			
			if ( keyWord.trim().equals("") || keyWord == null ) {
				sql = "SELECT * FROM qna ORDER BY QNA_NUM DESC LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			} else {
				sql = "SELECT * FROM qna WHERE " + keyField + " LIKE ? ORDER BY QNA_NUM DESC LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				QnaBean bean = new QnaBean();
				bean.setQna_num(rs.getInt("QNA_NUM"));
				bean.setQna_title(rs.getString("QNA_TITLE"));
				bean.setQna_content(rs.getString("QNA_CONTENT"));
				bean.setQna_date(rs.getString("QNA_DATE"));
				bean.setQna_user_id(rs.getString("QNA_USER_ID"));
				vlist.addElement(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// QnA 총 게시물 수
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		
		try {
			con = pool.getConnection();
			if ( keyWord.trim().equals("") || keyWord == null ) {
				sql = "SELECT COUNT(*) FROM qna";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "SELECT COUNT(*) FROM qna "
						+ "WHERE " + keyField + " LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			
			rs = pstmt.executeQuery();
			if ( rs.next() ) totalCount = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// QnA 게시판 제목 불러오기
	public String getTitle(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String title = "";
		
		try {
			con = pool.getConnection();
			sql = "SELECT QNA_TITLE FROM qna WHERE QNA_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				title = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return title;
	}
	
	// QnA 게시판 내용 불러오기
	public String getContent(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String content = "";
		
		try {
			con = pool.getConnection();
			sql = "SELECT QNA_CONTENT FROM qna WHERE QNA_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				content = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return content;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
