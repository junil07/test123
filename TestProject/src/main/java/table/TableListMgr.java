package table;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import project.DBConnectionMgr;

public class TableListMgr {
	private DBConnectionMgr pool;
	
	public TableListMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//테이블 전체
	public Vector<TableListBean> getTableList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TableListBean> vlist = new Vector<TableListBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tablelist";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TableListBean bean = new TableListBean();
				bean.setTablelist_num(rs.getInt("tablelist_num"));
				bean.setTablelist_table(rs.getString("tablelist_table"));
				bean.setTablelist_name(rs.getString("tablelist_name"));
				bean.setTablelist_user_op(rs.getInt("tablelist_user_op"));
				bean.setTablelist_pay_op(rs.getInt("tablelist_pay_op"));
				bean.setTablelist_likey_op(rs.getInt("tablelist_likey_op"));
				bean.setTablelist_uploadfile_op(rs.getInt("tablelist_uploadfile_op"));
				bean.setTablelist_comment_op(rs.getInt("tablelist_comment_op"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//테이블 하나
	public TableListBean getTable(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		TableListBean bean = new TableListBean();
		try {
			con = pool.getConnection();
			sql = "select * from tablelist where tablelist_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setTablelist_num(rs.getInt("tablelist_num"));
				bean.setTablelist_table(rs.getString("tablelist_table"));
				bean.setTablelist_name(rs.getString("tablelist_name"));
				bean.setTablelist_user_op(rs.getInt("tablelist_user_op"));
				bean.setTablelist_pay_op(rs.getInt("tablelist_pay_op"));
				bean.setTablelist_likey_op(rs.getInt("tablelist_likey_op"));
				bean.setTablelist_uploadfile_op(rs.getInt("tablelist_uploadfile_op"));
				bean.setTablelist_comment_op(rs.getInt("tablelist_comment_op"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	public void updateTable(List<String> opList, int num) {
		int[] op = {0, 0, 0, 0, 0};
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		TableListBean bean = getTable(num);
		String table = bean.getTablelist_table();
		String name = bean.getTablelist_name();
		
		//이전 테이블 이름과 입력 테이블 이름이 같지 않을 경우
		if(!table.equals(opList.get(0)))
			table = opList.get(0);
		
		//이전 게시판 이름과 입력 게시판 이름이 같지 않을 경우
		if(!name.equals(opList.get(1)))
			name = opList.get(1);
		
		for(int i=0;i < opList.size()-2; i++) {
			if(opList.get(i+2)!=null)
				op[i] = 1;
			else
				op[i] = 0;
		}
		try {
			con = pool.getConnection();
			
			sql = "update tablelist set tablelist_table=?, tablelist_name=?, tablelist_user_op=?, tablelist_pay_op=?, "
					+ "tablelist_likey_op=?, tablelist_uploadfile_op=?, tablelist_comment_op=? where tablelist_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, table);
			pstmt.setString(2, name);
			pstmt.setInt(3, op[0]);
			pstmt.setInt(4, op[1]);
			pstmt.setInt(5, op[2]);
			pstmt.setInt(6, op[3]);
			pstmt.setInt(7, op[4]);
			pstmt.setInt(8, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
}
