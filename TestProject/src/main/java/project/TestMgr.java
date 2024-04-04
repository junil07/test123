package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class TestMgr {
	
	private DBConnectionMgr pool;
	
	public TestMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//시험 종목 리스트 출력
	public Vector<TestBean> testList(String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TestBean> vlist = new Vector<TestBean>();
		try {
			con = pool.getConnection();
			if ( keyWord.trim().equals("") || keyWord == null ) {
			sql = "SELECT DISTINCT test_title FROM test";
			pstmt = con.prepareStatement(sql);
			}
			else {
			sql="SELECT DISTINCT test_title FROM test where test_title LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TestBean bean = new TestBean();
				bean.setTest_title(rs.getString(1));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public Vector<TestBean> testyear(String title){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TestBean> vlist = new Vector<TestBean>();
		try {
			con = pool.getConnection();
			sql = "select distinct test_year from test where test_title=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,title);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TestBean bean = new TestBean();
				bean.setTest_year(rs.getString(1));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<TestBean> testSessTitle(String title){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TestBean> vlist = new Vector<TestBean>();
		try {
			con = pool.getConnection();
			sql = "select test_subject from test where test_title=? GROUP BY test_subject,test_subnummber ORDER BY test_subnummber";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TestBean bean = new TestBean();
				bean.setTest_subject(rs.getString(1));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public String testNum(String title,String year,int sessNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String testNum = "";
		try {
			con = pool.getConnection();
			sql = "select test_num from test where test_title = ? and test_year = ? and test_subnummber = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, year);
			pstmt.setInt(3, sessNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				testNum = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return testNum;
	}
}
