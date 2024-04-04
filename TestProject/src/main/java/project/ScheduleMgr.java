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
	/* 
	 1 - 기사 및 산업기사
	 2 - 기능사
	 3 - 기술사
	 4 - 기능장
	 */
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
	
	/*
	public static void main(String[] args) {
		
		ScheduleMgr mgr = new ScheduleMgr();
		Vector<ScheduleBean> vlist = mgr.getTitleName();
		
		for (int i = 0; i < vlist.size(); i++) {
			ScheduleBean bean = vlist.get(i);
			System.out.println(bean.getSchedule_name());
		}
		
	}
	*/
	
}
