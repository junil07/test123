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
	
	public Vector<QuestionBean> questionBeans(){
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
	         while(rs.next()) {
	            QuestionBean bean = new QuestionBean();
	            bean.setQuestion_num(rs.getInt("question_num"));
	            bean.setQuestion_test_num(rs.getString("question_test_num"));
	            bean.setQuestion_number(rs.getInt("question_number"));
	            bean.setQuestion_contnet(rs.getString("question_content"));
	            bean.setQuestion_correct(rs.getInt("question_correct"));
	            bean.setQuestion_file(rs.getString("question_file"));
	            bean.setQuestion_filesize(rs.getInt("question_filesize"));
	            bean.setQuestion_percent(rs.getDouble("question_percent"));
	            vlist.addElement(bean);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         pool.freeConnection(con, pstmt, rs);
	      }
	      return vlist;
	   }
	
	public static void main(String[] args) {
		/*
		QuestionMgr mgr = new QuestionMgr();
		Vector<QuestionBean> beanbaby;
		beanbaby = mgr.questionBeans();
		
		for ( int i = 0; i < beanbaby.size(); i++ ) {
			QuestionBean bean = beanbaby.get(i);
			System.out.println(bean.getQuestion_contnet());
			
		}
		*/
	}
	
}
