package project;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;


public class PaypostCommentMgr {

	public PaypostCommentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//게시글 별 총 댓글수 카운트
	public int getCountComment(int list_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int countComment = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from paypost_comment where comment_paypost_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, list_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				countComment = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return countComment;	
	}
	
	//게시글 별 데이터 전체 불러오기
	public Vector<PaypostCommentBean> getCommentList(int list_num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PaypostCommentBean> Pcomment = new Vector<PaypostCommentBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT PAYPOST_COMMENT_CONTENT, PAYPOST_COMMENT_REPLY_POS, PAYPOST_COMMENT_REPLY_REF, PAYPOST_COMMENT_REPLY_DEPTH, PAYPOST_COMMENT_USER_ID,PAYPOST_COMMENT_DATE FROM paypost_comment WHERE COMMENT_PAYPOST_NUM = ? ORDER BY PAYPOST_COMMENT_REPLY_POS DESC, PAYPOST_COMMENT_REPLY_REF ASC, PAYPOST_COMMENT_REPLY_DEPTH ASC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, list_num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PaypostCommentBean cbean = new PaypostCommentBean();
				cbean.setPaypost_comment_content(rs.getString(1));
				cbean.setPaypost_comment_reply_pos(rs.getInt(2));
				cbean.setPaypost_comment_reply_ref(rs.getInt(3));
				cbean.setPaypost_comment_reply_depth(rs.getInt(4));
				cbean.setPaypost_comment_user_id(rs.getString(5));
				cbean.setPaypost_comment_date(rs.getString(6));
				Pcomment.addElement(cbean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return Pcomment;
	}
	
	//댓글 유저 이름
	public String getCuserName(String Cuser_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String Cname = null;
		try {
			con = pool.getConnection();
			sql = "select user_name from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Cuser_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Cname = rs.getString("user_name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return Cname;
	}
	
	////댓글 등급 이름
	public int getCuserGrade(String Cuser_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int Cgrade = 0;
		try {
			con = pool.getConnection();
			sql = "select user_grade from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Cuser_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Cgrade = rs.getInt("user_grade");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return Cgrade;
	}
	
	//댓글 저장
	public void insertComment(PaypostCommentBean Pbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			int maxPos = getMaxPos(Pbean.getComment_paypost_num());
			PaypostCommentBean pbean = new PaypostCommentBean();
			//댓글 작성(pos값 증가)
			sql = "INSERT INTO paypost_comment (COMMENT_PAYPOST_NUM, PAYPOST_COMMENT_CONTENT, PAYPOST_COMMENT_REPLY_POS, PAYPOST_COMMENT_REPLY_REF, PAYPOST_COMMENT_REPLY_DEPTH, PAYPOST_COMMENT_USER_ID, PAYPOST_COMMENT_DATE) "
					+ "VALUES (?, ?, ?, ?, ?, ?, NOW())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Pbean.getComment_paypost_num());
			pstmt.setString(2, Pbean.getPaypost_comment_content());
			pstmt.setInt(3, maxPos + 1);
			pstmt.setInt(4, Pbean.getPaypost_comment_reply_ref());
			pstmt.setInt(5, Pbean.getPaypost_comment_reply_depth());
			pstmt.setString(6, Pbean.getPaypost_comment_user_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//대댓글
	public void underComment(String Cpos, String Cref, String Cdepth, String under_comment, String userId, int cnum, PaypostCommentBean Pbean) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        
	        // PaypostCommentBean 객체의 값 설정
	        
	        
	        int maxPos = getMaxPos(Pbean.getComment_paypost_num());
	        int maxRef = getMaxRef(cnum, Cpos);
	        int maxDepth = getMaxdepth(Pbean.getComment_paypost_num());

	        int pos = Integer.parseInt(Cpos);
	        int ref = Integer.parseInt(Cref);
	        int depth = Integer.parseInt(Cdepth);
	        int Cnum = cnum;
	        String Ccomment =  under_comment;
	        String CuserId = userId;
	        
	        if (ref == 0 && depth == 0) {
	            sql = "INSERT INTO paypost_comment (COMMENT_PAYPOST_NUM, PAYPOST_COMMENT_CONTENT, PAYPOST_COMMENT_REPLY_POS, PAYPOST_COMMENT_REPLY_REF, PAYPOST_COMMENT_REPLY_DEPTH, PAYPOST_COMMENT_USER_ID, PAYPOST_COMMENT_DATE) "
	                + "VALUES (?, ?, ?, ?, ?, ?, NOW())";
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
	            sql = "INSERT INTO paypost_comment (COMMENT_PAYPOST_NUM, PAYPOST_COMMENT_CONTENT, PAYPOST_COMMENT_REPLY_POS, PAYPOST_COMMENT_REPLY_REF, PAYPOST_COMMENT_REPLY_DEPTH, PAYPOST_COMMENT_USER_ID, PAYPOST_COMMENT_DATE) "
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


	
	//각 게시글에서 pos중 제일 큰 숫자 출력
	public int getMaxPos(int list_num) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int MaxPos = 0;
	    try {
	        con = pool.getConnection();
	        sql = "SELECT MAX(paypost_comment_reply_pos) FROM paypost_comment WHERE comment_paypost_num = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, list_num);
	        rs = pstmt.executeQuery();
	        if(rs.next()) {
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
			sql = "SELECT MAX(paypost_comment_reply_ref) FROM paypost_comment WHERE comment_paypost_num = ? and PAYPOST_COMMENT_REPLY_POS = ?";
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
			sql = "SELECT MAX(paypost_comment_reply_depth) FROM paypost_comment WHERE comment_paypost_num = ?";
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

	// 대댓글 위치 수정
	public void replyUp(int ref, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update paypost_comment set getPaypost_comment_reply_pos = getPaypost_comment_reply_pos + 1 where getPaypost_comment_reply_ref = ? and getPaypost_comment_reply_pos > 0";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, pos);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
//	//댓글삭제 버젼
//	public void deleteComment(String Dpos, String Dref, String Ddepth) {
//	    Connection con = null;
//	    PreparedStatement pstmt = null;
//	    String sql = null;
//	    int pos = Integer.parseInt(Dpos);
//	    int ref = Integer.parseInt(Dref);
//	    int depth = Integer.parseInt(Ddepth);
//	    try {
//	        con = pool.getConnection();
//	        if(ref == 0 && depth == 0) {
//	            sql = "DELETE FROM paypost_comment WHERE paypost_comment_reply_pos = ?";
//	            pstmt = con.prepareStatement(sql);
//	            pstmt.setInt(1, pos);
//	        } else if(depth == 1 && ref >= 1) {
//	            sql = "DELETE FROM paypost_comment WHERE paypost_comment_reply_pos = ? AND paypost_comment_reply_ref = ?";
//	            pstmt = con.prepareStatement(sql);
//	            pstmt.setInt(1, pos);
//	            pstmt.setInt(2, ref);
//	        } else if(depth >= 2) {
//	            sql = "DELETE FROM paypost_comment WHERE paypost_comment_reply_pos = ? AND paypost_comment_reply_ref = ? AND paypost_comment_reply_depth >= ?";
//	            pstmt = con.prepareStatement(sql);
//	            pstmt.setInt(1, pos);
//	            pstmt.setInt(2, ref);
//	            pstmt.setInt(3, depth);
//	        }
//	        // 실행
//	        pstmt.executeUpdate();
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    } finally {
//	        pool.freeConnection(con, pstmt);
//	    }
//	    return;
//	}
	
	//댓글 내용 = "삭제된 내용입니다." 변경 버젼
	public void deleteComment(String Dpos, String Dref, String Ddepth) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    int pos = Integer.parseInt(Dpos);
	    int ref = Integer.parseInt(Dref);
	    int depth = Integer.parseInt(Ddepth);
	    try {
	        con = pool.getConnection();
	        sql = "UPDATE paypost_comment SET PAYPOST_COMMENT_CONTENT = '삭제된 내용입니다.'  WHERE paypost_comment_reply_pos = ? AND paypost_comment_reply_ref = ? AND paypost_comment_reply_depth = ?";
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

	
	
	// 부모 댓글 개수 세기
	public int getOriginCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(DISTINCT PAYPOST_COMMENT_REPLY_POS) FROM PAYPOST_COMMENT WHERE COMMENT_PAYPOST_NUM = ?";
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
	
	// 댓글 불러오기
	public Vector<PaypostCommentBean> getComment(int num, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PaypostCommentBean> vlist = new Vector<PaypostCommentBean>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM paypost_comment WHERE COMMENT_PAYPOST_NUM = ? AND PAYPOST_COMMENT_REPLY_POS = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, pos);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				PaypostCommentBean bean = new PaypostCommentBean();
				bean.setPaypost_comment_content(rs.getString("PAYPOST_COMMENT_CONTENT"));
				bean.setPaypost_comment_reply_pos(rs.getInt("PAYPOST_COMMENT_REPLY_POS"));
				bean.setPaypost_comment_reply_ref(rs.getInt("PAYPOST_COMMENT_REPLY_REF"));
				bean.setPaypost_comment_reply_depth(rs.getInt("PAYPOST_COMMENT_REPLY_DEPTH"));
				bean.setPaypost_comment_user_id(rs.getString("PAYPOST_COMMENT_USER_ID"));
				bean.setPaypost_comment_date(rs.getString("PAYPOST_COMMENT_DATE"));
				bean.setPaypost_comment_manager_id(rs.getString("PAYPOST_COMMENT_MANAGER_ID"));
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
