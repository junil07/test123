package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import project.DBConnectionMgr;

public class BoardMgr {
	
	private DBConnectionMgr pool;
	
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<BoardBean> boardList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			sql = "select * from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setBoard_num(rs.getInt(1));
				bean.setBoard_title(rs.getString(2));
				bean.setBoard_content(rs.getString(3));
				bean.setBoard_date(rs.getString(4));
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
