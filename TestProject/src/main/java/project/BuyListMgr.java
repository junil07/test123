package project;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
	
	
	//구매내역 insert
	public void insetBuylist(int pay, int num, String buyer, String seller) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      String sql = null;
	      
	      try {
	         con = pool.getConnection();
	         sql = "insert buylist(buylist_pay, buylist_paypost_num, buylist_date, buylist_buyer, buylist_seller) "
	               + "values(?, ?, now(), ?, ?)";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, pay);
	         pstmt.setInt(2, num);
	         pstmt.setString(1, buyer);
	         pstmt.setString(2, seller);
	         if(pstmt.executeUpdate()==1) {
	        	 pstmt.close();
	        	 // 구매자 구매 포인트 만큼 빼기 
	        	 sql = "update user set user_point=user_point-? where user_id=?";
	        	 pstmt = con.prepareStatement(sql);
		         pstmt.setInt(1, pay);
		         pstmt.setString(2, buyer);
		         if(pstmt.executeUpdate()==1) {
		        	 pstmt.close();
		        	 // 판매자 판매 포인트 만큼 더하기 
		        	 sql = "update user set user_point=user_point+? where user_id=?";
		        	 pstmt = con.prepareStatement(sql);
			         pstmt.setInt(1, pay);
			         pstmt.setString(2, seller);
			         pstmt.executeUpdate();
		         }
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt);
	      }
	}
	
	//유저가 파일을 구매했는지 안 했는지 확인
	public boolean buyCheck(String user, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select buylist_buyser from buylist where buylist_buyser=? and buylist_payapost_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user);
			pstmt.setInt(2, num);
			rs = pstmt.executeQuery();
			if ( rs.next() ) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
}
