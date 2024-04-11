package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class WrongMgr {
    
    private DBConnectionMgr pool;
    
    public WrongMgr() {
        pool = DBConnectionMgr.getInstance();
    }
    
    public void wrongInsert(String userId,String title,String testYear,String testSec,String questionNum) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert wrong(wrong_user_id, wrong_test_title,wrong_test_year,wrong_test_sec,wrong_ins_time,wrong_question_num) "
					+"values(?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,userId);
			pstmt.setString(2,title);
			pstmt.setString(3,testYear);
			pstmt.setString(4,testSec);
			pstmt.setString(5,questionNum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
    }
    
    public boolean wrongDupli(String userId,String title,String testYear,String testSec,String questionNum) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from wrong where wrong_user_id=? and wrong_test_title=? and wrong_test_year=? and wrong_test_sec=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,userId);
			pstmt.setString(2,title);
			pstmt.setString(3,testYear);
			pstmt.setString(4,testSec);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
    }
    public String updateQuestionNum(String userId,String title,String testYear,String testSec) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String dbQuestion_num="";
		try {
			con = pool.getConnection();
			sql = "select wrong_question_num from wrong where wrong_user_id=? and wrong_test_title=? and wrong_test_year=? and wrong_test_sec=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,userId);
			pstmt.setString(2,title);
			pstmt.setString(3,testYear);
			pstmt.setString(4,testSec);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbQuestion_num = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return dbQuestion_num;
    }
    
    public void updateQuestion(String question_num,String userId,String title,String testYear,String testSec) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update wrong set wrong_question_num=? where wrong_user_id=? and wrong_test_title=? and wrong_test_year=? and wrong_test_sec=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,question_num);
			pstmt.setString(2,userId);
			pstmt.setString(3,title);
			pstmt.setString(4,testYear);
			pstmt.setString(5,testSec);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
    }
    
    public int getTotalCount(String keyField,String keyWord) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if ( keyWord.trim().equals("") || keyWord == null ) {
				sql = "SELECT COUNT(*) FROM wrong";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "SELECT COUNT(*) FROM wrong "
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
    
    public Vector<WrongBean> getWrongList(String keyField, String keyWord, int start, int cnt ,String userId){
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<WrongBean> vlist = new Vector<WrongBean>();
		try {
			con = pool.getConnection();
			
			if ( keyWord.trim().equals("") || keyWord == null ) {
				sql = "SELECT * FROM wrong where wrong_user_id=? ORDER BY wrong_num DESC LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, userId);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			} else {
				sql = "SELECT * FROM wrong WHERE " + keyField + " LIKE ? and wrong_user_id=? ORDER BY wrong_num DESC LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setString(2, userId);
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			}
			
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				WrongBean bean = new WrongBean();
				bean.setWrong_num(rs.getInt("wrong_num"));
				bean.setWrong_test_title(rs.getString("wrong_test_title"));
				bean.setWrong_test_year(rs.getString("wrong_test_year"));
				bean.setWrong_test_sec(rs.getString("wrong_test_sec"));
				bean.setWrong_ins_time(rs.getString("wrong_ins_time"));
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
