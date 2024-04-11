package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class QuestionMgr {
	private DBConnectionMgr pool;

	public QuestionMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// 문제 리스트
	public Vector<QuestionBean> questionBeans() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<QuestionBean> vlist = new Vector<QuestionBean>();
		try {
			con = pool.getConnection();
			sql = "select * from question";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				QuestionBean bean = new QuestionBean();
				bean.setQuestion_num(rs.getInt("question_num"));
				bean.setQuestion_test_num(rs.getString("question_test_num"));
				bean.setQuestion_number(rs.getInt("question_number"));
				bean.setQuestion_content(rs.getString("question_content"));
				bean.setQuestion_correct(rs.getInt("question_correct"));
				bean.setQuestion_file(rs.getString("question_file"));
				bean.setQuestion_filesize(rs.getInt("question_filesize"));
				bean.setQuestion_percent(rs.getDouble("question_percent"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 문제 update
	public boolean updateQuestion(QuestionBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update Question set QUESTION_NUMBER =?, QUESTION_CORRECT=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getQuestion_number());
			pstmt.setString(2, bean.getQuestion_content());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 문제 insert
	public boolean insertQuestion(QuestionBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert question(Question_test_num, question_number, question_content, question_correct, question_file, question_filesize, question_percent) "
					+ "values (?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getQuestion_test_num());
			pstmt.setInt(2, bean.getQuestion_number());
			pstmt.setString(3, bean.getQuestion_content());
			pstmt.setInt(4, bean.getQuestion_correct());
			pstmt.setString(5, bean.getQuestion_file());
			pstmt.setInt(6, bean.getQuestion_filesize());
			pstmt.setDouble(7, bean.getQuestion_percent());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 문제 삭제
	public void deleteQuestion(int question_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from question where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, question_num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

	public int maxPk() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0;
		try {
			con = pool.getConnection();
			sql = "select max(question_num) from question";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return num;
	}

	public Vector<QuestionBean> testQuestion(String testNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<QuestionBean> vlist = new Vector<QuestionBean>();
		try {
			con = pool.getConnection();
			sql = "select * from question where question_test_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, testNum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				QuestionBean questBean = new QuestionBean();
				questBean.setQuestion_num(rs.getInt(1));
				questBean.setQuestion_test_num(rs.getString(2));
				questBean.setQuestion_number(rs.getInt(3));
				questBean.setQuestion_content(rs.getString(4));
				questBean.setQuestion_correct(rs.getInt(5));
				questBean.setQuestion_file(rs.getString(6));
				questBean.setQuestion_filesize(rs.getInt(7));
				questBean.setQuestion_percent(rs.getDouble(8));
				vlist.addElement(questBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<QuestionBean> QuestionCorrect(String testNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<QuestionBean> vlist = new Vector<QuestionBean>();
		try {
			con = pool.getConnection();
			sql = "select question_correct from question where question_test_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, testNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				QuestionBean questBean = new QuestionBean();
				questBean.setQuestion_correct(rs.getInt(1));
				vlist.addElement(questBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 문제 모든 값 리턴
	public QuestionBean getQInfo(String tnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		QuestionBean qbean = new QuestionBean();
		try {
		   con = pool.getConnection();
		   sql = "select * from question where QUESTION_TEST_NUM = ?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, tnum);
		   rs = pstmt.executeQuery();
		   if (rs.next()) {
			  qbean.setQuestion_num(rs.getInt("question_num"));
			  qbean.setQuestion_test_num(rs.getString("question_test_num"));
			  qbean.setQuestion_number(rs.getInt("question_number"));
			  qbean.setQuestion_content(rs.getString("question_content"));
			  ;
			  qbean.setQuestion_correct(rs.getInt("question_correct"));
			  qbean.setQuestion_file(rs.getString("question_file"));
			  qbean.setQuestion_filesize(rs.getInt("question_filesize"));
			  qbean.setQuestion_percent(rs.getFloat("question_percent"));
		   }
		} catch (Exception e) {
		   e.printStackTrace();
		} finally {
		   pool.freeConnection(con, pstmt, rs);
		}
		return qbean;
	 }
  
	 public Vector<QuestionBean> allQlist(String tnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<QuestionBean> elist = new Vector<QuestionBean>();
		try {
		   con = pool.getConnection();
		   sql = "select * from question where QUESTION_TEST_NUM = ?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, tnum);
		   rs = pstmt.executeQuery();
		   while (rs.next()) {
			  QuestionBean qbean = new QuestionBean();
			  qbean.setQuestion_num(rs.getInt("question_num"));
			  qbean.setQuestion_test_num(rs.getString("question_test_num"));
			  qbean.setQuestion_number(rs.getInt("question_number"));
			  qbean.setQuestion_content(rs.getString("question_content"));
			  qbean.setQuestion_correct(rs.getInt("question_correct"));
			  qbean.setQuestion_file(rs.getString("question_file"));
			  qbean.setQuestion_filesize(rs.getInt("question_filesize"));
			  qbean.setQuestion_percent(rs.getFloat("question_percent"));
			  elist.addElement(qbean);
		   }
		} catch (Exception e) {
		   e.printStackTrace();
		} finally {
		   pool.freeConnection(con, pstmt, rs);
		}
		return elist;
	 }
}
