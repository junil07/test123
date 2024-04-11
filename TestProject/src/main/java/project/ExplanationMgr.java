package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ExplanationMgr {
	
	private DBConnectionMgr pool;
	
	public ExplanationMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<ExplanationBean> explanationlist(int question_num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ExplanationBean> vlist = new Vector<ExplanationBean>();
		try {
			con = pool.getConnection();
			sql = "select * from explanation where explanation_question_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, question_num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ExplanationBean bean = new ExplanationBean();
				bean.setExplanation_num(rs.getInt(1));
				bean.setExplanation_test_num(rs.getString(2));
				bean.setExplanation_question_num(rs.getInt(3));
				bean.setExplanation_content(rs.getString(4));
				bean.setExplanation_file(rs.getString(5));
				bean.setExplanation_filesize(rs.getInt(6));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<ExplanationBean> getExInfo(int tnum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ExplanationBean> exlist = new Vector<ExplanationBean>();
		try {
			con = pool.getConnection();
			sql = "select * from explanation where EXPLANATION_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ExplanationBean ebean = new ExplanationBean();
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return exlist;
	}
	
	public Vector<ExplanationBean> allexinfo(int question_number){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ExplanationBean> exlist = new Vector<ExplanationBean>();
		try {
			con = pool.getConnection();
			sql = "select * from explanation where EXPLANATION_QUESTION_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, question_number);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ExplanationBean exbean = new ExplanationBean();
				exbean.setExplanation_num(rs.getInt("Explanation_num"));
				exbean.setExplanation_question_num(rs.getInt("EXPLANATION_QUESTION_NUM"));
				exbean.setExplanation_content(rs.getString("EXPLANATION_CONTENT"));
				exbean.setExplanation_file(rs.getString("EXPLANATION_FILE"));
				exbean.setExplanation_filesize(rs.getInt("EXPLANATION_FILESIZE"));
				exlist.addElement(exbean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return exlist;
	}
}
