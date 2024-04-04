package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class NoticeMgr {
	private DBConnectionMgr pool;
	
	public NoticeMgr() {
		pool = DBConnectionMgr.getInstance();
		System.out.println("성공완");
	}
	
	public Vector<NoticeBean> noticeList() {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      Vector<NoticeBean> vlist = new Vector<NoticeBean>();
	      try {
	         con = pool.getConnection();
	         sql = "select * from notice";
	         pstmt = con.prepareStatement(sql);
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	            NoticeBean bean = new NoticeBean();
	            bean.setNotice_num(rs.getInt(1));
	            bean.setNotice_title(rs.getString(2));
	            bean.setNotice_content(rs.getString(3));
	            bean.setNotice_date(rs.getString(4));
	            bean.setNotice_count(rs.getInt(5));
	            vlist.addElement(bean);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt, rs);
	      }
	   
	      return vlist;
	   }
		
	
	public static void main(String[] args) {
		/*
		NoticeMgr mgr = new NoticeMgr();
		Vector<NoticeBean> beanbaby;
		beanbaby = mgr.noticeList();
		
		for ( int i = 0; i < beanbaby.size(); i++ ) {
			NoticeBean bean = beanbaby.get(i);
			System.out.println(bean.getNotice_content());
			
		}
		
		NoticeBean baby = beanbaby.get(1); 
		mgr.noticeList();
		*/
	}
}
