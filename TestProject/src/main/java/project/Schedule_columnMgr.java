package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class Schedule_columnMgr {
	
	private DBConnectionMgr pool;
	
	public Schedule_columnMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 시험 일정 가져오기
	/* 
	 1 - 기사 및 산업기사
	 2 - 기능사
	 3 - 기술사
	 4 - 기능장
	 */
	public Vector<Schedule_columnBean> getExamSchedule(int fknum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Schedule_columnBean> vlist = new Vector<Schedule_columnBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM schedule_column WHERE SCHEDULE_COLUMN_FKNUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fknum);
			rs = pstmt.executeQuery();
			if ( fknum == 1 || fknum == 2 ) {
				while ( rs.next() ) {
					Schedule_columnBean bean = new Schedule_columnBean();
					bean.setSchedule_column_num(rs.getInt("SCHEDULE_COLUMN_NUM"));
					bean.setSchedule_column_attempt(rs.getString("SCHEDULE_COLUMN_ATTEMPT"));
					bean.setSchedule_column_written_registration(rs.getString("SCHEDULE_COLUMN_WRITTEN_REGISTRATION"));
					bean.setSchedule_column_written_test(rs.getString("SCHEDULE_COLUMN_WRITTEN_TEST"));
					bean.setSchedule_column_written_pass(rs.getString("SCHEDULE_COLUMN_WRITTEN_PASS"));
					bean.setSchedule_column_practical_registration(rs.getString("SCHEDULE_COLUMN_PRACTICAL_REGISTRATION"));
					bean.setSchedule_column_practical_test(rs.getString("SCHEDULE_COLUMN_PRACTICAL_TEST"));
					bean.setSchedule_column_pass(rs.getString("SCHEDULE_COLUMN_PASS"));
					vlist.addElement(bean);
				}
			} else if ( fknum == 3 || fknum == 4 ) {
				while ( rs.next() ) {
					Schedule_columnBean bean = new Schedule_columnBean();
					bean.setSchedule_column_num(rs.getInt("SCHEDULE_COLUMN_NUM"));
					bean.setSchedule_column_attempt(rs.getString("SCHEDULE_COLUMN_ATTEMPT"));
					bean.setSchedule_column_written_registration(rs.getString("SCHEDULE_COLUMN_WRITTEN_REGISTRATION"));
					bean.setSchedule_column_written_test(rs.getString("SCHEDULE_COLUMN_WRITTEN_TEST"));
					bean.setSchedule_column_written_pass(rs.getString("SCHEDULE_COLUMN_WRITTEN_PASS"));
					bean.setSchedule_column_interview_registration(rs.getString("SCHEDULE_COLUMN_INTERVIEW_REGISTRATION"));
					bean.setSchedule_column_interview_test(rs.getString("SCHEDULE_COLUMN_INTERVIEW_TEST"));
					bean.setSchedule_column_pass(rs.getString("SCHEDULE_COLUMN_PASS"));
					vlist.addElement(bean);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 한 행 찾기용
	public Vector<Schedule_columnBean> onerow(int num, int fknum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Schedule_columnBean> vlist = new Vector<Schedule_columnBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM schedule_column WHERE SCHEDULE_COLUMN_FKNUM = ? AND SCHEDULE_COLUMN_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fknum);
			pstmt.setInt(2, num);
			rs = pstmt.executeQuery();
			if ( fknum == 1 || fknum == 2 ) {
				while ( rs.next() ) {
					Schedule_columnBean bean = new Schedule_columnBean();
					bean.setSchedule_column_num(rs.getInt("SCHEDULE_COLUMN_NUM"));
					bean.setSchedule_column_attempt(rs.getString("SCHEDULE_COLUMN_ATTEMPT"));
					bean.setSchedule_column_written_registration(rs.getString("SCHEDULE_COLUMN_WRITTEN_REGISTRATION"));
					bean.setSchedule_column_written_test(rs.getString("SCHEDULE_COLUMN_WRITTEN_TEST"));
					bean.setSchedule_column_written_pass(rs.getString("SCHEDULE_COLUMN_WRITTEN_PASS"));
					bean.setSchedule_column_practical_registration(rs.getString("SCHEDULE_COLUMN_PRACTICAL_REGISTRATION"));
					bean.setSchedule_column_practical_test(rs.getString("SCHEDULE_COLUMN_PRACTICAL_TEST"));
					bean.setSchedule_column_pass(rs.getString("SCHEDULE_COLUMN_PASS"));
					vlist.addElement(bean);
				}
				
			} else if ( fknum == 3 || fknum == 4 ) {
				while ( rs.next() ) {
					Schedule_columnBean bean = new Schedule_columnBean();
					bean.setSchedule_column_num(rs.getInt("SCHEDULE_COLUMN_NUM"));
					bean.setSchedule_column_attempt(rs.getString("SCHEDULE_COLUMN_ATTEMPT"));
					bean.setSchedule_column_written_registration(rs.getString("SCHEDULE_COLUMN_WRITTEN_REGISTRATION"));
					bean.setSchedule_column_written_test(rs.getString("SCHEDULE_COLUMN_WRITTEN_TEST"));
					bean.setSchedule_column_written_pass(rs.getString("SCHEDULE_COLUMN_WRITTEN_PASS"));
					bean.setSchedule_column_interview_registration(rs.getString("SCHEDULE_COLUMN_INTERVIEW_REGISTRATION"));
					bean.setSchedule_column_interview_test(rs.getString("SCHEDULE_COLUMN_INTERVIEW_TEST"));
					bean.setSchedule_column_pass(rs.getString("SCHEDULE_COLUMN_PASS"));
					vlist.addElement(bean);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 시험 일정 수정
	public boolean editExamSchedule(int num, int fknum, String a, String b, String c, String d, String e, String f, String g) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		if ( fknum == 1 || fknum == 2 ) {
			sql = "UPDATE schedule_column SET SCHEDULE_COLUMN_ATTEMPT = ?, " +
					"SCHEDULE_COLUMN_WRITTEN_REGISTRATION = ?, SCHEDULE_COLUMN_WRITTEN_TEST = ?, " +
					"SCHEDULE_COLUMN_WRITTEN_PASS = ?, SCHEDULE_COLUMN_PRACTICAL_REGISTRATION = ?, " +
					"SCHEDULE_COLUMN_PRACTICAL_TEST = ?, SCHEDULE_COLUMN_PASS = ? " +
					"WHERE SCHEDULE_COLUMN_NUM = ?";
		} else {
			sql = "UPDATE schedule_column SET SCHEDULE_COLUMN_ATTEMPT = ?, " +
					"SCHEDULE_COLUMN_WRITTEN_REGISTRATION = ?, SCHEDULE_COLUMN_WRITTEN_TEST = ?, " +
					"SCHEDULE_COLUMN_WRITTEN_PASS = ?, SCHEDULE_COLUMN_INTERVIEW_REGISTRATION = ?, " +
					"SCHEDULE_COLUMN_INTERVIEW_TEST = ?, SCHEDULE_COLUMN_PASS = ? " +
					"WHERE SCHEDULE_COLUMN_NUM = ?";
		}
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, a);
			pstmt.setString(2, b);
			pstmt.setString(3, c);
			pstmt.setString(4, d);
			pstmt.setString(5, e);
			pstmt.setString(6, f);
			pstmt.setString(7, g);
			pstmt.setInt(8, num);
			if ( pstmt.executeUpdate() > 0 ) flag = true;
		} catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	
	/*
	public static void main(String[] args) {
		
		Schedule_columnMgr mgr = new Schedule_columnMgr();
		Vector<Schedule_columnBean> vlist = mgr.getExamSchedule(1);
		for ( int i = 0; i < vlist.size(); i++ ) {
			Schedule_columnBean bean = vlist.get(i);
			System.out.println(bean.getSchedule_column_attempt());
			System.out.println(bean.getSchedule_column_written_registration());
			System.out.println(bean.getSchedule_column_written_test());
			System.out.println(bean.getSchedule_column_written_pass());
			System.out.println(bean.getSchedule_column_practical_registration());
			System.out.println(bean.getSchedule_column_practical_test());
			System.out.println(bean.getSchedule_column_pass());
			System.out.println("\n ---------------------- \n");
		}
		
	}
	*/
	
	
}
