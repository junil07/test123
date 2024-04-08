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
	

	//페이징 처리를 위한 출력
	public Vector<BoardBean> allboardList(String keyField,String keyWord, int start, int cnt){
    Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
      if(keyWord.trim().equals("") || keyWord == null) {
				sql = "select * from board order by board_num DESC LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
	            pstmt.setInt(2, cnt);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					BoardBean bean = new BoardBean();
					bean.setBoard_num(rs.getInt(1));
					bean.setBoard_title(rs.getString(2));
					bean.setBoard_content(rs.getString(3));
					bean.setBoard_date(rs.getString(4));
					bean.setBoard_count(rs.getInt(5));
					bean.setBoard_user_id(rs.getString(6));
					vlist.addElement(bean);
				}
			}else {
				sql = "select b.board_num, b.board_title, b.board_content, b.board_date, b.board_count, b.board_user_id, u.user_id from board b join user u on b.board_user_id = u.user_id where" + keyField + " like ? order by board_num desc  limit?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
	            pstmt.setInt(2, start);
	            pstmt.setInt(3, cnt);
				rs = pstmt.executeQuery();
				while(rs.next()) {
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
		}} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
      
	public Vector<BoardBean> boardList(){
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
			while(rs.next()) {
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
			

	
	//글 갯수 파악
	public int getTotalCount(String keyField, String keyWord) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int totalCount = 0;
	    try {
	        con = pool.getConnection();
	        if(keyWord.trim().equals("") || keyWord == null) {
	            sql = "SELECT COUNT(*) FROM board";
	            pstmt = con.prepareStatement(sql);
	        } else {
	            sql = "select count(*) from board b join user u on b.board_user_id = u.user_id where" + keyField + "like ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, "%" + keyWord + "%");
	        }
	        rs = pstmt.executeQuery();
	        if(rs.next()) totalCount = rs.getInt(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return totalCount;
	}
	
	//userId로 이름찾기
	public String getUserName(String userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String userName = null;
        try {
            con = pool.getConnection();
            String sql = "SELECT user_name FROM user WHERE user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
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
	
	//listview에서 필요로한 모든 값 리턴
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
				if(rs.next()) {
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
		
		//user테이블에서 등급 출력
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
				if(rs.next()) {
					userGrade = rs.getInt("user_grade");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return userGrade;
		}

}
