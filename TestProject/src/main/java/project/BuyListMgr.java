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
	
	//리스트 페이징 처리 및 출력값 keyField에 따라 변경
	public Vector<BuyListBean> getBuyList(String keyField, String keytext, int start, int cnt) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<BuyListBean> Bllist = new Vector<BuyListBean>();
	    try {
	        con = pool.getConnection();
	        if (keytext.trim().equals("") || keytext == null) {
	            sql = "SELECT * FROM buylist ORDER BY BUYLIST_DATE DESC LIMIT ?, ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setInt(1, start);
	            pstmt.setInt(2, cnt);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	                BuyListBean Blbean = new BuyListBean();
	                Blbean.setBuylist_num(rs.getInt(1));
	                Blbean.setBuylist_pay(rs.getInt(2));
	                Blbean.setBuylist_date(rs.getString(3));
	                Blbean.setBuylist_paypost_num(rs.getInt(4));
	                Blbean.setBuylist_buyer(rs.getString(5));
	                Blbean.setBuylist_seller(rs.getString(6));
	                Bllist.addElement(Blbean);
	            }
	        } else {
	            if ("buyer".equals(keyField)) {
	                sql = "SELECT * FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_buyer = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE u.user_name LIKE ? LIMIT ?, ?";
	            } else if ("title".equals(keyField)) {
	                sql = "SELECT * FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_buyer = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE p.paypost_title LIKE ? LIMIT ?, ?";
	            } else if ("pay".equals(keyField)) {
	                sql = "SELECT * FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_buyer = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE b.buylist_pay LIKE ? LIMIT ?, ?";
	            } else if ("date".equals(keyField)) {
	                sql = "SELECT * FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_buyer = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE b.buylist_date LIKE ? LIMIT ?, ?";
	            } else if ("seller".equals(keyField)) {
	                sql = "SELECT * FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_seller = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE u.user_name LIKE ? LIMIT ?, ?";
	            }
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, "%" + keytext + "%");
	            pstmt.setInt(2, start);
	            pstmt.setInt(3, cnt);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	                BuyListBean Blbean = new BuyListBean();
	                Blbean.setBuylist_num(rs.getInt("buylist_num"));
	                Blbean.setBuylist_pay(rs.getInt("buylist_pay"));
	                Blbean.setBuylist_date(rs.getString("buylist_date"));
	                Blbean.setBuylist_paypost_num(rs.getInt("buylist_paypost_num"));
	                Blbean.setBuylist_buyer(rs.getString("buylist_buyer"));
	                Blbean.setBuylist_seller(rs.getString("buylist_seller"));
	                Blbean.setUser_name(rs.getString("user_name"));
	                Blbean.setPaypost_title(rs.getString("paypost_title"));
	                Bllist.addElement(Blbean);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return Bllist;
	}

	
	//관리자 구매자 이름 출력하기
	public String getBuyerName(String buyer_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String buyer_name = null;
		try {
			con = pool.getConnection();
			sql = "select user_name from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, buyer_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				buyer_name = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return buyer_name;
	}
	//관리자 판매자 이름 출력하기
	public String getsellerName(String seller_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String seller_name = null;
		try {
			con = pool.getConnection();
			sql = "select user_name from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, seller_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				seller_name = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return seller_name;
	}
	//관리자 유료글 제목 출력하기
	public String gettitle(int ppnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String title = null;
		try {
			con = pool.getConnection();
			sql = "select PAYPOST_TITLE from paypost where PAYPOST_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ppnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				title = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return title;
	}
	
	//페이징 처리에 따른 리스트 출력 인원수 파악
	public int getcountlist(String keyField, String keytext) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int totalCount = 0;
	    try {
	        con = pool.getConnection();
	        if (keytext.trim().equals("") || keytext == null) {
	            sql = "SELECT COUNT(*) FROM buylist";
	            pstmt = con.prepareStatement(sql);
	        } else {
	            if ("buyer".equals(keyField)) {
	                sql = "SELECT COUNT(*) FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_buyer = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE u.user_name LIKE ?";
	            } else if ("title".equals(keyField)) {
	                sql = "SELECT COUNT(*) FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_buyer = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE p.paypost_title LIKE ?";
	            } else if ("pay".equals(keyField)) {
	                sql = "SELECT COUNT(*) FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_buyer = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE b.buylist_pay LIKE ?";
	            } else if ("date".equals(keyField)) {
	                sql = "SELECT COUNT(*) FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_buyer = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE b.buylist_date LIKE ?";
	            } else if ("seller".equals(keyField)) {
	                sql = "SELECT COUNT(*) FROM buylist b " +
	                      "LEFT OUTER JOIN user u ON b.buylist_seller = u.user_id " +
	                      "LEFT OUTER JOIN paypost p ON b.buylist_paypost_num = p.paypost_num " +
	                      "WHERE u.user_name LIKE ?";
	            }
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, "%" + keytext + "%");
	        }
	        rs = pstmt.executeQuery();
	        if (rs.next())
	            totalCount = rs.getInt(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return totalCount;
	}

	
	//단순 총 사용사 파악용
	public int getallcount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from buylist";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	//목록 선택된 것만(다수가능) 삭제
	public void deleteBuylist(String[] blnums) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from buylist where buylist_num = ?";
			pstmt = con.prepareStatement(sql);
			for(int i = 0; i<blnums.length; i++) {
				pstmt.setString(1, blnums[i]);
				pstmt.executeUpdate();
			}
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}
}
