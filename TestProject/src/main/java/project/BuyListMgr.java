package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class BuyListMgr {
	
	private DBConnectionMgr pool;
	
	public BuyListMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 구매내역 조회
	public Vector<BuyListBean> showBuyList(String id, String datestart, String dateend, int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BuyListBean> vlist = new Vector<BuyListBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM buylist WHERE BUYLIST_BUYER = ? AND BUYLIST_DATE >= ? AND BUYLIST_DATE <= ? ORDER BY BUYLIST_DATE DESC LIMIT ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, datestart);
			pstmt.setString(3, dateend);
			pstmt.setInt(4, start);
			pstmt.setInt(5, cnt);
			
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				BuyListBean bean = new BuyListBean();
				bean.setBuylist_pay(rs.getInt(2));
				bean.setBuylist_date(rs.getString(3));
				bean.setBuylist_paypost_num(rs.getInt(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 총 구매내역 수 조회
	public int getTotalCount(String id, String datestart, String dateend) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM BUYLIST WHERE BUYLIST_BUYER = ? AND BUYLIST_DATE >= ? AND BUYLIST_DATE <= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, datestart);
			pstmt.setString(3, dateend);
			rs = pstmt.executeQuery();
			if ( rs.next() ) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
}
