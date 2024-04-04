package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class PaypostMgr {
   
   DBConnectionMgr pool;
   
   public PaypostMgr() {
      pool = DBConnectionMgr.getInstance();
   }
   
   //paypost 유료글 리스트 출력(번호, 아이디, 제목, 가격, 날짜) - 유료글 게시판에서 전체적인 출력(paypost_agree가 2인것만출력으로 변경)
   public Vector<PaypostBean> allPaypost(String keyField,String keyWord, int start, int cnt){
       Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String sql = null;
       Vector<PaypostBean> vlist = new Vector<PaypostBean>();
       try {
           con = pool.getConnection();
           if(keyWord.trim().equals("") || keyWord == null) {
               sql = "SELECT paypost_num, paypost_user_id, paypost_title, paypost_pay, paypost_date FROM paypost ORDER BY paypost_num DESC LIMIT ?, ?";
               //sql = "SELECT paypost_num, paypost_user_id, paypost_title, paypost_pay, paypost_date FROM paypost where PAYPOST_AGREE <= 1 ORDER BY paypost_num DESC LIMIT ?, ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setInt(1, start);
               pstmt.setInt(2, cnt);
               rs = pstmt.executeQuery();
              while(rs.next()) {
                  PaypostBean pbean = new PaypostBean();
                  pbean.setPaypost_num(rs.getInt(1));
                  pbean.setPaypost_user_id(rs.getString(2));
                  pbean.setPaypost_title(rs.getString(3));
                   pbean.setPaypost_pay(rs.getInt(4));
                  pbean.setPaypost_date(rs.getString(5));
                  vlist.addElement(pbean);
              }
           } else {
               sql = "SELECT p.paypost_num, p.paypost_user_id, u.user_name, p.paypost_title, p.paypost_pay, p.paypost_date FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ? ORDER BY paypost_num DESC LIMIT ?, ?";
               //sql = "SELECT p.paypost_num, p.paypost_user_id, u.user_name, p.paypost_title, p.paypost_pay, p.paypost_date FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ? and p.PAYPOST_AGREEORDER <= 1 BY paypost_num DESC LIMIT ?, ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, "%" + keyWord + "%");
               pstmt.setInt(2, start);
               pstmt.setInt(3, cnt);
               rs = pstmt.executeQuery();
              while(rs.next()) {
                  PaypostBean pbean = new PaypostBean();
                  UserBean ubean = new UserBean();
                  pbean.setPaypost_num(rs.getInt(1));
                  pbean.setPaypost_user_id(rs.getString(2));
                  ubean.setUser_name(rs.getString(3));
                  pbean.setPaypost_title(rs.getString(4));
                   pbean.setPaypost_pay(rs.getInt(5));
                  pbean.setPaypost_date(rs.getString(6));
                  vlist.addElement(pbean);
              }
           }
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           pool.freeConnection(con, pstmt, rs);
       }
       return vlist;
   }

   //paypost_agree 유료글 승인 게시판 리스트 출력(전체적으로 출력, 승인완료라도 추후 거절로 변경할수 있도록)
   public Vector<PaypostBean> agreePaypost(String keyField, String keyWord, int start, int cnt){
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      Vector<PaypostBean> vlist = new Vector<PaypostBean>();
      try {
         con = pool.getConnection();
         if(keyWord.trim().equals("") || keyWord == null) {
               sql = "SELECT paypost_num, paypost_user_id, paypost_title, paypost_pay, paypost_date, PAYPOST_AGREE FROM paypost ORDER BY paypost_num DESC LIMIT ?, ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setInt(1, start);
               pstmt.setInt(2, cnt);
               rs = pstmt.executeQuery();
              while(rs.next()) {
                  PaypostBean pbean = new PaypostBean();
                  pbean.setPaypost_num(rs.getInt(1));
                  pbean.setPaypost_user_id(rs.getString(2));
                  pbean.setPaypost_title(rs.getString(3));
                   pbean.setPaypost_pay(rs.getInt(4));
                  pbean.setPaypost_date(rs.getString(5));
                  pbean.setPaypost_agree(rs.getInt(6));
                  vlist.addElement(pbean);
              }
           } else {
               sql = "SELECT p.paypost_num, p.paypost_user_id, u.user_name, p.paypost_title, p.paypost_pay, p.paypost_date, p.paypost_agree FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ? ORDER BY paypost_num DESC LIMIT ?, ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, "%" + keyWord + "%");
               pstmt.setInt(2, start);
               pstmt.setInt(3, cnt);
               rs = pstmt.executeQuery();
              while(rs.next()) {
                  PaypostBean pbean = new PaypostBean();
                  UserBean ubean = new UserBean();
                  pbean.setPaypost_num(rs.getInt(1));
                  pbean.setPaypost_user_id(rs.getString(2));
                  ubean.setUser_name(rs.getString(3));
                  pbean.setPaypost_title(rs.getString(4));
                   pbean.setPaypost_pay(rs.getInt(5));
                  pbean.setPaypost_date(rs.getString(6));
                  pbean.setPaypost_agree(rs.getInt(7));
                  vlist.addElement(pbean);
              }
           }
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           pool.freeConnection(con, pstmt, rs);
       }
       return vlist;
   }
   
   
   
   
   //유로글 리스트에서 뽑은 아이디를 통해 user테이블에서 이름
   public String getUserName(String userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String userName = null;
        try {
            con = pool.getConnection();
            String sql = "SELECT user_name FROM user WHERE user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                userName = rs.getString("user_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return userName;
    }
   
   //user테이블에서 등급 출력
   public int getUserGrade(String userId) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int userGrade = 0;
      try {
         con = pool.getConnection();
         String sql = "select user_grade from user where user_id = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, userId);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            userGrade = rs.getInt("user_grade");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return userGrade;
   }
   
   //전체적인 유로글 갯수확인 추후 paypost_agree가 2인것만 count하게 변경
   public int getTotalCount(String keyField, String keyWord) {
       Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String sql = null;
       int totalCount = 0;
       try {
           con = pool.getConnection();
           if(keyWord.trim().equals("") || keyWord == null) {
               sql = "SELECT COUNT(*) FROM paypost";
               pstmt = con.prepareStatement(sql);
           } else {
               sql = "SELECT COUNT(*) FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, "%" + keyWord + "%");
           }
           rs = pstmt.executeQuery();
           if(rs.next()) totalCount = rs.getInt(1);
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           pool.freeConnection(con, pstmt, rs);
       }
       return totalCount;
   }
   
   //전체적인 유로글 갯수확인 추후 paypost_agree가 2인것만 count하게 변경
      public int getagree2Count(String keyField, String keyWord) {
          Connection con = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          String sql = null;
          int totalCount = 0;
          try {
              con = pool.getConnection();
              if(keyWord.trim().equals("") || keyWord == null) {
                  sql = "SELECT COUNT(*) FROM paypost where PAYPOST_AGREE <= 1";
                  pstmt = con.prepareStatement(sql);
              } else {
                  sql = "SELECT COUNT(*) FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ?";
                  pstmt = con.prepareStatement(sql);
                  pstmt.setString(1, "%" + keyWord + "%");
              }
              rs = pstmt.executeQuery();
              if(rs.next()) totalCount = rs.getInt(1);
          } catch (Exception e) {
              e.printStackTrace();
          } finally {
              pool.freeConnection(con, pstmt, rs);
          }
          return totalCount;
      }

   
   //listview에서 필요로한 모든 값 리턴
   public PaypostBean getlist(int paypost_num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      PaypostBean pbean = new PaypostBean();
      try {
         con = pool.getConnection();
         sql = "select * from paypost where paypost_num = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, paypost_num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            pbean.setPaypost_num(rs.getInt("paypost_num"));
            pbean.setPaypost_test_num(rs.getString("paypost_test_num"));
            pbean.setPaypost_user_id(rs.getString("paypost_user_id"));
            pbean.setPaypost_title(rs.getString("paypost_title"));
            pbean.setPaypost_content(rs.getString("paypost_content"));
            pbean.setPaypost_pay(rs.getInt("paypost_pay"));
            pbean.setPaypost_agree(rs.getInt("paypost_agree"));
            pbean.setPaypost_date(rs.getString("paypost_date"));
            pbean.setPaypost_good(rs.getInt("paypost_good"));
            pbean.setPaypost_reason(rs.getString("paypost_reason"));   
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return pbean;
   }
   
   //유료글 좋아요(good) 출력
   public int getpaypostlike(int list_num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      int paypost_good = 0;
      try {
         con = pool.getConnection();
         sql = "select paypost_good from paypost where paypost_num = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, list_num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            paypost_good = rs.getInt("paypost_good");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return paypost_good;
   }
   
   //유료글 거절 사유 찾기
   public String getpaypostReason(int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      String reason = null;
      try {
         con = pool.getConnection();
         sql = "select paypost_reason from paypost where PAYPOST_NUM = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            reason = rs.getString("paypost_reason");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return reason;
   }
   
   // 유료 게시물의 거절 사유 변경 및 agree 값 1로 바꾸기(1 = 거절)
   public void updatepaypostReason(String reason, int num) {
       Connection con = null;
       PreparedStatement pstmt = null;
       String sql = null;
       try {
           con = pool.getConnection();
           sql = "UPDATE paypost SET PAYPOST_REASON = ?, PAYPOST_AGREE = 1 WHERE paypost_num = ?";
           pstmt = con.prepareStatement(sql);
           pstmt.setString(1, reason);
           pstmt.setInt(2, num);
           pstmt.executeUpdate();
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           pool.freeConnection(con, pstmt);
       }
   }
   
   //유료 게시글 승인
   public void updateagree(String text, int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      String sql = null;
      
      try {
         con = pool.getConnection();
         sql = "UPDATE paypost SET PAYPOST_REASON = ?, PAYPOST_AGREE = 2 WHERE paypost_num = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, text);
         pstmt.setInt(2, num);
         pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt);
      }
   }
  
  // 포인트 이용내역 - 이용한 게시글 제목 추출
	public String showPaypostTitle(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String paypostTitle = "";
		try {
			con = pool.getConnection();
			sql = "SELECT paypost_title FROM paypost WHERE PAYPOST_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				paypostTitle = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return paypostTitle;
	}
  
}