package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ScheduleMgr {
	
	private DBConnectionMgr pool;
	
	public ScheduleMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 시험 일정 제목 가져오기 
	public Vector<ScheduleBean> getTitleName() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ScheduleBean> vlist = new Vector<ScheduleBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM schedule";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				ScheduleBean bean = new ScheduleBean();
				bean.setSchedule_name(rs.getString(2));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 시험 일정 제목 수정하기
	public boolean editTitleName(String titlename, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE schedule SET SCHEDULE_NAME = ? WHERE SCHEDULE_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, titlename);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
			if ( pstmt.executeUpdate() > 1 ) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	/*
	public static void main(String[] args) {
		
		ScheduleMgr mgr = new ScheduleMgr();
		Vector<ScheduleBean> vlist = mgr.getTitleName(2);
		
		for (int i = 0; i < vlist.size(); i++) {
			ScheduleBean bean = vlist.get(i);
			System.out.println(bean.getSchedule_name());
		}
		
	}
	*/
	
}
